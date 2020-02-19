Return-Path: <SRS0=BWRz=4H=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B18CC34051
	for <linux-media@archiver.kernel.org>; Wed, 19 Feb 2020 12:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3155F20801
	for <linux-media@archiver.kernel.org>; Wed, 19 Feb 2020 12:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8JeMp4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbgBSM7P (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 19 Feb 2020 07:59:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36361 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgBSM7P (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 19 Feb 2020 07:59:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so441000wru.3
        for <linux-media@vger.kernel.org>; Wed, 19 Feb 2020 04:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zD578hUDzEdljbEMaXnAU5Fu0S+sZLfIWKeXuI6LQ/U=;
        b=F8JeMp4KBLWPz0FXFfN4ZhZpo0lNcuztHCup+NtEomkYRwJz6F1oiKkyPvmE7vLHiA
         dyKLSJmomLTUnx+7jWMc2YOG0JOwtClzFdRNaXUY4Uf2oGPsJWJViwz3LM66eT1P5IQc
         S1BdzlxFbjEEVYJFCJ6O7y17tydI5E+jWhhngc6K8dTCpvr+SEUq3R8QIwnC8YSG8vLi
         MZUhl74pSKxTVEZAXLIaMV+d0rDYToYvrYXWxW47vRIOJzevqv4AUXQ3KWST7tjedGqJ
         IOTfCTfjrEZmGF+69yc+dyOgHmokTPgdU76aLnYewbMp3aZgIPmYGbSapzzHDmwGfH/z
         maCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zD578hUDzEdljbEMaXnAU5Fu0S+sZLfIWKeXuI6LQ/U=;
        b=D4vi6YrZToX0VfEvqcWA6x744ZzoQZZnY61LQukcj1PnCSHzQ/lqFmrAIK7zWPDyd5
         o57U1xMtm4uJ2KQOoYsvRf9PuTmDC5PePcMFU9fxph4z7qpBcuHP8dZypWi5MH7HWsyv
         zyoTrSQ+tqTvTytYIjeI0UngFDIEahY2oG88IFetdRS0gbQfPuh0P+qVLjDImhgVZUij
         PcvVKeTi9iOuTXswdRw1ULVhxurlwHmqlLbg7jtz4bpQ/5YivSWmElHKA08rdNp2wRRR
         NtL+jMS5aNDZgK+EIUT27532Cih9duL6Jd1Tr35cquj8YuQwmWi06EmPhoRZ7eGa0K7i
         OjJw==
X-Gm-Message-State: APjAAAX81EJ4FKztQwNvNzL20H/fjGE3QUbZ521W+9nq2wwu7Cu8LHLW
        itjKFO2JiXgdctxnF74W4pkFLnKC
X-Google-Smtp-Source: APXvYqypLPmJbIi3gsaLC5ffX9TpDeERMeGUo6cDc/a6sZnGG5ilD2XtwQpxRhLLMrNKFdRALq+9yQ==
X-Received: by 2002:a5d:6987:: with SMTP id g7mr34834591wru.422.1582117153427;
        Wed, 19 Feb 2020 04:59:13 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:90ea:9d7:18a3:895e])
        by smtp.gmail.com with ESMTPSA id h2sm3079024wrt.45.2020.02.19.04.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 04:59:13 -0800 (PST)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-media@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        daniel@ffwll.ch
Subject: [PATCH 3/7] drm/amdgpu: use allowed_domains for exported DMA-bufs
Date:   Wed, 19 Feb 2020 13:59:06 +0100
Message-Id: <20200219125910.89147-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219125910.89147-1-christian.koenig@amd.com>
References: <20200219125910.89147-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Avoid that we ping/pong the buffers when we stop to pin DMA-buf
exports by using the allowed domains for exported buffers.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index a52a084158b1..41bd2dad842c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -28,6 +28,7 @@
 #include <linux/file.h>
 #include <linux/pagemap.h>
 #include <linux/sync_file.h>
+#include <linux/dma-buf.h>
 
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_syncobj.h>
@@ -415,7 +416,9 @@ static int amdgpu_cs_bo_validate(struct amdgpu_cs_parser *p,
 	/* Don't move this buffer if we have depleted our allowance
 	 * to move it. Don't move anything if the threshold is zero.
 	 */
-	if (p->bytes_moved < p->bytes_moved_threshold) {
+	if (p->bytes_moved < p->bytes_moved_threshold &&
+	    (!bo->tbo.base.dma_buf ||
+	    list_empty(&bo->tbo.base.dma_buf->attachments))) {
 		if (!amdgpu_gmc_vram_full_visible(&adev->gmc) &&
 		    (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)) {
 			/* And don't move a CPU_ACCESS_REQUIRED BO to limited
-- 
2.17.1

