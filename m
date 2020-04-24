Return-Path: <SRS0=poVo=6I=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886EBC54FCB
	for <linux-media@archiver.kernel.org>; Fri, 24 Apr 2020 10:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7111520776
	for <linux-media@archiver.kernel.org>; Fri, 24 Apr 2020 10:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgDXKkB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 24 Apr 2020 06:40:01 -0400
Received: from sauhun.de ([88.99.104.3]:46272 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbgDXKkB (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 24 Apr 2020 06:40:01 -0400
Received: from localhost (p5486CE62.dip0.t-ipconnect.de [84.134.206.98])
        by pokefinder.org (Postfix) with ESMTPSA id 71E812C1FE8;
        Fri, 24 Apr 2020 12:39:59 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Koji Matsuoka <koji.matsuoka.xm@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] media: rcar-csi2: Fix comment of VCDT/VCDT2 register
Date:   Fri, 24 Apr 2020 12:39:45 +0200
Message-Id: <20200424103945.2836-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

According to latest H/W manual v1.50, the description of channel
number in the VCDT/VCDT2 register is decremented by one.
Therefore, this patch fixes it about comment.

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/media/platform/rcar-vin/rcar-csi2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/rcar-vin/rcar-csi2.c
index faa9fb23a2e9..151e6a90c5fb 100644
--- a/drivers/media/platform/rcar-vin/rcar-csi2.c
+++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
@@ -52,8 +52,8 @@ struct rcar_csi2;
 
 /*
  * Channel Data Type Select
- * VCDT[0-15]:  Channel 1 VCDT[16-31]:  Channel 2
- * VCDT2[0-15]: Channel 3 VCDT2[16-31]: Channel 4
+ * VCDT[0-15]:  Channel 0 VCDT[16-31]:  Channel 1
+ * VCDT2[0-15]: Channel 2 VCDT2[16-31]: Channel 3
  */
 #define VCDT_REG			0x10
 #define VCDT2_REG			0x14
-- 
2.20.1

