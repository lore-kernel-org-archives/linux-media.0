Return-Path: <SRS0=djxu=SF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955CBC4360F
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A052133D
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6iSFLOA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfDCWSU (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:18:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33465 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfDCWSU (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 3 Apr 2019 18:18:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so922720wrp.0
        for <linux-media@vger.kernel.org>; Wed, 03 Apr 2019 15:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Iw+AiiVSZiXn+dUTNAfRPSjZqjh6DGkXBoEk8Pxaxkk=;
        b=i6iSFLOAT9VKQzILeGTkIr4d3yFukxiVTNkmcuRutEbsjOLrVvm+lE57MM98SdF+0V
         rIqBBnMgAAdjomvcDTgNbgcpiWNWO8ccl3xAC5G3FScNrVj+uHUaxlGt5CT9I6WFZt7b
         pLYD73gx30rCfwpWmDpyVhxXHVIh5LJaZ2Umlj9vxwEyhN7s9gDikvMwZocRepC3WL8B
         eC0nTHJHUlohxafx5M1etatpj+LF37F9pY0urbcQm6N8xObxT8CZizmgD7J8MnAZhYly
         hlEpNpSOAZO7UpEYdfPBcPZt+oPBXC8FyxkFrnNmWJ/KT+hhgu0n54sZLhAayDYMBt5t
         R5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Iw+AiiVSZiXn+dUTNAfRPSjZqjh6DGkXBoEk8Pxaxkk=;
        b=crqqQ22og3D89cr6DZtG44MXfwz6B5BfDAitCtMZdw/o/L+dolIBJe/91UogOdvTwl
         KGlAFxIXxJrIw8pMtolYGK7nJ0FLsJTPaxuGBQGHxeT9hERW8OlDgADXxQ96eknHqcEg
         f5Fz6KKbfey7syOJShW7NLm8mxSCaejT3X3sQ/pxDasji8Xap9kjgsfeD6+LCwf9sffc
         6k0s4BBIoZYMqzVwmLynQnoR11SJ9ulBShsgDXHtBWjrD9XokGA+aMWwLlAMRtyso/lV
         OXzliWNO0MaYnkJcDHVOvwVyTmKhwiesZQuQEQuHUWPTGrV4Ie3YRrd07Zm9UWfI1r5Z
         x3zg==
X-Gm-Message-State: APjAAAXODeyVD9b7QePDDocAzNGXzL7kJ6Pr3nT5k8AYTL6o7hvlcYo1
        ctMbz+A8E0RzYe8/Ue4VeEk=
X-Google-Smtp-Source: APXvYqwebJK5uHXwvjiJ/5AqZvt7p9jv+p8BseRtbU+OiFtn/jbQbCB7lRlF+mYw2S8hWhJsJWHGgg==
X-Received: by 2002:adf:f101:: with SMTP id r1mr1342253wro.251.1554329898022;
        Wed, 03 Apr 2019 15:18:18 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id d6sm26019552wrx.62.2019.04.03.15.18.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 15:18:17 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     dafna3@gmail.com, linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH v2 08/16] vicodec: set KEY/PFRAME flag when decoding
Date:   Wed,  3 Apr 2019 15:14:53 -0700
Message-Id: <20190403221501.32814-9-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403221501.32814-1-dafna3@gmail.com>
References: <20190403221501.32814-1-dafna3@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Set V4L2_BUF_FLAG_P/KEYFRAME after decoding a frame.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/platform/vicodec/vicodec-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index 21000cc2f395..4896f349b4aa 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -335,6 +335,10 @@ static int device_process(struct vicodec_ctx *ctx,
 			copy_cap_to_ref(p_dst, ctx->state.info, &ctx->state);
 
 		vb2_set_plane_payload(&dst_vb->vb2_buf, 0, q_dst->sizeimage);
+		if (ntohl(ctx->state.header.flags) & FWHT_FL_I_FRAME)
+			dst_vb->flags |= V4L2_BUF_FLAG_KEYFRAME;
+		else
+			dst_vb->flags |= V4L2_BUF_FLAG_PFRAME;
 	}
 	return ret;
 }
@@ -410,7 +414,6 @@ static void device_run(void *priv)
 	u32 state;
 	struct media_request *src_req;
 
-
 	src_buf = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
 	dst_buf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
 	src_req = src_buf->vb2_buf.req_obj.req;
@@ -424,7 +427,7 @@ static void device_run(void *priv)
 	else
 		dst_buf->sequence = q_dst->sequence++;
 	dst_buf->flags &= ~V4L2_BUF_FLAG_LAST;
-	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, !ctx->is_enc);
+	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, false);
 
 	spin_lock(ctx->lock);
 	if (!ctx->comp_has_next_frame && src_buf == ctx->last_src_buf) {
-- 
2.17.1

