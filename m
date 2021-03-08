Return-Path: <SRS0=qtPK=IG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB30EC433E0
	for <linux-media@archiver.kernel.org>; Mon,  8 Mar 2021 03:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DD916514D
	for <linux-media@archiver.kernel.org>; Mon,  8 Mar 2021 03:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhCHDOp (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 7 Mar 2021 22:14:45 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:52779 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232583AbhCHDO1 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 7 Mar 2021 22:14:27 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UQp.mbY_1615173259;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UQp.mbY_1615173259)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 08 Mar 2021 11:14:25 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        sumit.semwal@linaro.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] drm/amdgpu: Remove unnecessary conversion to bool
Date:   Mon,  8 Mar 2021 11:14:14 +0800
Message-Id: <1615173254-22078-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c:1600:40-45: WARNING: conversion
to bool not needed here.

./drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c:1598:40-45: WARNING: conversion
to bool not needed here.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 690a509..b39e7db 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1595,9 +1595,9 @@ static int sdma_v5_2_set_clockgating_state(void *handle,
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
 		sdma_v5_2_update_medium_grain_clock_gating(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		sdma_v5_2_update_medium_grain_light_sleep(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		break;
 	default:
 		break;
-- 
1.8.3.1

