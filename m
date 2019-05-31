Return-Path: <SRS0=lOn+=T7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0387C46460
	for <linux-media@archiver.kernel.org>; Fri, 31 May 2019 22:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A803226FAB
	for <linux-media@archiver.kernel.org>; Fri, 31 May 2019 22:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfEaWQF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 31 May 2019 18:16:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:36052 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbfEaWQE (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 31 May 2019 18:16:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 May 2019 15:16:04 -0700
X-ExtLoop1: 1
Received: from maru.jf.intel.com ([10.54.51.75])
  by orsmga001.jf.intel.com with ESMTP; 31 May 2019 15:16:04 -0700
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To:     Eddie James <eajames@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-aspeed@lists.ozlabs.org, linux-media@vger.kernel.org,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH v3 09/10] media: aspeed: use different delays for triggering VE H/W reset
Date:   Fri, 31 May 2019 15:15:47 -0700
Message-Id: <20190531221548.14757-10-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190531221548.14757-1-jae.hyun.yoo@linux.intel.com>
References: <20190531221548.14757-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

In case of watchdog timeout detected while doing mode detection,
it's better triggering video engine hardware reset immediately so
this commit fixes code for the case. Other than the case, it will
trigger video engine hardware reset after RESOLUTION_CHANGE_DELAY.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Eddie James <eajames@linux.ibm.com>
---
v2 -> v3:
 None.

v1 -> v2:
 New.

 drivers/media/platform/aspeed-video.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index d6708ddb0391..ba093096a5a7 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -522,7 +522,7 @@ static void aspeed_video_bufs_done(struct aspeed_video *video,
 	spin_unlock_irqrestore(&video->lock, flags);
 }
 
-static void aspeed_video_irq_res_change(struct aspeed_video *video)
+static void aspeed_video_irq_res_change(struct aspeed_video *video, ulong delay)
 {
 	dev_dbg(video->dev, "Resolution changed; resetting\n");
 
@@ -532,7 +532,7 @@ static void aspeed_video_irq_res_change(struct aspeed_video *video)
 	aspeed_video_off(video);
 	aspeed_video_bufs_done(video, VB2_BUF_STATE_ERROR);
 
-	schedule_delayed_work(&video->res_work, RESOLUTION_CHANGE_DELAY);
+	schedule_delayed_work(&video->res_work, delay);
 }
 
 static irqreturn_t aspeed_video_irq(int irq, void *arg)
@@ -545,7 +545,7 @@ static irqreturn_t aspeed_video_irq(int irq, void *arg)
 	 * re-initialize
 	 */
 	if (sts & VE_INTERRUPT_MODE_DETECT_WD) {
-		aspeed_video_irq_res_change(video);
+		aspeed_video_irq_res_change(video, 0);
 		return IRQ_HANDLED;
 	}
 
@@ -563,7 +563,8 @@ static irqreturn_t aspeed_video_irq(int irq, void *arg)
 			 * Signal acquired while NOT doing resolution
 			 * detection; reset the engine and re-initialize
 			 */
-			aspeed_video_irq_res_change(video);
+			aspeed_video_irq_res_change(video,
+						    RESOLUTION_CHANGE_DELAY);
 			return IRQ_HANDLED;
 		}
 	}
-- 
2.21.0

