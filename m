Return-Path: <SRS0=tdip=DZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE14C433E7
	for <linux-media@archiver.kernel.org>; Sun, 18 Oct 2020 19:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50C7C2231B
	for <linux-media@archiver.kernel.org>; Sun, 18 Oct 2020 19:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603048975;
	bh=L2+RJXccCaMCISHwYIWzmgF0+1Wiq4nILRjct3Rac6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aZ526Y27sWDpQHY+ke9GJv4tJ7PJ0FM7cE9Luv4d381OGNEemjxcaMD+LcZeCup3Q
	 APXhJJi8ahYkwVdkLhF1p1nZ7AxUi+tVXlLB8Qrm1LNiX6RGbXoifzXnX0z2iy/GfL
	 seLUQfxNEBhQ8sU1fnwitR300AzNWgZ859r9L/Ns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgJRTWx (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 18 Oct 2020 15:22:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730026AbgJRTWw (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sun, 18 Oct 2020 15:22:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C90320791;
        Sun, 18 Oct 2020 19:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603048972;
        bh=L2+RJXccCaMCISHwYIWzmgF0+1Wiq4nILRjct3Rac6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vy4V1bXlwQ85ozHNlOPBQzOXjXd3UiZKinOKG850O9OcG3186a/I7IJy6NFnl3tF8
         Zqf4v07xFO446Zo0kNOXQJ+ZtMk1RS1M2VYYzcVUQbCJZiYXhYcfQbcI2F3X+nYs9o
         U6MEH4gXj3/IUoWuXezammZIJUcZfSBLRIXlwUYA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 15/80] media: platform: sti: hva: Fix runtime PM imbalance on error
Date:   Sun, 18 Oct 2020 15:21:26 -0400
Message-Id: <20201018192231.4054535-15-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201018192231.4054535-1-sashal@kernel.org>
References: <20201018192231.4054535-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit d912a1d9e9afe69c6066c1ceb6bfc09063074075 ]

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code. Thus a pairing decrement is needed on
the error handling path to keep the counter balanced.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/sti/hva/hva-hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sti/hva/hva-hw.c b/drivers/media/platform/sti/hva/hva-hw.c
index bb13348be0832..43f279e2a6a38 100644
--- a/drivers/media/platform/sti/hva/hva-hw.c
+++ b/drivers/media/platform/sti/hva/hva-hw.c
@@ -389,7 +389,7 @@ int hva_hw_probe(struct platform_device *pdev, struct hva_dev *hva)
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
 		dev_err(dev, "%s     failed to set PM\n", HVA_PREFIX);
-		goto err_clk;
+		goto err_pm;
 	}
 
 	/* check IP hardware version */
-- 
2.25.1

