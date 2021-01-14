Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C7CC433DB
	for <linux-media@archiver.kernel.org>; Thu, 14 Jan 2021 13:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 713C22310F
	for <linux-media@archiver.kernel.org>; Thu, 14 Jan 2021 13:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbhANNEC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 14 Jan 2021 08:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbhANNEB (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 14 Jan 2021 08:04:01 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D62C061575
        for <linux-media@vger.kernel.org>; Thu, 14 Jan 2021 05:03:21 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c124so4462175wma.5
        for <linux-media@vger.kernel.org>; Thu, 14 Jan 2021 05:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lMjCyJ4LFX2yXOveR+4JmstAFOfGTUFf7mwxezUhrSE=;
        b=VU9ytjDnsJhBQEKU8CcNfn5EcCVMbibvcmMIQSw6rqWNc6nN1Lf1oPsOOgFmwiKBTc
         RrPVWF1HCcyoZ3tDzDgIdYHPj60ibMqmq7v41lcCdLex3eGAfcqZNX3auAiU+HgY4YI4
         y8jR1nV/ehPXzbKO5mBB9omD5EgSVnqYK232Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lMjCyJ4LFX2yXOveR+4JmstAFOfGTUFf7mwxezUhrSE=;
        b=i6+nr+OipEUtZ4d1My7GSAzOtM9kRjB2/aZOMGwutwvc+rgpoSjgLu+KGvQ5zo4H0J
         ZdpwB9PtPWpQzltA1cHoy8Z0ygy1svPH09Kspy+/riX43FI0OypeDxuLpaT+Y9wVxbXh
         tf2ovUHdP5c30/h0huvPrS8KZX+lcQ7ZULsE0BzaSACpyWc5RKobQuSGUY/sIF9eJdoB
         IzNBKwuhbGh8FUOgtg9AU4eOlKmIm+xA4wI/qqKD/WoBJs3Ki2vHObTW4B1F61LJDfr0
         fH1fRwLOYgUMUguI4Nd8Lrix5E9MZOesHBMT3vmzCZu9arWE2PVD8aZSEWVnsfvzm0EX
         Q1dA==
X-Gm-Message-State: AOAM531RYX6OOidclAaYrUnjohaACwg77laYsCn3YKVOPKvCzhy8vcK3
        mV5P1wVrr4Q19ILF+mG971piGg==
X-Google-Smtp-Source: ABdhPJwFrQgrAKlNT+/f/q7vLOej10mKl2NqLzYVqByPSzm1wlk/JVQWuVJ4qCBH9M1ZbeaQlqukKg==
X-Received: by 2002:a1c:cc19:: with SMTP id h25mr3952785wmb.124.1610629399701;
        Thu, 14 Jan 2021 05:03:19 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id x13sm9313627wrp.80.2021.01.14.05.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 05:03:19 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH] media: hantro: Fix reset_raw_fmt initialization
Date:   Thu, 14 Jan 2021 14:03:16 +0100
Message-Id: <20210114130316.803231-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

raw_fmt->height in never initialized. But width in initialized twice.

Fixes: 88d06362d1d05 ("media: hantro: Refactor for V4L2 API spec compliancy")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/hantro/hantro_v4l2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
index b668a82d40ad..f5fbdbc4ffdb 100644
--- a/drivers/staging/media/hantro/hantro_v4l2.c
+++ b/drivers/staging/media/hantro/hantro_v4l2.c
@@ -367,7 +367,7 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx)
 
 	hantro_reset_fmt(raw_fmt, raw_vpu_fmt);
 	raw_fmt->width = encoded_fmt->width;
-	raw_fmt->width = encoded_fmt->width;
+	raw_fmt->height = encoded_fmt->height;
 	if (ctx->is_encoder)
 		hantro_set_fmt_out(ctx, raw_fmt);
 	else
-- 
2.30.0.284.gd98b1dd5eaa7-goog

