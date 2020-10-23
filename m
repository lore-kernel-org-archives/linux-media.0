Return-Path: <SRS0=FqJP=D6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F0CC61DD8
	for <linux-media@archiver.kernel.org>; Fri, 23 Oct 2020 12:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9090F24640
	for <linux-media@archiver.kernel.org>; Fri, 23 Oct 2020 12:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="da0uNPQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463628AbgJWMWq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 23 Oct 2020 08:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463622AbgJWMWp (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 23 Oct 2020 08:22:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2673C0613CE
        for <linux-media@vger.kernel.org>; Fri, 23 Oct 2020 05:22:43 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id n15so1597567wrq.2
        for <linux-media@vger.kernel.org>; Fri, 23 Oct 2020 05:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KOyGCTKuuJziCpWzWdCo/QK3Mayinv6OMW6Q5kQhnyk=;
        b=da0uNPQTF9iafrGvjttCTo8KaCRGJJ0losxnfEnQ+ctYYMk40w+JM+UOvxXYJaJDlG
         xnhBhyiiG2KhEERw/wSo3xnYtahtTOoeS3KP8SHjgUOynK4D05IBt6vq+GpjyIyyqglj
         o++XAyFlbf9CE2K6mHWsMlao1Qc55VGiPnPJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KOyGCTKuuJziCpWzWdCo/QK3Mayinv6OMW6Q5kQhnyk=;
        b=Leierr+vNx1kde2QyRBGTa3mw19mVNK/kO8atm/FTWYFpGQL3B4QPgB1yQo6vzZ2I6
         tQmusrhevh18l3ZeS+SQP7wniRQCacG5md8LTplKg0V1avJZzTdl03iYT+Gr955Tvn/6
         Mn/FSdcNyoLkFO1Ic7hAVmt0B8ULw06t2X6Lz/nSzygRswc1fOryz5qckRKBsPhGfJBZ
         W81NuSwPKYMAqAuxvpwVaH1GJLEs80Bm8kIJ4oGUDMtz1hSNPX9fz208If4M/XoxrDgG
         MNJJ7KX3jTAc+oT3tIEs37JIJiZ1C/MwdqPDf0AMTPmdg1QKUwo5HfrjSGREyYDDL5+U
         QbYw==
X-Gm-Message-State: AOAM532L7d0zvLEg8RthGndIKvb9HJ2FQy4JHKLBQdqekptPhcpLeZij
        OeCNhOOax1hBicrhdW3by9/Rbw==
X-Google-Smtp-Source: ABdhPJxrOX8/B2rmy6TerQUriY/hvWhKXRqCPO7bzGJK2shyHhd4WjRC4UHiZqehTAyO+ARcrDOJSA==
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr2304784wrn.362.1603455762699;
        Fri, 23 Oct 2020 05:22:42 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y4sm3056484wrp.74.2020.10.23.05.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 05:22:42 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 18/65] drm/amdgpu: use dma-fence annotations in cs_submit()
Date:   Fri, 23 Oct 2020 14:21:29 +0200
Message-Id: <20201023122216.2373294-18-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023122216.2373294-1-daniel.vetter@ffwll.ch>
References: <20201021163242.1458885-1-daniel.vetter@ffwll.ch>
 <20201023122216.2373294-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This is a bit tricky, since ->notifier_lock is held while calling
dma_fence_wait we must ensure that also the read side (i.e.
dma_fence_begin_signalling) is on the same side. If we mix this up
lockdep complaints, and that's again why we want to have these
annotations.

A nice side effect of this is that because of the fs_reclaim priming
for dma_fence_enable lockdep now automatically checks for us that
nothing in here allocates memory, without even running any userptr
workloads.

Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: linux-rdma@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index d50b63a93d37..3b3999225e31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1212,6 +1212,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	struct amdgpu_job *job;
 	uint64_t seq;
 	int r;
+	bool fence_cookie;
 
 	job = p->job;
 	p->job = NULL;
@@ -1226,6 +1227,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	 */
 	mutex_lock(&p->adev->notifier_lock);
 
+	fence_cookie = dma_fence_begin_signalling();
+
 	/* If userptr are invalidated after amdgpu_cs_parser_bos(), return
 	 * -EAGAIN, drmIoctl in libdrm will restart the amdgpu_cs_ioctl.
 	 */
@@ -1262,12 +1265,14 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
 
 	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
+	dma_fence_end_signalling(fence_cookie);
 	mutex_unlock(&p->adev->notifier_lock);
 
 	return 0;
 
 error_abort:
 	drm_sched_job_cleanup(&job->base);
+	dma_fence_end_signalling(fence_cookie);
 	mutex_unlock(&p->adev->notifier_lock);
 
 error_unlock:
-- 
2.28.0

