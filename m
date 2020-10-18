Return-Path: <SRS0=tdip=DZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E47C433E7
	for <linux-media@archiver.kernel.org>; Sun, 18 Oct 2020 19:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C6722272
	for <linux-media@archiver.kernel.org>; Sun, 18 Oct 2020 19:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603049434;
	bh=Etl385WUN4icE6iEWAybHyDVoUUE8rGg7lanvGlSY/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vcm/OvXkc6DR5KbtJyneQlZqFIEXZHqDJg6iVdrALHOqveFzcH2rO4mLJXZsbASrF
	 cG68c/dArGIGOmuxkfCr8NglJA2rmu0U/jsgujx544NQh3MkuMrAaMdpeMpYFDJhm4
	 UTdFzMNN/swMgCt9myfO8j5KOM9/MCKVvIP2BNfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbgJRTad (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 18 Oct 2020 15:30:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732145AbgJRT1h (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sun, 18 Oct 2020 15:27:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1258A22273;
        Sun, 18 Oct 2020 19:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603049256;
        bh=Etl385WUN4icE6iEWAybHyDVoUUE8rGg7lanvGlSY/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XBiuVrnrqt7qrHSQFFo1H+ZLMNt2iRcJlKEZnTXcP6vY8Ij2aFStVulv4n0i/2bOT
         B2Q3rLGNvGchYk9MM/PTBeiBr40ghJPtHx8O44CzQewWXSDL61+j8FH75PLXMT9xzi
         7Ilr26JOrp6HEPCYpm5OoIrEyHlbrdmHQ/jgGTz8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 06/33] media: bdisp: Fix runtime PM imbalance on error
Date:   Sun, 18 Oct 2020 15:27:01 -0400
Message-Id: <20201018192728.4056577-6-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201018192728.4056577-1-sashal@kernel.org>
References: <20201018192728.4056577-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit dbd2f2dc025f9be8ae063e4f270099677238f620 ]

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code. Thus a pairing decrement is needed on
the error handling path to keep the counter balanced.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Reviewed-by: Fabien Dessenne <fabien.dessenne@st.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/sti/bdisp/bdisp-v4l2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/sti/bdisp/bdisp-v4l2.c b/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
index a00dfaa1b945d..6c97063cb3b3f 100644
--- a/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
+++ b/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
@@ -1369,7 +1369,7 @@ static int bdisp_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
 		dev_err(dev, "failed to set PM\n");
-		goto err_dbg;
+		goto err_pm;
 	}
 
 	/* Continuous memory allocator */
@@ -1406,7 +1406,6 @@ static int bdisp_probe(struct platform_device *pdev)
 	vb2_dma_contig_cleanup_ctx(bdisp->alloc_ctx);
 err_pm:
 	pm_runtime_put(dev);
-err_dbg:
 	bdisp_debugfs_remove(bdisp);
 err_v4l2:
 	v4l2_device_unregister(&bdisp->v4l2_dev);
-- 
2.25.1

