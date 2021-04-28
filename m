Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66112C4363C
	for <linux-media@archiver.kernel.org>; Wed, 28 Apr 2021 14:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1706143E
	for <linux-media@archiver.kernel.org>; Wed, 28 Apr 2021 14:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239898AbhD1OzY (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 28 Apr 2021 10:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240397AbhD1Oxs (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 28 Apr 2021 10:53:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C576E6194F;
        Wed, 28 Apr 2021 14:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619621564;
        bh=zHjujpboN+Iu7V2XpqIB+1lLAb+rrUx5c1q69NYA2sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dcrxahqfLcgpA/LydyGfKrzwUUQx05Vl0WOe4gFug0iBYxdvQcMYKp1pMaDlZlNpi
         CNLPgAdzNNqP/UQexjgzJIYcZn6BDWSYES3GZuMcRuLuPVOG3FkwayBGHEYzFvfaEh
         /0rY5RX5wr0rpdPCrYHPykZtnjPcvpAzNxmDVxZlkceEnoV8THTeB7cXIFi9EjQqdR
         /ITKCrNaWkmheRjQj/VjdFzburNe/3DCMIPCUbR96I1zEbUoLU0af0NyodHj6PXxae
         65BN9ItHTCeEgzQHviOTrgSGV1brP8KQ4G52fQ+rC0EFYDC0DBQ3cjOy21Cx05useE
         uqMbAW+GblSTA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lblYQ-001Dri-RF; Wed, 28 Apr 2021 16:52:42 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v4 44/79] media: i2c: ov2685: use pm_runtime_resume_and_get()
Date:   Wed, 28 Apr 2021 16:52:05 +0200
Message-Id: <868b8a71e01e7ddeefe068ea90cf094da053a3f2.1619621413.git.mchehab+huawei@kernel.org>
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

Commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to deal with usage counter")
added pm_runtime_resume_and_get() in order to automatically handle
dev->power.usage_count decrement on errors.

Use the new API, in order to cleanup the error check logic.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/i2c/ov2685.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ov2685.c b/drivers/media/i2c/ov2685.c
index 49a2dcedb347..2f3836dd8eed 100644
--- a/drivers/media/i2c/ov2685.c
+++ b/drivers/media/i2c/ov2685.c
@@ -456,11 +456,10 @@ static int ov2685_s_stream(struct v4l2_subdev *sd, int on)
 		goto unlock_and_return;
 
 	if (on) {
-		ret = pm_runtime_get_sync(&ov2685->client->dev);
-		if (ret < 0) {
-			pm_runtime_put_noidle(&client->dev);
+		ret = pm_runtime_resume_and_get(&ov2685->client->dev);
+		if (ret < 0)
 			goto unlock_and_return;
-		}
+
 		ret = __v4l2_ctrl_handler_setup(&ov2685->ctrl_handler);
 		if (ret) {
 			pm_runtime_put(&client->dev);
-- 
2.30.2

