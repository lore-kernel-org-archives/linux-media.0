Return-Path: <SRS0=IMFm=SB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23375C43381
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DF7218D8
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/Rz6qIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbfC3Upx (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 30 Mar 2019 16:45:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33467 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730692AbfC3Upw (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 30 Mar 2019 16:45:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id z6so12323718wmi.0
        for <linux-media@vger.kernel.org>; Sat, 30 Mar 2019 13:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d9NLSDmkZZ7ohnDdnY71XZb9bbAruqYljXTdhP+xu6E=;
        b=T/Rz6qIWs86LDVBPfIThYJAKN4c8k9HRb28yLR0AA/nzay6ZSg/MftYDu9K0sAKQTD
         xB5JemHqIVHTaudV9VZD3f6787T3ukU729bKecB1JCWfkHbOLjYVoNk/TRZWqDZUFF/Q
         lpws6beV6/KyIjmonRJSRkNxzvZjSE5oJ56h58yi9NhU7wompwDE2Ehxt/6UsDqN+BZd
         CX/ANkVjBntpcYQVIAtFZyJmmry4yFhh3VSUxbN4q0XxPJNXiAJ6pLuRD0QuYOO80Oio
         c26Kzw7wbTp2IAyN3wmdpqSxFYGS/dZCM9bbWPfZhIApzgrm4+VpibrHOLtCg2Jzgrh7
         8kgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d9NLSDmkZZ7ohnDdnY71XZb9bbAruqYljXTdhP+xu6E=;
        b=NzqIF4mrtQPfWq0S33GYXiVxqxUGtMd+zgqeVSGPxopGstneagNUiz/pvPvo/k7gkz
         cxYfXwjx2N5/DPS0klU/BxIQgE34zxsUI3ccp0CJ9YU/JTeWtBuqCYVTglJ4Dtle6WT4
         4ov0QQYknud5v+a/fM+oNUBwPXrI1noinrgzvdGXNQ/i2Pn7NPpuI7349oP62stQmgHJ
         +06HwEq/JWbG9sFXXxiqY1NeNAhGq90wRg07banuRLBsdPpYN6urjiiePzPitkNNKHZW
         jwjbVELNZ0OcefniAEm2VSQrvhJBf13OY4dSGYMg1govjNmIu5AOjDmsdwHEDVHW/kSC
         JjBw==
X-Gm-Message-State: APjAAAUnTI33G3dzydW/BMy/p9ueg2ewGAk9vGfMvM0B8B/UGYGz9ivi
        UuWwOANgmEW1uyrfdj760uvnz/LK4r0=
X-Google-Smtp-Source: APXvYqxK+0n9byFm94n+XvO1RjrAMFeeNiJhLwZ46a4UPZNj8KBAzYwmRO3b3jNLeKLGyOYMAnvfNA==
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr7547549wmk.108.1553978750945;
        Sat, 30 Mar 2019 13:45:50 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id a9sm5903671wmb.30.2019.03.30.13.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 13:45:50 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 07/14] vicodec: restrict decoder format list when src fmt is known
Date:   Sat, 30 Mar 2019 13:43:05 -0700
Message-Id: <20190330204311.107417-8-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190330204311.107417-1-dafna3@gmail.com>
References: <20190330204311.107417-1-dafna3@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Report the full list of supported decoder formats until the
format encoded in the bitstream is known. After that only
report the formats compatible with that initial format.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/platform/vicodec/vicodec-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index 980c30cc9d48..7e4ac412cc38 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -671,7 +671,6 @@ static int job_ready(void *priv)
 			v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
 
 		update_capture_data_from_header(ctx);
-		ctx->first_source_change_sent = true;
 		v4l2_event_queue_fh(&ctx->fh, &rs_event);
 		set_last_buffer(dst_buf, src_buf, ctx);
 		ctx->source_changed = true;
@@ -718,7 +717,7 @@ static int enum_fmt(struct v4l2_fmtdesc *f, struct vicodec_ctx *ctx,
 		const struct v4l2_fwht_pixfmt_info *info =
 					get_q_data(ctx, f->type)->info;
 
-		if (!info || ctx->is_enc)
+		if (!ctx->first_source_change_sent || ctx->is_enc)
 			info = v4l2_fwht_get_pixfmt(f->index);
 		else
 			info = v4l2_fwht_find_nth_fmt(info->width_div,
@@ -1522,6 +1521,7 @@ static void vicodec_buf_queue(struct vb2_buffer *vb)
 	 * handled in job_ready
 	 */
 	if (vb2_is_streaming(vq_cap) && vb2_is_streaming(vq_out)) {
+		ctx->first_source_change_sent = true;
 		v4l2_m2m_buf_queue(ctx->fh.m2m_ctx, vbuf);
 		return;
 	}
@@ -1726,6 +1726,8 @@ static void vicodec_stop_streaming(struct vb2_queue *q)
 			ctx->next_is_last = false;
 		}
 	}
+	if (!ctx->is_enc && V4L2_TYPE_IS_OUTPUT(q->type))
+		ctx->first_source_change_sent = false;
 
 	if ((!V4L2_TYPE_IS_OUTPUT(q->type) && !ctx->is_enc) ||
 	    (V4L2_TYPE_IS_OUTPUT(q->type) && ctx->is_enc)) {
-- 
2.17.1

