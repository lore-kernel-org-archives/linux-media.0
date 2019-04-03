Return-Path: <SRS0=djxu=SF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983E2C4360F
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D3C20882
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsU3hn3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfDCWSY (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:18:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37499 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfDCWSY (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 3 Apr 2019 18:18:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so679070wmf.2
        for <linux-media@vger.kernel.org>; Wed, 03 Apr 2019 15:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wB7R+yjlvrN4rznzfX00KVoewVB8tpani/gC/kIYGuE=;
        b=XsU3hn3nBGLvKIGNkFPxRGo/sXuyxEEkrWOVh2Wqs+FWZ8+/YIUmT/69A8X0hmKpmF
         r3JFdYTu8p7TMfRanfSmQTfrRIvlaf714vinjOtsGChLQ4ApPiP/Xy9REbRBDKxWRfoF
         FBUF/zZIq+IyD/+0xUO8w++7LBEIdlrDT+0JQ5R7B+MwFYmJt0Yn3Q0KeXbRFtsqhOOZ
         Um3egXjnPt/O73gIYix+XmwZqIMT/8lF2Scdf/0mcujTifYppMwpuR7Qt/jfmegSog7x
         g6gLbXmBFQhmeSwsDA5uIWhNM6YlHOTPHUYLoy38xtDGj8C91hrPMH4a4hSpka/8hVkq
         FFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wB7R+yjlvrN4rznzfX00KVoewVB8tpani/gC/kIYGuE=;
        b=LfFBB8t8MWPClZBTSX6wsmA+NIjubKnxqp0cWv1Mh71Ah7AOmylUNiBo3uQmWYRA8Y
         5NYRjriHd6EIxDwhwb44stLRcLPc8+CZSLijkUdQYDFoIOItvBH1xjYys8VPgA3GrkeD
         nXHuzvuQhLVahB+q0BFsCNLHnCyjpU9wyJ3FaX1qkVXju2CBo8lgX0Fw5o8o2macFlN2
         +C7nJKMosT1cN/t7JvR9Eww+TuSjxegc1hpI/TUBDgL4f+kGP22RBuO8GvABMXj3YFrk
         Vci1tOnMdYDjjOJDAIc8VET11PbDViqiAP0Kzu3MN5OkuM+WCnmU9Td99U10UwJ+LC6I
         Xw4Q==
X-Gm-Message-State: APjAAAVH+sVDoEUuzDrxgMO7eZZMfD+15Mk8jhVLUoY2WSPz1lzSMvYN
        nIu9BVcJahD+I8AkoTAfmzE=
X-Google-Smtp-Source: APXvYqzoi+hvbY+n81Cis2RReQk4lLVH8kn6CHHWLY0yJCbVeXewzw+1CvfX8L0nYyPobt7+GP3VVg==
X-Received: by 2002:a1c:a8d3:: with SMTP id r202mr1645080wme.106.1554329901628;
        Wed, 03 Apr 2019 15:18:21 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id d6sm26019552wrx.62.2019.04.03.15.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 15:18:21 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     dafna3@gmail.com, linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com
Subject: [PATCH v2 11/16] media: vicodec: change fwht_encode_frame to get the header separately
Date:   Wed,  3 Apr 2019 15:14:56 -0700
Message-Id: <20190403221501.32814-12-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403221501.32814-1-dafna3@gmail.com>
References: <20190403221501.32814-1-dafna3@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

pass a pointer to the compressed frame header as a
different variable. This is a preparation for the
stateless encoder where the header is not in the same
buffer with the data.

Signed-off-by: Dafna Hirschfeld <dafna3@gmail.com>
---
 drivers/media/platform/vicodec/codec-v4l2-fwht.c | 9 ++++-----
 drivers/media/platform/vicodec/codec-v4l2-fwht.h | 3 ++-
 drivers/media/platform/vicodec/vicodec-core.c    | 9 +++++++--
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/vicodec/codec-v4l2-fwht.c b/drivers/media/platform/vicodec/codec-v4l2-fwht.c
index 01e7f09efc4e..6a88c6defd1e 100644
--- a/drivers/media/platform/vicodec/codec-v4l2-fwht.c
+++ b/drivers/media/platform/vicodec/codec-v4l2-fwht.c
@@ -199,12 +199,12 @@ static int prepare_raw_frame(struct fwht_raw_frame *rf,
 	return 0;
 }
 
-int v4l2_fwht_encode(struct v4l2_fwht_state *state, u8 *p_in, u8 *p_out)
+int v4l2_fwht_encode(struct v4l2_fwht_state *state, u8 *p_in, u8 *p_out,
+		     struct fwht_cframe_hdr *p_hdr)
 {
 	unsigned int size = state->stride * state->coded_height;
 	unsigned int chroma_stride = state->stride;
 	const struct v4l2_fwht_pixfmt_info *info = state->info;
-	struct fwht_cframe_hdr *p_hdr;
 	struct fwht_cframe cf;
 	struct fwht_raw_frame rf;
 	u32 encoding;
@@ -225,7 +225,7 @@ int v4l2_fwht_encode(struct v4l2_fwht_state *state, u8 *p_in, u8 *p_out)
 
 	cf.i_frame_qp = state->i_frame_qp;
 	cf.p_frame_qp = state->p_frame_qp;
-	cf.rlc_data = (__be16 *)(p_out + sizeof(*p_hdr));
+	cf.rlc_data = (__be16 *)p_out;
 
 	encoding = fwht_encode_frame(&rf, &state->ref_frame, &cf,
 				     !state->gop_cnt,
@@ -238,7 +238,6 @@ int v4l2_fwht_encode(struct v4l2_fwht_state *state, u8 *p_in, u8 *p_out)
 	if (++state->gop_cnt >= state->gop_size)
 		state->gop_cnt = 0;
 
-	p_hdr = (struct fwht_cframe_hdr *)p_out;
 	p_hdr->magic1 = FWHT_MAGIC1;
 	p_hdr->magic2 = FWHT_MAGIC2;
 	p_hdr->version = htonl(FWHT_VERSION);
@@ -266,7 +265,7 @@ int v4l2_fwht_encode(struct v4l2_fwht_state *state, u8 *p_in, u8 *p_out)
 	p_hdr->ycbcr_enc = htonl(state->ycbcr_enc);
 	p_hdr->quantization = htonl(state->quantization);
 	p_hdr->size = htonl(cf.size);
-	return cf.size + sizeof(*p_hdr);
+	return cf.size;
 }
 
 int v4l2_fwht_decode(struct v4l2_fwht_state *state, u8 *p_in, u8 *p_out)
diff --git a/drivers/media/platform/vicodec/codec-v4l2-fwht.h b/drivers/media/platform/vicodec/codec-v4l2-fwht.h
index 1a0d2a9f931a..e540cd58cf97 100644
--- a/drivers/media/platform/vicodec/codec-v4l2-fwht.h
+++ b/drivers/media/platform/vicodec/codec-v4l2-fwht.h
@@ -58,7 +58,8 @@ const struct v4l2_fwht_pixfmt_info *v4l2_fwht_find_nth_fmt(u32 width_div,
 							  u32 pixenc,
 							  unsigned int start_idx);
 
-int v4l2_fwht_encode(struct v4l2_fwht_state *state, u8 *p_in, u8 *p_out);
+int v4l2_fwht_encode(struct v4l2_fwht_state *state, u8 *p_in, u8 *p_out,
+		     struct fwht_cframe_hdr *hdr);
 int v4l2_fwht_decode(struct v4l2_fwht_state *state, u8 *p_in, u8 *p_out);
 
 #endif
diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index 52e8128d2d28..08073f914fd6 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -313,13 +313,18 @@ static int device_process(struct vicodec_ctx *ctx,
 	if (ctx->is_enc) {
 		struct vicodec_q_data *q_src;
 		int comp_sz_or_errcode;
+		struct fwht_cframe_hdr *p_hdr = (struct fwht_cframe_hdr *) p_dst;
+		u8 *comp_buf = p_dst + sizeof(struct fwht_cframe_hdr);
+
 
 		q_src = get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT);
 		state->info = q_src->info;
-		comp_sz_or_errcode = v4l2_fwht_encode(state, p_src, p_dst);
+		comp_sz_or_errcode = v4l2_fwht_encode(state, p_src, comp_buf,
+						      p_hdr);
 		if (comp_sz_or_errcode < 0)
 			return comp_sz_or_errcode;
-		vb2_set_plane_payload(&dst_vb->vb2_buf, 0, comp_sz_or_errcode);
+		vb2_set_plane_payload(&dst_vb->vb2_buf, 0,
+				      comp_sz_or_errcode + sizeof(*p_hdr));
 	} else {
 		struct vicodec_q_data *q_dst;
 		unsigned int comp_frame_size = ntohl(ctx->state.header.size);
-- 
2.17.1

