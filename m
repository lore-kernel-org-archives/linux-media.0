Return-Path: <SRS0=QIOR=CS=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D861C43461
	for <linux-media@archiver.kernel.org>; Wed,  9 Sep 2020 07:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F22621D7B
	for <linux-media@archiver.kernel.org>; Wed,  9 Sep 2020 07:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgIIH7j (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:59:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11288 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728443AbgIIH7c (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 9 Sep 2020 03:59:32 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EB59C6E5A53A63C5D27B;
        Wed,  9 Sep 2020 15:59:29 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Sep 2020 15:59:23 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <sumit.semwal@linaro.org>,
        <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
        <ben.dooks@codethink.co.uk>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-media@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] drm/scheduler: fix sched_fence.c kernel-doc warnings
Date:   Wed, 9 Sep 2020 15:57:05 +0800
Message-ID: <1599638225-39300-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fix kernel-doc warnings.
drivers/gpu/drm/scheduler/sched_fence.c:110: warning: Function parameter or
member 'f' not described in 'drm_sched_fence_release_scheduled'
drivers/gpu/drm/scheduler/sched_fence.c:110: warning: Excess function
parameter 'fence' description in 'drm_sched_fence_release_scheduled'

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/scheduler/sched_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
index 8b45c3a1b84..69de2c7 100644
--- a/drivers/gpu/drm/scheduler/sched_fence.c
+++ b/drivers/gpu/drm/scheduler/sched_fence.c
@@ -101,7 +101,7 @@ static void drm_sched_fence_free(struct rcu_head *rcu)
 /**
  * drm_sched_fence_release_scheduled - callback that fence can be freed
  *
- * @fence: fence
+ * @f: fence
  *
  * This function is called when the reference count becomes zero.
  * It just RCU schedules freeing up the fence.
-- 
2.7.4

