Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B55BC433B4
	for <linux-media@archiver.kernel.org>; Wed, 19 May 2021 14:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C2F161353
	for <linux-media@archiver.kernel.org>; Wed, 19 May 2021 14:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347715AbhESOcG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 19 May 2021 10:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347594AbhESOcF (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 19 May 2021 10:32:05 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05461C061761
        for <linux-media@vger.kernel.org>; Wed, 19 May 2021 07:30:46 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 10so10037663pfl.1
        for <linux-media@vger.kernel.org>; Wed, 19 May 2021 07:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6kfOa099pLULt6jl0OFN8u1UODEiizY8ZTmqttw30oY=;
        b=YYJFq2dgWieXlD+hnduTh0WtZyYeZa2EiPeTpa57lwQx9mTGzA66B6NQbzCbtqWUL9
         ZaZgHHENzsJ0sk17VTO6z5PDzEw/YKN4yBDtnWhcJkNm320t/00ciQPP/0RXOtEHC8yU
         Q+dm28F+rxbG953RMEJ0ptfP9zNQdFsJklcqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6kfOa099pLULt6jl0OFN8u1UODEiizY8ZTmqttw30oY=;
        b=r/IZYPmxex6ZeI1r9MiVxfqxoh41Xx6J5BpfZG2OzoUXyp41SF4unRdThDOdVQwZjJ
         0j9SY9qDJHqWxLU0QC6gBumdAhRTP/uVwz3XTLPqhKzxrwgCxDG6gr0TZcNQqDc4pLT7
         Zgryhe1HlCDJn3nlPHzu0+bFj7HLGqD1c6nAhvhGAjziNwheeTIhjvFsYCeDSZqaCZeQ
         8Yp/FSo6i99Sn0DCp0NDFZZA9Ji9naaXb4sa2UAz4/qp9D74/Ntg91xcWqBuGml7pzns
         z8NSDTqROxy1pFAKT+44Nv3s1GC4cJiK939lhDu1S1UCC+xKDhMYVvt7u2gneYZF9B82
         sG4A==
X-Gm-Message-State: AOAM532Z9AMgRVzRLoozyS/sImY5jcOQUO3AsEOW+EUm6WEDI9vCqfqa
        r5E+cn2ZVkUWSZd4r/IDVNjsmg==
X-Google-Smtp-Source: ABdhPJx1JoTLdOlAqO91SpwdnBsgYrywh1y4pWh6k1KrKQ93xhy72ahDDweSpIwRMcOnbAGct9eP6w==
X-Received: by 2002:a63:7e13:: with SMTP id z19mr11116767pgc.184.1621434645624;
        Wed, 19 May 2021 07:30:45 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:87ab:ff82:1544:697])
        by smtp.gmail.com with ESMTPSA id 3sm14337661pff.132.2021.05.19.07.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:30:45 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v5 03/14] media: mtk-vcodec: vdec: clamp OUTPUT resolution to hardware limits
Date:   Wed, 19 May 2021 23:30:00 +0900
Message-Id: <20210519143011.1175546-4-acourbot@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
In-Reply-To: <20210519143011.1175546-1-acourbot@chromium.org>
References: <20210519143011.1175546-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Calling S_FMT or TRY_FMT on the OUTPUT queue should adjust the
resolution to the limits supported by the hardware. Until now this was
only done on the CAPTURE queue, which could make clients believe that
unsupported resolutions can be used when they set the coded size on the
OUTPUT queue.

In the case of the stateless decoder, the problem was even bigger since
subsequently calling G_FMT on the CAPTURE queue would result in the
unclamped resolution being returned, further inducing the client into
error.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
index 1a633b485a69..58e521096b94 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
@@ -649,19 +649,19 @@ static int vidioc_try_fmt(struct v4l2_format *f,
 
 	pix_fmt_mp->field = V4L2_FIELD_NONE;
 
+	pix_fmt_mp->width = clamp(pix_fmt_mp->width,
+				MTK_VDEC_MIN_W,
+				MTK_VDEC_MAX_W);
+	pix_fmt_mp->height = clamp(pix_fmt_mp->height,
+				MTK_VDEC_MIN_H,
+				MTK_VDEC_MAX_H);
+
 	if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
 		pix_fmt_mp->num_planes = 1;
 		pix_fmt_mp->plane_fmt[0].bytesperline = 0;
 	} else if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
 		int tmp_w, tmp_h;
 
-		pix_fmt_mp->height = clamp(pix_fmt_mp->height,
-					MTK_VDEC_MIN_H,
-					MTK_VDEC_MAX_H);
-		pix_fmt_mp->width = clamp(pix_fmt_mp->width,
-					MTK_VDEC_MIN_W,
-					MTK_VDEC_MAX_W);
-
 		/*
 		 * Find next closer width align 64, heign align 64, size align
 		 * 64 rectangle
-- 
2.31.1.751.gd2f1c929bd-goog

