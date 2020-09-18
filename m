Return-Path: <SRS0=ldJM=C3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E76C43463
	for <linux-media@archiver.kernel.org>; Fri, 18 Sep 2020 02:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2ED323730
	for <linux-media@archiver.kernel.org>; Fri, 18 Sep 2020 02:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600396701;
	bh=xLEf58mjGmbH0CWWabSTZzpE4t32riFaLBMWYf6Q/rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D0mrxgILxPrR2HHdU3A+BScgqpOikYC9my0X8ZqY9GFVM/HLaMqjJh5E2pdwP+xnX
	 6O2aBj3mwiSOBeWme7kobJnS+quprw7fq5YGLJ0fOAfnKFDUP3agKF/x6mYGgGrL3P
	 UxpE0M8VoXBacdPeJx/auzb6/PNK+8WWtwfLf+QI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgIRCiP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:38:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728776AbgIRCM1 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 17 Sep 2020 22:12:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B19C323447;
        Fri, 18 Sep 2020 02:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600395147;
        bh=xLEf58mjGmbH0CWWabSTZzpE4t32riFaLBMWYf6Q/rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DOdF+riE7qKUapmyITFFm8EZSLGekRWDUKL1l9UAa1wzjJO/wqZOf4v4Q42JzTi3a
         DC/DwClQzZVLbSVSaAlqeTLu/4U/k4sVohSx9lIP3lfQ+dmG7wpGNw6bgVyxffyWfZ
         GD6WhSE8kM6QTUPbOWhPNBStbC5GK6Zpxv7ZY2SE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 006/127] media: smiapp: Fix error handling at NVM reading
Date:   Thu, 17 Sep 2020 22:10:19 -0400
Message-Id: <20200918021220.2066485-6-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918021220.2066485-1-sashal@kernel.org>
References: <20200918021220.2066485-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit a5b1d5413534607b05fb34470ff62bf395f5c8d0 ]

If NVM reading failed, the device was left powered on. Fix that.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/smiapp/smiapp-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/smiapp/smiapp-core.c b/drivers/media/i2c/smiapp/smiapp-core.c
index e4d7f2febf00c..05b3974bd9202 100644
--- a/drivers/media/i2c/smiapp/smiapp-core.c
+++ b/drivers/media/i2c/smiapp/smiapp-core.c
@@ -2338,11 +2338,12 @@ smiapp_sysfs_nvm_read(struct device *dev, struct device_attribute *attr,
 		if (rval < 0) {
 			if (rval != -EBUSY && rval != -EAGAIN)
 				pm_runtime_set_active(&client->dev);
-			pm_runtime_put(&client->dev);
+			pm_runtime_put_noidle(&client->dev);
 			return -ENODEV;
 		}
 
 		if (smiapp_read_nvm(sensor, sensor->nvm)) {
+			pm_runtime_put(&client->dev);
 			dev_err(&client->dev, "nvm read failed\n");
 			return -ENODEV;
 		}
-- 
2.25.1

