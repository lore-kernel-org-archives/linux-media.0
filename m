Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FBDC433FE
	for <linux-media@archiver.kernel.org>; Thu,  3 Mar 2022 12:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiCCMou (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 3 Mar 2022 07:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiCCMos (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 3 Mar 2022 07:44:48 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11708180209
        for <linux-media@vger.kernel.org>; Thu,  3 Mar 2022 04:44:01 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:6495:14e6:1343:3ecb])
        by laurent.telenet-ops.be with bizsmtp
        id 1ok0270065ER6nL01ok086; Thu, 03 Mar 2022 13:44:00 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nPkoJ-002Xqz-M1; Thu, 03 Mar 2022 13:43:59 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nPkoJ-008D41-5Y; Thu, 03 Mar 2022 13:43:59 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] media: rcar-csi2: Drop comma after SoC match table sentinel
Date:   Thu,  3 Mar 2022 13:43:57 +0100
Message-Id: <0c6a183ade26c68b96d91ce14e675ca01fc563fb.1646311410.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

It does not make sense to have a comma after a sentinel, as any new
elements must be added before the sentinel.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/media/platform/rcar-vin/rcar-csi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/rcar-vin/rcar-csi2.c
index 8c939cb3073d79ec..54428f0a5758ae10 100644
--- a/drivers/media/platform/rcar-vin/rcar-csi2.c
+++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
@@ -1414,7 +1414,7 @@ static const struct soc_device_attribute r8a7795[] = {
 		.soc_id = "r8a7795", .revision = "ES2.*",
 		.data = &rcar_csi2_info_r8a7795es2,
 	},
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 static int rcsi2_probe(struct platform_device *pdev)
-- 
2.25.1

