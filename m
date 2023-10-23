Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC15C004C0
	for <linux-media@archiver.kernel.org>; Mon, 23 Oct 2023 16:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjJWQFs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 23 Oct 2023 12:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjJWQFr (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 23 Oct 2023 12:05:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F78510A;
        Mon, 23 Oct 2023 09:05:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D854C433C8;
        Mon, 23 Oct 2023 16:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698077145;
        bh=rC/hNZ7Bswy153IHNZJNcZBlr9hop+G6Sg6aUKxjdIg=;
        h=From:To:Cc:Subject:Date:From;
        b=YOvXabiOgl0nH2oPF9hfgJhkEJP+UUFp0h9KGCfx88oPj6u6WfzTBffoVLAWwFkUQ
         /r6lXvTN2pi/mjokglO3uUrDRNCuIxaAkmOL1L4egSVv0boGU9kmN/e0BVksgEngpK
         rj3xv41RK+MXX1QUkSdbNjV3b1Wq88e+qakIoWJFdGNEk5behSD1BBk6txm7dcEIqm
         xa45GHtj1Umi4uRUAfmXpyQV/udasf+RYsglGut5t9DB7D+FRfFCE9FpkjG6Mk+lTi
         RnF3PYmo5ccnkN7Ua77vb+Rx16ZTpNsFNgyCASyd3HjN4BAAhiVPVC2uJEV6QjfNpJ
         KbCskka5IO7Yg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Martin Tuma <martin.tuma@digiteqautomotive.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] media: pci: mgb4: add COMMON_CLK dependency
Date:   Mon, 23 Oct 2023 18:05:31 +0200
Message-Id: <20231023160539.1537355-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This driver fails to build when HAVE_CLK and COMMON_CLK are disabled:

x86_64-linux-ld: vmlinux.o: in function `mgb4_remove':
mgb4_core.c:(.text+0x1915e8c): undefined reference to `clkdev_drop'
x86_64-linux-ld: mgb4_core.c:(.text+0x1915e98): undefined reference to `clk_hw_unregister'

Add a Kconfig dependency to enforce a clean build.

Fixes: 0ab13674a9bd ("media: pci: mgb4: Added Digiteq Automotive MGB4 driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/pci/mgb4/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/pci/mgb4/Kconfig b/drivers/media/pci/mgb4/Kconfig
index 13fad15a434c..f2a05a1c8ffa 100644
--- a/drivers/media/pci/mgb4/Kconfig
+++ b/drivers/media/pci/mgb4/Kconfig
@@ -2,6 +2,7 @@
 config VIDEO_MGB4
 	tristate "Digiteq Automotive MGB4 support"
 	depends on VIDEO_DEV && PCI && I2C && DMADEVICES && SPI && MTD && IIO
+	depends on COMMON_CLK
 	select VIDEOBUF2_DMA_SG
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
-- 
2.39.2

