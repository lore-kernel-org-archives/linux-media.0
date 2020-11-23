Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEA7C64E7C
	for <linux-media@archiver.kernel.org>; Mon, 23 Nov 2020 14:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAC102075A
	for <linux-media@archiver.kernel.org>; Mon, 23 Nov 2020 14:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgKWOk3 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 23 Nov 2020 09:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbgKWOkZ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 23 Nov 2020 09:40:25 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B04C0613CF;
        Mon, 23 Nov 2020 06:40:25 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 304BE1F449A6
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v4 02/13] media: rkvdec: h264: Support profile and level controls
Date:   Mon, 23 Nov 2020 11:39:49 -0300
Message-Id: <20201123144000.81310-3-ezequiel@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201123144000.81310-1-ezequiel@collabora.com>
References: <20201123144000.81310-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Jonas Karlman <jonas@kwiboo.se>

The Rockchip Video Decoder used in RK3399 supports H.264 profiles from
Baseline to High 4:2:2 up to Level 5.1, except for the Extended profile.

Expose the V4L2_CID_MPEG_VIDEO_H264_PROFILE and the
V4L2_CID_MPEG_VIDEO_H264_LEVEL control, so that userspace can query the
driver for the list of supported profiles and level.

For now, we don't expose 4:2:2 since the driver doesn't
implement the required support.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
[Ezequiel: Don't expose 4:2:2 profile for now]
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/staging/media/rkvdec/rkvdec.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 552e0bd12ecf..fe65f55d3b49 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -82,6 +82,19 @@ static const struct rkvdec_ctrl_desc rkvdec_h264_ctrl_descs[] = {
 		.cfg.def = V4L2_MPEG_VIDEO_H264_START_CODE_ANNEX_B,
 		.cfg.max = V4L2_MPEG_VIDEO_H264_START_CODE_ANNEX_B,
 	},
+	{
+		.cfg.id = V4L2_CID_MPEG_VIDEO_H264_PROFILE,
+		.cfg.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
+		.cfg.max = V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
+		.cfg.menu_skip_mask =
+			BIT(V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED),
+		.cfg.def = V4L2_MPEG_VIDEO_H264_PROFILE_MAIN,
+	},
+	{
+		.cfg.id = V4L2_CID_MPEG_VIDEO_H264_LEVEL,
+		.cfg.min = V4L2_MPEG_VIDEO_H264_LEVEL_1_0,
+		.cfg.max = V4L2_MPEG_VIDEO_H264_LEVEL_5_1,
+	},
 };
 
 static const struct rkvdec_ctrls rkvdec_h264_ctrls = {
-- 
2.27.0

