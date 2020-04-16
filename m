Return-Path: <SRS0=ht1n=6A=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C3BC2BB85
	for <linux-media@archiver.kernel.org>; Thu, 16 Apr 2020 12:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3603C206B9
	for <linux-media@archiver.kernel.org>; Thu, 16 Apr 2020 12:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587039758;
	bh=aZXoMiNzA9an2kHK+EolYVcLgbDTjxqS+hb404GBhBM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XJe1J3vaUDggYjdaxyiCtO3gAK7Ri1l8jVehlSiY27k851uHuL2KM+9V19Ji2b8jy
	 +8OtHOZ060ERMlIa9yhecG2pQ+O6f4VAe+pitG2nOORV6tTxzL6b0JkwY+WGySNXP4
	 M2ZPBMuqmEIMWGJ++s4qMV/rq1DUYsEshb71fIy0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635286AbgDPMWd (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:22:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2635261AbgDPMW2 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 16 Apr 2020 08:22:28 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D938A206B9;
        Thu, 16 Apr 2020 12:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587039748;
        bh=aZXoMiNzA9an2kHK+EolYVcLgbDTjxqS+hb404GBhBM=;
        h=From:To:Cc:Subject:Date:From;
        b=dSLHncbnRAt/IXrBbtB1TP4g2IWMH8iGYeVrvHlvCdrBj+lMuMY78YxqKT8SzX9I1
         5R+MPlxnTlY42sSEWg1eSBGnPhJoQvNull9V+snBYcZ1HQ0ghHa1B8NyGowr6x7UrJ
         pbV2Gb17JBPupfWzI6WJPK419XnaqPwxV3wiP+Jo=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jP3XF-007TDL-NO; Thu, 16 Apr 2020 14:22:25 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH RFC] media: admin-guide: improve cardlist.rst documentation
Date:   Thu, 16 Apr 2020 14:22:22 +0200
Message-Id: <34d6b30adb63f3525acbe6bcc3dfdf247d3f5e18.1587039739.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The cardlist section is important for some boards, because they
may require extra modprobe parameters.

Improve the docs to mention that.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/media/cardlist.rst | 76 ++++++++++++++++++--
 1 file changed, 71 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/media/cardlist.rst b/Documentation/admin-guide/media/cardlist.rst
index 527188ee9697..4beef18fc46d 100644
--- a/Documentation/admin-guide/media/cardlist.rst
+++ b/Documentation/admin-guide/media/cardlist.rst
@@ -1,22 +1,88 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+==========
 Cards List
 ==========
 
+The media subsystem provide support for lots of PCI and USB drivers, plus
+platform-specific drivers. It also contains several ancillary I²C drivers.
+
+This section contains a list of some of those supported drivers.
+
+USB drivers
+===========
+
+The USB boards are identified by an identification called USB ID.
+
+The ``lsusb`` command allows identifying the USB IDs::
+
+    $ lsusb
+    ...
+    Bus 001 Device 015: ID 046d:082d Logitech, Inc. HD Pro Webcam C920
+    Bus 001 Device 074: ID 2040:b131 Hauppauge
+    Bus 001 Device 075: ID 2013:024f PCTV Systems nanoStick T2 290e
+    ...
+
+Unfortunately, sometimes the same USB ID is used by different products.
+So, several media drivers allow passing a ``card=`` parameter, in order
+to setup a card number that would match the correct settings for an
+specific board.
+
 .. toctree::
 	:maxdepth: 1
 
 	au0828-cardlist
+	cx231xx-cardlist
+	em28xx-cardlist
+	tm6000-cardlist
+	usbvision-cardlist
+	gspca-cardlist
+
+PCI drivers
+===========
+
+The PCI boards are identified by an identification called PCI ID.
+
+The ``lspci`` command allows identifying the PCI IDs::
+
+    $ lspci -nn
+    ...
+    00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture [1822:0026] (rev 11)
+    ...
+
+Unfortunately, sometimes the same PCI ID is used by different products.
+So, several media drivers allow passing a ``card=`` parameter, in order
+to setup a card number that would match the correct settings for an
+specific board.
+
+.. toctree::
+	:maxdepth: 1
+
 	bttv-cardlist
 	cx18-cardlist
-	cx231xx-cardlist
 	cx23885-cardlist
 	cx88-cardlist
-	em28xx-cardlist
 	ivtv-cardlist
 	saa7134-cardlist
 	saa7164-cardlist
-	tm6000-cardlist
+
+I²C drivers
+===========
+
+The I²C (Inter-Integrated Circuit) bus is a three-wires bus used internally
+at the media cards for communication between different chips. While the bus
+is not visible to the Linux Kernel, drivers need to send and receive
+commands via the bus. The Linux Kernel driver abstraction has support to
+implement different drivers for each component inside an I²C bus, as if
+the bus were visible to the main system board.
+
+One of the problems with I²C devices is that sometimes the same device may
+work with different I²C hardware. This is common, for example, on devices
+that comes with a tuner for North America market, and another one for
+Europe. Some drivers have a ``tuner=`` modprobe parameter to allow using a
+different tuner number in order to address such issue.
+
+.. toctree::
+	:maxdepth: 1
+
 	tuner-cardlist
-	usbvision-cardlist
-	gspca-cardlist
-- 
2.25.2

