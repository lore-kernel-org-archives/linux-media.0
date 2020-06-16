Return-Path: <SRS0=krkx=75=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4B3C433E0
	for <linux-media@archiver.kernel.org>; Tue, 16 Jun 2020 12:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81CE920B1F
	for <linux-media@archiver.kernel.org>; Tue, 16 Jun 2020 12:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgFPMsV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:48:21 -0400
Received: from gofer.mess.org ([88.97.38.141]:34769 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbgFPMsU (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 16 Jun 2020 08:48:20 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id C55C611A003; Tue, 16 Jun 2020 13:48:18 +0100 (BST)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Subject: [PATCH 1/4] media: drx-k: remove unused MulDiv32 function
Date:   Tue, 16 Jun 2020 13:48:15 +0100
Message-Id: <cd11aa2f3e7ea321e7e2f57eae83e1d485ec69cc.1592302248.git.sean@mess.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1592302248.git.sean@mess.org>
References: <cover.1592302248.git.sean@mess.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This function has never been used. Found with clang:

drivers/media/dvb-frontends/drxk_hard.c:159:19: warning: unused function 'MulDiv32' [-Wunused-function]
static inline u32 MulDiv32(u32 a, u32 b, u32 c)

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/dvb-frontends/drxk_hard.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/media/dvb-frontends/drxk_hard.c b/drivers/media/dvb-frontends/drxk_hard.c
index 7e8e5c308d1c6..0ae9d8c72d8dc 100644
--- a/drivers/media/dvb-frontends/drxk_hard.c
+++ b/drivers/media/dvb-frontends/drxk_hard.c
@@ -155,17 +155,6 @@ if (debug >= level)							\
 	printk(KERN_DEBUG KBUILD_MODNAME ": %s " fmt, __func__, ##arg);	\
 } while (0)
 
-
-static inline u32 MulDiv32(u32 a, u32 b, u32 c)
-{
-	u64 tmp64;
-
-	tmp64 = (u64) a * (u64) b;
-	do_div(tmp64, c);
-
-	return (u32) tmp64;
-}
-
 static inline u32 Frac28a(u32 a, u32 c)
 {
 	int i = 0;
-- 
2.26.2

