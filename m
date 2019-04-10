Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34561C10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 12:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A3C20818
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 12:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732034AbfDJMnB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:43:01 -0400
Received: from kozue.soulik.info ([108.61.200.231]:43986 "EHLO
        kozue.soulik.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732028AbfDJMnA (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 08:43:00 -0400
Received: from misaki.sumomo.pri (unknown [IPv6:2001:470:b30d:2:c604:15ff:0:401])
        by kozue.soulik.info (Postfix) with ESMTPA id 4C5791014EC;
        Wed, 10 Apr 2019 21:43:46 +0900 (JST)
From:   ayaka <ayaka@soulik.info>
To:     linux-media@vger.kernel.org
Cc:     ayaka <ayaka@soulik.info>, randy.li@rock-chips.com,
        hverkuil@xs4all.nl, maxime.ripard@bootlin.com, joro@8bytes.org,
        nicolas@ndufresne.ca, jernej.skrabec@gmail.com,
        paul.kocialkowski@bootlin.com, thomas.petazzoni@bootlin.com,
        mchehab@kernel.org, ezequiel@collabora.com, posciak@chromium.org,
        groeck@chromium.org, linux-rockchip@lists.infradead.org
Subject: [PATCH v3 4/9] [WIP]: rockchip: mpp: H.264 decoder ctrl data
Date:   Wed, 10 Apr 2019 20:42:21 +0800
Message-Id: <20190410124226.8612-5-ayaka@soulik.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410124226.8612-1-ayaka@soulik.info>
References: <20190410124226.8612-1-ayaka@soulik.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

I really don't want to do this.

Signed-off-by: Randy Li <randy.li@rock-chips.com>
Signed-off-by: ayaka <ayaka@soulik.info>
---
 drivers/staging/rockchip-mpp/Makefile         |   2 +-
 drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c |   8 +-
 .../staging/rockchip-mpp/rkvdec/avc-data.c    | 239 ++++++++++++++++++
 .../staging/rockchip-mpp/rkvdec/avc-data.h    |  40 +++
 drivers/staging/rockchip-mpp/rkvdec/avc.c     |  71 +++++-
 drivers/staging/rockchip-mpp/vdpu2/avc.c      | 165 ++++++++++++
 6 files changed, 514 insertions(+), 11 deletions(-)
 create mode 100644 drivers/staging/rockchip-mpp/rkvdec/avc-data.c
 create mode 100644 drivers/staging/rockchip-mpp/rkvdec/avc-data.h
 create mode 100644 drivers/staging/rockchip-mpp/vdpu2/avc.c

diff --git a/drivers/staging/rockchip-mpp/Makefile b/drivers/staging/rockchip-mpp/Makefile
index 8da33fa5142d..e2c2bf297812 100644
--- a/drivers/staging/rockchip-mpp/Makefile
+++ b/drivers/staging/rockchip-mpp/Makefile
@@ -2,7 +2,7 @@
 rk-mpp-service-objs := mpp_service.o
 rk-mpp-device-objs := mpp_dev_common.o
 rk-mpp-vdec-objs := mpp_dev_rkvdec.o
-rk-mpp-vdec-objs += rkvdec/avc.o
+rk-mpp-vdec-objs += rkvdec/avc.o rkvdec/avc-data.o
 rk-mpp-vdec-objs += rkvdec/hevc.o rkvdec/hevc-data.o rkvdec/rbsp.o
 rk-mpp-vdpu2-objs := mpp_dev_vdpu2.o vdpu2/mpeg2.o
 
diff --git a/drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c b/drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c
index 756821dbf829..97abfdfc344f 100644
--- a/drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c
+++ b/drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c
@@ -284,13 +284,15 @@ static int rkvdec_s_fmt_vid_cap_mplane(struct file *filp, void *priv,
 		    pix_mp->plane_fmt[1].bytesperline * ALIGN(pix_mp->height,
 							      8);
 #else
-		/* TODO: HEVC only request the height is aligned with 8 */
+		/*
+		 * TODO: H.264 would use 16 alignment while the resolution is under HD,
+		 * HEVC only request the height is aligned with 8
+		 */
 		pix_mp->plane_fmt[0].sizeimage =
 		    pix_mp->plane_fmt[0].bytesperline * ALIGN(pix_mp->height,
-							      16);
+							      8);
 		/* Additional space for motion vector */
 		pix_mp->plane_fmt[0].sizeimage *= 2;
-		pix_mp->plane_fmt[0].sizeimage += SZ_4M;
 		pix_mp->plane_fmt[1].sizeimage = SZ_2M;
 #endif
 		pix_mp->num_planes = 2;
diff --git a/drivers/staging/rockchip-mpp/rkvdec/avc-data.c b/drivers/staging/rockchip-mpp/rkvdec/avc-data.c
new file mode 100644
index 000000000000..57172528f988
--- /dev/null
+++ b/drivers/staging/rockchip-mpp/rkvdec/avc-data.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2019 Randy Li, <ayaka@soulik.info>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include "avc-data.h"
+
+static const u32 zig_zag_4x4[16] = {
+	0, 1, 4, 8, 5, 2, 3, 6, 9, 12, 13, 10, 7, 11, 14, 15
+};
+
+static const u32 zig_zag_8x8[64] = {
+	0, 1, 8, 16, 9, 2, 3, 10, 17, 24, 32, 25, 18, 11, 4, 5,
+	12, 19, 26, 33, 40, 48, 41, 34, 27, 20, 13, 6, 7, 14, 21, 28,
+	35, 42, 49, 56, 57, 50, 43, 36, 29, 22, 15, 23, 30, 37, 44, 51,
+	58, 59, 52, 45, 38, 31, 39, 46, 53, 60, 61, 54, 47, 55, 62, 63
+};
+
+static void fill_is_long_term(struct rbsp *rbsp, const struct v4l2_ctrl_h264_decode_param
+			      *decode_param)
+{
+	u16 is_long_term = 0;
+	u8 i;
+
+	for (i = 0; i < 16; i++)
+		if (decode_param->dpb[i].
+		    flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM)
+			is_long_term |= (1 << i);
+
+	rbsp_write_bits(rbsp, 16, is_long_term);
+}
+
+/* in zig-zag order */
+void rkvdec_avc_update_scaling_list(u8 * buf, const struct
+				    v4l2_ctrl_h264_scaling_matrix
+				    *scaling)
+{
+	u8 i, j;
+
+	for (i = 0; i < 6; i++)
+		for (j = 0; j < 16; j++)
+			buf[zig_zag_4x4[j] + (i << 4)] =
+			    scaling->scaling_list_4x4[i][j];
+
+	for (i = 0; i < 2; i++)
+		for (j = 0; j < 64; j++)
+			buf[zig_zag_8x8[j] + (i << 6)] =
+			    scaling->scaling_list_8x8[i][j];
+}
+
+int rkvdec_avc_write_sps(struct rbsp *rbsp,
+			 const struct v4l2_ctrl_h264_sps *sps)
+{
+	/* TODO: seq_parameter_set_id */
+	rbsp_write_bits(rbsp, 4, 0);
+	rbsp_write_bits(rbsp, 8, sps->profile_idc);
+	/* constraint_set3_flag */
+	rbsp_write_flag(rbsp, sps->constraint_set_flags >> 3);
+	rbsp_write_bits(rbsp, 2, sps->chroma_format_idc);
+	/* bit_depth_luma Not used */
+	rbsp_write_bits(rbsp, 3, sps->bit_depth_luma_minus8);
+	/* bit_depth_chroma Not used */
+	rbsp_write_bits(rbsp, 3, sps->bit_depth_chroma_minus8);
+	/* TODO: qpprime_y_zero_transform_bypass_flag */
+	rbsp_write_flag(rbsp, 0);
+	rbsp_write_bits(rbsp, 4, sps->log2_max_frame_num_minus4);
+	rbsp_write_bits(rbsp, 5, sps->max_num_ref_frames);
+	rbsp_write_bits(rbsp, 2, sps->pic_order_cnt_type);
+	rbsp_write_bits(rbsp, 4, sps->log2_max_pic_order_cnt_lsb_minus4);
+	/* delta_pic_order_always_zero_flag */
+	rbsp_write_flag(rbsp,
+			sps->flags &
+			V4L2_H264_SPS_FLAG_DELTA_PIC_ORDER_ALWAYS_ZERO);
+	rbsp_write_bits(rbsp, 9, sps->pic_width_in_mbs_minus1 + 1);
+	/* TODO: check whether it work for field coding */
+	rbsp_write_bits(rbsp, 9, sps->pic_height_in_map_units_minus1 + 1);
+	rbsp_write_flag(rbsp, sps->flags & V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY);
+	rbsp_write_flag(rbsp, sps->flags & V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIELD);
+	rbsp_write_flag(rbsp,
+			sps->flags & V4L2_H264_SPS_FLAG_DIRECT_8X8_INFERENCE);
+
+	/* TODO: mvc */
+	rbsp_write_flag(rbsp, 0);
+	/* num_views_minus1 */
+	rbsp_write_bits(rbsp, 2, 0);
+	/* view_id[0] */
+	rbsp_write_bits(rbsp, 10, 0);
+	/* view_id[1] */
+	rbsp_write_bits(rbsp, 10, 0);
+	/* num_anchor_refs_l0 */
+	rbsp_write_flag(rbsp, 0);
+	/* anchor_ref_l0 */
+	rbsp_write_bits(rbsp, 10, 0);
+	rbsp_write_flag(rbsp, 0);
+	rbsp_write_bits(rbsp, 10, 0);
+	/* num_non_anchor_refs_l0 */
+	rbsp_write_flag(rbsp, 0);
+	rbsp_write_bits(rbsp, 10, 0);
+	rbsp_write_flag(rbsp, 0);
+	rbsp_write_bits(rbsp, 10, 0);
+	/* Align with 128 bit */
+	rbsp_write_bits(rbsp, 2, 0);
+
+	return 0;
+}
+
+int rkvdec_avc_write_pps(struct rbsp *rbsp,
+			 const struct v4l2_ctrl_h264_pps *pps)
+{
+	/* TODO: pps_pic_parameter_set_id */
+	rbsp_write_bits(rbsp, 8, 0);
+	rbsp_write_bits(rbsp, 5, 0);
+	rbsp_write_flag(rbsp,
+			pps->flags & V4L2_H264_PPS_FLAG_ENTROPY_CODING_MODE);
+	rbsp_write_flag(rbsp,
+			pps->flags &
+			V4L2_H264_PPS_FLAG_BOTTOM_FIELD_PIC_ORDER_IN_FRAME_PRESENT);
+	rbsp_write_bits(rbsp, 5, pps->num_ref_idx_l0_default_active_minus1);
+	rbsp_write_bits(rbsp, 5, pps->num_ref_idx_l1_default_active_minus1);
+	rbsp_write_flag(rbsp, pps->flags & V4L2_H264_PPS_FLAG_WEIGHTED_PRED);
+	rbsp_write_bits(rbsp, 2, pps->weighted_bipred_idc);
+	rbsp_write_bits(rbsp, 7, pps->pic_init_qp_minus26);
+	rbsp_write_bits(rbsp, 6, pps->pic_init_qs_minus26);
+	rbsp_write_bits(rbsp, 5, pps->chroma_qp_index_offset);
+	rbsp_write_flag(rbsp,
+			pps->flags &
+			V4L2_H264_PPS_FLAG_DEBLOCKING_FILTER_CONTROL_PRESENT);
+	rbsp_write_flag(rbsp,
+			pps->flags & V4L2_H264_PPS_FLAG_CONSTRAINED_INTRA_PRED);
+	rbsp_write_flag(rbsp,
+			pps->flags &
+			V4L2_H264_PPS_FLAG_REDUNDANT_PIC_CNT_PRESENT);
+	rbsp_write_flag(rbsp,
+			pps->flags & V4L2_H264_PPS_FLAG_TRANSFORM_8X8_MODE);
+	rbsp_write_bits(rbsp, 5, pps->second_chroma_qp_index_offset);
+	rbsp_write_flag(rbsp,
+			pps->flags &
+			V4L2_H264_PPS_FLAG_PIC_SCALING_MATRIX_PRESENT);
+
+	return 0;
+}
+
+int rkvdec_avc_write_pps_tail(struct rbsp *rbsp, dma_addr_t scaling_addr, const struct v4l2_ctrl_h264_decode_param
+			      *decode_param)
+{
+	/* scaling list buffer */
+	rbsp_write_bits(rbsp, 32, scaling_addr);
+
+	/* DPB */
+	fill_is_long_term(rbsp, decode_param);
+
+	/* TODO: VOIdx, Layer id */
+	rbsp_write_bits(rbsp, 16, 0);
+
+	/* Align with 128 bit */
+	rbsp_write_bits(rbsp, 8, 0);
+
+	return 0;
+}
+
+static inline void fill_rps_list(struct rbsp *rbsp, const struct v4l2_ctrl_h264_decode_param
+				 *decode_param, const u8 * list)
+{
+	u8 i;
+
+	for (i = 0; i < 32; i++) {
+		u8 idx, active_flag;
+
+		idx = list[i];
+
+		active_flag = decode_param->dpb[idx].flags &
+		    V4L2_H264_DPB_ENTRY_FLAG_ACTIVE;
+		if (!active_flag) {
+			rbsp_write_bits(rbsp, 7, 0);
+		} else {
+			rbsp_write_bits(rbsp, 5, idx | BIT(5));
+			/* TODO: bottom flag */
+			rbsp_write_flag(rbsp, 0);
+			/* TODO: view id */
+			rbsp_write_flag(rbsp, 0);
+		}
+	}
+}
+
+int rkvdec_avc_write_rps(struct rbsp *rbsp,
+			 const struct v4l2_ctrl_h264_sps *sps,
+			 const struct v4l2_ctrl_h264_slice_param *slice_param,
+			 const struct v4l2_ctrl_h264_decode_param *decode_param)
+{
+	int max_frame_num = 1 << (sps->log2_max_frame_num_minus4 + 4);
+	u8 i;
+
+	for (i = 0; i < 16; i++) {
+		u16 frame_num = decode_param->dpb[i].frame_num;
+
+		rbsp_write_bits(rbsp, 16, frame_num > max_frame_num ?
+				frame_num - max_frame_num : frame_num);
+	}
+
+	/* reserved */
+	rbsp_write_bits(rbsp, 16, 0);
+	/* TODO: VoidX */
+	rbsp_write_bits(rbsp, 16, 0);
+
+	switch (slice_param->slice_type) {
+	case V4L2_H264_SLICE_TYPE_P:
+		fill_rps_list(rbsp, decode_param, slice_param->ref_pic_list0);
+		for (i = 0; i < 14; i++)
+			rbsp_write_bits(rbsp, 32, 0);
+		break;
+	case V4L2_H264_SLICE_TYPE_B:
+		for (i = 0; i < 7; i++)
+			rbsp_write_bits(rbsp, 32, 0);
+		fill_rps_list(rbsp, decode_param, slice_param->ref_pic_list0);
+		fill_rps_list(rbsp, decode_param, slice_param->ref_pic_list1);
+		break;
+	case V4L2_H264_SLICE_TYPE_I:
+		/* TODO: SVC */
+	default:
+		for (i = 0; i < 21; i++)
+			rbsp_write_bits(rbsp, 32, 0);
+		break;
+	}
+
+	rbsp_write_bits(rbsp, 32, 0);
+	rbsp_write_bits(rbsp, 32, 0);
+
+	return 0;
+}
diff --git a/drivers/staging/rockchip-mpp/rkvdec/avc-data.h b/drivers/staging/rockchip-mpp/rkvdec/avc-data.h
new file mode 100644
index 000000000000..38ad17273b8a
--- /dev/null
+++ b/drivers/staging/rockchip-mpp/rkvdec/avc-data.h
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2019 Randy Li, <ayaka@soulik.info>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/types.h>
+
+#include <linux/videodev2.h>
+#include <media/v4l2-ctrls.h>
+
+#include "rbsp.h"
+
+void rkvdec_avc_update_scaling_list(u8 * buf, const struct
+				    v4l2_ctrl_h264_scaling_matrix
+				    *scaling);
+
+int rkvdec_avc_write_sps(struct rbsp *rbsp,
+			 const struct v4l2_ctrl_h264_sps *sps);
+
+int rkvdec_avc_write_pps(struct rbsp *rbsp,
+			 const struct v4l2_ctrl_h264_pps *pps);
+
+int rkvdec_avc_write_pps_tail(struct rbsp *rbsp, dma_addr_t scaling_addr,
+			      const struct v4l2_ctrl_h264_decode_param *decode_param);
+
+int rkvdec_avc_write_rps(struct rbsp *rbsp,
+			 const struct v4l2_ctrl_h264_sps *sps,
+			 const struct v4l2_ctrl_h264_slice_param *slice_param,
+			 const struct v4l2_ctrl_h264_decode_param
+			 *decode_param);
diff --git a/drivers/staging/rockchip-mpp/rkvdec/avc.c b/drivers/staging/rockchip-mpp/rkvdec/avc.c
index 3d91a119e533..1cb5b2208bfa 100644
--- a/drivers/staging/rockchip-mpp/rkvdec/avc.c
+++ b/drivers/staging/rockchip-mpp/rkvdec/avc.c
@@ -24,6 +24,56 @@
 #include "mpp_dev_common.h"
 #include "hal.h"
 #include "regs.h"
+#include "avc-data.h"
+
+static void generate_input_data(struct rkvdec_regs *p_regs,
+				struct vb2_v4l2_buffer *src_buf,
+				const struct v4l2_ctrl_h264_sps *sps,
+				const struct v4l2_ctrl_h264_pps *pps,
+				const struct v4l2_ctrl_h264_scaling_matrix
+				*scaling, const struct v4l2_ctrl_h264_slice_param
+				*slice_param, const struct v4l2_ctrl_h264_decode_param
+				*decode_param)
+{
+	struct rbsp rbsp = { 0, };
+	size_t r_scaling_offs, r_sps_offs, r_rps_offs;
+	size_t stream_len = 0;
+	dma_addr_t scaling_addr = 0;
+	void *r_data = NULL;
+	int i;
+
+	stream_len = slice_param->size + 64;
+
+	r_data = vb2_plane_vaddr(&src_buf->vb2_buf, 0);
+	r_scaling_offs = ALIGN(stream_len, 16);
+	r_data += r_scaling_offs;
+
+	if (pps->flags & V4L2_H264_PPS_FLAG_PIC_SCALING_MATRIX_PRESENT) {
+		rkvdec_avc_update_scaling_list(r_data, scaling);
+		r_sps_offs = r_scaling_offs + 6 * 16 + 2 * 64 + 128;
+		r_sps_offs = ALIGN(r_sps_offs, 16);
+		scaling_addr = p_regs->sw_strm_rlc_base + r_scaling_offs;
+	} else {
+		r_sps_offs = r_scaling_offs;
+		scaling_addr = 0;
+	}
+
+	rbsp_init(&rbsp, r_data + r_sps_offs, SZ_2M - r_sps_offs, 0);
+	rkvdec_avc_write_sps(&rbsp, sps);
+	rkvdec_avc_write_pps(&rbsp, pps);
+	rkvdec_avc_write_pps_tail(&rbsp, scaling_addr, decode_param);
+	p_regs->sw_pps_base = p_regs->sw_strm_rlc_base + r_sps_offs;
+
+	for (i = 1; i < 256; i++)
+		memset(r_data + r_sps_offs + i * 32, 0, 32);
+
+	/* 256 bits */
+	r_rps_offs = r_sps_offs + 32 * 256 + 128;
+	r_rps_offs = ALIGN(r_rps_offs, 16);
+	rbsp_init(&rbsp, r_data + r_rps_offs, SZ_2M - r_rps_offs, 0);
+	rkvdec_avc_write_rps(&rbsp, sps, slice_param, decode_param);
+	p_regs->sw_rps_base = p_regs->sw_strm_rlc_base + r_rps_offs;
+}
 
 static void init_hw_cfg(struct rkvdec_regs *p_regs)
 {
@@ -152,18 +202,23 @@ int rkvdec_avc_gen_reg(struct mpp_session *session, void *regs,
 {
 	const struct v4l2_ctrl_h264_sps *sps;
 	const struct v4l2_ctrl_h264_pps *pps;
+	const struct v4l2_ctrl_h264_scaling_matrix *scaling;
 	const struct v4l2_ctrl_h264_slice_param *slice_param;
 	const struct v4l2_ctrl_h264_decode_param *decode_param;
 	struct vb2_v4l2_buffer *dst_buf;
 	struct rkvdec_regs *p_regs = regs;
-	size_t stream_len = 0;
 
 	sps = rockchip_mpp_get_cur_ctrl(session, V4L2_CID_MPEG_VIDEO_H264_SPS);
 	pps = rockchip_mpp_get_cur_ctrl(session, V4L2_CID_MPEG_VIDEO_H264_PPS);
-	slice_param = rockchip_mpp_get_cur_ctrl(session,
-						V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS);
-	decode_param = rockchip_mpp_get_cur_ctrl(session,
-						 V4L2_CID_MPEG_VIDEO_H264_DECODE_PARAMS);
+	scaling =
+	    rockchip_mpp_get_cur_ctrl(session,
+				      V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS);
+	slice_param =
+	    rockchip_mpp_get_cur_ctrl(session,
+				      V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS);
+	decode_param =
+	    rockchip_mpp_get_cur_ctrl(session,
+				      V4L2_CID_MPEG_VIDEO_H264_DECODE_PARAMS);
 
 	if (!sps || !pps || !slice_param || !decode_param)
 		return -EINVAL;
@@ -178,12 +233,14 @@ int rkvdec_avc_gen_reg(struct mpp_session *session, void *regs,
 	p_regs->sw_sysctrl.strm_start_bit = slice_param->header_bit_size;
 
 	/* hardware wants a zerod memory at the stream end */
-	stream_len = slice_param->size + 64;
-	p_regs->sw_stream_len = stream_len;
+	p_regs->sw_stream_len = slice_param->size + 64;
 
 	dst_buf = v4l2_m2m_next_dst_buf(session->fh.m2m_ctx);
 	rkvdec_avc_gen_ref(p_regs, dst_buf, decode_param);
 
+	generate_input_data(p_regs, src_buf, sps, pps, scaling, slice_param,
+			    decode_param);
+
 	return 0;
 }
 
diff --git a/drivers/staging/rockchip-mpp/vdpu2/avc.c b/drivers/staging/rockchip-mpp/vdpu2/avc.c
new file mode 100644
index 000000000000..f77bb8ef810a
--- /dev/null
+++ b/drivers/staging/rockchip-mpp/vdpu2/avc.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2019 Randy Li, <ayaka@soulik.info>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/types.h>
+
+#include <linux/videodev2.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-ioctl.h>
+#include <media/v4l2-mem2mem.h>
+#include <media/videobuf2-dma-contig.h>
+
+#include "mpp_dev_common.h"
+#include "hal.h"
+#include "regs.h"
+
+#define DEC_LITTLE_ENDIAN	(1)
+
+static const u8 zigzag[64] = {
+	0, 1, 8, 16, 9, 2, 3, 10,
+	17, 24, 32, 25, 18, 11, 4, 5,
+	12, 19, 26, 33, 40, 48, 41, 34,
+	27, 20, 13, 6, 7, 14, 21, 28,
+	35, 42, 49, 56, 57, 50, 43, 36,
+	29, 22, 15, 23, 30, 37, 44, 51,
+	58, 59, 52, 45, 38, 31, 39, 46,
+	53, 60, 61, 54, 47, 55, 62, 63
+};
+
+static const u8 intra_default_q_matrix[64] = {
+	8, 16, 19, 22, 26, 27, 29, 34,
+	16, 16, 22, 24, 27, 29, 34, 37,
+	19, 22, 26, 27, 29, 34, 34, 38,
+	22, 22, 26, 27, 29, 34, 37, 40,
+	22, 26, 27, 29, 32, 35, 40, 48,
+	26, 27, 29, 32, 35, 40, 48, 58,
+	26, 27, 29, 34, 38, 46, 56, 69,
+	27, 29, 35, 38, 46, 56, 69, 83
+};
+
+static void init_hw_cfg(struct vdpu2_regs *p_regs)
+{
+	p_regs->sw54.dec_strm_wordsp = 1;
+	p_regs->sw54.dec_strendian_e = DEC_LITTLE_ENDIAN;
+	p_regs->sw54.dec_in_wordsp = 1;
+	p_regs->sw54.dec_out_wordsp = 1;
+	p_regs->sw54.dec_in_endian = DEC_LITTLE_ENDIAN;	//change
+	p_regs->sw54.dec_out_endian = DEC_LITTLE_ENDIAN;
+	p_regs->sw57.dec_timeout = 1;
+	p_regs->sw57.dec_timeout_e = 1;
+
+	p_regs->sw57.dec_clk_gate_e = 1;
+	p_regs->sw57.pref_sigchan = 1;
+	p_regs->sw57.bus_pos_sel = 1;
+	p_regs->sw57.intra_dbl3t = 1;
+	p_regs->sw57.inter_dblspeed = 1;
+	p_regs->sw57.intra_dblspeed = 1;
+
+	p_regs->sw50.tiled_mode_msb = 0;
+	p_regs->sw56.dec_max_burst = 16;
+	p_regs->sw50.dec_scmd_dis = 0;
+	p_regs->sw50.dec_adv_pre_dis = 0;
+	p_regs->sw52.apf_threshold = 8;
+
+	p_regs->sw50.dec_latency = 0;
+	p_regs->sw56.dec_data_disc_e = 0;
+
+	p_regs->sw55.dec_irq = 0;
+	p_regs->sw56.dec_axi_rd_id = 0;
+	p_regs->sw56.dec_axi_wr_id = 0;
+
+        p_reg->sw59.pred_bc_tap_0_0 = 1;
+	/* -5 */
+        p_reg->sw59.pred_bc_tap_0_1 = 0x3fb;
+        p_reg->sw59.pred_bc_tap_0_2 = 20;
+
+	p_regs->sw53.dec_mode = RKVDPU2_FMT_H264D;
+}
+
+int rkvdpu_mpeg2_gen_reg(struct mpp_session *session, void *regs,
+			 struct vb2_v4l2_buffer *src_buf)
+{
+	const struct v4l2_ctrl_h264_sps *sps;
+	const struct v4l2_ctrl_h264_pps *pps;
+	const struct v4l2_ctrl_h264_scaling_matrix *scaling;
+	const struct v4l2_ctrl_h264_slice_param *slice_param;
+	const struct v4l2_ctrl_h264_decode_param *decode_param;
+	struct vb2_v4l2_buffer *dst_buf;
+	struct rkvdec_regs *p_regs = regs;
+
+	sps = rockchip_mpp_get_cur_ctrl(session, V4L2_CID_MPEG_VIDEO_H264_SPS);
+	pps = rockchip_mpp_get_cur_ctrl(session, V4L2_CID_MPEG_VIDEO_H264_PPS);
+	scaling =
+	    rockchip_mpp_get_cur_ctrl(session,
+				      V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS);
+	slice_param =
+	    rockchip_mpp_get_cur_ctrl(session,
+				      V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS);
+	decode_param =
+	    rockchip_mpp_get_cur_ctrl(session,
+				      V4L2_CID_MPEG_VIDEO_H264_DECODE_PARAMS);
+
+	if (!sps || !pps || !slice_param || !decode_param)
+		return -EINVAL;
+
+	init_hw_cfg(p_regs);
+
+	p_regs->sw120.pic_mb_width = sps->pic_width_in_mbs_minus1 + 1;
+	p_regs->sw120.pic_mb_height_p = sps->pic_height_in_map_units_minus1 + 1;
+
+#if 0
+	/* PICT_FRAME */
+	if (picture->picture_structure == 3) {
+		p_regs->sw57.pic_fieldmode_e = 0;
+	} else {
+		p_regs->sw57.pic_fieldmode_e = 1;
+		/* PICT_TOP_FIEL */
+		if (picture->picture_structure == 1)
+			p_regs->sw57.pic_topfield_e = 1;
+	}
+#endif
+	p_regs->sw51.qp_init = pps->pic_init_qp_minus26 + 26;
+	p_regs->sw114.max_refidx0 = slice_params->num_ref_idx_l0_active_minus1 + 1;
+	p_regs->sw111.max_refnum = sps->num_ref_frames;
+
+    p_regs->sw115.const_intra_en = pps->constrained_intra_pred_flag;
+
+#if 0
+    p_regs->sw112.dblk_ctrl_flag = pp->deblocking_filter_control_present_flag;
+    p_regs->sw112.rpcp_flag = pp->redundant_pic_cnt_present_flag;
+    p_regs->sw113.refpic_mk_len = p_hal->slice_long[0].drpm_used_bitlen;
+    p_regs->sw115.idr_pic_flag = p_hal->slice_long[0].idr_flag;
+    p_regs->sw113.idr_pic_id = p_hal->slice_long[0].idr_pic_id;
+    p_regs->sw114.pps_id = p_hal->slice_long[0].active_pps_id;
+    p_regs->sw114.poc_field_len = p_hal->slice_long[0].poc_used_bitlen;
+#endif
+
+	p_regs->sw52.startmb_x = 0;
+	p_regs->sw52.startmb_y = 0;
+	p_regs->sw57.dec_out_dis = 0;
+	p_regs->sw50.filtering_dis = 1;
+
+	p_regs->sw64.rlc_vlc_base =
+	    vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, 0);
+	p_regs->sw122.strm_start_bit = params->data_bit_offset;
+	stream_len = vb2_get_plane_payload(&src_buf->vb2_buf, 0);
+	p_regs->sw51.stream_len = stream_len;
+
+	qtable = vb2_plane_vaddr(&src_buf->vb2_buf, 0) + ALIGN(stream_len, 8);
+        p_regs->sw61.qtable_base = p_regs->sw64.rlc_vlc_base
+		+ ALIGN(stream_len, 8);
+
+	return 0;
+}
-- 
2.20.1

