Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EC7C10F14
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 12:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9AA20818
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 12:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbfDJMm7 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:42:59 -0400
Received: from kozue.soulik.info ([108.61.200.231]:43962 "EHLO
        kozue.soulik.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732026AbfDJMm7 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 08:42:59 -0400
Received: from misaki.sumomo.pri (unknown [IPv6:2001:470:b30d:2:c604:15ff:0:401])
        by kozue.soulik.info (Postfix) with ESMTPA id C4F861014EF;
        Wed, 10 Apr 2019 21:43:38 +0900 (JST)
From:   ayaka <ayaka@soulik.info>
To:     linux-media@vger.kernel.org
Cc:     Randy Li <randy.li@rock-chips.com>, hverkuil@xs4all.nl,
        maxime.ripard@bootlin.com, joro@8bytes.org, nicolas@ndufresne.ca,
        jernej.skrabec@gmail.com, paul.kocialkowski@bootlin.com,
        thomas.petazzoni@bootlin.com, mchehab@kernel.org,
        ezequiel@collabora.com, posciak@chromium.org, groeck@chromium.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v3 3/9] [WIP]: rockchip: mpp: HEVC decoder ctrl data
Date:   Wed, 10 Apr 2019 20:42:20 +0800
Message-Id: <20190410124226.8612-4-ayaka@soulik.info>
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

Not done yet, not enough data.

Signed-off-by: Randy Li <randy.li@rock-chips.com>
---
 drivers/staging/rockchip-mpp/Makefile         |   4 +-
 .../staging/rockchip-mpp/rkvdec/hevc-data.c   | 208 ++++++++++++++++++
 .../staging/rockchip-mpp/rkvdec/hevc-data.h   |  27 +++
 drivers/staging/rockchip-mpp/rkvdec/hevc.c    |   2 +
 4 files changed, 240 insertions(+), 1 deletion(-)
 create mode 100644 drivers/staging/rockchip-mpp/rkvdec/hevc-data.c
 create mode 100644 drivers/staging/rockchip-mpp/rkvdec/hevc-data.h

diff --git a/drivers/staging/rockchip-mpp/Makefile b/drivers/staging/rockchip-mpp/Makefile
index 9722b0059563..8da33fa5142d 100644
--- a/drivers/staging/rockchip-mpp/Makefile
+++ b/drivers/staging/rockchip-mpp/Makefile
@@ -1,7 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 rk-mpp-service-objs := mpp_service.o
 rk-mpp-device-objs := mpp_dev_common.o
-rk-mpp-vdec-objs := mpp_dev_rkvdec.o rkvdec/hevc.o rkvdec/avc.o
+rk-mpp-vdec-objs := mpp_dev_rkvdec.o
+rk-mpp-vdec-objs += rkvdec/avc.o
+rk-mpp-vdec-objs += rkvdec/hevc.o rkvdec/hevc-data.o rkvdec/rbsp.o
 rk-mpp-vdpu2-objs := mpp_dev_vdpu2.o vdpu2/mpeg2.o
 
 obj-$(CONFIG_ROCKCHIP_MPP_SERVICE) += rk-mpp-service.o
