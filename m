Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48083C433EF
	for <linux-media@archiver.kernel.org>; Wed, 23 Mar 2022 03:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbiCWDKZ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 22 Mar 2022 23:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiCWDKY (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 22 Mar 2022 23:10:24 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829387087A;
        Tue, 22 Mar 2022 20:08:54 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 23 Mar
 2022 11:08:53 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 23 Mar
 2022 11:08:52 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <sumit.semwal@linaro.org>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>,
        Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] gpu: drm: Fix duplicate included linux/module.h
Date:   Wed, 23 Mar 2022 11:08:50 +0800
Message-ID: <1648004930-28070-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-124.meizu.com (172.16.1.124) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Clean up the following includecheck warning:

drivers/gpu/drm/drm_gem_shmem_helper.c: linux/module.h is
included more than once.

No functional change.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 62192411..7915047 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -10,7 +10,6 @@
 #include <linux/shmem_fs.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
-#include <linux/module.h>
 
 #ifdef CONFIG_X86
 #include <asm/set_memory.h>
-- 
2.7.4

