Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6DBC433DB
	for <linux-media@archiver.kernel.org>; Thu, 25 Feb 2021 09:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 824E064F0F
	for <linux-media@archiver.kernel.org>; Thu, 25 Feb 2021 09:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbhBYJFq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Feb 2021 04:05:46 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:34800 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234606AbhBYJCz (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Feb 2021 04:02:55 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UPXLGzZ_1614243730;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UPXLGzZ_1614243730)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Feb 2021 17:02:10 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     airlied@linux.ie
Cc:     daniel@ffwll.ch, sumit.semwal@linaro.org,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] drm/amdgpu: Replace DEFINE_SIMPLE_ATTRIBUTE with  DEFINE_DEBUGFS_ATTRIBUTE
Date:   Thu, 25 Feb 2021 17:02:08 +0800
Message-Id: <1614243728-52952-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fix the following coccicheck warning:
./drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1589:0-23: WARNING:
fops_ib_preempt should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1592:0-23: WARNING:
fops_sclk_set should be defined with DEFINE_DEBUGFS_ATTRIBUTE

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 0a25fec..52ef488 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1586,10 +1586,10 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_ib_preempt, NULL,
+DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
 			amdgpu_debugfs_ib_preempt, "%llu\n");
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_sclk_set, NULL,
+DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
 			amdgpu_debugfs_sclk_set, "%llu\n");
 
 int amdgpu_debugfs_init(struct amdgpu_device *adev)
-- 
1.8.3.1

