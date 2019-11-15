Return-Path: <SRS0=gaxT=ZH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9325C432C3
	for <linux-media@archiver.kernel.org>; Fri, 15 Nov 2019 14:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87322072D
	for <linux-media@archiver.kernel.org>; Fri, 15 Nov 2019 14:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfKOOat (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:30:49 -0500
Received: from mga03.intel.com ([134.134.136.65]:17996 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbfKOOat (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 15 Nov 2019 09:30:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 06:30:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="208142114"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 15 Nov 2019 06:30:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3C02212A; Fri, 15 Nov 2019 16:30:44 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] media: venus: firmware: Use %pR to print IO resource
Date:   Fri, 15 Nov 2019 16:30:44 +0200
Message-Id: <20191115143044.55512-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Replace explicit use of members of struct resource by %pR to print
the resource.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/platform/qcom/venus/firmware.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index d3d1748a7ef6..de6812fb55f4 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -100,8 +100,7 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
 
 	mem_va = memremap(r.start, *mem_size, MEMREMAP_WC);
 	if (!mem_va) {
-		dev_err(dev, "unable to map memory region: %pa+%zx\n",
-			&r.start, *mem_size);
+		dev_err(dev, "unable to map memory region: %pR\n", &r);
 		ret = -ENOMEM;
 		goto err_release_fw;
 	}
-- 
2.24.0

