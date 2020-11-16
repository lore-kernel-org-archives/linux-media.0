Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07010C63697
	for <linux-media@archiver.kernel.org>; Mon, 16 Nov 2020 17:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6BDA20B80
	for <linux-media@archiver.kernel.org>; Mon, 16 Nov 2020 17:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f7neOg4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387864AbgKPRn2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 16 Nov 2020 12:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387843AbgKPRmN (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 16 Nov 2020 12:42:13 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB80DC0617A6
        for <linux-media@vger.kernel.org>; Mon, 16 Nov 2020 09:42:12 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 10so52078wml.2
        for <linux-media@vger.kernel.org>; Mon, 16 Nov 2020 09:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4XjzABzYijzfUYSQAFjSWGgtY8O6T4iGtJT/GdPVe/g=;
        b=f7neOg4p2FtX/vppSn6QN4LztxxWXPO5PsEPG4P1pfWm9ayx4ZaCXP7Qy5MqXIyTJc
         szXloESY6VRWVHOrJFA0WDsNDfNySfQbMAttyoqqqrPShI2NHvwtsWMnnVe90jgsu6/k
         RfOFgRTAgrB9QnazseVDq0C31vlwqKRYp/3Iv9uR/1K+XMNC2FUSHUFAbjWZFBxEqLMJ
         5yM7hZMKGVWVIANE4KarSM+svzza1WdFLdf+b51OHuQcgM4RzIu0shsgULOJyqo5wxmx
         EpGBaE7lPbGEd1xXXmTdM9La82KremeZzH6buoeGQECFzv4wW0EUHa3LjPQsOWRIRaD3
         rhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4XjzABzYijzfUYSQAFjSWGgtY8O6T4iGtJT/GdPVe/g=;
        b=g4mLUFpnjY9x+beYi+mNeJB4Ijsfx5cMNi3RvQlYoMtjXJHKdLl5QTtKoMcxWGwaGf
         NhFgGVejTOEMfb4w1XoGzvGYuPnE24pdWD25M46ey/wfXBPLW1jDMMkrQiTsGqJ42CxQ
         5J0NNXfmm+VhyqDpAftGy2zTFi90H2pEPZt+2bMzHNGj/yPbYSBZ3KH0n/FPNDFGNiFn
         lSIPDcOzguvhPZpIkoQ0lQSSjVcc65m4WH5OgoRztjzFZPkJ4l2s8Ah8HQWblz3UO7AJ
         GhUKRmrH2dHGMkO6XvZY1FaZmTsAzyBZC/o60QoFOrGSWTWnFakJDKim8aOdVgBkX2ZJ
         578g==
X-Gm-Message-State: AOAM531uBK0Y16CWrSnJxq/ZbuGLywNrN9iUFz9LDlC8xLb5zxYmSGtQ
        0p1WNRFOCaxbKStR4VXPnDtW7A==
X-Google-Smtp-Source: ABdhPJxD3PsXkkAcAPwL+o29CIkE9xzELIl6mVYJ526IXOd8g4jWPgod5PLCtsJAgJzqn/4rRNKQ/Q==
X-Received: by 2002:a1c:c20a:: with SMTP id s10mr8267wmf.23.1605548531381;
        Mon, 16 Nov 2020 09:42:11 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:42:10 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH 36/42] drm/v3d/v3d_sched: Demote non-conformant kernel-doc header
Date:   Mon, 16 Nov 2020 17:41:06 +0000
Message-Id: <20201116174112.1833368-37-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/v3d/v3d_sched.c:75: warning: Function parameter or member 'sched_job' not described in 'v3d_job_dependency'
 drivers/gpu/drm/v3d/v3d_sched.c:75: warning: Function parameter or member 's_entity' not described in 'v3d_job_dependency'

Cc: Eric Anholt <eric@anholt.net>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/v3d/v3d_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 0747614a78f0b..452682e2209f4 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -63,7 +63,7 @@ v3d_job_free(struct drm_sched_job *sched_job)
 	v3d_job_put(job);
 }
 
-/**
+/*
  * Returns the fences that the job depends on, one by one.
  *
  * If placed in the scheduler's .dependency method, the corresponding
-- 
2.25.1

