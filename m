Return-Path: <SRS0=rHfj=S2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBEDC10F11
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 09:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C49020878
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 09:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfDXJhz (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:37:55 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:41493 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726262AbfDXJhz (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 24 Apr 2019 05:37:55 -0400
Received: from [IPv6:2001:420:44c1:2579:8575:c0e0:a08:6676] ([IPv6:2001:420:44c1:2579:8575:c0e0:a08:6676])
        by smtp-cloud7.xs4all.net with ESMTPA
        id JELdhJEI7ZVjxJELghZlMZ; Wed, 24 Apr 2019 11:37:52 +0200
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH] coda/venus/s5p_mfc: fix control typo
Message-ID: <fa365332-4280-6bb2-1d1c-00960f2cc199@xs4all.nl>
Date:   Wed, 24 Apr 2019 11:37:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKWEByQkDunD36YdvyjF8hMglbxPTSN/6atOGEhonIeBpQ5ZTgq93g1HVkIY5EcDzuWFyUGGCKd61KcAOFdPPUUUYvBAam5LnLSwlODkxiCZ48uU3V73
 E3iVFqYws2j1rL0+vt3bB6uCK04pJ76XKLP4gsZ2TBKUBasfnDXjdffXCdpT5+5F1FVlYSWjKriVQp/9pNep63j3fvtalHTy4JncVX24K1pzNVLujkL4+4om
 5NP/ASMGJn69p+NhChQTuK33UBwZsqfHwECy6ZVlaBoJtH5VIMOD3t8rEu6zYP6h1S9hfa8/SCaxGpLEcU0fTcQQRT1NiHPv3h11EjiT9d5ge63nzBUSaUjk
 HDd8RbyiE5VKfs6XAQPderZ3nIJvqsdP0EUGcWnzN8W/y5hAYBg=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

These two slice modes used by the V4L2_CID_MPEG_VIDEO_MULTI_SLICE_MODE
control had a silly typo:

V4L2_MPEG_VIDEO_MULTI_SICE_MODE_MAX_MB
V4L2_MPEG_VIDEO_MULTI_SICE_MODE_MAX_BYTES

SICE should be SLICE.

Rename these enum values, keeping the old ones (under #ifndef __KERNEL__)
for backwards compatibility reasons.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
diff --git a/drivers/media/platform/coda/coda-bit.c b/drivers/media/platform/coda/coda-bit.c
index eaa86737fa04..7e82ff704622 100644
--- a/drivers/media/platform/coda/coda-bit.c
+++ b/drivers/media/platform/coda/coda-bit.c
@@ -1043,7 +1043,7 @@ static int coda_start_encoding(struct coda_ctx *ctx)
 		case V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_SINGLE:
 			value = 0;
 			break;
-		case V4L2_MPEG_VIDEO_MULTI_SICE_MODE_MAX_MB:
+		case V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_MB:
 			value  = (ctx->params.slice_max_mb &
 				  CODA_SLICING_SIZE_MASK)
 				 << CODA_SLICING_SIZE_OFFSET;
@@ -1051,7 +1051,7 @@ static int coda_start_encoding(struct coda_ctx *ctx)
 				 << CODA_SLICING_UNIT_OFFSET;
 			value |=  1 & CODA_SLICING_MODE_MASK;
 			break;
-		case V4L2_MPEG_VIDEO_MULTI_SICE_MODE_MAX_BYTES:
+		case V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_BYTES:
 			value  = (ctx->params.slice_max_bits &
 				  CODA_SLICING_SIZE_MASK)
 				 << CODA_SLICING_SIZE_OFFSET;
diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index 3ce58dee4422..67f0e519ea18 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -2034,7 +2034,7 @@ static void coda_encode_ctrls(struct coda_ctx *ctx)
 	}
 	v4l2_ctrl_new_std_menu(&ctx->ctrls, &coda_ctrl_ops,
 		V4L2_CID_MPEG_VIDEO_MULTI_SLICE_MODE,
-		V4L2_MPEG_VIDEO_MULTI_SICE_MODE_MAX_BYTES, 0x0,
+		V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_BYTES, 0x0,
 		V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_SINGLE);
 	v4l2_ctrl_new_std(&ctx->ctrls, &coda_ctrl_ops,
 		V4L2_CID_MPEG_VIDEO_MULTI_SLICE_MAX_MB, 1, 0x3fffffff, 1, 1);
diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
index ac1e1d26f341..22ee704aa740 100644
--- a/drivers/media/platform/qcom/venus/venc_ctrls.c
+++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
@@ -274,7 +274,7 @@ int venc_ctrl_init(struct venus_inst *inst)

 	v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &venc_ctrl_ops,
 		V4L2_CID_MPEG_VIDEO_MULTI_SLICE_MODE,
-		V4L2_MPEG_VIDEO_MULTI_SICE_MODE_MAX_BYTES,
+		V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_BYTES,
 		0, V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_SINGLE);

 	v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &venc_ctrl_ops,
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
index 8fcf627dedfb..5505e4fc2090 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
@@ -134,7 +134,7 @@ static struct mfc_control controls[] = {
 		.id = V4L2_CID_MPEG_VIDEO_MULTI_SLICE_MODE,
 		.type = V4L2_CTRL_TYPE_MENU,
 		.minimum = V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_SINGLE,
-		.maximum = V4L2_MPEG_VIDEO_MULTI_SICE_MODE_MAX_BYTES,
+		.maximum = V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_BYTES,
 		.default_value = V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_SINGLE,
 		.menu_skip_mask = 0,
 	},
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c
index 6144e95f6425..e83ede3efca7 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c
@@ -695,9 +695,9 @@ static int s5p_mfc_set_enc_params(struct s5p_mfc_ctx *ctx)
 	/* multi-slice control */
 	/* multi-slice MB number or bit size */
 	mfc_write(dev, p->slice_mode, S5P_FIMV_ENC_MSLICE_CTRL);