diff --git a/drivers/staging/rockchip-mpp/rkvdec/hevc-data.c b/drivers/staging/rockchip-mpp/rkvdec/hevc-data.c
new file mode 100644
index 000000000000..26694a2f46c5
--- /dev/null
+++ b/drivers/staging/rockchip-mpp/rkvdec/hevc-data.c
@@ -0,0 +1,208 @@
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
+#include "hevc-data.h"
+
+/* 7.3.2.2.1 General sequence parameter set RBSP syntax */
+int rkvdec_hevc_write_sps(struct rbsp *rbsp,
+			  const struct v4l2_ctrl_hevc_sps *sps)
+{
+	/* TODO: sps_video_parameter_set_id */
+	rbsp_write_bits(rbsp, 4, 0);
+	/* TODO: sps_seq_parameter_set_id */
+	rbsp_write_bits(rbsp, 4, 0);
+	/* chroma_format_idc */
+	rbsp_write_bits(rbsp, 2, sps->chroma_format_idc);
+	rbsp_write_bits(rbsp, 13, sps->pic_width_in_luma_samples);
+	rbsp_write_bits(rbsp, 13, sps->pic_height_in_luma_samples);
+	/* bit_depth_luma */
+	rbsp_write_bits(rbsp, 4, sps->bit_depth_luma_minus8 + 8);
+	rbsp_write_bits(rbsp, 4, sps->bit_depth_chroma_minus8 + 8);
+	/* log2_max_pic_order_cnt_lsb */
+	rbsp_write_bits(rbsp, 5, sps->log2_max_pic_order_cnt_lsb_minus4 + 4);
+	/* FIXME it is 3 bits in document */
+	rbsp_write_bits(rbsp, 2, sps->log2_diff_max_min_luma_coding_block_size);
+	/* log2_min_luma_coding_block_size */
+	rbsp_write_bits(rbsp, 3,
+			sps->log2_min_luma_coding_block_size_minus3 + 3);
+	/* log2_min_transform_block_size */
+	rbsp_write_bits(rbsp, 3,
+			sps->log2_min_luma_transform_block_size_minus2 + 2);
+	rbsp_write_bits(rbsp, 2,
+			sps->log2_diff_max_min_luma_transform_block_size);
+	rbsp_write_bits(rbsp, 3, sps->max_transform_hierarchy_depth_inter);
+	rbsp_write_bits(rbsp, 3, sps->max_transform_hierarchy_depth_intra);
+
+	rbsp_write_flag(rbsp, sps->scaling_list_enabled_flag);
+	rbsp_write_flag(rbsp, sps->amp_enabled_flag);
+	rbsp_write_flag(rbsp, sps->sample_adaptive_offset_enabled_flag);
+	rbsp_write_flag(rbsp, sps->pcm_enabled_flag);
+
+	/* pcm_sample_bit_depth_luma */
+	rbsp_write_bits(rbsp, 4, sps->pcm_sample_bit_depth_luma_minus1 + 1);
+	/* pcm_sample_bit_depth_chroma */
+	rbsp_write_bits(rbsp, 4, sps->pcm_sample_bit_depth_chroma_minus1 + 1);
+	rbsp_write_flag(rbsp, sps->pcm_loop_filter_disabled_flag);
+
+	rbsp_write_bits(rbsp, 3,
+			sps->log2_diff_max_min_pcm_luma_coding_block_size);
+	/* log2_min_pcm_luma_coding_block_size */
+	rbsp_write_bits(rbsp, 3,
+			sps->log2_min_pcm_luma_coding_block_size_minus3 + 3);
+	rbsp_write_bits(rbsp, 7, sps->num_short_term_ref_pic_sets);
+	rbsp_write_flag(rbsp, sps->long_term_ref_pics_present_flag);
+	rbsp_write_bits(rbsp, 6, sps->num_long_term_ref_pics_sps);
+	rbsp_write_flag(rbsp, sps->sps_temporal_mvp_enabled_flag);
+	rbsp_write_flag(rbsp, sps->strong_intra_smoothing_enabled_flag);
+	/* Above is 100 bits total */
+#if 0
+	/* transform_skip_rotation_enabled_flag to intra_smoothing_disabled_flag */
+	rbsp_write_bits(rbsp, 7, 0);
+	/* sps_max_dec_pic_buffering_minus1 */
+	rbsp_write_bits(rbsp, 4, sps->sps_max_dec_pic_buffering_minus1);
+	rbsp_write_flag(rbsp, sps->separate_colour_plane_flag);
+	/* TODO: high_precision_offsets_enabled */
+	rbsp_write_flag(rbsp, 0);
+	/* TODO: persistent_rice_adaptation_enabled_flag */
+	rbsp_write_flag(rbsp, 0);
+	/* reserved */
+	rbsp_write_bits(rbsp, 14, 0xffffffff);
+#else
+	rbsp_write_bits(rbsp, 7, 0);
+	/* padding */
+	rbsp_write_bits(rbsp, 21, 0xffffffff);
+#endif
+
+	return 0;
+}
+
+int rkvdec_hevc_write_pps(struct rbsp *rbsp,
+			  const struct v4l2_ctrl_hevc_sps *sps,
+			  const struct v4l2_ctrl_hevc_pps *pps,
+			  const struct v4l2_ctrl_hevc_slice_params *slice_params)
+{
+
+	u32 min_cb_log2_size_y, ctb_log2_size_y, log2_min_cu_qp_delta_size;
+	u16 column_width[20] = { 0, };
+	u16 row_height[22] = { 0, };
+	u8 i;
+
+	min_cb_log2_size_y = sps->log2_min_luma_coding_block_size_minus3 + 3;
+	ctb_log2_size_y = min_cb_log2_size_y +
+	    sps->log2_diff_max_min_luma_coding_block_size;
+
+	log2_min_cu_qp_delta_size = ctb_log2_size_y - pps->diff_cu_qp_delta_depth;
+
+	/* pps_pic_parameter_set_id */
+	rbsp_write_bits(rbsp, 6, 0);
+	/* pps_seq_parameter_set_id */
+	rbsp_write_bits(rbsp, 4, 0);
+	/* dependent_slice_segments_enabled_flag */
+	rbsp_write_flag(rbsp, pps->dependent_slice_segment_flag);
+	rbsp_write_flag(rbsp, pps->output_flag_present_flag);
+	/* FIXME it is 3 bits in document */
+	rbsp_write_bits(rbsp, 13, pps->num_extra_slice_header_bits);
+	/* sign_data_hiding_flag */
+	rbsp_write_flag(rbsp, pps->sign_data_hiding_enabled_flag);
+	rbsp_write_flag(rbsp, pps->cabac_init_present_flag);
+	/* FIXME: from slice params ? */
+	rbsp_write_bits(rbsp, 4, slice_params->num_ref_idx_l0_active_minus1 + 1);
+	rbsp_write_bits(rbsp, 4, slice_params->num_ref_idx_l1_active_minus1 + 1);
+	/* FIXME it is 6 bits in document init_qp_minus26 */
+	rbsp_write_bits(rbsp, 7, pps->init_qp_minus26);
+	rbsp_write_flag(rbsp, pps->constrained_intra_pred_flag);
+	rbsp_write_flag(rbsp, pps->transform_skip_enabled_flag);
+	rbsp_write_flag(rbsp, pps->cu_qp_delta_enabled_flag);
+	/* Log2MinCuQpDeltaSize */
+	rbsp_write_bits(rbsp, 3, log2_min_cu_qp_delta_size);
+	rbsp_write_bits(rbsp, 5, pps->pps_cb_qp_offset);
+	rbsp_write_bits(rbsp, 5, pps->pps_cr_qp_offset);
+	rbsp_write_flag(rbsp, pps->pps_slice_chroma_qp_offsets_present_flag);
+	rbsp_write_flag(rbsp, pps->weighted_pred_flag);
+	rbsp_write_flag(rbsp, pps->weighted_bipred_flag);
+	rbsp_write_flag(rbsp, pps->transquant_bypass_enabled_flag);
+	rbsp_write_flag(rbsp, pps->tiles_enabled_flag);
+	rbsp_write_flag(rbsp, pps->entropy_coding_sync_enabled_flag);
+	rbsp_write_flag(rbsp, pps->pps_loop_filter_across_slices_enabled_flag);
+	rbsp_write_flag(rbsp, pps->loop_filter_across_tiles_enabled_flag);
+	rbsp_write_flag(rbsp, pps->deblocking_filter_override_enabled_flag);
+	/* pps_deblocking_filter_disabled_flag */
+	rbsp_write_flag(rbsp, pps->pps_disable_deblocking_filter_flag);
+	rbsp_write_bits(rbsp, 4, pps->pps_beta_offset_div2);
+	rbsp_write_bits(rbsp, 4, pps->pps_tc_offset_div2);
+	rbsp_write_flag(rbsp, pps->lists_modification_present_flag);
+	rbsp_write_bits(rbsp, 3, pps->log2_parallel_merge_level_minus2 + 2);
+	rbsp_write_flag(rbsp, pps->slice_segment_header_extension_present_flag);
+	/* reserved, log2_transform_skip_max_size_minus2 */
+	rbsp_write_bits(rbsp, 3, 0);
+	/* num_tile_columns */
+	rbsp_write_bits(rbsp, 5, pps->num_tile_columns_minus1 + 1);
+	/* num_tile_rows */
+	rbsp_write_bits(rbsp, 5, pps->num_tile_rows_minus1 + 1);
+	/* ? */
+	rbsp_write_bits(rbsp, 3, 2);
+	/* align 30 ? */
+	rbsp_write_bits(rbsp, 32, 0xffffffff);
+
+	/* TODO: support tile video */
+	column_width[0] = 0;
+	row_height[0] = 0;
+
+	for (i = 0; i < 20; i++) {
+		if (column_width[i])
+			column_width[i]--;
+		rbsp_write_bits(rbsp, column_width[i], 8);
+	}
+	for (i = 0; i < 22; i++) {
+		if (row_height[i])
+			row_height[i]--;
+		rbsp_write_bits(rbsp, row_height[i], 8);
+	}
+
+	/* TODO: scaleing_address */
+
+	return 0;
+}
+
+int rkvdec_hevc_write_soft_rps(struct rbsp *rbsp,
+			  const struct v4l2_ctrl_hevc_slice_params *slice_params)
+{
+	int i;
+
+	for (i = 0; i < 15; i++) {
+		/* FIXME: is long term */
+		rbsp_write_flag(rbsp, 0);
+		rbsp_write_bits(rbsp, 4, slice_params->ref_idx_l0[i]);
+	}
+
+	for (i = 0; i < 15; i++) {
+		/* FIXME: is long term */
+		rbsp_write_flag(rbsp, 0);
+		rbsp_write_bits(rbsp, 4, slice_params->ref_idx_l1[i]);
+	}
+	/* TODO: lowdelay_flag */
+	rbsp_write_flag(rbsp, 1);
+
+	/* TODO: Rps_bit_offset_include_lt */
+	rbsp_write_bits(rbsp, 10, 0);
+	rbsp_write_bits(rbsp, 9, 0);
+}
+
+/* 7.3.7 Short-term reference picture set syntax */
+int rkvdec_hevc_write_rps(struct rbsp *rbsp,
+			  const struct v4l2_ctrl_hevc_pps *pps)
+{
+
+}
diff --git a/drivers/staging/rockchip-mpp/rkvdec/hevc-data.h b/drivers/staging/rockchip-mpp/rkvdec/hevc-data.h
new file mode 100644
index 000000000000..6b94cd41d377
--- /dev/null
+++ b/drivers/staging/rockchip-mpp/rkvdec/hevc-data.h
@@ -0,0 +1,27 @@
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
+int rkvdec_hevc_write_sps(struct rbsp *rbsp,
+			  const struct v4l2_ctrl_hevc_sps *sps);
+
+int rkvdec_hevc_write_rps(struct rbsp *rbsp,
+			  const struct v4l2_ctrl_hevc_pps *pps);
diff --git a/drivers/staging/rockchip-mpp/rkvdec/hevc.c b/drivers/staging/rockchip-mpp/rkvdec/hevc.c
index 78f150000128..6f74ce45533a 100644
--- a/drivers/staging/rockchip-mpp/rkvdec/hevc.c
+++ b/drivers/staging/rockchip-mpp/rkvdec/hevc.c
@@ -25,6 +25,8 @@
 #include "hal.h"
 #include "regs.h"
 
+#include "hevc-data.h"
+
 static void init_hw_cfg(struct rkvdec_regs *p_regs)
 {
 	p_regs->sw_interrupt.dec_e = 1;
-- 
2.20.1

