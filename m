Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5730CC43460
	for <linux-media@archiver.kernel.org>; Mon, 12 Apr 2021 11:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3799A6124C
	for <linux-media@archiver.kernel.org>; Mon, 12 Apr 2021 11:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240597AbhDLLf6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:35:58 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:52640 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240540AbhDLLfz (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 12 Apr 2021 07:35:55 -0400
Received: from deskari.lan (91-157-208-71.elisa-laajakaista.fi [91.157.208.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 53F745A9;
        Mon, 12 Apr 2021 13:35:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1618227336;
        bh=T8poA3mp0l7wuKp+eMn0jXB2QTD/bU4OkDfsuNCUMj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DZpEz3pDu2IUS8PoHNSshZQi+ruZJGZ+gxeFSU7D4IFvn2UtplOp/Fu7KdJFKsYEf
         a61VaRCnSAqUU2uW3Cq0tQr/rkBKQ9G2sNSjm/VK7x9LSVpVzceXGpn/yMlWRxo3RB
         0A9Yu7X2oHYRUSa6EWo04LM9ydtcapopV4ON2wJc=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     Benoit Parrot <bparrot@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 24/28] media: ti-vpe: cal: add mbus_code support to cal_mc_enum_fmt_vid_cap
Date:   Mon, 12 Apr 2021 14:34:53 +0300
Message-Id: <20210412113457.328012-25-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412113457.328012-1-tomi.valkeinen@ideasonboard.com>
References: <20210412113457.328012-1-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Commit e5b6b07a1b45dd9d19bec1fa1d60750b0fcf2fb0 ("media: v4l2: Extend
VIDIOC_ENUM_FMT to support MC-centric devices") added support to
enumerate formats based in mbus-code.

Add this feature to cal driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/platform/ti-vpe/cal-video.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal-video.c b/drivers/media/platform/ti-vpe/cal-video.c
index ea9b13c16a06..1d9c0fce4b03 100644
--- a/drivers/media/platform/ti-vpe/cal-video.c
+++ b/drivers/media/platform/ti-vpe/cal-video.c
@@ -437,13 +437,28 @@ static const struct v4l2_ioctl_ops cal_ioctl_video_ops = {
 static int cal_mc_enum_fmt_vid_cap(struct file *file, void  *priv,
 				   struct v4l2_fmtdesc *f)
 {
+	unsigned int i;
+	unsigned int idx;
+
 	if (f->index >= cal_num_formats)
 		return -EINVAL;
 
-	f->pixelformat = cal_formats[f->index].fourcc;
-	f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+	idx = 0;
 
-	return 0;
+	for (i = 0; i < cal_num_formats; ++i) {
+		if (f->mbus_code && cal_formats[i].code != f->mbus_code)
+			continue;
+
+		if (idx == f->index) {
+			f->pixelformat = cal_formats[i].fourcc;
+			f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+			return 0;
+		}
+
+		idx++;
+	}
+
+	return -EINVAL;
 }
 
 static void cal_mc_try_fmt(struct cal_ctx *ctx, struct v4l2_format *f,
-- 
2.25.1

