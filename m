Return-Path: <SRS0=1/ZG=WT=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65EFC3A5A2
	for <linux-media@archiver.kernel.org>; Fri, 23 Aug 2019 21:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4A021897
	for <linux-media@archiver.kernel.org>; Fri, 23 Aug 2019 21:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406198AbfHWVaA (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 23 Aug 2019 17:30:00 -0400
Received: from mga12.intel.com ([192.55.52.136]:41719 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406196AbfHWVaA (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 23 Aug 2019 17:30:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 14:29:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,422,1559545200"; 
   d="scan'208";a="330841452"
Received: from maru.jf.intel.com ([10.54.51.77])
  by orsmga004.jf.intel.com with ESMTP; 23 Aug 2019 14:29:59 -0700
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To:     Eddie James <eajames@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-aspeed@lists.ozlabs.org, linux-media@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH] media: aspeed: fix an incorrect return code on buffer allocation failure
Date:   Fri, 23 Aug 2019 14:29:57 -0700
Message-Id: <20190823212957.26043-1-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

It returns '0' even when a failure happens on jpeg buffer allocation
so this commit fixes the issue.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 drivers/media/platform/aspeed-video.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index f899ac3b4a61..94f97d96dabc 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -1624,6 +1624,7 @@ static int aspeed_video_init(struct aspeed_video *video)
 	if (!aspeed_video_alloc_buf(video, &video->jpeg,
 				    VE_JPEG_HEADER_SIZE)) {
 		dev_err(dev, "Failed to allocate DMA for JPEG header\n");
+		rc = -ENOMEM;
 		goto err_release_reserved_mem;
 	}
 
-- 
2.7.4

