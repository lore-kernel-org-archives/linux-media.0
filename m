Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EDEC82489
	for <linux-media@archiver.kernel.org>; Fri, 27 Nov 2020 16:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A86206DF
	for <linux-media@archiver.kernel.org>; Fri, 27 Nov 2020 16:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="c21Xo6Rj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbgK0QnW (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 27 Nov 2020 11:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731554AbgK0QmB (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 27 Nov 2020 11:42:01 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6F3C0613D2
        for <linux-media@vger.kernel.org>; Fri, 27 Nov 2020 08:42:01 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id t4so6170764wrr.12
        for <linux-media@vger.kernel.org>; Fri, 27 Nov 2020 08:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MT1z3cj215AzOOgO3dPH+bq94VZWhyvFICSSDrawSRQ=;
        b=c21Xo6Rj7estCGPrDTj8F/i7Yj+krVWD4HRtsgjJ5HM3ti0pxKMcUeJWhEPoFRCyxm
         1A1kzXuYRFOR/X+6YDTzJXdBai011blJGvgmrkSXBVP5T5qkBuL2TX0c1GXUrVu68ZQV
         7WLP8+TYoIE1YNuaBvjxsmSVUsTBXsc/v2np0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MT1z3cj215AzOOgO3dPH+bq94VZWhyvFICSSDrawSRQ=;
        b=ujpvMF3lE00SipEK1xFT/a+D7RVVCTsiIjURieRkmjlzCwcCYyd//DfELeIA821UIu
         G8EQsIZRkXWq6VGp5ycjWk7oVq+uVaiv/JPBtfEwGnEOWRnil7bmzQa36xVHb9tWijRj
         Gm+1k3L7ahUQrvr0X4Oa7Bbbd1TM6GJ+RnptbOuTG11Vuf9/HemcNaF0jV1ZsOOVrrrq
         hHJ+2S1Ezc5vVhua5TH6CA2sng2Ajl3zSlsOgl9HAoqGKrW8UUOO4KfYqupqH6xEY824
         bsXAy5tV8jGl0gFNFDB+x8vINAGKHOtKPGp+ybba7/SIvV9b3CnyhymS/EdSn0CpyI4o
         xz0A==
X-Gm-Message-State: AOAM5315JKDmsVJeWRqnVjIbHa3D4W5dp1XO1W5QfeVrRQ+iGHGY1XDr
        eBjjFKCjKPjKDIqIES6PQ3hyIg==
X-Google-Smtp-Source: ABdhPJxJ+tJLOlH6yvpyDM4wsRPMg/i5xjzosEA83cZyFmOXcl5fGMh4eoZjxhHpFGJ3CymrXbGpNw==
X-Received: by 2002:adf:f783:: with SMTP id q3mr11568497wrp.88.1606495319838;
        Fri, 27 Nov 2020 08:41:59 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q12sm14859078wrx.86.2020.11.27.08.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 08:41:59 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v7 02/17] drm/exynos: Use FOLL_LONGTERM for g2d cmdlists
Date:   Fri, 27 Nov 2020 17:41:16 +0100
Message-Id: <20201127164131.2244124-3-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127164131.2244124-1-daniel.vetter@ffwll.ch>
References: <20201127164131.2244124-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The exynos g2d interface is very unusual, but it looks like the
userptr objects are persistent. Hence they need FOLL_LONGTERM.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-media@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/exynos/exynos_drm_g2d.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index ecede41af9b9..1e0c5a7f206e 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -475,7 +475,8 @@ static dma_addr_t *g2d_userptr_get_dma_addr(struct g2d_data *g2d,
 		goto err_free;
 	}
 
-	ret = pin_user_pages_fast(start, npages, FOLL_FORCE | FOLL_WRITE,
+	ret = pin_user_pages_fast(start, npages,
+				  FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
 				  g2d_userptr->pages);
 	if (ret != npages) {
 		DRM_DEV_ERROR(g2d->dev,
-- 
2.29.2

