Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CF2C43332
	for <linux-media@archiver.kernel.org>; Mon, 11 Jan 2021 14:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECB6822795
	for <linux-media@archiver.kernel.org>; Mon, 11 Jan 2021 14:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388995AbhAKO4u (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 11 Jan 2021 09:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388988AbhAKO4t (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 11 Jan 2021 09:56:49 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFA7C0617BA
        for <linux-media@vger.kernel.org>; Mon, 11 Jan 2021 06:54:54 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id i9so77037wrc.4
        for <linux-media@vger.kernel.org>; Mon, 11 Jan 2021 06:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AKDGtEhnWmTb9KoPsyE100Se2qlDDTUKP3nh7yfrkBU=;
        b=OHMp+Ph86NCVy/5ERoXGHpgH2qS4x1jwqS1yL1ndgmhTMKDgBw+e/O0mXROCcpzZod
         q5umr1B+4ebVj2wHwmNVEak4gLHItRDEZTHBXxNhncWwrYfDfp2qAcRqmofJZ/EMFeGE
         A70DCWtLLIHmXtPnTHxiH/DSzUiINNJKXac6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AKDGtEhnWmTb9KoPsyE100Se2qlDDTUKP3nh7yfrkBU=;
        b=scPRYVcc/+886T+T+Lj56pf/hMDa79dd7Hz2LLAe9YEUUNvAcTBietaLAl2EdsSPd9
         Jkplls75DypQ35nY2haDsIBXdqHfGJu2j6SLmH8fbTk2oLwW3iAVY2Y3W1NlN8ZWaANe
         jmh2QR0zIgqfvkEnlf3WGMYrRJ9Hy5ei2JGvb+G8uVoLdqtf0FIo+vafUQEiX6pyU/qv
         R/LtRivDjBo4y8Ow1EOy8BdhNZjLIquTJyEdNM8Zwt/PuvfuTcM8Nt+xbqy5V33nTgoN
         3+8I5C2dJ+bZrWDESt3a1fwNAqGL/9XPfQ9eouZhUV2xAXW564D2ct8vV2+g5rhJwBN/
         1jwg==
X-Gm-Message-State: AOAM533ucVY4A8ipOYONPJAXiDTxi+W30r1K1vjgMKCZZzIV2A49Vl01
        N3ea8uDrnBEf3ly2cOgsny/Kj0BxCCqs5S3sinE=
X-Google-Smtp-Source: ABdhPJxT0Csqs/mc1iqDf/uhP704k+gxCV0QI5PXpgOD1Qq7P8Lo8ufCLaRURRwSfd/gn/yiO9M/1A==
X-Received: by 2002:a5d:4641:: with SMTP id j1mr16915584wrs.94.1610376893432;
        Mon, 11 Jan 2021 06:54:53 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id s133sm17780wmf.38.2021.01.11.06.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 06:54:52 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Benoit Parrot <bparrot@ti.com>
Subject: [PATCH 7/9] media: ti-vpe: Do not zero reserved fields
Date:   Mon, 11 Jan 2021 15:54:43 +0100
Message-Id: <20210111145445.28854-8-ribalda@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210111145445.28854-1-ribalda@chromium.org>
References: <20210111145445.28854-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Core code already clears reserved fields of struct
v4l2_pix_format_mplane, check: 4e1e0eb0e074 ("media: v4l2-ioctl: Zero
v4l2_plane_pix_format reserved fields").

Cc: Benoit Parrot <bparrot@ti.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/ti-vpe/vpe.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/vpe.c b/drivers/media/platform/ti-vpe/vpe.c
index 779dd74b82d0..10251b787674 100644
--- a/drivers/media/platform/ti-vpe/vpe.c
+++ b/drivers/media/platform/ti-vpe/vpe.c
@@ -1683,7 +1683,6 @@ static int __vpe_try_fmt(struct vpe_ctx *ctx, struct v4l2_format *f,
 		}
 	}
 
-	memset(pix->reserved, 0, sizeof(pix->reserved));
 	for (i = 0; i < pix->num_planes; i++) {
 		plane_fmt = &pix->plane_fmt[i];
 		depth = fmt->vpdma_fmt[i]->depth;
@@ -1713,7 +1712,6 @@ static int __vpe_try_fmt(struct vpe_ctx *ctx, struct v4l2_format *f,
 					       plane_fmt->bytesperline *
 					       depth) >> 3;
 		}
-		memset(plane_fmt->reserved, 0, sizeof(plane_fmt->reserved));
 	}
 
 	return 0;
-- 
2.30.0.284.gd98b1dd5eaa7-goog

