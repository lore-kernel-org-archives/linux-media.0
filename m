Return-Path: <SRS0=Cf27=CL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7F6C433E2
	for <linux-media@archiver.kernel.org>; Wed,  2 Sep 2020 06:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1113D2078B
	for <linux-media@archiver.kernel.org>; Wed,  2 Sep 2020 06:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgIBG3n (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:29:43 -0400
Received: from retiisi.org.uk ([95.216.213.190]:57240 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgIBG3n (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 2 Sep 2020 02:29:43 -0400
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id BD8F9634C8C
        for <linux-media@vger.kernel.org>; Wed,  2 Sep 2020 09:29:19 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 1/1] media: i2c: Remove Alan Chiang's e-mail address
Date:   Wed,  2 Sep 2020 09:24:49 +0300
Message-Id: <20200902062449.23597-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Alan Chiang's e-mail address no longer works. Remove it.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/dw9807-vcm.c | 2 +-
 drivers/media/i2c/imx258.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/dw9807-vcm.c b/drivers/media/i2c/dw9807-vcm.c
index b38a4e6d270d..438a44b76da8 100644
--- a/drivers/media/i2c/dw9807-vcm.c
+++ b/drivers/media/i2c/dw9807-vcm.c
@@ -324,6 +324,6 @@ static struct i2c_driver dw9807_i2c_driver = {
 
 module_i2c_driver(dw9807_i2c_driver);
 
-MODULE_AUTHOR("Chiang, Alan <alanx.chiang@intel.com>");
+MODULE_AUTHOR("Chiang, Alan");
 MODULE_DESCRIPTION("DW9807 VCM driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index f86ae18bc104..ccb55fd1d506 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -1304,7 +1304,7 @@ static struct i2c_driver imx258_i2c_driver = {
 module_i2c_driver(imx258_i2c_driver);
 
 MODULE_AUTHOR("Yeh, Andy <andy.yeh@intel.com>");
-MODULE_AUTHOR("Chiang, Alan <alanx.chiang@intel.com>");
+MODULE_AUTHOR("Chiang, Alan");
 MODULE_AUTHOR("Chen, Jason <jasonx.z.chen@intel.com>");
 MODULE_DESCRIPTION("Sony IMX258 sensor driver");
 MODULE_LICENSE("GPL v2");
-- 
2.27.0

