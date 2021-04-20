Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29F3C433B4
	for <linux-media@archiver.kernel.org>; Tue, 20 Apr 2021 12:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD806613C0
	for <linux-media@archiver.kernel.org>; Tue, 20 Apr 2021 12:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhDTMFq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhDTMFp (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 20 Apr 2021 08:05:45 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB67C06174A
        for <linux-media@vger.kernel.org>; Tue, 20 Apr 2021 05:05:14 -0700 (PDT)
Received: from deskari.lan (91-157-208-71.elisa-laajakaista.fi [91.157.208.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 19BA5E2E;
        Tue, 20 Apr 2021 14:05:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1618920312;
        bh=4QYYolV113IH+zWwRAUVxieAotJdGKkVBAkqil8qB1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N+aQ2ucecOkvfiHpdflacLyD/Cjrx509vRqsEI+kVIWKIvyscCEpLgGQRsViBXrn/
         vxACn/Cc/zVxAS6QZz6rTj2T4uzC3Nknb0zmVg49CqqdqeIO5xbQFtI8yHIbi9Q+rO
         0kW3G7NFYBqW+i2HkwJJF1LwaFDqZ16Yqgr8UGno=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     Benoit Parrot <bparrot@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v2 02/35] media: ti-vpe: cal: fix error handling in cal_camerarx_create
Date:   Tue, 20 Apr 2021 15:04:00 +0300
Message-Id: <20210420120433.902394-3-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420120433.902394-1-tomi.valkeinen@ideasonboard.com>
References: <20210420120433.902394-1-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

cal_camerarx_create() doesn't handle error returned from
cal_camerarx_sd_init_cfg(). Fix this.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/platform/ti-vpe/cal-camerarx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti-vpe/cal-camerarx.c b/drivers/media/platform/ti-vpe/cal-camerarx.c
index cbe6114908de..63d13bcc83b4 100644
--- a/drivers/media/platform/ti-vpe/cal-camerarx.c
+++ b/drivers/media/platform/ti-vpe/cal-camerarx.c
@@ -842,7 +842,9 @@ struct cal_camerarx *cal_camerarx_create(struct cal_dev *cal,
 	if (ret)
 		goto error;
 
-	cal_camerarx_sd_init_cfg(sd, NULL);
+	ret = cal_camerarx_sd_init_cfg(sd, NULL);
+	if (ret)
+		goto error;
 
 	ret = v4l2_device_register_subdev(&cal->v4l2_dev, sd);
 	if (ret)
-- 
2.25.1

