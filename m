Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FADEB64DD
	for <linux-media@archiver.kernel.org>; Wed,  9 Aug 2023 06:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjHIGws (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 9 Aug 2023 02:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjHIGwr (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 9 Aug 2023 02:52:47 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72651BF7;
        Tue,  8 Aug 2023 23:52:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VpOrdpm_1691563950;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VpOrdpm_1691563950)
          by smtp.aliyun-inc.com;
          Wed, 09 Aug 2023 14:52:40 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     maarten.lankhorst@linux.intel.com
Cc:     mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, sumit.semwal@linaro.org, christian.koenig@amd.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm: manager: Remove the unused variable prev
Date:   Wed,  9 Aug 2023 14:52:29 +0800
Message-Id: <20230809065229.71300-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Variable prev is not effectively used, so delete it.

drivers/gpu/drm/drm_gpuva_mgr.c:1079:32: warning: variable ‘prev’ set but not used.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/drm_gpuva_mgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuva_mgr.c b/drivers/gpu/drm/drm_gpuva_mgr.c
index f86bfad74ff8..afa5330445b3 100644
--- a/drivers/gpu/drm/drm_gpuva_mgr.c
+++ b/drivers/gpu/drm/drm_gpuva_mgr.c
@@ -1076,7 +1076,7 @@ __drm_gpuva_sm_map(struct drm_gpuva_manager *mgr,
 		   u64 req_addr, u64 req_range,
 		   struct drm_gem_object *req_obj, u64 req_offset)
 {
-	struct drm_gpuva *va, *next, *prev = NULL;
+	struct drm_gpuva *va, *next = NULL;
 	u64 req_end = req_addr + req_range;
 	int ret;
 
@@ -1206,7 +1206,6 @@ __drm_gpuva_sm_map(struct drm_gpuva_manager *mgr,
 			}
 		}
 next:
-		prev = va;
 	}
 
 	return op_map_cb(ops, priv,
-- 
2.20.1.7.g153144c

