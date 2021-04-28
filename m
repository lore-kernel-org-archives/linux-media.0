Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1D0C433B4
	for <linux-media@archiver.kernel.org>; Wed, 28 Apr 2021 14:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 064276143E
	for <linux-media@archiver.kernel.org>; Wed, 28 Apr 2021 14:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239933AbhD1Oz1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 28 Apr 2021 10:55:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240404AbhD1Oxs (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 28 Apr 2021 10:53:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4F856194E;
        Wed, 28 Apr 2021 14:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619621565;
        bh=CBbCf8lLczURo0R8ANC6iiJbxWCN1ESFz/X/hIdzJFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BKu2YQcU5XwwD0PITeQH1a8LcQVhlgGs6iuZ+CqOAE/3w+0QHFAma6QzsI3eJpPOA
         XMYFMDJANYReugMGKucOsViUCI7iCQXSNOSl+Q8cpNA2LDSp1z35B2Bbg3ksex1ihE
         prSfane3wIj504aOKin520Jehi1wq3+OEMDX1FPOL8URJhsjSlehNgcMWfSbC0KEPP
         bcUN/H4g8Kgt/EoheO65+YrHiaq9Ml65QYgcLw7aFA1Xq8Py79zr71w1q/PbGp1f6m
         +idAEYoGZlar//OB77yoBvLH4lA1gfbgND0j6S91mogMg4TAOu+quyv1t1ZMee3ZSz
         gMk8F2l3Hf3lQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lblYR-001DsC-4V; Wed, 28 Apr 2021 16:52:43 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v4 54/79] media: i2c: ov9734: use pm_runtime_resume_and_get()
Date:   Wed, 28 Apr 2021 16:52:15 +0200
Message-Id: <d65469ac5bc1f6031e3fcbc9c2d76a8723dd39f9.1619621413.git.mchehab+huawei@kernel.org>
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
 drivers/media/i2c/ov9734.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov9734.c b/drivers/media/i2c/ov9734.c
index b7309a551cae..ba156683c533 100644
--- a/drivers/media/i2c/ov9734.c
+++ b/drivers/media/i2c/ov9734.c
@@ -644,9 +644,8 @@ static int ov9734_set_stream(struct v4l2_subdev *sd, int enable)
 	}
 
 	if (enable) {
-		ret = pm_runtime_get_sync(&client->dev);
+		ret = pm_runtime_resume_and_get(&client->dev);
 		if (ret < 0) {
-			pm_runtime_put_noidle(&client->dev);
 			mutex_unlock(&ov9734->mutex);
 			return ret;
 		}
-- 
2.30.2

