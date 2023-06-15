Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28C4EB64DA
	for <linux-media@archiver.kernel.org>; Thu, 15 Jun 2023 14:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345009AbjFOOPk (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 15 Jun 2023 10:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345016AbjFOOPf (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 15 Jun 2023 10:15:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CC52683
        for <linux-media@vger.kernel.org>; Thu, 15 Jun 2023 07:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686838487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gZ9nmGFVZLIcMbAuUVbv95m0/uLTfMRc0Oc4OBI3kKo=;
        b=Sa9e5zd433OoKGU5L3NsYk0IrfeUVun/fob64CIW68+Nx2fEGFrRxkIm9vqY1V58+3KhG9
        ubIqEhF7MO3U5leBxEeqqpvXH+7EvlOAWooseWLZIzqQD/yIoAldMI0h1O7oL7T5i0eCGR
        NECj2GjI3YNrdJue3uBeSjwk1b8MeX0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-T-gUq_a2ONacW8HbpjBMZw-1; Thu, 15 Jun 2023 10:14:43 -0400
X-MC-Unique: T-gUq_a2ONacW8HbpjBMZw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 109F6857A8B;
        Thu, 15 Jun 2023 14:14:23 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4E0048FB01;
        Thu, 15 Jun 2023 14:14:21 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Daniel Scally <dan.scally@ideasonboard.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, Kate Hsuan <hpa@redhat.com>,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        linux-media@vger.kernel.org
Subject: [PATCH v2 24/28] media: ov2680: Fix exposure and gain ctrls range and default value
Date:   Thu, 15 Jun 2023 16:13:45 +0200
Message-Id: <20230615141349.172363-25-hdegoede@redhat.com>
In-Reply-To: <20230615141349.172363-1-hdegoede@redhat.com>
References: <20230615141349.172363-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The exposure control's max effective value is VTS - 8, set the control
range to match this. Thas means that if/when a future commit makes VTS
configurable as a control itself the exposure range needs to be
updated dynamically to match the VTS value.

The gain control goes from 0 - 1023, higher values wrap around to
the lowest gain setting.

Also stop setting 0 as default for both controls this leads to
a totally black picture which is no good. This is esp. important
for tests of the sensor driver without (userspace driven)
auto exposure / gain.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/media/i2c/ov2680.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
index adffe3438660..1651fc6df972 100644
--- a/drivers/media/i2c/ov2680.c
+++ b/drivers/media/i2c/ov2680.c
@@ -81,6 +81,9 @@
 /* If possible send 16 extra rows / lines to the ISP as padding */
 #define OV2680_END_MARGIN			16
 
+/* Max exposure time is VTS - 8 */
+#define OV2680_INTEGRATION_TIME_MARGIN		8
+
 #define OV2680_DEFAULT_WIDTH			800
 #define OV2680_DEFAULT_HEIGHT			600
 
@@ -823,6 +826,7 @@ static int ov2680_v4l2_register(struct ov2680_dev *sensor)
 	const struct v4l2_ctrl_ops *ops = &ov2680_ctrl_ops;
 	struct ov2680_ctrls *ctrls = &sensor->ctrls;
 	struct v4l2_ctrl_handler *hdl = &ctrls->handler;
+	int exp_max = OV2680_LINES_PER_FRAME - OV2680_INTEGRATION_TIME_MARGIN;
 	int ret = 0;
 
 	v4l2_i2c_subdev_init(&sensor->sd, client, &ov2680_subdev_ops);
@@ -849,9 +853,10 @@ static int ov2680_v4l2_register(struct ov2680_dev *sensor)
 					0, 0, test_pattern_menu);
 
 	ctrls->exposure = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_EXPOSURE,
-					    0, 32767, 1, 0);
+					    0, exp_max, 1, exp_max);
 
-	ctrls->gain = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_GAIN, 0, 2047, 1, 0);
+	ctrls->gain = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_GAIN,
+					0, 1023, 1, 250);
 
 	if (hdl->error) {
 		ret = hdl->error;
-- 
2.40.1

