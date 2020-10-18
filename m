Return-Path: <SRS0=tdip=DZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E9CC433DF
	for <linux-media@archiver.kernel.org>; Sun, 18 Oct 2020 19:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42BC022269
	for <linux-media@archiver.kernel.org>; Sun, 18 Oct 2020 19:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603050731;
	bh=uMiewmmEqIP9o+WBAyBsct7iMPd6w8XJY4CYwUbB3zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jfsy9Nws6Cx4H7PI56NjXBTTN+jFBUq4iyMpLDH7Kdi5ZReg7I8Tb+zGGZZXrs1SF
	 XmDuZ10CXIXk9B6huGLsNmWv3lAFZAODmcktUXHBAiepnrnJMm2krRfPkLbWLfVPhX
	 vschrx7QFyUyo8TB/1x/2QAzYMHVjR0LS/1Nw5do=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387837AbgJRTwK (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 18 Oct 2020 15:52:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729219AbgJRTVG (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sun, 18 Oct 2020 15:21:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71D17222B9;
        Sun, 18 Oct 2020 19:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603048866;
        bh=uMiewmmEqIP9o+WBAyBsct7iMPd6w8XJY4CYwUbB3zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1pAzcTaj7hYrYJJ7zf0xANxT8Wz2c7dRUURVY4QFVbs1w4Szsm9OV/qzIMRrmUlJw
         Ljap8Vyv3nO1MhpzF3pPWYzSZSqqwqmf2PWEtgX/vfNdJwbtzkH9qazmNbPN2Y4Y6l
         iOt92+FMIHoUuad/DmfWmc9SWyfQwofRhMo2jj5M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 032/101] media: venus: core: Fix runtime PM imbalance in venus_probe
Date:   Sun, 18 Oct 2020 15:19:17 -0400
Message-Id: <20201018192026.4053674-32-sashal@kernel.org>
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

[ Upstream commit bbe516e976fce538db96bd2b7287df942faa14a3 ]

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code. Thus a pairing decrement is needed on
the error handling path to keep the counter balanced. For other error
paths after this call, things are the same.

Fix this by adding pm_runtime_put_noidle() after 'err_runtime_disable'
label. But in this case, the error path after pm_runtime_put_sync()
will decrease PM usage counter twice. Thus add an extra
pm_runtime_get_noresume() in this path to balance PM counter.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/venus/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index bfcaba37d60fe..321ad77cb6cf4 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -289,8 +289,10 @@ static int venus_probe(struct platform_device *pdev)
 		goto err_core_deinit;
 
 	ret = pm_runtime_put_sync(dev);
-	if (ret)
+	if (ret) {
+		pm_runtime_get_noresume(dev);
 		goto err_dev_unregister;
+	}
 
 	return 0;
 
@@ -301,6 +303,7 @@ static int venus_probe(struct platform_device *pdev)
 err_venus_shutdown:
 	venus_shutdown(core);
 err_runtime_disable:
+	pm_runtime_put_noidle(dev);
 	pm_runtime_set_suspended(dev);
 	pm_runtime_disable(dev);
 	hfi_destroy(core);
-- 
2.25.1

