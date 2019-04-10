Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0818C10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 12:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A6C2133D
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 12:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732041AbfDJMnI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:43:08 -0400
Received: from kozue.soulik.info ([108.61.200.231]:44030 "EHLO
        kozue.soulik.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732040AbfDJMnI (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 08:43:08 -0400
Received: from misaki.sumomo.pri (unknown [IPv6:2001:470:b30d:2:c604:15ff:0:401])
        by kozue.soulik.info (Postfix) with ESMTPA id 086B81014F2;
        Wed, 10 Apr 2019 21:43:53 +0900 (JST)
From:   ayaka <ayaka@soulik.info>
To:     linux-media@vger.kernel.org
Cc:     ayaka <ayaka@soulik.info>, randy.li@rock-chips.com,
        hverkuil@xs4all.nl, maxime.ripard@bootlin.com, joro@8bytes.org,
        nicolas@ndufresne.ca, jernej.skrabec@gmail.com,
        paul.kocialkowski@bootlin.com, thomas.petazzoni@bootlin.com,
        mchehab@kernel.org, ezequiel@collabora.com, posciak@chromium.org,
        groeck@chromium.org, linux-rockchip@lists.infradead.org
Subject: [PATCH v3 7/9] [TEST]: rkvdec: spspps address alignment
Date:   Wed, 10 Apr 2019 20:42:24 +0800
Message-Id: <20190410124226.8612-8-ayaka@soulik.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410124226.8612-1-ayaka@soulik.info>
References: <20190410124226.8612-1-ayaka@soulik.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

I found the offset for cpu access is not equal to the DMA
opeartion.

Signed-off-by: ayaka <ayaka@soulik.info>
---
 drivers/staging/rockchip-mpp/mpp_dev_common.h |  3 +++
 drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c |  3 +++
 drivers/staging/rockchip-mpp/rkvdec/avc.c     | 14 +++++++-------
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rockchip-mpp/mpp_dev_common.h b/drivers/staging/rockchip-mpp/mpp_dev_common.h
index 36770af53a95..6718bcccde1f 100644
--- a/drivers/staging/rockchip-mpp/mpp_dev_common.h
+++ b/drivers/staging/rockchip-mpp/mpp_dev_common.h
@@ -100,6 +100,9 @@ struct mpp_session {
 	struct v4l2_ctrl_handler ctrl_handler;
 	/* TODO: FIXME: slower than helper function ? */
 	struct v4l2_ctrl **ctrls;
+
+	void *aux_vaddr;
+	dma_addr_t aux_addr;
 };
 
 /* The context for the a task */
diff --git a/drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c b/drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c
index 97abfdfc344f..cc1fa9737bc1 100644
--- a/drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c
+++ b/drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c
@@ -382,6 +382,9 @@ static int rkvdec_open(struct file *filp)
 	filp->private_data = &session->fh;
 	pm_runtime_get_sync(mpp_dev->dev);
 
+	session->aux_vaddr = dmam_alloc_coherent(mpp_dev->dev, SZ_1M,
+						 &session->aux_addr, GFP_KERNEL);
+
 	mpp_debug_leave();
 	return 0;
 }
diff --git a/drivers/staging/rockchip-mpp/rkvdec/avc.c b/drivers/staging/rockchip-mpp/rkvdec/avc.c
index 1cb5b2208bfa..8266a990dca6 100644
--- a/drivers/staging/rockchip-mpp/rkvdec/avc.c
+++ b/drivers/staging/rockchip-mpp/rkvdec/avc.c
@@ -26,8 +26,8 @@
 #include "regs.h"
 #include "avc-data.h"
 
-static void generate_input_data(struct rkvdec_regs *p_regs,
-				struct vb2_v4l2_buffer *src_buf,
+static void generate_input_data(struct mpp_session *session,
+				struct rkvdec_regs *p_regs,
 				const struct v4l2_ctrl_h264_sps *sps,
 				const struct v4l2_ctrl_h264_pps *pps,
 				const struct v4l2_ctrl_h264_scaling_matrix
@@ -44,8 +44,8 @@ static void generate_input_data(struct rkvdec_regs *p_regs,
 
 	stream_len = slice_param->size + 64;
 
-	r_data = vb2_plane_vaddr(&src_buf->vb2_buf, 0);
-	r_scaling_offs = ALIGN(stream_len, 16);
+	r_data = session->aux_vaddr;
+	r_scaling_offs = 0;
 	r_data += r_scaling_offs;
 
 	if (pps->flags & V4L2_H264_PPS_FLAG_PIC_SCALING_MATRIX_PRESENT) {
@@ -62,7 +62,7 @@ static void generate_input_data(struct rkvdec_regs *p_regs,
 	rkvdec_avc_write_sps(&rbsp, sps);
 	rkvdec_avc_write_pps(&rbsp, pps);
 	rkvdec_avc_write_pps_tail(&rbsp, scaling_addr, decode_param);
-	p_regs->sw_pps_base = p_regs->sw_strm_rlc_base + r_sps_offs;
+	p_regs->sw_pps_base = session->aux_addr + r_sps_offs;
 
 	for (i = 1; i < 256; i++)
 		memset(r_data + r_sps_offs + i * 32, 0, 32);
@@ -72,7 +72,7 @@ static void generate_input_data(struct rkvdec_regs *p_regs,
 	r_rps_offs = ALIGN(r_rps_offs, 16);
 	rbsp_init(&rbsp, r_data + r_rps_offs, SZ_2M - r_rps_offs, 0);
 	rkvdec_avc_write_rps(&rbsp, sps, slice_param, decode_param);
-	p_regs->sw_rps_base = p_regs->sw_strm_rlc_base + r_rps_offs;
+	p_regs->sw_rps_base = session->aux_addr + r_rps_offs;
 }
 
 static void init_hw_cfg(struct rkvdec_regs *p_regs)
@@ -238,7 +238,7 @@ int rkvdec_avc_gen_reg(struct mpp_session *session, void *regs,
 	dst_buf = v4l2_m2m_next_dst_buf(session->fh.m2m_ctx);
 	rkvdec_avc_gen_ref(p_regs, dst_buf, decode_param);
 
-	generate_input_data(p_regs, src_buf, sps, pps, scaling, slice_param,
+	generate_input_data(session, p_regs, sps, pps, scaling, slice_param,
 			    decode_param);
 
 	return 0;
-- 
2.20.1

