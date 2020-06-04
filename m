Return-Path: <SRS0=S7kU=7R=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E512C433E0
	for <linux-media@archiver.kernel.org>; Thu,  4 Jun 2020 09:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55704206C3
	for <linux-media@archiver.kernel.org>; Thu,  4 Jun 2020 09:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgFDJo6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 4 Jun 2020 05:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgFDJo6 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 4 Jun 2020 05:44:58 -0400
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 Jun 2020 02:44:58 PDT
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5B8C03E96D
        for <linux-media@vger.kernel.org>; Thu,  4 Jun 2020 02:44:58 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:c96f:783c:a430:4a5a])
        by baptiste.telenet-ops.be with bizsmtp
        id mxfu2200V0MBGRv01xfuKF; Thu, 04 Jun 2020 11:39:54 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jgmLq-0001Rt-9S; Thu, 04 Jun 2020 11:39:54 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jgmLq-0000Vn-6s; Thu, 04 Jun 2020 11:39:54 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] medium: cec: Make MEDIA_CEC_SUPPORT default to n if !MEDIA_SUPPORT
Date:   Thu,  4 Jun 2020 11:39:53 +0200
Message-Id: <20200604093953.1353-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Recently, MEDIA_CEC_SUPPORT became indepedent of MEDIA_SUPPORT.
However, if MEDIA_SUPPORT is not enabled, MEDIA_SUPPORT_FILTER is not
defined, and MEDIA_CEC_SUPPORT is thus enabled by default, which is not
desirable.

Fix this by adding a dependency on MEDIA_CEC_SUPPORT to the default
configuration.

Fixes: 46d2a3b964ddbe63 ("media: place CEC menu before MEDIA_SUPPORT")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/media/cec/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/cec/Kconfig b/drivers/media/cec/Kconfig
index eea74b7cfa8c5dec..7e830444bdbbb1d1 100644
--- a/drivers/media/cec/Kconfig
+++ b/drivers/media/cec/Kconfig
@@ -24,7 +24,7 @@ config CEC_PIN_ERROR_INJ
 menuconfig MEDIA_CEC_SUPPORT
 	bool
 	prompt "HDMI CEC drivers"
-	default y if !MEDIA_SUPPORT_FILTER
+	default y if MEDIA_SUPPORT && !MEDIA_SUPPORT_FILTER
 	help
 	  Enable support for HDMI CEC (Consumer Electronics Control),
 	  which is an optional HDMI feature.
-- 
2.17.1

