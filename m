Return-Path: <SRS0=P+oI=CJ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D31C433E6
	for <linux-media@archiver.kernel.org>; Mon, 31 Aug 2020 02:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F1402078D
	for <linux-media@archiver.kernel.org>; Mon, 31 Aug 2020 02:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgHaCTk (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 30 Aug 2020 22:19:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:36895 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgHaCTj (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sun, 30 Aug 2020 22:19:39 -0400
IronPort-SDR: Om5jwEvkcOjm2TnkcI88clfvxX/YfRu0mnhUMPPnlfNh2g+ZXNEB9VBhIAvLaoPVvXo4ZQt5xL
 uM1lJt9FWkFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="144579703"
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; 
   d="scan'208";a="144579703"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2020 19:10:33 -0700
IronPort-SDR: GO1qvY8VC7I+/+L9qt3FXeBMyOwPpu2ZQsonA6rBJRZKCLLJePgqbbPe6DP+wLOD7DBkUZ7EJ1
 lU3UMQQv6O8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; 
   d="scan'208";a="296774465"
Received: from ipu5-build.bj.intel.com ([10.238.232.196])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2020 19:10:31 -0700
From:   Bingbu Cao <bingbu.cao@intel.com>
To:     linux-media@vger.kernel.org, sakari.ailus@linux.intel.com
Cc:     tfiga@chromium.org, bingbu.cao@intel.com,
        bingbu.cao@linux.intel.com
Subject: [PATCH] media: ov5675: fix typos in comments
Date:   Mon, 31 Aug 2020 10:09:44 +0800
Message-Id: <1598839784-12783-1-git-send-email-bingbu.cao@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This commit fix the typos in the comments that was involved by previous
commit d960c75daf2a.

Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
---
 drivers/media/i2c/ov5675.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
index 9540ce8918f0..4343b2637078 100644
--- a/drivers/media/i2c/ov5675.c
+++ b/drivers/media/i2c/ov5675.c
@@ -689,9 +689,9 @@ static int ov5675_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 
 	case V4L2_CID_EXPOSURE:
-		/* 4 least significant bits of expsoure are fractional part
+		/* 4 least significant bits of exposure are fractional part
 		 * val = val << 4
-		 * for ov5675, the unit of exposure is differnt from other
+		 * for ov5675, the unit of exposure is different from other
 		 * OmniVision sensors, its exposure value is twice of the
 		 * register value, the exposure should be divided by 2 before
 		 * set register, e.g. val << 3.
-- 
2.7.4

