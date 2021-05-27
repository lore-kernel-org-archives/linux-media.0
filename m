Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F03C4708A
	for <linux-media@archiver.kernel.org>; Thu, 27 May 2021 09:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9EC4613DC
	for <linux-media@archiver.kernel.org>; Thu, 27 May 2021 09:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbhE0JOf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 27 May 2021 05:14:35 -0400
Received: from comms.puri.sm ([159.203.221.185]:57900 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230111AbhE0JOf (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 27 May 2021 05:14:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 2BA33E2062;
        Thu, 27 May 2021 02:13:02 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 39qsxjIw9ivT; Thu, 27 May 2021 02:12:57 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     mchehab@kernel.org, robh@kernel.org,
        krzysztof.kozlowski@canonical.com,
        laurent.pinchart@ideasonboard.com
Cc:     kernel@puri.sm, paul.kocialkowski@bootlin.com, shawnx.tu@intel.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 4/4] Documentation: i2c-cardlist: add the Hynix hi846 sensor
Date:   Thu, 27 May 2021 11:12:21 +0200
Message-Id: <20210527091221.3335998-5-martin.kepplinger@puri.sm>
In-Reply-To: <20210527091221.3335998-1-martin.kepplinger@puri.sm>
References: <20210527091221.3335998-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add the SK Hynix Hi-846 8M Pixel CMOS image sensor to the i2c-cardlist.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 Documentation/admin-guide/media/i2c-cardlist.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/media/i2c-cardlist.rst b/Documentation/admin-guide/media/i2c-cardlist.rst
index e60d459d18a9..185e07a3da43 100644
--- a/Documentation/admin-guide/media/i2c-cardlist.rst
+++ b/Documentation/admin-guide/media/i2c-cardlist.rst
@@ -60,6 +60,7 @@ Driver        Name
 ============  ==========================================================
 et8ek8        ET8EK8 camera sensor
 hi556         Hynix Hi-556 sensor
+hi846         Hynix Hi-846 sensor
 imx214        Sony IMX214 sensor
 imx219        Sony IMX219 sensor
 imx258        Sony IMX258 sensor
-- 
2.30.2

