Return-Path: <SRS0=a2Vr=CY=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290FFC2D0E3
	for <linux-media@archiver.kernel.org>; Tue, 15 Sep 2020 23:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00581208E4
	for <linux-media@archiver.kernel.org>; Tue, 15 Sep 2020 23:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbgIOXCX (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 15 Sep 2020 19:02:23 -0400
Received: from bin-mail-out-06.binero.net ([195.74.38.229]:8379 "EHLO
        bin-mail-out-06.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727570AbgIOXCR (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 15 Sep 2020 19:02:17 -0400
X-Halon-ID: 795617bd-f7a7-11ea-92dc-005056917a89
Authorized-sender: niklas.soderlund@fsdn.se
Received: from bismarck.berto.se (p54ac52a8.dip0.t-ipconnect.de [84.172.82.168])
        by bin-vsp-out-01.atm.binero.net (Halon) with ESMTPA
        id 795617bd-f7a7-11ea-92dc-005056917a89;
        Wed, 16 Sep 2020 01:02:05 +0200 (CEST)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 1/2] rcar-csi2: Extend RAW8 support to all RGB layouts
Date:   Wed, 16 Sep 2020 01:01:39 +0200
Message-Id: <20200915230140.1201187-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915230140.1201187-1-niklas.soderlund+renesas@ragnatech.se>
References: <20200915230140.1201187-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Extend the list of supported formats to include all RGB layouts of RAW8.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/media/platform/rcar-vin/rcar-csi2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/rcar-vin/rcar-csi2.c
index 511cd4984777ad99..c21501ce8980000f 100644
--- a/drivers/media/platform/rcar-vin/rcar-csi2.c
+++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
@@ -320,6 +320,9 @@ static const struct rcar_csi2_format rcar_csi2_formats[] = {
 	{ .code = MEDIA_BUS_FMT_YUYV8_1X16,	.datatype = 0x1e, .bpp = 16 },
 	{ .code = MEDIA_BUS_FMT_UYVY8_2X8,	.datatype = 0x1e, .bpp = 16 },
 	{ .code = MEDIA_BUS_FMT_YUYV10_2X10,	.datatype = 0x1e, .bpp = 20 },
+	{ .code = MEDIA_BUS_FMT_SBGGR8_1X8,     .datatype = 0x2a, .bpp = 8 },
+	{ .code = MEDIA_BUS_FMT_SGBRG8_1X8,     .datatype = 0x2a, .bpp = 8 },
+	{ .code = MEDIA_BUS_FMT_SGRBG8_1X8,     .datatype = 0x2a, .bpp = 8 },
 	{ .code = MEDIA_BUS_FMT_SRGGB8_1X8,     .datatype = 0x2a, .bpp = 8 },
 };
 
-- 
2.28.0

