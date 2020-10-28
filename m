Return-Path: <SRS0=8lr5=ED=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAE4C55179
	for <linux-media@archiver.kernel.org>; Wed, 28 Oct 2020 22:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B68CE20725
	for <linux-media@archiver.kernel.org>; Wed, 28 Oct 2020 22:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DDXfpE9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387852AbgJ1WbQ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:31:16 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51808 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387861AbgJ1WbP (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 28 Oct 2020 18:31:15 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09SIgwps111356;
        Wed, 28 Oct 2020 13:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603910578;
        bh=eUUQz9Q2QCafre6eevRBt7I6qddetRHPjoxk8mGd2wY=;
        h=From:To:CC:Subject:Date;
        b=DDXfpE9kd+hfsLt1+CIQFVs1tYkTPZEwwR/whhbsKkEKypWME8K4whVbOWNldKQOp
         dKimbOY1wn3ieB8fJwMoWJmscTM7ob2NcXu0ZHmnCw/XPBKiecxHgANjRp+aUz7iZ5
         yNZF6HiAA+EUCbsIg1l2aMiUWa2EBlyF0jOnt0I4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09SIgwG9106242
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 13:42:58 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 28
 Oct 2020 13:42:58 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 28 Oct 2020 13:42:58 -0500
Received: from NiksLab.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09SIgsuN094611;
        Wed, 28 Oct 2020 13:42:55 -0500
From:   Nikhil Devshatwar <nikhil.nd@ti.com>
List-Id: <linux-firmware.lore.kernel.org>
To:     <linux-firmware@kernel.org>, <linux-media@vger.kernel.org>
CC:     Dan Murphy <dmurphy@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Benoit Parrot <bparrot@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>
Subject: [PATCH v2] vpdma: Move firmware to ti directory
Date:   Thu, 29 Oct 2020 00:12:49 +0530
Message-ID: <20201028184249.11293-1-nikhil.nd@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Current ti-connectivity location for the firmware is not the
correct place. It has all the wireless connectivity related firmwares.
Move the vpdma firmware to the ti specific directory.

Fixes: 5b30b383ce ("linux-firmware: Add new VPDMA firmware 1b8.bin")
Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>
---
 WHENCE                                |   2 +-
 {ti-connectivity => ti}/vpdma-1b8.bin | Bin
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename {ti-connectivity => ti}/vpdma-1b8.bin (100%)

diff --git a/WHENCE b/WHENCE
index 473f6fb..d4efee2 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2705,7 +2705,7 @@ Licence: Redistributable. See LICENCE.tda7706-firmware.txt for details.
 
 Driver: ti-vpe - Texas Instruments V4L2 driver for Video Processing Engine
 
-File: ti-connectivity/vpdma-1b8.bin
+File: ti/vpdma-1b8.bin
 
 Licence: Redistributable. See LICENCE.ti-tspa for details.
 
diff --git a/ti-connectivity/vpdma-1b8.bin b/ti/vpdma-1b8.bin
similarity index 100%
rename from ti-connectivity/vpdma-1b8.bin
rename to ti/vpdma-1b8.bin
-- 
2.17.1

