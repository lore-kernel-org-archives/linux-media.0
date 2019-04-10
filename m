Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965E4C10F14
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 12:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E07320818
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 12:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732039AbfDJMnF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:43:05 -0400
Received: from kozue.soulik.info ([108.61.200.231]:44030 "EHLO
        kozue.soulik.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732035AbfDJMnF (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 08:43:05 -0400
Received: from misaki.sumomo.pri (unknown [IPv6:2001:470:b30d:2:c604:15ff:0:401])
        by kozue.soulik.info (Postfix) with ESMTPA id CB93F1014F0;
        Wed, 10 Apr 2019 21:43:51 +0900 (JST)
From:   ayaka <ayaka@soulik.info>
To:     linux-media@vger.kernel.org
Cc:     Randy Li <randy.li@rock-chips.com>, hverkuil@xs4all.nl,
        maxime.ripard@bootlin.com, joro@8bytes.org, nicolas@ndufresne.ca,
        jernej.skrabec@gmail.com, paul.kocialkowski@bootlin.com,
        thomas.petazzoni@bootlin.com, mchehab@kernel.org,
        ezequiel@collabora.com, posciak@chromium.org, groeck@chromium.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v3 6/9] [TEST]: rockchip: mpp: vdpu2: move qtable to input buffer
Date:   Wed, 10 Apr 2019 20:42:23 +0800
Message-Id: <20190410124226.8612-7-ayaka@soulik.info>
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

I want the memory region !!!
It can save more time if those data are prepared in userspace.

Signed-off-by: Randy Li <randy.li@rock-chips.com>
---
 drivers/staging/rockchip-mpp/mpp_dev_common.c |  3 +--
 drivers/staging/rockchip-mpp/mpp_dev_common.h |  3 ---
 drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c  |  3 +++
 drivers/staging/rockchip-mpp/vdpu2/mpeg2.c    | 20 +++++++++++--------
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rockchip-mpp/mpp_dev_common.c b/drivers/staging/rockchip-mpp/mpp_dev_common.c
index 21816ad8a43b..97c4d897f168 100644
--- a/drivers/staging/rockchip-mpp/mpp_dev_common.c
+++ b/drivers/staging/rockchip-mpp/mpp_dev_common.c
@@ -1217,8 +1217,7 @@ static int rockchip_mpp_queue_init(void *priv, struct vb2_queue *src_vq,
 	src_vq->io_modes = VB2_MMAP | VB2_DMABUF;
 	src_vq->drv_priv = session;
 	src_vq->mem_ops = &vb2_dma_contig_memops;
-	src_vq->dma_attrs = DMA_ATTR_ALLOC_SINGLE_PAGES |
-			    DMA_ATTR_NO_KERNEL_MAPPING;
+	src_vq->dma_attrs = DMA_ATTR_ALLOC_SINGLE_PAGES;
 	src_vq->buf_struct_size = sizeof(struct v4l2_m2m_buffer);
 	src_vq->min_buffers_needed = 1;
 	src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
diff --git a/drivers/staging/rockchip-mpp/mpp_dev_common.h b/drivers/staging/rockchip-mpp/mpp_dev_common.h
index 33d7725be67b..36770af53a95 100644
--- a/drivers/staging/rockchip-mpp/mpp_dev_common.h
+++ b/drivers/staging/rockchip-mpp/mpp_dev_common.h
@@ -100,9 +100,6 @@ struct mpp_session {
 	struct v4l2_ctrl_handler ctrl_handler;
 	/* TODO: FIXME: slower than helper function ? */
 	struct v4l2_ctrl **ctrls;
-
-	dma_addr_t qtable_addr;
-	void *qtable_vaddr;
 };
 
 /* The context for the a task */
diff --git a/drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c b/drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c
index 1be73ab9c2be..92d68b962fe1 100644
--- a/drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c
+++ b/drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c
@@ -176,6 +176,9 @@ static int rkvdpu_s_fmt_vid_out_mplane(struct file *filp, void *priv,
 	if (sizes >= SZ_16M)
 		return -EINVAL;
 
+	/* For those slice header data */
+	pix_mp->plane_fmt[pix_mp->num_planes - 1].sizeimage += SZ_1M;
+
 	if (vdpu_setup_ctrls(session, pix_mp->pixelformat))
 		return -EINVAL;
 
diff --git a/drivers/staging/rockchip-mpp/vdpu2/mpeg2.c b/drivers/staging/rockchip-mpp/vdpu2/mpeg2.c
index 837ee4a4a000..c12d1a8ef2da 100644
--- a/drivers/staging/rockchip-mpp/vdpu2/mpeg2.c
+++ b/drivers/staging/rockchip-mpp/vdpu2/mpeg2.c
@@ -113,7 +113,10 @@ int rkvdpu_mpeg2_gen_reg(struct mpp_session *session, void *regs,
 	const struct v4l2_ctrl_mpeg2_slice_params *params;
 	const struct v4l2_mpeg2_sequence *sequence;
 	const struct v4l2_mpeg2_picture *picture;
+	const struct v4l2_ctrl_mpeg2_quantization *quantization;
 	struct vdpu2_regs *p_regs = regs;
+	void *qtable = NULL;
+	size_t stream_len = 0;
 
 	params = rockchip_mpp_get_cur_ctrl(session,
 					   V4L2_CID_MPEG_VIDEO_MPEG2_SLICE_PARAMS);
@@ -122,6 +125,8 @@ int rkvdpu_mpeg2_gen_reg(struct mpp_session *session, void *regs,
 
 	sequence = &params->sequence;
 	picture = &params->picture;
+	quantization = rockchip_mpp_get_cur_ctrl(session,
+			V4L2_CID_MPEG_VIDEO_MPEG2_QUANTIZATION);
 
 	init_hw_cfg(p_regs);
 
@@ -198,7 +203,13 @@ int rkvdpu_mpeg2_gen_reg(struct mpp_session *session, void *regs,
 	p_regs->sw64.rlc_vlc_base =
 	    vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, 0);
 	p_regs->sw122.strm_start_bit = params->data_bit_offset;
-	p_regs->sw51.stream_len = vb2_get_plane_payload(&src_buf->vb2_buf, 0);
+	stream_len = vb2_get_plane_payload(&src_buf->vb2_buf, 0);
+	p_regs->sw51.stream_len = stream_len;
+
+	qtable = vb2_plane_vaddr(&src_buf->vb2_buf, 0) + ALIGN(stream_len, 8);
+	mpeg2_dec_copy_qtable(qtable, quantization);
+        p_regs->sw61.qtable_base = p_regs->sw64.rlc_vlc_base
+		+ ALIGN(stream_len, 8);
 
 	return 0;
 }
@@ -207,7 +218,6 @@ int rkvdpu_mpeg2_prepare_buf(struct mpp_session *session, void *regs)
 {
 	const struct v4l2_ctrl_mpeg2_slice_params *params;
 	const struct v4l2_mpeg2_sequence *sequence;
-	const struct v4l2_ctrl_mpeg2_quantization *quantization;
 	const struct v4l2_mpeg2_picture *picture;
 	struct vb2_v4l2_buffer *dst_buf;
 	dma_addr_t cur_addr, fwd_addr, bwd_addr;
@@ -220,9 +230,6 @@ int rkvdpu_mpeg2_prepare_buf(struct mpp_session *session, void *regs)
 	picture = &params->picture;
 	sequence = &params->sequence;
 
-	quantization = rockchip_mpp_get_cur_ctrl(session,
-			V4L2_CID_MPEG_VIDEO_MPEG2_QUANTIZATION);
-
 	dst_buf = v4l2_m2m_next_dst_buf(session->fh.m2m_ctx);
 	cur_addr = vb2_dma_contig_plane_dma_addr(&dst_buf->vb2_buf, 0);
 
@@ -266,8 +273,5 @@ int rkvdpu_mpeg2_prepare_buf(struct mpp_session *session, void *regs)
 		p_regs->sw135.refer3_base = cur_addr >> 2;
 	}
 
-	mpeg2_dec_copy_qtable(session->qtable_vaddr, quantization);
-        p_regs->sw61.qtable_base = session->qtable_addr;
-
 	return 0;
 }
-- 
2.20.1

