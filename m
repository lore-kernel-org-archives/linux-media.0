Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A20C43461
	for <linux-media@archiver.kernel.org>; Sat, 24 Apr 2021 06:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A99C61482
	for <linux-media@archiver.kernel.org>; Sat, 24 Apr 2021 06:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbhDXGrM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 24 Apr 2021 02:47:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233139AbhDXGqO (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sat, 24 Apr 2021 02:46:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84D896187E;
        Sat, 24 Apr 2021 06:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619246733;
        bh=x4LtonqYrT7G4qNBwEeK0f+06mohriAA55Pys8MWWx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bKjiw2G0kZr+ABmA2XVg7IjYBBIn6XsjsZ2ELUUF46gXQJ5Gdl4cCKxuuOomxbmsy
         ScMTbcCWpXjcOoFjQhbGBXoPkYupi8N4VmXJgUiXLdQ8sCx3ivjujcmcEUoblizvpq
         Ooj7YMnYCbX4DG5UH6kTrtakCmaqmYqavNxSbX0cW2g1d0tuWoA+lU86/TtejPYF+p
         UO9uA001vlX9MtUAiNRLp+y5badNkUjhKK5ARijOk6P6ULsrBLwyBFwOXLQS3v3rCa
         tNJgF2ZKw/1P9CDbcUiC3b6E8a8Whl48tT41A/CkEiaoBA5YEG6PDO7R877/xAWkTL
         sRqYyDlkhaivA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1laC2l-004Jes-Ij; Sat, 24 Apr 2021 08:45:31 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 24/78] media: i2c: ak7375: use pm_runtime_resume_and_get()
Date:   Sat, 24 Apr 2021 08:44:34 +0200
Message-Id: <c67edd42134c31f8a519fddae12a833787d8da27.1619191723.git.mchehab+huawei@kernel.org>
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
 drivers/media/i2c/ak7375.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/media/i2c/ak7375.c b/drivers/media/i2c/ak7375.c
index e1f94ee0f48f..40b1a4aa846c 100644
--- a/drivers/media/i2c/ak7375.c
+++ b/drivers/media/i2c/ak7375.c
@@ -87,15 +87,7 @@ static const struct v4l2_ctrl_ops ak7375_vcm_ctrl_ops = {
 
 static int ak7375_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
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
 
 static int ak7375_close(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
-- 
2.30.2

