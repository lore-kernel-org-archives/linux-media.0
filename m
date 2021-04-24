Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08F0C43461
	for <linux-media@archiver.kernel.org>; Sat, 24 Apr 2021 06:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A40756120D
	for <linux-media@archiver.kernel.org>; Sat, 24 Apr 2021 06:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbhDXGrZ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 24 Apr 2021 02:47:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233252AbhDXGqQ (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sat, 24 Apr 2021 02:46:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 871896188B;
        Sat, 24 Apr 2021 06:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619246733;
        bh=9Su9Ws433aXy+PjnC7QMSvzB91NG3iiE93sDFxFiYlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k3IwNuO9JMoEyQ9FvrtBgiP3PNkgHehAJeBvv27jnD2LTgixVhcN+yY2yxx6QfOqp
         qFI+9N8r4ClXilr1ekgllBCV7Ga7L+l32djm6Ne3GhYR+AARlfGoZ9wujGcoDWmUqd
         8J1Z8OZwEaGArfslRwcP+N9IYEXV/DpVvT4Us3DT1wJZ9RV7A8KMhBgxii/UqiQ5MB
         1yCI6sCUU215zXHaOAyzLxSadhioyxqx+1HorBHbkbm2M6+U3bX9gsiKQDrJiJgq/3
         7dDajXZuKvOvsJAntylVrSWWAMMe065/9lLgI/ZyqlgaiRL9O0PPZ6PvyhBfRBG+47
         VkH6CxVQEKT5g==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1laC2n-004JhK-5G; Sat, 24 Apr 2021 08:45:33 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 73/78] media: s5p-mfc: use pm_runtime_resume_and_get()
Date:   Sat, 24 Apr 2021 08:45:23 +0200
Message-Id: <f01c6e2c5e61bc198443ecb82cd8a6eb6961b6d7.1619191723.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619191723.git.mchehab+huawei@kernel.org>
References: <cover.1619191723.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to deal with usage counter")
added pm_runtime_resume_and_get() in order to automatically handle
dev->power.usage_count decrement on errors.

Use the new API, in order to cleanup the error check logic.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_pm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c b/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c
index 62d2320a7218..88b7d33c9197 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c
@@ -78,11 +78,9 @@ int s5p_mfc_power_on(void)
 {
 	int i, ret = 0;
 
-	ret = pm_runtime_get_sync(pm->device);
-	if (ret < 0) {
-		pm_runtime_put_noidle(pm->device);
+	ret = pm_runtime_resume_and_get(pm->device);
+	if (ret < 0)
 		return ret;
-	}
 
 	/* clock control */
 	for (i = 0; i < pm->num_clocks; i++) {
-- 
2.30.2

