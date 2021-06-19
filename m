Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B09C2B9F4
	for <linux-media@archiver.kernel.org>; Sat, 19 Jun 2021 17:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E3EC610CA
	for <linux-media@archiver.kernel.org>; Sat, 19 Jun 2021 17:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbhFSR0u (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 19 Jun 2021 13:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbhFSR0s (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 19 Jun 2021 13:26:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10B7C061574
        for <linux-media@vger.kernel.org>; Sat, 19 Jun 2021 10:24:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 7A9F91F43C23
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     Ezequiel Garcia <ezequiel@collabora.com>, kernel@collabora.com
Subject: [PATCH] media: gspca: Drop default m
Date:   Sat, 19 Jun 2021 14:24:23 -0300
Message-Id: <20210619172423.35388-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Drop the "default m", as options should default to disabled.
No other media driver is enabled by default.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/media/usb/gspca/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/usb/gspca/Kconfig b/drivers/media/usb/gspca/Kconfig
index 0283e3b908e4..dca4e16ed133 100644
--- a/drivers/media/usb/gspca/Kconfig
+++ b/drivers/media/usb/gspca/Kconfig
@@ -4,7 +4,6 @@ menuconfig USB_GSPCA
 	depends on VIDEO_V4L2
 	depends on INPUT || INPUT=n
 	select VIDEOBUF2_VMALLOC
-	default m
 	help
 	  Say Y here if you want to enable selecting webcams based
 	  on the GSPCA framework.
-- 
2.30.0

