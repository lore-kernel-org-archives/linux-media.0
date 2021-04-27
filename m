Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE09AC433ED
	for <linux-media@archiver.kernel.org>; Tue, 27 Apr 2021 10:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5064613C6
	for <linux-media@archiver.kernel.org>; Tue, 27 Apr 2021 10:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbhD0KPf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:15:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235488AbhD0KOl (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 27 Apr 2021 06:14:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8591661494;
        Tue, 27 Apr 2021 10:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619518432;
        bh=zHjujpboN+Iu7V2XpqIB+1lLAb+rrUx5c1q69NYA2sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7u+rAp/uxjkX46X8E9ZzzGAMoslnLL7F169mE61VT+kX/ZRdhf7ZnF5sd+d/HpmA
         5r+5N6/7U1L3JUZMBLeNez6D2RRHcIOCXHnPYirPdhQvzyXemdsQcA1jGeN9VfnAGs
         qe3NMhqaYvAxszbN0P45tQ4tPa6lMAcLesoPyX2mLwMihD4ceR6NzqN8rod0CrYJy1
         /+82ptY9RNJouCWBQDQ/77A3GNYnIPO+uj7k8MfXuquGC43it6G6R2YuhMvxVcCgVQ
         2LzaSASZDdvEh9bOsKGMuXqoxSzF/9qinF1LXxM/g4PxRuYOiRUwxwkxQe12Mn/GAQ
         KUlza7FxtNNew==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lbKj0-000j6o-GB; Tue, 27 Apr 2021 12:13:50 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 46/79] media: i2c: ov2685: use pm_runtime_resume_and_get()
Date:   Tue, 27 Apr 2021 12:13:13 +0200
Message-Id: <e3a6b916d0a305d14b4b537f91e998cac5cd5d1e.1619518193.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619518193.git.mchehab+huawei@kernel.org>
References: <cover.1619518193.git.mchehab+huawei@kernel.org>
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

