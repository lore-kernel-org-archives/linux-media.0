Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3638CC43460
	for <linux-media@archiver.kernel.org>; Tue, 20 Apr 2021 12:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDFF6613BF
	for <linux-media@archiver.kernel.org>; Tue, 20 Apr 2021 12:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhDTMFo (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:05:44 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:57964 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhDTMFo (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 20 Apr 2021 08:05:44 -0400
Received: from deskari.lan (91-157-208-71.elisa-laajakaista.fi [91.157.208.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6A5808AD;
        Tue, 20 Apr 2021 14:05:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1618920311;
        bh=KPMIlrTubnDnc2iiOiEY0o+GMSd2wA6DK8MBd+Tj/zY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=okx5Abj8pHSfW2MVr3iDEfAh8UDKFslGURYyKYlZ91YofDeU9Tue3ZZwTPDiza14z
         mSy7cqZCxVo4sq8qLctRXCZ9GIW/OJ5fSRRY9kXctXtPUnQ9SgI5yzzALynyZcr0U6
         1HmBDZPxxcfZ8dV7S6w35KHz8i9Unnse228+AEiw=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     Benoit Parrot <bparrot@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v2 01/35] media: ti-vpe: cal: add g/s_parm for legacy API
Date:   Tue, 20 Apr 2021 15:03:59 +0300
Message-Id: <20210420120433.902394-2-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420120433.902394-1-tomi.valkeinen@ideasonboard.com>
References: <20210420120433.902394-1-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

v4l2-compliance complains about g/s_parm when using the non-MC API. Fix
it by adding the functions and just call v4l2_s/g_parm_cap for the
phy subdev.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/ti-vpe/cal-video.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/media/platform/ti-vpe/cal-video.c b/drivers/media/platform/ti-vpe/cal-video.c
index 7b7436a355ee..86d7cdd27224 100644
--- a/drivers/media/platform/ti-vpe/cal-video.c
+++ b/drivers/media/platform/ti-vpe/cal-video.c
@@ -388,6 +388,20 @@ static int cal_enum_frameintervals(struct file *file, void *priv,
 	return 0;
 }
 
+static int cal_g_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
+{
+	struct cal_ctx *ctx = video_drvdata(file);
+
+	return v4l2_g_parm_cap(video_devdata(file), ctx->phy->sensor, a);
+}
+
+static int cal_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
+{
+	struct cal_ctx *ctx = video_drvdata(file);
+
+	return v4l2_s_parm_cap(video_devdata(file), ctx->phy->sensor, a);
+}
+
 static const struct v4l2_ioctl_ops cal_ioctl_video_ops = {
 	.vidioc_querycap      = cal_querycap,
 	.vidioc_enum_fmt_vid_cap  = cal_enum_fmt_vid_cap,
@@ -411,6 +425,8 @@ static const struct v4l2_ioctl_ops cal_ioctl_video_ops = {
 	.vidioc_log_status    = v4l2_ctrl_log_status,
 	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
 	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
+	.vidioc_g_parm		= cal_g_parm,
+	.vidioc_s_parm		= cal_s_parm,
 };
 
 /* ------------------------------------------------------------------
-- 
2.25.1

