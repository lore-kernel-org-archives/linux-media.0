Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326B4C433ED
	for <linux-media@archiver.kernel.org>; Thu,  6 May 2021 15:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF5E613C7
	for <linux-media@archiver.kernel.org>; Thu,  6 May 2021 15:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbhEFPZM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 6 May 2021 11:25:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235219AbhEFPYd (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 6 May 2021 11:24:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D232361423;
        Thu,  6 May 2021 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620314610;
        bh=nHZL/8LfEY59F+jSTZXbI5IsJhAvjS0xN6pbKcv/Zf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vCnzn3EefAS6OJ0ojXlBof9/Um+5ehG6wridu2MaMlanV/rl/YYLLNH0U5ilUDkwN
         f+ETGwD2Eyyj3YN5amOJb4V+MJEgRiMJPuKa5wOplwc10wWd9dMTHqJWvWcGUyqQtP
         +zxm+41R3ukVSAAuoY/kYwMOtyGzJBhx8UjM04KXXZ1uB7gp6bc3T6nbCg3z0cV/GP
         LHI2BxYqoNLU+XJ8P5AH8fSzj08J2jYm2Y1mGUIvYyBkkdFtBAriqHROVJhsIAKPJU
         vCwABEEhqBdHQptJrG+u0PRT/dDvr7QkWYoE73VIPJ9x7x9as2fwPFCyLoi7tF1gFT
         q8aU1KzCSgpzg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lefqb-000RwM-0k; Thu, 06 May 2021 17:23:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Chuhong Yuan <hslester96@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v5 28/30] media: i2c: tvp5150: use pm_runtime_resume_and_get()
Date:   Thu,  6 May 2021 17:23:24 +0200
Message-Id: <d18e5043e5699a7829a6016e1fc0568c86b2cec2.1620314098.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620314098.git.mchehab+huawei@kernel.org>
References: <cover.1620314098.git.mchehab+huawei@kernel.org>
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
 drivers/media/i2c/tvp5150.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/media/i2c/tvp5150.c b/drivers/media/i2c/tvp5150.c
index e26e3f544054..374a9da75e4d 100644
--- a/drivers/media/i2c/tvp5150.c
+++ b/drivers/media/i2c/tvp5150.c
@@ -1448,11 +1448,9 @@ static int tvp5150_s_stream(struct v4l2_subdev *sd, int enable)
 	       TVP5150_MISC_CTL_CLOCK_OE;
 
 	if (enable) {
-		ret = pm_runtime_get_sync(sd->dev);
-		if (ret < 0) {
-			pm_runtime_put_noidle(sd->dev);
+		ret = pm_runtime_resume_and_get(sd->dev);
+		if (ret < 0)
 			return ret;
-		}
 
 		tvp5150_enable(sd);
 
@@ -1675,15 +1673,7 @@ static int tvp5150_registered(struct v4l2_subdev *sd)
 
 static int tvp5150_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
 {
-	int ret;
-
-	ret = pm_runtime_get_sync(sd->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(sd->dev);
-		return ret;
-	}
-
-	return 0;
+	return pm_runtime_resume_and_get(sd->dev);
 }
 
 static int tvp5150_close(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
-- 
2.30.2

