Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA087C43461
	for <linux-media@archiver.kernel.org>; Thu,  6 May 2021 15:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D175D6121F
	for <linux-media@archiver.kernel.org>; Thu,  6 May 2021 15:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbhEFPZP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 6 May 2021 11:25:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235226AbhEFPYj (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 6 May 2021 11:24:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF8BD61414;
        Thu,  6 May 2021 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620314611;
        bh=79OkehonmjtZng1/b9LdwRP7XaO8omnxvo99Fl7zk0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e9Sjz/0Ldr9Vqmcgo7hHeTt48TKpX2hJHRAGXrChAnj4HQK04a+O8wMEDAyPnzBj5
         83t+NUzy+Msm5WQWVoSMqlhLN1yWxf2yZsITvPExdDZcxEMe1Aax0WhoYevh846Awh
         W/rGEsqo+aW+xbOadaWiekD0TTmp9h1xYYa1a0/CIU8muCMvTEqXc353Priz8fLB18
         BgB1hSTVefTGinDBtzFb2JB5cazZOZTfcfjM59b8uQ8rbybwbq9zNEGpi+mG/MWyVL
         QZkdRXQ+UBo8i218IXTtPRYkbVeoLRd0YWYxw+xQGeYPDOREwMsAOymalXfQt+hD7g
         fDIlnXCI2jQAA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lefqb-000RwU-3b; Thu, 06 May 2021 17:23:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 30/30] media: i2c: ccs-core: use pm_runtime_resume_and_get()
Date:   Thu,  6 May 2021 17:23:26 +0200
Message-Id: <588552504c2e4b0347b237454588e7040eff857a.1620314098.git.mchehab+huawei@kernel.org>
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/i2c/ccs/ccs-core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index 4a848ac2d2cd..a349189a38db 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -3101,12 +3101,9 @@ static int __maybe_unused ccs_suspend(struct device *dev)
 	bool streaming = sensor->streaming;
 	int rval;
 
-	rval = pm_runtime_get_sync(dev);
-	if (rval < 0) {
-		pm_runtime_put_noidle(dev);
-
+	rval = pm_runtime_resume_and_get(dev);
+	if (rval < 0)
 		return rval;
-	}
 
 	if (sensor->streaming)
 		ccs_stop_streaming(sensor);
-- 
2.30.2

