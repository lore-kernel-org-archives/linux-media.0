Return-Path: <SRS0=fNsq=6B=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CF8C38A2D
	for <linux-media@archiver.kernel.org>; Fri, 17 Apr 2020 16:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E00E2054F
	for <linux-media@archiver.kernel.org>; Fri, 17 Apr 2020 16:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587142743;
	bh=czDFa9bZgTwIV1u4cjaNEAA8R4x8ahI3lqz1yrH0a8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B97Y0SCzjAD9/dzb858lSJwnHDLxHm+3YTHOZaMhQFzYSGvEdmfwyjZCQ3ABFzqQ/
	 LQGwIkHHcpAEtNeIF1MNzM0yQy6bqtOt96wetdiEo8uia/rySdVe/loRfKXlOxvrDf
	 3P8OzN4hdo5TvYM9TVOm84sOqBKA6YEj7YDWQiz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgDQQ7C (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:59:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgDQQ7B (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 17 Apr 2020 12:59:01 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B793222209;
        Fri, 17 Apr 2020 16:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587142740;
        bh=czDFa9bZgTwIV1u4cjaNEAA8R4x8ahI3lqz1yrH0a8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uabGjHo2DmhRg5H119wvHRSxZG1/OMLKJXR/li9UBkky7Uj4AH+3CkAFZYv1qOjHp
         kf1EInpheMXQY+QB7PuS52ODVxYeGK4EM2GdB22gZuMnu1TUP7YfvPoLf3/d+wsMAZ
         TnkWJHOVOfw2ryV7E9j0XFbnKYLx1C7kmiAe/0Ec=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jPUKP-007wLK-2v; Fri, 17 Apr 2020 18:58:57 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>
Subject: [PATCH 04/15] media: pwc-if: place USB device list on numberical order
Date:   Fri, 17 Apr 2020 18:58:45 +0200
Message-Id: <a3408d69504dce9095da08b74bb5c71f6242e8f5.1587142382.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1587142382.git.mchehab+huawei@kernel.org>
References: <cover.1587142382.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

It seems easier to maintain the list if the USB_DEVICE
is ordered.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/usb/pwc/pwc-if.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/media/usb/pwc/pwc-if.c b/drivers/media/usb/pwc/pwc-if.c
index 8270fb061bd6..61869636ec61 100644
--- a/drivers/media/usb/pwc/pwc-if.c
+++ b/drivers/media/usb/pwc/pwc-if.c
@@ -71,6 +71,19 @@
 
 /* hotplug device table support */
 static const struct usb_device_id pwc_device_table [] = {
+	{ USB_DEVICE(0x041E, 0x400C) }, /* Creative Webcam 5 */
+	{ USB_DEVICE(0x041E, 0x4011) }, /* Creative Webcam Pro Ex */
+
+	{ USB_DEVICE(0x046D, 0x08B0) }, /* Logitech QuickCam 3000 Pro */
+	{ USB_DEVICE(0x046D, 0x08B1) }, /* Logitech QuickCam Notebook Pro */
+	{ USB_DEVICE(0x046D, 0x08B2) }, /* Logitech QuickCam 4000 Pro */
+	{ USB_DEVICE(0x046D, 0x08B3) }, /* Logitech QuickCam Zoom (old model) */
+	{ USB_DEVICE(0x046D, 0x08B4) }, /* Logitech QuickCam Zoom (new model) */
+	{ USB_DEVICE(0x046D, 0x08B5) }, /* Logitech QuickCam Orbit/Sphere */
+	{ USB_DEVICE(0x046D, 0x08B6) }, /* Logitech/Cisco VT Camera */
+	{ USB_DEVICE(0x046D, 0x08B7) }, /* Logitech ViewPort AV 100 */
+	{ USB_DEVICE(0x046D, 0x08B8) }, /* Logitech QuickCam */
+
 	{ USB_DEVICE(0x0471, 0x0302) }, /* Philips PCA645VC */
 	{ USB_DEVICE(0x0471, 0x0303) }, /* Philips PCA646VC */
 	{ USB_DEVICE(0x0471, 0x0304) }, /* Askey VC010 type 2 */
@@ -83,25 +96,20 @@ static const struct usb_device_id pwc_device_table [] = {
 	{ USB_DEVICE(0x0471, 0x0313) }, /* Philips PCVC720K/40 (ToUCam XS) */
 	{ USB_DEVICE(0x0471, 0x0329) }, /* Philips SPC 900NC webcam */
 	{ USB_DEVICE(0x0471, 0x032C) }, /* Philips SPC 880NC webcam */
-	{ USB_DEVICE(0x069A, 0x0001) }, /* Askey VC010 type 1 */
-	{ USB_DEVICE(0x046D, 0x08B0) }, /* Logitech QuickCam 3000 Pro */
-	{ USB_DEVICE(0x046D, 0x08B1) }, /* Logitech QuickCam Notebook Pro */
-	{ USB_DEVICE(0x046D, 0x08B2) }, /* Logitech QuickCam 4000 Pro */
-	{ USB_DEVICE(0x046D, 0x08B3) }, /* Logitech QuickCam Zoom (old model) */
-	{ USB_DEVICE(0x046D, 0x08B4) }, /* Logitech QuickCam Zoom (new model) */
-	{ USB_DEVICE(0x046D, 0x08B5) }, /* Logitech QuickCam Orbit/Sphere */
-	{ USB_DEVICE(0x046D, 0x08B6) }, /* Logitech/Cisco VT Camera */
-	{ USB_DEVICE(0x046D, 0x08B7) }, /* Logitech ViewPort AV 100 */
-	{ USB_DEVICE(0x046D, 0x08B8) }, /* Logitech QuickCam */
+
+	{ USB_DEVICE(0x04CC, 0x8116) }, /* Sotec Afina Eye */
+
 	{ USB_DEVICE(0x055D, 0x9000) }, /* Samsung MPC-C10 */
 	{ USB_DEVICE(0x055D, 0x9001) }, /* Samsung MPC-C30 */
 	{ USB_DEVICE(0x055D, 0x9002) },	/* Samsung SNC-35E (Ver3.0) */
-	{ USB_DEVICE(0x041E, 0x400C) }, /* Creative Webcam 5 */
-	{ USB_DEVICE(0x041E, 0x4011) }, /* Creative Webcam Pro Ex */
-	{ USB_DEVICE(0x04CC, 0x8116) }, /* Sotec Afina Eye */
+
+	{ USB_DEVICE(0x069A, 0x0001) }, /* Askey VC010 type 1 */
+
 	{ USB_DEVICE(0x06BE, 0x8116) }, /* AME Co. Afina Eye */
+
 	{ USB_DEVICE(0x0d81, 0x1900) }, /* Visionite VCS-UC300 */
 	{ USB_DEVICE(0x0d81, 0x1910) }, /* Visionite VCS-UM100 */
+
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, pwc_device_table);
-- 
2.25.2

