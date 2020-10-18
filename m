Return-Path: <SRS0=tdip=DZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55039C433DF
	for <linux-media@archiver.kernel.org>; Sun, 18 Oct 2020 19:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25E2122269
	for <linux-media@archiver.kernel.org>; Sun, 18 Oct 2020 19:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603050803;
	bh=oDOnjFHkVgiIoA7tw0e2d0rfAy5TH6MzhU8d0U9ZVbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fes1un+zzVTOvouYBrbMkDhKHOulBbg25rKe/lr31tEMCBSUSzxl14l6Nnwi8kRIJ
	 rR8MlwHoLqcI3pGhH/ubkiIUYtl294Ag2oIqyQerMs+3uXUlHjtljERGGOD6CC9JPR
	 IMH9KYy0CJV80nnSytsTiB0mnLa7kDmC7uBL8qtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387947AbgJRTxT (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 18 Oct 2020 15:53:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729015AbgJRTUp (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sun, 18 Oct 2020 15:20:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3523A222EB;
        Sun, 18 Oct 2020 19:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603048845;
        bh=oDOnjFHkVgiIoA7tw0e2d0rfAy5TH6MzhU8d0U9ZVbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQi+hudtVDFlM6e3hOTeUJCW0W6/cwKOqwBaD5Wb/n7/RL3z5iD4EiwY/1ikZFHEK
         Tq4TxEK97hffEZtAmfoFb3HupBZN4wl/QvRybPMxyHHTT2E7U+FOswFctKPuRyl0tM
         Fc/H5h07wLNmORrudwa+JxCfOHoLXrWBfPjNRTmw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 014/101] media: vsp1: Fix runtime PM imbalance on error
Date:   Sun, 18 Oct 2020 15:18:59 -0400
Message-Id: <20201018192026.4053674-14-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201018192026.4053674-1-sashal@kernel.org>
References: <20201018192026.4053674-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit 98fae901c8883640202802174a4bd70a1b9118bd ]

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code. Thus a pairing decrement is needed on
the error handling path to keep the counter balanced.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/vsp1/vsp1_drv.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platform/vsp1/vsp1_drv.c
index c650e45bb0ad1..dc62533cf32ce 100644
--- a/drivers/media/platform/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/vsp1/vsp1_drv.c
@@ -562,7 +562,12 @@ int vsp1_device_get(struct vsp1_device *vsp1)
 	int ret;
 
 	ret = pm_runtime_get_sync(vsp1->dev);
-	return ret < 0 ? ret : 0;
+	if (ret < 0) {
+		pm_runtime_put_noidle(vsp1->dev);
+		return ret;
+	}
+
+	return 0;
 }
 
 /*
@@ -845,12 +850,12 @@ static int vsp1_probe(struct platform_device *pdev)
 	/* Configure device parameters based on the version register. */
 	pm_runtime_enable(&pdev->dev);
 
-	ret = pm_runtime_get_sync(&pdev->dev);
+	ret = vsp1_device_get(vsp1);
 	if (ret < 0)
 		goto done;
 
 	vsp1->version = vsp1_read(vsp1, VI6_IP_VERSION);
-	pm_runtime_put_sync(&pdev->dev);
+	vsp1_device_put(vsp1);
 
 	for (i = 0; i < ARRAY_SIZE(vsp1_device_infos); ++i) {
 		if ((vsp1->version & VI6_IP_VERSION_MODEL_MASK) ==
-- 
2.25.1

