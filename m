Return-Path: <SRS0=tdip=DZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B982C43467
	for <linux-media@archiver.kernel.org>; Sun, 18 Oct 2020 19:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C64E0207DE
	for <linux-media@archiver.kernel.org>; Sun, 18 Oct 2020 19:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603049825;
	bh=VPcK4QekstiDnUmXbtzac80C6mHVC6oL3H4FbCSlz5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mXaT0A3rFqsRW9BjcPjDeR78XVf/PylwHNg1mu+2Gx2zwIRENYmwSYidhfd4BgvvW
	 GXycmDptQf8zZqGgiPMXA4Ua4k/VxVEGxSCU4cmLoWxYQezpbXNKlUZglxoFPWvIo5
	 v9kkvRV3NG4fekcU39fUy5blzLLnUJ1sznNHMZgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732850AbgJRThF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 18 Oct 2020 15:37:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731303AbgJRTZg (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sun, 18 Oct 2020 15:25:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D90492236F;
        Sun, 18 Oct 2020 19:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603049135;
        bh=VPcK4QekstiDnUmXbtzac80C6mHVC6oL3H4FbCSlz5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P8RtXZon3vnjkF83dvpvuBouCUB6Vffekz6cKZMF0Shrw2+HxxDvn+Wa/9jrpvm1W
         wxF8tUEziVZtntn3+lr3TELZZe77JoiBzs9rSW2mSUGraoSqy0tX5JU1xW6Td2lMxU
         J6/5CNc8bARNpVFOKiGQqymQUQXXaXWik4beWvj0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 04/52] media: st-delta: Fix reference count leak in delta_run_work
Date:   Sun, 18 Oct 2020 15:24:41 -0400
Message-Id: <20201018192530.4055730-4-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201018192530.4055730-1-sashal@kernel.org>
References: <20201018192530.4055730-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>

[ Upstream commit 57cc666d36adc7b45e37ba4cd7bc4e44ec4c43d7 ]

delta_run_work() calls delta_get_sync() that increments
the reference counter. In case of failure, decrement the reference
count by calling delta_put_autosuspend().

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/sti/delta/delta-v4l2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/sti/delta/delta-v4l2.c b/drivers/media/platform/sti/delta/delta-v4l2.c
index b2dc3d223a9c9..7c925f309158d 100644
--- a/drivers/media/platform/sti/delta/delta-v4l2.c
+++ b/drivers/media/platform/sti/delta/delta-v4l2.c
@@ -970,8 +970,10 @@ static void delta_run_work(struct work_struct *work)
 	/* enable the hardware */
 	if (!dec->pm) {
 		ret = delta_get_sync(ctx);
-		if (ret)
+		if (ret) {
+			delta_put_autosuspend(ctx);
 			goto err;
+		}
 	}
 
 	/* decode this access unit */
-- 
2.25.1

