Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10778C4332F
	for <linux-media@archiver.kernel.org>; Sun, 12 Sep 2021 08:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E37EA610FD
	for <linux-media@archiver.kernel.org>; Sun, 12 Sep 2021 08:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhILIWW (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 12 Sep 2021 04:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbhILIWV (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 12 Sep 2021 04:22:21 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5A2C061574;
        Sun, 12 Sep 2021 01:21:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w29so8758571wra.8;
        Sun, 12 Sep 2021 01:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=loVuR5rf8xXZUXrkvmuZ4jdfaeutXsglZCQg6SpqqWI=;
        b=mz9rcT5C8Hmf5wIRx6BVghFw/iPtNymfvfF8cuTcwBpj3tVtFNUDyVqKD9m/hwVuja
         3oAvSb7+QD/evuBHr8Ge9l0bHp6YhNR5ijLNRdBnZH9ubgoCtegSHThuZGr3Naml2G/U
         W4YxkMnq5xXcIl5MkbWBAFtwdeVgbAl9fHQ49aJZpXXC9l2Ak8oXuHuFx1hnFGI06Oa3
         QQFCQY32NwzQQVDyh4iAJF43lBrDw0Zhr6PysXZk2hkbX2C0/Zy7fukuJ+kVdJH9evC7
         NAJy4Q8w5Jwri1ZgA23SAcCuPq+NeBWHegfSMHCTApZ/Ls1t2EoVpYrEiAKf3szTCznS
         F3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=loVuR5rf8xXZUXrkvmuZ4jdfaeutXsglZCQg6SpqqWI=;
        b=KTw7V6kW8mBXOBKO6nn30wqVnxtE5eE8C91TLz9zG+obsZShPiq3j4NskSPM7q1lX8
         Mk9WacADy4Te9RXVPSqaSt4Ce4uSohTk3v4GV9Eai4BDmvNuZ93inZJj/kmF0VNHFCEN
         9461kFpXqgSFRZ+HLlqStS6K8cC4S8ky/62edCoycOYyzTJKWQF+9w90Sh3IdoyUWV32
         octe3kGv5GBgHmfSx74mk717z3vH/NKeCZrN3atAM9t1UOSf0KbvkGOBYkiNln27Pu6F
         fr4VU3XPypfj5RoF3i95WtZdqR6E+i51g73cL3+eoMukQSHmIRHXky5GBgXjZO/WNuIe
         ES8g==
X-Gm-Message-State: AOAM530E0WwbOJT+xoNUhJXyJQoXamSvCDydLCbJHDHZ7qfdRCLfvE5m
        lRd5NUrwGmKTo0qbpWfjT8A=
X-Google-Smtp-Source: ABdhPJymmVlbyu3mVI7xzQefhW6DAWK5wy+DMJxGBpj1f82ZRDyXtzqEeAd+gIeNepxhQTShqR7x+Q==
X-Received: by 2002:a5d:63c5:: with SMTP id c5mr6563829wrw.135.1631434864600;
        Sun, 12 Sep 2021 01:21:04 -0700 (PDT)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id z7sm4734148wre.72.2021.09.12.01.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 01:21:04 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     wens@csie.org, mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 2/2] media: cedrus: add check for H264 and H265 limitations
Date:   Sun, 12 Sep 2021 10:20:51 +0200
Message-Id: <20210912082051.404645-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210912082051.404645-1-jernej.skrabec@gmail.com>
References: <20210912082051.404645-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Cedrus supports only YUV420 H264/H265 content and mostly only 8-bit
colours (except on H6, where 10-bit are also supported).

Add validation callback to SPS controls, which will reject unsupported
combinations.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c | 46 +++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index e7741178465b..9dd30cb568e8 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -28,6 +28,50 @@
 #include "cedrus_dec.h"
 #include "cedrus_hw.h"
 
+static int cedrus_try_ctrl(struct v4l2_ctrl *ctrl)
+{
+	if (ctrl->id == V4L2_CID_STATELESS_H264_SPS) {
+		const struct v4l2_ctrl_h264_sps *sps = ctrl->p_new.p_h264_sps;
+
+		if (sps->chroma_format_idc != 1)
+			/* Only 4:2:0 is supported */
+			return -EINVAL;
+		if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
+			/* Luma and chroma bit depth mismatch */
+			return -EINVAL;
+		if (sps->bit_depth_luma_minus8 != 0)
+			/* Only 8-bit is supported */
+			return -EINVAL;
+	} else if (ctrl->id == V4L2_CID_MPEG_VIDEO_HEVC_SPS) {
+		const struct v4l2_ctrl_hevc_sps *sps = ctrl->p_new.p_hevc_sps;
+		struct cedrus_ctx *ctx = container_of(ctrl->handler, struct cedrus_ctx, hdl);
+
+		if (sps->chroma_format_idc != 1)
+			/* Only 4:2:0 is supported */
+			return -EINVAL;
+
+		if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
+			/* Luma and chroma bit depth mismatch */
+			return -EINVAL;
+
+		if (ctx->dev->capabilities & CEDRUS_CAPABILITY_H265_10_DEC) {
+			if (sps->bit_depth_luma_minus8 != 0 && sps->bit_depth_luma_minus8 != 2)
+				/* Only 8-bit and 10-bit are supported */
+				return -EINVAL;
+		} else {
+			if (sps->bit_depth_luma_minus8 != 0)
+				/* Only 8-bit is supported */
+				return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static const struct v4l2_ctrl_ops cedrus_ctrl_ops = {
+	.try_ctrl = cedrus_try_ctrl,
+};
+
 static const struct cedrus_control cedrus_controls[] = {
 	{
 		.cfg = {
@@ -62,6 +106,7 @@ static const struct cedrus_control cedrus_controls[] = {
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_H264_SPS,
+			.ops	= &cedrus_ctrl_ops,
 		},
 		.codec		= CEDRUS_CODEC_H264,
 	},
@@ -120,6 +165,7 @@ static const struct cedrus_control cedrus_controls[] = {
 	{
 		.cfg = {
 			.id	= V4L2_CID_MPEG_VIDEO_HEVC_SPS,
+			.ops	= &cedrus_ctrl_ops,
 		},
 		.codec		= CEDRUS_CODEC_H265,
 	},
-- 
2.33.0

