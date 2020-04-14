Return-Path: <SRS0=F69p=56=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC412C3815B
	for <linux-media@archiver.kernel.org>; Tue, 14 Apr 2020 08:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A09D12076C
	for <linux-media@archiver.kernel.org>; Tue, 14 Apr 2020 08:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586854302;
	bh=LaWxVo4D9ISmgYdgIiPEVboYuh3KrbG9u3DKdXl3734=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tLhCFo4NwChMEf6dtXMqh0nZgp0f2x7E7A+K86T3Jaya1LmdtjyAenLRKEeLNBq8X
	 BwNgvwDoJ3Uj7CkDs9E/CdNJ3b+kDP15onIxbvAYc81QTQxWFiFGijzXSBXSlg37QW
	 CsIMX/OnRfYHDjKQDShZ+L20ux2jWmh9IHMwUH6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437137AbgDNIvj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437094AbgDNIvM (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 14 Apr 2020 04:51:12 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AD8721569;
        Tue, 14 Apr 2020 08:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586854269;
        bh=LaWxVo4D9ISmgYdgIiPEVboYuh3KrbG9u3DKdXl3734=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lJf91VPPSz5FKygt9JAj7iGIrFVzyLo/FvA+FXwL/LUYaF7qI4vszD/uRE/7doHRw
         tgAmuTKODormIEk8v00Ct83Lq7xps38clfZ8ZvceINphb4hDffBZC3f1ieSMMlEB4b
         T7N0qslEmHTltcEi+u19fxXHVrbMRf7iq0W6lb0w=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOHHf-002wzf-An; Tue, 14 Apr 2020 10:51:07 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Antoine Jacquet <royale@zerezo.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 12/19] media: docs: zr364xx: update documentation
Date:   Tue, 14 Apr 2020 10:50:58 +0200
Message-Id: <eebc6358e5ed3d78c6b1169aa40452e311bcf8c1.1586854191.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586854191.git.mchehab+huawei@kernel.org>
References: <cover.1586854191.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

There aren't much to be done here... almost everything is
still valid. The supported boards even reflect the current
driver's state. Yet, some things changed, so let's keep
this document updated.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/media/zr364xx.rst | 28 ++++++++-------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/Documentation/admin-guide/media/zr364xx.rst b/Documentation/admin-guide/media/zr364xx.rst
index ec8acb3e98fc..7291e54b8be3 100644
--- a/Documentation/admin-guide/media/zr364xx.rst
+++ b/Documentation/admin-guide/media/zr364xx.rst
@@ -7,24 +7,18 @@ site: http://royale.zerezo.com/zr364xx/
 
 mail: royale@zerezo.com
 
-.. note::
-
-   This documentation is outdated
 
 Introduction
 ------------
 
 
-This brings support under Linux for the Aiptek PocketDV 3300 in webcam
-mode. If you just want to get on your PC the pictures and movies on the
-camera, you should use the usb-storage module instead.
+This brings support under Linux for the Aiptek PocketDV 3300 and similar
+devices in webcam mode. If you just want to get on your PC the pictures
+and movies on the camera, you should use the usb-storage module instead.
 
 The driver works with several other cameras in webcam mode (see the list
 below).
 
-Maybe this code can work for other JPEG/USB cams based on the Coach
-chips from Zoran?
-
 Possible chipsets are : ZR36430 (ZR36430BGC) and
 maybe ZR36431, ZR36440, ZR36442...
 
@@ -34,20 +28,18 @@ at the source code).
 You can get these values by looking at /var/log/messages when you plug
 your camera, or by typing : cat /sys/kernel/debug/usb/devices.
 
-If you manage to use your cam with this code, you can send me a mail
-(royale@zerezo.com) with the name of your cam and a patch if needed.
-
-This is a beta release of the driver. Since version 0.70, this driver is
-only compatible with V4L2 API and 2.6.x kernels. If you need V4L1 or
-2.4x kernels support, please use an older version, but the code is not
-maintained anymore. Good luck!
 
 Install
 -------
 
-In order to use this driver, you must compile it with your kernel.
+In order to use this driver, you must compile it with your kernel,
+with the following config options::
 
-Location: Device Drivers -> Multimedia devices -> Video For Linux -> Video Capture Adapters -> V4L USB devices
+    ./scripts/config -e USB
+    ./scripts/config -m MEDIA_SUPPORT
+    ./scripts/config -e MEDIA_USB_SUPPORT
+    ./scripts/config -e MEDIA_CAMERA_SUPPORT
+    ./scripts/config -m USB_ZR364XX
 
 Usage
 -----
-- 
2.25.2

