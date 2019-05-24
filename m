Return-Path: <SRS0=UxAd=TY=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD785C282E1
	for <linux-media@archiver.kernel.org>; Fri, 24 May 2019 23:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84F620675
	for <linux-media@archiver.kernel.org>; Fri, 24 May 2019 23:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfEXXRh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 24 May 2019 19:17:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:23063 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfEXXRf (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 24 May 2019 19:17:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 16:17:35 -0700
X-ExtLoop1: 1
Received: from maru.jf.intel.com ([10.54.51.75])
  by orsmga007.jf.intel.com with ESMTP; 24 May 2019 16:17:35 -0700
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To:     Eddie James <eajames@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-aspeed@lists.ozlabs.org, linux-media@vger.kernel.org,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH v2 10/11] media: aspeed: fix an incorrect timeout checking in mode detection
Date:   Fri, 24 May 2019 16:17:24 -0700
Message-Id: <20190524231725.12320-11-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524231725.12320-1-jae.hyun.yoo@linux.intel.com>
References: <20190524231725.12320-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

There is an incorrect timeout checking in mode detection logic so
it misses resolution detecting chances. This commit fixes the bug.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
v1 -> v2:
 New.

 drivers/media/platform/aspeed-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 67f476bf0a03..b05b073b63bc 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -735,7 +735,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 	do {
 		if (tries) {
 			set_current_state(TASK_INTERRUPTIBLE);
-			if (schedule_timeout(INVALID_RESOLUTION_DELAY))
+			if (!schedule_timeout(INVALID_RESOLUTION_DELAY))
 				return;
 		}
 
-- 
2.21.0

