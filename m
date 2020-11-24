Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9738FC64E75
	for <linux-media@archiver.kernel.org>; Tue, 24 Nov 2020 19:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 552FF208CA
	for <linux-media@archiver.kernel.org>; Tue, 24 Nov 2020 19:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jzIcHL0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgKXTpI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 24 Nov 2020 14:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgKXTou (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:50 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34970C08E85F
        for <linux-media@vger.kernel.org>; Tue, 24 Nov 2020 11:44:50 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r17so23605461wrw.1
        for <linux-media@vger.kernel.org>; Tue, 24 Nov 2020 11:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LAMUF0M+5e5QxYGdyHTIO/CIT9L6gglBGUvPq+MzHBg=;
        b=jzIcHL0eMMZm6DtlZ9fd+0W/Qjf5OD3r//36xPdi8sot0v4hYcjWBJGo5JsdiMAylp
         59cVzB0oYdEJPt6mdkziyQpaCf9SGy3mSSb/GS6zD2UgphuNsEksk+mdbzN58DTfIKHq
         EAOM2xRHO5Peg/72jxA8+vV69v1RYabIKSnergZZ0ZMBcl+60CIl9Iq3i0vVOQ24h4iG
         GvSC+Xkk8n07CN7qKU+XEd44EJWCpmiRlNYWrlWHzqAYUhnJHcFSBkYV+/Ut8MP8+xxf
         pr0QrRWs6YAUEhSh5t8ghtWxnO/bqpAlEyi4IUA21Oj2pQc67sOd7YpbMJx2fSqqXAju
         XxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LAMUF0M+5e5QxYGdyHTIO/CIT9L6gglBGUvPq+MzHBg=;
        b=pIBGPLaKnMYf89lsdOJDtsHJ1MjjYwxD1D/5ci77bYT6kqUoTFo2OP3ajyK4IXsFz9
         SDnLRLSM32w33Vap1lp+IPrvgv5RL1i6gHifcMJjtMrx7WlDJ0STBXLMMPeuFC5CZazk
         J59c4Cgzyx66AZQ6BCPEPXoYOse2QwPBWcl90pMXRpk9lFnAvHFHyjkB1UcoyD7FNaJ6
         EZHKqLTjVyuRkgJIUEeNe/78JPVnt0mucsI/MUqM3mRirR+V3y8BHTYDCHEn0Tgc2gXa
         A89Z3Che2dfWwAU0NK5p7JH8kNgwBqiR235jeglhoGjYPAMqpq3iDjbtKOhhOm7flhRY
         RJxA==
X-Gm-Message-State: AOAM533uOyc+DEwbyIUXTLJJWyWB+oKAcc01WRDePT0gn7dVglG6HUCS
        pvyOWcMlxjWMn6qpkwHRD7+fyg==
X-Google-Smtp-Source: ABdhPJwGpjx8U/47ZgWVIMjepZQiRgQQJIP/hnzr40LeSboZi3EXQzjARjAY1rA2rTYNNnVeMWqbpA==
X-Received: by 2002:a5d:690c:: with SMTP id t12mr44599wru.405.1606247088972;
        Tue, 24 Nov 2020 11:44:48 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:48 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 40/40] drm/amd/amdgpu/amdgpu_uvd: Add description for amdgpu_uvd_cs_msg_decode()'s 'buf_sizes' param
Date:   Tue, 24 Nov 2020 19:38:24 +0000
Message-Id: <20201124193824.1118741-41-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124193824.1118741-1-lee.jones@linaro.org>
References: <20201124193824.1118741-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:555: warning: Function parameter or member 'buf_sizes' not described in 'amdgpu_uvd_cs_msg_decode'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index f8f0384a8d9ad..7c5b60e534822 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -547,6 +547,7 @@ static int amdgpu_uvd_cs_pass1(struct amdgpu_uvd_cs_ctx *ctx)
  *
  * @adev: amdgpu_device pointer
  * @msg: pointer to message structure
+ * @buf_sizes: placeholder to put the different buffer lengths
  *
  * Peek into the decode message and calculate the necessary buffer sizes.
  */
-- 
2.25.1

