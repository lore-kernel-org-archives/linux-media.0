Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7DAC433ED
	for <linux-media@archiver.kernel.org>; Wed, 28 Apr 2021 14:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC18F6143E
	for <linux-media@archiver.kernel.org>; Wed, 28 Apr 2021 14:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240322AbhD1Oxh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 28 Apr 2021 10:53:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240266AbhD1Ox3 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 28 Apr 2021 10:53:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B947561443;
        Wed, 28 Apr 2021 14:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619621563;
        bh=WqKoYQevkaStNcKaOzNIvfyWSTMDPdaJk89Ynu0GOzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AhluyASWRvSudbSL/CU0ekYMC1zmCrn+0YnbTPYtxfpVFanBm5Xe11SQxMkFeoqhB
         bUjanReRTPCuRe6bDw/qwq4S+fIr5zpAwCJI3NiSFiY7qhXkLu3f5bcRZVV0PPVm6v
         3XGM5VeA0QFK010Bu5lxxX8phMSf622hHvF7G34AOGaR30XOxiKVxRWwm3hlDqVd5E
         4bWF3IqZidQlbRNyOr/nTk0j8GE9A7yKFcU+ltGk5pc3QqDA+010sVBqXUsznScVn/
         YrT9YUwB1XazB+WZHdKySiAKvvYDr1KUaktEVxmBN69o9S/5Zfiq54TKtOTmu3G7rb
         SfMU4eKWGR12A==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lblYP-001DqA-TN; Wed, 28 Apr 2021 16:52:41 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 12/79] media: renesas-ceu: Properly check for PM errors
Date:   Wed, 28 Apr 2021 16:51:33 +0200
Message-Id: <70e2f612d1d3b7ad74fbfc5f90850f3874670fb2.1619621413.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619621413.git.mchehab+huawei@kernel.org>
References: <cover.1619621413.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Right now, the driver just assumes that PM runtime resume
worked, but it may fail.

Well, the pm_runtime_get_sync() internally increments the
dev->power.usage_count without decrementing it, even on errors.

So, using it is tricky. Let's replace it by the new
pm_runtime_resume_and_get(), introduced by:
commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to deal with usage counter")
and return an error if something bad happens.

This should ensure that the PM runtime usage_count will be
properly decremented if an error happens at open time.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/platform/renesas-ceu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/renesas-ceu.c b/drivers/media/platform/renesas-ceu.c
index cd137101d41e..17f01b6e3fe0 100644
--- a/drivers/media/platform/renesas-ceu.c
+++ b/drivers/media/platform/renesas-ceu.c
@@ -1099,10 +1099,10 @@ static int ceu_open(struct file *file)
 
 	mutex_lock(&ceudev->mlock);
 	/* Causes soft-reset and sensor power on on first open */
-	pm_runtime_get_sync(ceudev->dev);
+	ret = pm_runtime_resume_and_get(ceudev->dev);
 	mutex_unlock(&ceudev->mlock);
 
-	return 0;
+	return ret;
 }
 
 static int ceu_release(struct file *file)
-- 
2.30.2

