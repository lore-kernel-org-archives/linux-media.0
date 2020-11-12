Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321A9C56202
	for <linux-media@archiver.kernel.org>; Thu, 12 Nov 2020 16:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E26B222240
	for <linux-media@archiver.kernel.org>; Thu, 12 Nov 2020 16:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbgKLQI7 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 12 Nov 2020 11:08:59 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:55337 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbgKLQI7 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 12 Nov 2020 11:08:59 -0500
X-Originating-IP: 93.34.118.233
Received: from uno.lan (93-34-118-233.ip49.fastwebnet.it [93.34.118.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 5C678E000E;
        Thu, 12 Nov 2020 16:08:56 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     koji.matsuoka.xm@renesas.com,
        niklas.soderlund+renesas@ragnatech.se,
        laurent.pinchart@ideasonboard.com
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/2] media: rcar-vin: Remove unused macro
Date:   Thu, 12 Nov 2020 17:08:50 +0100
Message-Id: <20201112160851.99750-2-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201112160851.99750-1-jacopo+renesas@jmondi.org>
References: <20201112160851.99750-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The VNCSI_IFMD_CSI_CHSEL_MASK is not used: remove it.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/media/platform/rcar-vin/rcar-dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/rcar-vin/rcar-dma.c b/drivers/media/platform/rcar-vin/rcar-dma.c
index f6e84fa29bce..378514a75bc2 100644
--- a/drivers/media/platform/rcar-vin/rcar-dma.c
+++ b/drivers/media/platform/rcar-vin/rcar-dma.c
@@ -137,7 +137,6 @@
 #define VNCSI_IFMD_DES1		(1 << 26)
 #define VNCSI_IFMD_DES0		(1 << 25)
 #define VNCSI_IFMD_CSI_CHSEL(n) (((n) & 0xf) << 0)
-#define VNCSI_IFMD_CSI_CHSEL_MASK 0xf
 
 /* Video n scaling control register (Gen3) */
 #define VNUDS_CTRL_AMD		(1 << 30)
-- 
2.29.1

