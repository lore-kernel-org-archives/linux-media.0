Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7279BC10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 12:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495D52133D
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 12:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbfDJMnD (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:43:03 -0400
Received: from kozue.soulik.info ([108.61.200.231]:44006 "EHLO
        kozue.soulik.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732035AbfDJMnD (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 08:43:03 -0400
Received: from misaki.sumomo.pri (unknown [IPv6:2001:470:b30d:2:c604:15ff:0:401])
        by kozue.soulik.info (Postfix) with ESMTPA id A5EA21014ED;
        Wed, 10 Apr 2019 21:43:48 +0900 (JST)
From:   ayaka <ayaka@soulik.info>
To:     linux-media@vger.kernel.org
Cc:     Randy Li <randy.li@rock-chips.com>, hverkuil@xs4all.nl,
        maxime.ripard@bootlin.com, joro@8bytes.org, nicolas@ndufresne.ca,
        jernej.skrabec@gmail.com, paul.kocialkowski@bootlin.com,
        thomas.petazzoni@bootlin.com, mchehab@kernel.org,
        ezequiel@collabora.com, posciak@chromium.org, groeck@chromium.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v3 5/9] [TEST]: rockchip: mpp: support qtable
Date:   Wed, 10 Apr 2019 20:42:22 +0800
Message-Id: <20190410124226.8612-6-ayaka@soulik.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410124226.8612-1-ayaka@soulik.info>
References: <20190410124226.8612-1-ayaka@soulik.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Randy Li <randy.li@rock-chips.com>

I don't care, I don't want to store buffers for a session.
I just want to use it to verify the FFmpeg.
---
 drivers/staging/rockchip-mpp/mpp_dev_common.h |  3 +++
 drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c  |  5 ++++-
 drivers/staging/rockchip-mpp/vdpu2/mpeg2.c    | 13 ++++++++-----
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rockchip-mpp/mpp_dev_common.h b/drivers/staging/rockchip-mpp/mpp_dev_common.h
index 36770af53a95..33d7725be67b 100644
--- a/drivers/staging/rockchip-mpp/mpp_dev_common.h
+++ b/drivers/staging/rockchip-mpp/mpp_dev_common.h
@@ -100,6 +100,9 @@ struct mpp_session {
 	struct v4l2_ctrl_handler ctrl_handler;
 	/* TODO: FIXME: slower than helper function ? */
 	struct v4l2_ctrl **ctrls;
+
+	dma_addr_t qtable_addr;
+	void *qtable_vaddr;
 };
 
 /* The context for the a task */
diff --git a/drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c b/drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c
index dbd9f334562e..1be73ab9c2be 100644
--- a/drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c
+++ b/drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c
@@ -246,6 +246,9 @@ static int rkvdpu_open(struct file *filp)
 	if (IS_ERR_OR_NULL(session))
 		return PTR_ERR(session);
 
+	session->qtable_vaddr = dmam_alloc_coherent(mpp_dev->dev, 64 * 4,
+						    &session->qtable_addr,
+						    GFP_KERNEL);
 	filp->private_data = &session->fh;
 	pm_runtime_get_sync(mpp_dev->dev);
 
@@ -529,7 +532,7 @@ static int rockchip_mpp_rkvdpu_probe(struct platform_device *pdev)
 	ret = mpp_dev_register_node(mpp_dev, mpp_dev->variant->node_name,
 				    NULL, &rkvdpu_ioctl_ops);
 	if (ret)
-		dev_err(dev, "register char device failed: %d\n", ret);
+		dev_err(dev, "register v4l2/media device failed: %d\n", ret);
 
 	memcpy(mpp_dev->fmt_out, fmt_out_templ, sizeof(fmt_out_templ));
 	memcpy(mpp_dev->fmt_cap, fmt_cap_templ, sizeof(fmt_cap_templ));
diff --git a/drivers/staging/rockchip-mpp/vdpu2/mpeg2.c b/drivers/staging/rockchip-mpp/vdpu2/mpeg2.c
index d32958c4cb20..837ee4a4a000 100644
--- a/drivers/staging/rockchip-mpp/vdpu2/mpeg2.c
+++ b/drivers/staging/rockchip-mpp/vdpu2/mpeg2.c
@@ -52,7 +52,7 @@ static const u8 intra_default_q_matrix[64] = {
 static void mpeg2_dec_copy_qtable(u8 * qtable, const struct v4l2_ctrl_mpeg2_quantization
 				  *ctrl)
 {
-	int i, n;
+	int i;
 
 	if (!qtable || !ctrl)
 		return;
@@ -111,16 +111,12 @@ int rkvdpu_mpeg2_gen_reg(struct mpp_session *session, void *regs,
 			 struct vb2_v4l2_buffer *src_buf)
 {
 	const struct v4l2_ctrl_mpeg2_slice_params *params;
-	const struct v4l2_ctrl_mpeg2_quantization *quantization;
 	const struct v4l2_mpeg2_sequence *sequence;
 	const struct v4l2_mpeg2_picture *picture;
 	struct vdpu2_regs *p_regs = regs;
 
 	params = rockchip_mpp_get_cur_ctrl(session,
 					   V4L2_CID_MPEG_VIDEO_MPEG2_SLICE_PARAMS);
-	quantization = rockchip_mpp_get_cur_ctrl(session,
-						 V4L2_CID_MPEG_VIDEO_MPEG2_QUANTIZATION);
-
 	if (!params)
 		return -EINVAL;
 
@@ -211,6 +207,7 @@ int rkvdpu_mpeg2_prepare_buf(struct mpp_session *session, void *regs)
 {
 	const struct v4l2_ctrl_mpeg2_slice_params *params;
 	const struct v4l2_mpeg2_sequence *sequence;
+	const struct v4l2_ctrl_mpeg2_quantization *quantization;
 	const struct v4l2_mpeg2_picture *picture;
 	struct vb2_v4l2_buffer *dst_buf;
 	dma_addr_t cur_addr, fwd_addr, bwd_addr;
@@ -223,6 +220,9 @@ int rkvdpu_mpeg2_prepare_buf(struct mpp_session *session, void *regs)
 	picture = &params->picture;
 	sequence = &params->sequence;
 
+	quantization = rockchip_mpp_get_cur_ctrl(session,
+			V4L2_CID_MPEG_VIDEO_MPEG2_QUANTIZATION);
+
 	dst_buf = v4l2_m2m_next_dst_buf(session->fh.m2m_ctx);
 	cur_addr = vb2_dma_contig_plane_dma_addr(&dst_buf->vb2_buf, 0);
 
@@ -266,5 +266,8 @@ int rkvdpu_mpeg2_prepare_buf(struct mpp_session *session, void *regs)
 		p_regs->sw135.refer3_base = cur_addr >> 2;
 	}
 
+	mpeg2_dec_copy_qtable(session->qtable_vaddr, quantization);
+        p_regs->sw61.qtable_base = session->qtable_addr;
+
 	return 0;
 }
-- 
2.20.1

