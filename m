Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24804C43334
	for <linux-media@archiver.kernel.org>; Fri,  1 Jul 2022 10:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbiGAKxL (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbiGAKxJ (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 1 Jul 2022 06:53:09 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC396CFA
        for <linux-media@vger.kernel.org>; Fri,  1 Jul 2022 03:53:07 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c4so2024939plc.8
        for <linux-media@vger.kernel.org>; Fri, 01 Jul 2022 03:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zRI9Gh7/YtjgP8mVgApQyA3GHi/707s2OxZOLEZ9+C4=;
        b=Hs8XspyQYDCsbTiyxekYNXorFxxz/uNUUV1G6tU7K0S9W/6puaw0ZMpKUGGZs4Tatk
         hA/iAbm6BPVSQRsQDD02OXTxKoQdFyHteMx9SVYTsFeBrHECss4HdVqLNMsSVkVIWyqy
         pEuFr4+J80MSXT0OqwAO8+fXVkbGwYjx4fhP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zRI9Gh7/YtjgP8mVgApQyA3GHi/707s2OxZOLEZ9+C4=;
        b=fBZ9xRSIgAD/p0iuWuKdn849f2uIQdvpkQV6nR35aRbAA+xOELtWP3jAjokMQ3JBF3
         0p1Puqkpal7S7YrN4y1wB6ElhuFImbJS+aarI2cdQX8YJP/8Nv4QPFtfiNxSNvTyfT4d
         IjmS7dKSdRuKhKaQ/YwJoiGRjzhyq5kahoYLuv0ccSVFv2uZ9lFyQ8iMozSvA6cCg+kU
         L3hboraE3MYVUojRD5ErOhpuVrUAZy3MLYBDbROpJdQtr3T4+2XrLqLbTkJpA0Mt6Ocg
         JlCDv9HfI03uQjFhHXoQO3/CZ3a3BSexLGqgvQM13RRqJaWBCaG8SPmnBZbMW99hVv3n
         bOtQ==
X-Gm-Message-State: AJIora9xiiH4Cn3gFxnb/xxksdneOU24B2Uu+gATsgh5Wg9nNktFLjdX
        xisS4uI2t2MlcCH6u6tCin6Vd8MHKS4hqQ==
X-Google-Smtp-Source: AGRyM1thrJAL4fMosshrrxIa9gN4QIMY/Q1Zq8NQRWgztOQpLfQiSsViCjvDYvLI4NRK+Rca0AtsbA==
X-Received: by 2002:a17:90a:bc84:b0:1ec:81f4:f86f with SMTP id x4-20020a17090abc8400b001ec81f4f86fmr17714158pjr.29.1656672787210;
        Fri, 01 Jul 2022 03:53:07 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:59bf:8b47:50a0:b04f])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902758200b0016a058b7547sm14906670pll.294.2022.07.01.03.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:53:06 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 1/6] media: mediatek: vcodec: Revert driver name change in decoder capabilities
Date:   Fri,  1 Jul 2022 18:52:32 +0800
Message-Id: <20220701105237.932332-2-wenst@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220701105237.932332-1-wenst@chromium.org>
References: <20220701105237.932332-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This partially reverts commit a8a7a278c56ad3b4ddd4db9a960e0537d032b0b3.

This recent change caused ChromeOS's decoder to no longer function. This
is due to ChromeOS using the driver name field to match the video device
with its accompanying media device. After the change, they no longer
matched.

The driver name field should contain the actual driver name, not some
otherwise unused string macro from the driver. To make this clear,
copy the name from the driver's name field.

Fixes: a8a7a278c56a ("media: mediatek: vcodec: Change decoder v4l2 capability value")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
index 5d6fdf18c3a6..e7ea632a3f94 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
@@ -243,9 +243,11 @@ static int mtk_vcodec_dec_get_chip_name(void *priv)
 static int vidioc_vdec_querycap(struct file *file, void *priv,
 				struct v4l2_capability *cap)
 {
+	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct device *dev = &ctx->dev->plat_dev->dev;
 	int platform_name = mtk_vcodec_dec_get_chip_name(priv);
 
-	strscpy(cap->driver, MTK_VCODEC_DRV_NAME, sizeof(cap->driver));
+	strscpy(cap->driver, dev->driver->name, sizeof(cap->driver));
 	strscpy(cap->card, MTK_VCODEC_DEC_NAME, sizeof(cap->card));
 	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:mt%d-dec", platform_name);
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