-	if (p->slice_mode == V4L2_MPEG_VIDEO_MULTI_SICE_MODE_MAX_MB) {
+	if (p->slice_mode == V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_MB) {
 		mfc_write(dev, p->slice_mb, S5P_FIMV_ENC_MSLICE_MB);
-	} else if (p->slice_mode == V4L2_MPEG_VIDEO_MULTI_SICE_MODE_MAX_BYTES) {
+	} else if (p->slice_mode == V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_BYTES) {
 		mfc_write(dev, p->slice_bit, S5P_FIMV_ENC_MSLICE_BIT);
 	} else {
 		mfc_write(dev, 0, S5P_FIMV_ENC_MSLICE_MB);
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
index 281699ab7fe1..d75511190e47 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
@@ -736,10 +736,10 @@ static int s5p_mfc_set_slice_mode(struct s5p_mfc_ctx *ctx)
 	/* multi-slice control */
 	/* multi-slice MB number or bit size */
 	writel(ctx->slice_mode, mfc_regs->e_mslice_mode);
-	if (ctx->slice_mode == V4L2_MPEG_VIDEO_MULTI_SICE_MODE_MAX_MB) {
+	if (ctx->slice_mode == V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_MB) {
 		writel(ctx->slice_size.mb, mfc_regs->e_mslice_size_mb);
 	} else if (ctx->slice_mode ==
-			V4L2_MPEG_VIDEO_MULTI_SICE_MODE_MAX_BYTES) {
+			V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_BYTES) {
 		writel(ctx->slice_size.bits, mfc_regs->e_mslice_size_bits);
 	} else {
 		writel(0x0, mfc_regs->e_mslice_size_mb);
@@ -779,11 +779,11 @@ static int s5p_mfc_set_enc_params(struct s5p_mfc_ctx *ctx)
 	/* multi-slice MB number or bit size */
 	ctx->slice_mode = p->slice_mode;
 	reg = 0;
-	if (p->slice_mode == V4L2_MPEG_VIDEO_MULTI_SICE_MODE_MAX_MB) {
+	if (p->slice_mode == V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_MB) {
 		reg |= (0x1 << 3);
 		writel(reg, mfc_regs->e_enc_options);
 		ctx->slice_size.mb = p->slice_mb;
-	} else if (p->slice_mode == V4L2_MPEG_VIDEO_MULTI_SICE_MODE_MAX_BYTES) {
+	} else if (p->slice_mode == V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_BYTES) {
 		reg |= (0x1 << 3);
 		writel(reg, mfc_regs->e_enc_options);
 		ctx->slice_size.bits = p->slice_bit;
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 37807f23231e..9cad9fd969e3 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -392,8 +392,13 @@ enum v4l2_mpeg_video_header_mode {
 #define V4L2_CID_MPEG_VIDEO_MULTI_SLICE_MODE		(V4L2_CID_MPEG_BASE+221)
 enum v4l2_mpeg_video_multi_slice_mode {
 	V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_SINGLE		= 0,
+	V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_MB		= 1,
+	V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_BYTES	= 2,
+#ifndef __KERNEL__
+	/* Kept for backwards compatibility reasons. Stupid typo... */
 	V4L2_MPEG_VIDEO_MULTI_SICE_MODE_MAX_MB		= 1,
 	V4L2_MPEG_VIDEO_MULTI_SICE_MODE_MAX_BYTES	= 2,
+#endif
 };
 #define V4L2_CID_MPEG_VIDEO_VBV_SIZE			(V4L2_CID_MPEG_BASE+222)
 #define V4L2_CID_MPEG_VIDEO_DEC_PTS			(V4L2_CID_MPEG_BASE+223)
