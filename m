Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3689BC433EF
	for <linux-media@archiver.kernel.org>; Mon, 28 Mar 2022 05:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238116AbiC1FOH (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 28 Mar 2022 01:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237107AbiC1FOG (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 28 Mar 2022 01:14:06 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22F951315;
        Sun, 27 Mar 2022 22:12:23 -0700 (PDT)
X-UUID: fb30e82a4d7c424e9a44f7ee3c6f49f3-20220328
X-GW-Reason: 11101
X-Policy-Incident: 5pS25Lu25Lq66LaF6L+HNeS6uumcgOimgeWuoeaguA==
X-Content-Feature: ica/max.line-size 167
        audit/email.address 1
        meta/cnt.alert 1
X-UUID: fb30e82a4d7c424e9a44f7ee3c6f49f3-20220328
Received: from cs2c.com.cn [(172.17.111.24)] by nksmu.kylinos.cn
        (envelope-from <lizhenneng@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 2131348658; Mon, 28 Mar 2022 12:05:18 +0800
X-ns-mid: postfix-62413430-3057013324
Received: from localhost.localdomain (unknown [172.20.108.41])
        by cs2c.com.cn (NSMail) with ESMTPA id D30D23848676;
        Mon, 28 Mar 2022 04:06:07 +0000 (UTC)
From:   Zhenneng Li <lizhenneng@kylinos.cn>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Jack Zhang <Jack.Zhang1@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, Zhenneng Li <lizhenneng@kylinos.cn>
Subject: [PATCH] drm/amdgpu: resolve s3 hang for r7340
Date:   Mon, 28 Mar 2022 12:05:36 +0800
Message-Id: <20220328040536.4121797-1-lizhenneng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This is a workaround for s3 hang for r7340(amdgpu).
When we test s3 with r7340 on arm64 platform, graphics card will hang up,
the error message are as follows:
Mar  4 01:14:11 greatwall-GW-XXXXXX-XXX kernel: [    1.599374][ 7] [  T291] amdgpu 0000:02:00.0: fb0: amdgpudrmfb frame buffer device
Mar  4 01:14:11 greatwall-GW-XXXXXX-XXX kernel: [    1.612869][ 7] [  T291] [drm:amdgpu_device_ip_late_init [amdgpu]] *ERROR* late_init of IP block <si_dpm> failed -22
Mar  4 01:14:11 greatwall-GW-XXXXXX-XXX kernel: [    1.623392][ 7] [  T291] amdgpu 0000:02:00.0: amdgpu_device_ip_late_init failed
Mar  4 01:14:11 greatwall-GW-XXXXXX-XXX kernel: [    1.630696][ 7] [  T291] amdgpu 0000:02:00.0: Fatal error during GPU init
Mar  4 01:14:11 greatwall-GW-XXXXXX-XXX kernel: [    1.637477][ 7] [  T291] [drm] amdgpu: finishing device.

Change-Id: I5048b3894c0ca9faf2f4847ddab61f9eb17b4823
Signed-off-by: Zhenneng Li <lizhenneng@kylinos.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3987ecb24ef4..1eced991b5b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2903,6 +2903,8 @@ static void amdgpu_device_delayed_init_work_handler(struct work_struct *work)
 		container_of(work, struct amdgpu_device, delayed_init_work.work);
 	int r;
 
+	mdelay(1);
+
 	r = amdgpu_ib_ring_tests(adev);
 	if (r)
 		DRM_ERROR("ib ring test failed (%d).\n", r);
-- 
2.25.1

