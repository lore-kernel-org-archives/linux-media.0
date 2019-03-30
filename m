Return-Path: <SRS0=IMFm=SB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE864C4360F
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D853218FD
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpKrThwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbfC3Upz (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 30 Mar 2019 16:45:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41779 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730769AbfC3Upy (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 30 Mar 2019 16:45:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id r4so6834663wrq.8
        for <linux-media@vger.kernel.org>; Sat, 30 Mar 2019 13:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J8Qwf9YZDIIhE+Gk4+r2yhkT7DL0FcWTxX1YaphqNJM=;
        b=PpKrThwmh48VrRrfsf5iC3T+pi9emTgxg9R0JieBD5HPHAUKwBuTfEANe08ADsZgEW
         t9qBYDRMjEOKHv5LJ/AvWaBjaVl8oc/AlAq8ubb2r32SC7Htq5zIz/QmT7bFazRp0BfI
         aB7doD6TiFPUNwikZkfWManZCxS52mTPE7gXYzFx5S9CXcOGny0pltHRYxdRo9NXq1fD
         O5+OIhCGkJEVwJ/JdOnlkMsnx9kLOUzvYP/vEdzzSn8RZK0hpETS12mBkWoNu7dCW4zl
         voJTkV1NYbIup/7A8AlzQ5Nv+PWodqbE6zbUzA4DvOyvMz7gRexq/BXekWAVB1Yapvkj
         0oIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J8Qwf9YZDIIhE+Gk4+r2yhkT7DL0FcWTxX1YaphqNJM=;
        b=WRGHOv3ne5R4tgvM/c9NG4tccz8J9+472pA34S0DZoU139hNHG232jiOn9N4EXwIl+
         31PCJgz96S49jnC4FgIbTgChAtVltdVkUJRp5nGOb5TXzAJTOH6VKNxf2DmYs91Er92W
         9nkCCJwVy6DaurvNUEhqy3zh3ZEFvmu64WZ+DW7vqQxYYPdjAxgQv/SuJMz+tvsUO/y3
         RszVCZriMK98q2XoyGfjYmTiaDyRg/vQ2uBR7PNCdbeFi8VZqgTiMtzxn8jj3LRo7cl3
         1mb7yDf2esah/XWx0RwJm/PAEDP3sEm1hd1w4VXVhwz2VUzhmnW4BRwBfYQZEhyytWuo
         aF3A==
X-Gm-Message-State: APjAAAUxwayM3j/eNTTB8WMlxsGD3DFz9kOelcwTzVlsjykTR7IUl3CO
        KPezlEuwNiKqWDqnJrYFE6rYh8v0lP4=
X-Google-Smtp-Source: APXvYqw/mbZ71dilT7LYBAT0tFJGdhRbAEPJScKmuw+2f/5h+hn+CXkM1FuagA6wc7C4uwMZ3spoAw==
X-Received: by 2002:a5d:4a8d:: with SMTP id o13mr34127776wrq.209.1553978752944;
        Sat, 30 Mar 2019 13:45:52 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id a9sm5903671wmb.30.2019.03.30.13.45.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 13:45:52 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Dafna Hirschfeld <dafna3@gmail.com>
Subject: [PATCH 09/14] media: vicodec: don't test if info is NULL
Date:   Sat, 30 Mar 2019 13:43:07 -0700
Message-Id: <20190330204311.107417-10-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190330204311.107417-1-dafna3@gmail.com>
References: <20190330204311.107417-1-dafna3@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

pixel info of q_data is never set to NULL
so there is no need to test if it is.

Signed-off-by: Dafna Hirschfeld <dafna3@gmail.com>
---
 drivers/media/platform/vicodec/vicodec-core.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index ba327512e085..6276a803cc4d 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -659,7 +659,6 @@ static int job_ready(void *priv)
 
 	if (ntohl(ctx->state.header.width) != q_dst->visible_width ||
 	    ntohl(ctx->state.header.height) != q_dst->visible_height ||
-	    !q_dst->info ||
 	    hdr_width_div != q_dst->info->width_div ||
 	    hdr_height_div != q_dst->info->height_div) {
 		static const struct v4l2_event rs_event = {
@@ -768,9 +767,6 @@ static int vidioc_g_fmt(struct vicodec_ctx *ctx, struct v4l2_format *f)
 	q_data = get_q_data(ctx, f->type);
 	info = q_data->info;
 
-	if (!info)
-		info = v4l2_fwht_get_pixfmt(0);
-
 	switch (f->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
@@ -992,7 +988,6 @@ static int vidioc_s_fmt(struct vicodec_ctx *ctx, struct v4l2_format *f)
 		pix = &f->fmt.pix;
 		if (ctx->is_enc && V4L2_TYPE_IS_OUTPUT(f->type))
 			fmt_changed =
-				!q_data->info ||
 				q_data->info->id != pix->pixelformat ||
 				q_data->coded_width != pix->width ||
 				q_data->coded_height != pix->height;
@@ -1015,7 +1010,6 @@ static int vidioc_s_fmt(struct vicodec_ctx *ctx, struct v4l2_format *f)
 		pix_mp = &f->fmt.pix_mp;
 		if (ctx->is_enc && V4L2_TYPE_IS_OUTPUT(f->type))
 			fmt_changed =
-				!q_data->info ||
 				q_data->info->id != pix_mp->pixelformat ||
 				q_data->coded_width != pix_mp->width ||
 				q_data->coded_height != pix_mp->height;
@@ -1593,10 +1587,6 @@ static unsigned int total_frame_size(struct vicodec_q_data *q_data)
 	unsigned int size;
 	unsigned int chroma_div;
 
-	if (!q_data->info) {
-		WARN_ON(1);
-		return 0;
-	}
 	size = q_data->coded_width * q_data->coded_height;
 	chroma_div = q_data->info->width_div * q_data->info->height_div;
 
@@ -1619,9 +1609,6 @@ static int vicodec_start_streaming(struct vb2_queue *q,
 	unsigned int total_planes_size;
 	u8 *new_comp_frame = NULL;
 
-	if (!info)
-		return -EINVAL;
-
 	chroma_div = info->width_div * info->height_div;
 	q_data->sequence = 0;
 
@@ -1820,8 +1807,6 @@ static int vicodec_try_ctrl(struct v4l2_ctrl *ctrl)
 
 	switch (ctrl->id) {
 	case V4L2_CID_MPEG_VIDEO_FWHT_PARAMS:
-		if (!q_dst->info)
-			return -EINVAL;
 		params = ctrl->p_new.p_fwht_params;
 		if (params->width > q_dst->coded_width ||
 		    params->width < MIN_WIDTH ||
-- 
2.17.1

