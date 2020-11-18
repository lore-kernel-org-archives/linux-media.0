Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAC1C56201
	for <linux-media@archiver.kernel.org>; Wed, 18 Nov 2020 18:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B06C4246B9
	for <linux-media@archiver.kernel.org>; Wed, 18 Nov 2020 18:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgKRSre (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 18 Nov 2020 13:47:34 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37680 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgKRSrc (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 18 Nov 2020 13:47:32 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id CB6F81F449D0
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
Subject: [PATCH v3 06/13] media: uapi: h264: Add profile_idc macros
Date:   Wed, 18 Nov 2020 15:46:53 -0300
Message-Id: <20201118184700.331213-7-ezequiel@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201118184700.331213-1-ezequiel@collabora.com>
References: <20201118184700.331213-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add some macros to document the profile_idc magic numbers.
This will be used to validate the controls, but could
also be used by drivers.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 include/media/h264-ctrls.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/media/h264-ctrls.h b/include/media/h264-ctrls.h
index f86345b8efd1..e14307f1a77c 100644
--- a/include/media/h264-ctrls.h
+++ b/include/media/h264-ctrls.h
@@ -98,6 +98,13 @@ enum v4l2_mpeg_video_h264_start_code {
 #define V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIELD		0x20
 #define V4L2_H264_SPS_FLAG_DIRECT_8X8_INFERENCE			0x40
 
+#define V4L2_H264_PROFILE_IDC_BASELINE                          66
+#define V4L2_H264_PROFILE_IDC_MAIN                              77
+#define V4L2_H264_PROFILE_IDC_EXTENDED                          88
+#define V4L2_H264_PROFILE_IDC_HIGH                              100
+#define V4L2_H264_PROFILE_IDC_HIGH_422                          122
+#define V4L2_H264_PROFILE_IDC_HIGH_444                          244
+
 /**
  * struct v4l2_ctrl_h264_sps - H264 sequence parameter set
  *
-- 
2.27.0

