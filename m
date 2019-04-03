Return-Path: <SRS0=djxu=SF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3396EC4360F
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002D62133D
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdeGkYCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfDCWSX (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:18:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39733 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfDCWSW (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 3 Apr 2019 18:18:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so670902wmk.4
        for <linux-media@vger.kernel.org>; Wed, 03 Apr 2019 15:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tiHamkKU0v4G5mxdRp25JO8TtysD+Z28oKNuheGm3+g=;
        b=qdeGkYCqWuEKAtREA134kvkAEAH3TR/QoDRPapp6/FGTKL0K2N3kMaIyZemCsPIJw1
         gN58BbFOemux3hNqUptQcdIf5GVCfBKp58CUrw5Iubdi49tlSWMpH0yNKCp/Mq7jX9Js
         2teDuLliJCg51o+x1Lb2PV2lU9Y46SAWA9mg/N1r7d8BmbQyP9rJYKbfHgNUahnmPzd2
         /XTxN1VERRNYWYW5iV5inF8CuXBn1dIulzfIvP2yEwUdz7k0Q3vPKqagIJPEQ/xf9zcn
         9/5k7YS37k0SSTfwIQH5euPYj+RF/E3PiQoGNON7Thzg/wP095ddfFwJjuMNqnFK2V3M
         CDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tiHamkKU0v4G5mxdRp25JO8TtysD+Z28oKNuheGm3+g=;
        b=OIZdIxVRQ+6f77oLhLkOpMvtFAkm3tAMxXmQ/tW3agfpUcpFPA6d1oGu9uVIjygvVe
         SqZAIl9lOdxSO5bwCv1Lz6C54VJ85GT9e2/LYYWbIfepQc8zqoy4kf2R33clQ1C3EbFb
         LiigzNmB4uCZX2ayc/tfTuRiT7ceELnUOAYILP/oKg5F63zlGYtGJ7YHZIBRwQJAI3Tr
         dnUTZ3KFBrREm64eEkQyoBKxCfVGL0wqhEcV19s4TVSgyF0j0kcx4Gs+7N6xeLhvhDxr
         gIq61mP2NplYsD2qHdX421CBmVH8tc8RZUenC93vz44w0RG5M72z3rghnt8D4ufGXbnl
         oz8g==
X-Gm-Message-State: APjAAAX1ei7Pz2Uf3UnLYKszh9tOnISvl7cEp0iV0FZiA6mvgipU6cqB
        YMiCMyRyHMroUSQDB/Avw6LoWiAc31c=
X-Google-Smtp-Source: APXvYqzVoFRXm02xTU29+lEVU+7rFGLkXyhNZNZqplk8CQusb94M2fxXEl1KDcNYorsrGLr3yIjrpA==
X-Received: by 2002:a1c:bac2:: with SMTP id k185mr1476742wmf.5.1554329900421;
        Wed, 03 Apr 2019 15:18:20 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id d6sm26019552wrx.62.2019.04.03.15.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 15:18:19 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     dafna3@gmail.com, linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com
Subject: [PATCH v2 10/16] media: vicodec: don't test if info is NULL
Date:   Wed,  3 Apr 2019 15:14:55 -0700
Message-Id: <20190403221501.32814-11-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403221501.32814-1-dafna3@gmail.com>
References: <20190403221501.32814-1-dafna3@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

pixel info of q_data is never set to NULL
so there is no need to test if it is.

Signed-off-by: Dafna Hirschfeld <dafna3@gmail.com>
---
 drivers/media/platform/vicodec/vicodec-core.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index 4896f349b4aa..52e8128d2d28 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -662,7 +662,6 @@ static int job_ready(void *priv)
 
 	if (ntohl(ctx->state.header.width) != q_dst->visible_width ||
 	    ntohl(ctx->state.header.height) != q_dst->visible_height ||
-	    !q_dst->info ||
 	    hdr_width_div != q_dst->info->width_div ||
 	    hdr_height_div != q_dst->info->height_div) {
 		static const struct v4l2_event rs_event = {
@@ -992,7 +991,6 @@ static int vidioc_s_fmt(struct vicodec_ctx *ctx, struct v4l2_format *f)
 		pix = &f->fmt.pix;
 		if (ctx->is_enc && V4L2_TYPE_IS_OUTPUT(f->type))
 			fmt_changed =
-				!q_data->info ||
 				q_data->info->id != pix->pixelformat ||
 				q_data->coded_width != pix->width ||
 				q_data->coded_height != pix->height;
@@ -1015,7 +1013,6 @@ static int vidioc_s_fmt(struct vicodec_ctx *ctx, struct v4l2_format *f)
 		pix_mp = &f->fmt.pix_mp;
 		if (ctx->is_enc && V4L2_TYPE_IS_OUTPUT(f->type))
 			fmt_changed =
-				!q_data->info ||
 				q_data->info->id != pix_mp->pixelformat ||
 				q_data->coded_width != pix_mp->width ||
 				q_data->coded_height != pix_mp->height;
@@ -1601,10 +1598,6 @@ static unsigned int total_frame_size(struct vicodec_q_data *q_data)
 	unsigned int size;
 	unsigned int chroma_div;
 
-	if (!q_data->info) {
-		WARN_ON(1);
-		return 0;
-	}
 	size = q_data->coded_width * q_data->coded_height;
 	chroma_div = q_data->info->width_div * q_data->info->height_div;
 
@@ -1825,8 +1818,6 @@ static int vicodec_try_ctrl(struct v4l2_ctrl *ctrl)
 
 	switch (ctrl->id) {
 	case V4L2_CID_MPEG_VIDEO_FWHT_PARAMS:
-		if (!q_dst->info)
-			return -EINVAL;
 		params = ctrl->p_new.p_fwht_params;
 		if (params->width > q_dst->coded_width ||
 		    params->width < MIN_WIDTH ||
-- 
2.17.1

