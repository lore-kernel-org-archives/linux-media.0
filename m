Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2B3C433DB
	for <linux-media@archiver.kernel.org>; Tue, 23 Mar 2021 02:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A820619A9
	for <linux-media@archiver.kernel.org>; Tue, 23 Mar 2021 02:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhCWCqu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 22 Mar 2021 22:46:50 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:58505 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229760AbhCWCqX (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 22 Mar 2021 22:46:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0UT1Ea9s_1616467574;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UT1Ea9s_1616467574)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Mar 2021 10:46:19 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     l.stach@pengutronix.de
Cc:     linux+etnaviv@armlinux.org.uk, christian.gmeiner@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, sumit.semwal@linaro.org,
        christian.koenig@amd.com, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] drm/etnaviv: Remove redundant NULL check
Date:   Tue, 23 Mar 2021 10:46:12 +0800
Message-Id: <1616467572-112804-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c:622:2-8: WARNING: NULL
check before some freeing functions is not needed.

./drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c:618:2-8: WARNING: NULL
check before some freeing functions is not needed.

./drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c:616:2-8: WARNING: NULL
check before some freeing functions is not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
index d05c359..bd0d66e 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
@@ -612,14 +612,10 @@ int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
 err_submit_cmds:
 	if (ret && (out_fence_fd >= 0))
 		put_unused_fd(out_fence_fd);
-	if (stream)
-		kvfree(stream);
-	if (bos)
-		kvfree(bos);
-	if (relocs)
-		kvfree(relocs);
-	if (pmrs)
-		kvfree(pmrs);
+	kvfree(stream);
+	kvfree(bos);
+	kvfree(relocs);
+	kvfree(pmrs);
 
 	return ret;
 }
-- 
1.8.3.1

