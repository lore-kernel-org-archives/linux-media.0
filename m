Return-Path: <SRS0=tdip=DZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55EBC433DF
	for <linux-media@archiver.kernel.org>; Sun, 18 Oct 2020 19:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 739DD22267
	for <linux-media@archiver.kernel.org>; Sun, 18 Oct 2020 19:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603050362;
	bh=4DCuPeW3yW2U9oJ3tflmq+0xSP9pSKrKh9VbhaYRndk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X+awJmjEbTy8UmA82xJKtGIILOBgU1wNL1O5bl/25/jbvqcTvvlUO9hK+ttiZoBYi
	 WYXlfXzef3T/qypLAbR/5LGum13nvgtZIDI192BHVxOWk/xQt1tnefarvR2abh5jpN
	 vSW+RF281QR2UOHEzLbhpNFJ+6oP3cg2u5tZT1sk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbgJRTqB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 18 Oct 2020 15:46:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730046AbgJRTWx (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sun, 18 Oct 2020 15:22:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CB08222EC;
        Sun, 18 Oct 2020 19:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603048973;
        bh=4DCuPeW3yW2U9oJ3tflmq+0xSP9pSKrKh9VbhaYRndk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mi8h0059MX17TsZMxD7Y/jO67lfTuCd3+cDYXPpbdyV3jKew5JFemf1Ve2SkCyPZb
         rL8AgQhDS94gRocA+K7ncnRfc2ldvKOZ3BzT02YEYEGdNpK+eqyUh8rFdpeickrml8
         hXP7H06HE/g1SdVfoB1cLfgnXYMg10U41dYNqoPI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 16/80] media: bdisp: Fix runtime PM imbalance on error
Date:   Sun, 18 Oct 2020 15:21:27 -0400
Message-Id: <20201018192231.4054535-16-sashal@kernel.org>
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
index 675b5f2b4c2ee..a55ddf8d185d5 100644
--- a/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
+++ b/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
@@ -1367,7 +1367,7 @@ static int bdisp_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
 		dev_err(dev, "failed to set PM\n");
-		goto err_dbg;
+		goto err_pm;
 	}
 
 	/* Filters */
@@ -1395,7 +1395,6 @@ static int bdisp_probe(struct platform_device *pdev)
 	bdisp_hw_free_filters(bdisp->dev);
 err_pm:
 	pm_runtime_put(dev);
-err_dbg:
 	bdisp_debugfs_remove(bdisp);
 err_v4l2:
 	v4l2_device_unregister(&bdisp->v4l2_dev);
-- 
2.25.1

