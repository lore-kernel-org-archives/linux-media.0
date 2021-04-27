Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC36AC433B4
	for <linux-media@archiver.kernel.org>; Tue, 27 Apr 2021 10:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3A8C611C1
	for <linux-media@archiver.kernel.org>; Tue, 27 Apr 2021 10:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbhD0K2r (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:28:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235635AbhD0K2F (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 27 Apr 2021 06:28:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 428DD613E7;
        Tue, 27 Apr 2021 10:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619519236;
        bh=WqKoYQevkaStNcKaOzNIvfyWSTMDPdaJk89Ynu0GOzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RyBpl6AKaQKI6Mfu73bAvucGOohlNoKilp4m+KOexK1Etf0BZPy0FFCRJ04WDR/HZ
         VOUn9LsCW3gVbQfuNQe18ZI+Gg7DD/zmNu+WeXMVdZFNQqbE6HQrvTAYIuDssqDJJX
         K80H2JVkEHyzM5jFBdQQkAWTsEjDAZR57bfR1pnCzp2n0/OV/xh3/RmHroTzLEP8tt
         l8+lviYnkQ0eGg1WiX5tF9inHLdV6tLBp3sR12fy6AR/677yzDG+pIr3T30TbhWGB2
         JxXejjwtLR8n7xyaiTg1uisMlhxGBmXQzj181tYSjwGOCmQjdSYKGLkyIznHa3gU/r
         r5JX4VExbKuvA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lbKvv-000nzn-FQ; Tue, 27 Apr 2021 12:27:11 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 12/79] media: renesas-ceu: Properly check for PM errors
Date:   Tue, 27 Apr 2021 12:26:02 +0200
Message-Id: <54ff89c9e585c21fef85c4a47b6fa1f1b1ba3677.1619519080.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619519080.git.mchehab+huawei@kernel.org>
References: <cover.1619519080.git.mchehab+huawei@kernel.org>
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

