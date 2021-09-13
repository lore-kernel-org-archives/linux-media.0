Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A415C433FE
	for <linux-media@archiver.kernel.org>; Mon, 13 Sep 2021 13:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55EB661439
	for <linux-media@archiver.kernel.org>; Mon, 13 Sep 2021 13:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241796AbhIMNbR (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 13 Sep 2021 09:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239963AbhIMNTw (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 13 Sep 2021 09:19:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A54C0613E4
        for <linux-media@vger.kernel.org>; Mon, 13 Sep 2021 06:17:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u15so8600047wru.6
        for <linux-media@vger.kernel.org>; Mon, 13 Sep 2021 06:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AQf+EG1LqOYQqT40zZYv5ISTQOpig8QPja/gK5mvSkk=;
        b=o0FiPQTwN18HlAj3IMAzdpZhNgUkwaOWPzbtIBRFMInNJnGiYMOctX9OPqVk1DHHO9
         SKmb4SZfoQ4HOdQdPSOiojjB8PWUv4WR6fD8Q1FdZYGF3ah0eMfncDKfOk4qD/h7uCci
         HcT7QlmrhxFCtre14LVVCzq+5DpaCtTHb5crySwbNhzxiZ0Z18kXpYA5tTuFgGddeoJ9
         SP4RZGJYTxpm/Xyi8pakNrIgAqDih5R7gcNHjtOU1KVvi/yjTUQNBpU6ov9jb3wfzYAg
         KckU3VW/kwn85Ht0hLjiRhezQ9wf3ZTuUzrzQjiDQWDU+JUPyARlVMjLNEVzSLgtft2Z
         gdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AQf+EG1LqOYQqT40zZYv5ISTQOpig8QPja/gK5mvSkk=;
        b=kYPhUXbfaYXlJeZ3S7KL/tta2e6EulB2Yl4Lvp4XR0du4GlyiVr26sgfp8l35laUrm
         RIGJYThhGMENLJ80QULe7tupD+Vy8vTdo26h2FuY55TvoXKE+UdujsqWPRmZPNMjRFyj
         10UTrpeqZ02jp0tVVHxe+nZC5NgvylouzaFnkTaio+J1vJ7cqBRm6SYEBIrT4T2m5qyR
         ULLHYt7WldFeJd+RaTb/fW3ihv+1bFI7R530Wk3DtBpM2AZdzIWQ6lVnOHwr7hDiB1Lz
         GZNbMNpC1aAiP+tpbRL4NTn55kGFO4T2XkSEtggcSvbPofIf8cgwxskkJIdflxgglOwS
         7edA==
X-Gm-Message-State: AOAM531aJi2YMVktAKdeFlmtSBV1mSTVJI9iF6MfkH+FruXvKz5XL7/q
        MqDdV+AWUHcmV34cZGcacgk=
X-Google-Smtp-Source: ABdhPJyVv83AoFCYbid5KVzm+8jM4rad/1rkOdsJV57v03IVN4TJUfiogyz91xsQU0YnKxNdMe/pUA==
X-Received: by 2002:a5d:4e47:: with SMTP id r7mr12627007wrt.417.1631539042306;
        Mon, 13 Sep 2021 06:17:22 -0700 (PDT)
Received: from abel.fritz.box (p5b0ea1b5.dip0.t-ipconnect.de. [91.14.161.181])
        by smtp.gmail.com with ESMTPSA id h18sm7602834wrb.33.2021.09.13.06.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 06:17:21 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org
Cc:     daniel@ffwll.ch, intel-gfx@lists.freedesktop.org
Subject: [PATCH 07/26] drm/ttm: use the new iterator in ttm_bo_flush_all_fences
Date:   Mon, 13 Sep 2021 15:16:48 +0200
Message-Id: <20210913131707.45639-8-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913131707.45639-1-christian.koenig@amd.com>
References: <20210913131707.45639-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This is probably a fix since we didn't even grabed a reference to the
fences.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 0a3127436f61..5dd0c3dfec3c 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -269,19 +269,11 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
 static void ttm_bo_flush_all_fences(struct ttm_buffer_object *bo)
 {
 	struct dma_resv *resv = &bo->base._resv;
-	struct dma_resv_list *fobj;
+	struct dma_resv_cursor cursor;
 	struct dma_fence *fence;
-	int i;
 
 	rcu_read_lock();
-	fobj = dma_resv_shared_list(resv);
-	fence = dma_resv_excl_fence(resv);
-	if (fence && !fence->ops->signaled)
-		dma_fence_enable_sw_signaling(fence);
-
-	for (i = 0; fobj && i < fobj->shared_count; ++i) {
-		fence = rcu_dereference(fobj->shared[i]);
-
+	dma_resv_for_each_fence_unlocked(resv, &cursor, true, fence) {
 		if (!fence->ops->signaled)
 			dma_fence_enable_sw_signaling(fence);
 	}
-- 
2.25.1

