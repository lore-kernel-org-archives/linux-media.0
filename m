Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A87C433E4
	for <linux-media@archiver.kernel.org>; Tue, 23 Mar 2021 12:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66A68619DD
	for <linux-media@archiver.kernel.org>; Tue, 23 Mar 2021 12:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhCWMID (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 23 Mar 2021 08:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhCWMH6 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 23 Mar 2021 08:07:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205A8C061574
        for <linux-media@vger.kernel.org>; Tue, 23 Mar 2021 05:07:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id A0ADC1F44C74
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>, kernel@collabora.com
Subject: [PATCH] media: hantro: fix kernel-doc warnings and style
Date:   Tue, 23 Mar 2021 09:07:46 -0300
Message-Id: <20210323120746.27321-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add a description for enum values in hantro_enc_fmt,
in order to fix these warnings:

drivers/staging/media/hantro/hantro_hw.h:149: warning: Enum value 'RK3288_VPU_ENC_FMT_YUV420P' not described in enum 'hantro_enc_fmt'
drivers/staging/media/hantro/hantro_hw.h:149: warning: Enum value 'RK3288_VPU_ENC_FMT_YUV420SP' not described in enum 'hantro_enc_fmt'
drivers/staging/media/hantro/hantro_hw.h:149: warning: Enum value 'RK3288_VPU_ENC_FMT_YUYV422' not described in enum 'hantro_enc_fmt'
drivers/staging/media/hantro/hantro_hw.h:149: warning: Enum value 'RK3288_VPU_ENC_FMT_UYVY422' not described in enum 'hantro_enc_fmt'

While here, improve the kernel-doc style, adding an empty
line before the fields of the structs.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/staging/media/hantro/hantro_hw.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
index 13a6e7113001..83b3e42b63a3 100644
--- a/drivers/staging/media/hantro/hantro_hw.h
+++ b/drivers/staging/media/hantro/hantro_hw.h
@@ -27,6 +27,7 @@ struct hantro_variant;
 
 /**
  * struct hantro_aux_buf - auxiliary DMA buffer for hardware data
+ *
  * @cpu:	CPU pointer to the buffer.
  * @dma:	DMA address of the buffer.
  * @size:	Size of the buffer.
@@ -41,6 +42,7 @@ struct hantro_aux_buf {
 
 /**
  * struct hantro_jpeg_enc_hw_ctx
+ *
  * @bounce_buffer:	Bounce buffer
  */
 struct hantro_jpeg_enc_hw_ctx {
@@ -52,6 +54,7 @@ struct hantro_jpeg_enc_hw_ctx {
 
 /**
  * struct hantro_h264_dec_ctrls
+ *
  * @decode:	Decode params
  * @scaling:	Scaling info
  * @sps:	SPS info
@@ -66,6 +69,7 @@ struct hantro_h264_dec_ctrls {
 
 /**
  * struct hantro_h264_dec_reflists
+ *
  * @p:		P reflist
  * @b0:		B0 reflist
  * @b1:		B1 reflist
@@ -78,6 +82,7 @@ struct hantro_h264_dec_reflists {
 
 /**
  * struct hantro_h264_dec_hw_ctx
+ *
  * @priv:	Private auxiliary buffer for hardware.
  * @dpb:	DPB
  * @reflists:	P/B0/B1 reflists
@@ -92,6 +97,7 @@ struct hantro_h264_dec_hw_ctx {
 
 /**
  * struct hantro_mpeg2_dec_hw_ctx
+ *
  * @qtable:		Quantization table
  */
 struct hantro_mpeg2_dec_hw_ctx {
@@ -100,6 +106,7 @@ struct hantro_mpeg2_dec_hw_ctx {
 
 /**
  * struct hantro_vp8_dec_hw_ctx
+ *
  * @segment_map:	Segment map buffer.
  * @prob_tbl:		Probability table buffer.
  */
@@ -140,6 +147,11 @@ struct hantro_codec_ops {
 
 /**
  * enum hantro_enc_fmt - source format ID for hardware registers.
+ *
+ * @RK3288_VPU_ENC_FMT_YUV420P: Y/CbCr 4:2:0 planar format
+ * @RK3288_VPU_ENC_FMT_YUV420SP: Y/CbCr 4:2:0 semi-planar format
+ * @RK3288_VPU_ENC_FMT_YUYV422: YUV 4:2:2 packed format (YUYV)
+ * @RK3288_VPU_ENC_FMT_UYVY422: YUV 4:2:2 packed format (UYVY)
  */
 enum hantro_enc_fmt {
 	RK3288_VPU_ENC_FMT_YUV420P = 0,
-- 
2.30.0

