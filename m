Return-Path: <SRS0=tdip=DZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832FAC433DF
	for <linux-media@archiver.kernel.org>; Sun, 18 Oct 2020 19:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47E4F207DE
	for <linux-media@archiver.kernel.org>; Sun, 18 Oct 2020 19:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603049773;
	bh=SSRlL4f84kMrgd9oCMsZLq8cF/Dwc/cJu7lwmU1Wjew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qHektu8zwJkBMnipl4uWzpS7klbhtjOTOlO5SVMcP0gepnZn4xIMyly14F1OYtsht
	 DL5RTfVQC4S2jYxmefgNP50t6izXr8eRgQr5+WpjIKg9IynrBiIx92cjp9oBzGso3m
	 1V2j3bSbbnKuFGkJ7SIsoXcpE53k/pXw6hxPCwJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbgJRTZq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 18 Oct 2020 15:25:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731358AbgJRTZp (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sun, 18 Oct 2020 15:25:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24308222C8;
        Sun, 18 Oct 2020 19:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603049144;
        bh=SSRlL4f84kMrgd9oCMsZLq8cF/Dwc/cJu7lwmU1Wjew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AgDJtRZOtxc4DuECtO+eVhUWX5+4AbpjJRekm4F5onuWrn0efSWvUk+R1HuSg5sU4
         5WP0vlGOlOExmZpzl+cD8T6xMzxcxz0AAR/hyUfnSuwqrhftwawisQ/uR1q6WkTcfK
         7/gqPbU1dqtK6Gl5zkpWi41mpJkoM8cGmBiW0iwY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 11/52] media: platform: sti: hva: Fix runtime PM imbalance on error
Date:   Sun, 18 Oct 2020 15:24:48 -0400
Message-Id: <20201018192530.4055730-11-sashal@kernel.org>
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
index 8dce2ccc551cb..1185f6b6721e9 100644
--- a/drivers/media/platform/sti/hva/hva-hw.c
+++ b/drivers/media/platform/sti/hva/hva-hw.c
@@ -393,7 +393,7 @@ int hva_hw_probe(struct platform_device *pdev, struct hva_dev *hva)
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
 		dev_err(dev, "%s     failed to set PM\n", HVA_PREFIX);
-		goto err_clk;
+		goto err_pm;
 	}
 
 	/* check IP hardware version */
-- 
2.25.1

