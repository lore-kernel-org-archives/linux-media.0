Return-Path: <SRS0=pkrO=5Q=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFB4C10F26
	for <linux-media@archiver.kernel.org>; Tue, 31 Mar 2020 11:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2518B208E4
	for <linux-media@archiver.kernel.org>; Tue, 31 Mar 2020 11:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585653147;
	bh=fx/GiD+yHdTKjGWCvAVctm52L+HzEnvYoKkUZMEZbAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qcjsnr1dAPZP297rOgWvEAPiaSg6NCaq8z6V1eUQAiZ4zBK1G1dHPb7Zdf0BeBMM7
	 Al3trLjLyFt6E0mvIw1LIlEAbyvbKxrVqJdi5k5oMfs9PU+YfLRjWt4s2mEISvNyVu
	 FHY+NZGXkBE0iIAwoMqjSzm07xvfDLeeV+/zbuiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbgCaLM0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 31 Mar 2020 07:12:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730642AbgCaLMQ (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 31 Mar 2020 07:12:16 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D68B0221F8;
        Tue, 31 Mar 2020 11:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585653134;
        bh=fx/GiD+yHdTKjGWCvAVctm52L+HzEnvYoKkUZMEZbAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q+vrf5Qh6WvnWWxDgvKCjNl9m/iAjUs9ZYQiWyG6PIdnfdrIJgxEpmOKQQIgbuq/p
         X+VPknh9LVr6oPhP2lLcetxO72Zv369XjqyG0VXgFrP3bLKUNKc5F1LZgnn0IiMzyI
         A7KqLEXe0FuUql15dy12jMhc8F6i8p664etzI0YY=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jJEoW-002bsS-2n; Tue, 31 Mar 2020 13:12:12 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v4 33/33] media: Kconfig: don't use visible for device type select
Date:   Tue, 31 Mar 2020 13:12:09 +0200
Message-Id: <f2b8fb37e20e9d0a7f39f1709db9bf3c24348ea9.1585651678.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585651678.git.mchehab+huawei@kernel.org>
References: <cover.1585651678.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

While making the menu invisible seemed a good idea, there's
a drawback: when the menu is not visible, it is not parsing
the "default" dependency.

So, instead, let's just avoid the items at the menu to be
prompted, by using the "prompt ... if" construction.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/Kconfig | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index 382366b8ab46..0972a42e7e0c 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -57,13 +57,13 @@ config MEDIA_SUBDRV_AUTOSELECT
 	  If unsure say Y.
 
 menu "Media device types"
-	visible if MEDIA_SUPPORT_FILTER
 
 #
 # Multimedia support - automatically enable V4L2 and DVB core
 #
 config MEDIA_CAMERA_SUPPORT
-	bool "Cameras and video grabbers"
+	bool
+	prompt "Cameras and video grabbers" if MEDIA_SUPPORT_FILTER
 	default y if !MEDIA_SUPPORT_FILTER
 	help
 	  Enable support for webcams and video grabbers.
@@ -71,7 +71,8 @@ config MEDIA_CAMERA_SUPPORT
 	  Say Y when you have a webcam or a video capture grabber board.
 
 config MEDIA_ANALOG_TV_SUPPORT
-	bool "Analog TV"
+	bool
+	prompt "Analog TV" if MEDIA_SUPPORT_FILTER
 	default y if !MEDIA_SUPPORT_FILTER
 	help
 	  Enable analog TV support.
@@ -79,7 +80,8 @@ config MEDIA_ANALOG_TV_SUPPORT
 	  Say Y when you have a board with analog TV support.
 
 config MEDIA_DIGITAL_TV_SUPPORT
-	bool "Digital TV"
+	bool
+	prompt "Digital TV" if MEDIA_SUPPORT_FILTER
 	default y if !MEDIA_SUPPORT_FILTER
 	help
 	  Enable digital TV support.
@@ -87,7 +89,8 @@ config MEDIA_DIGITAL_TV_SUPPORT
 	  Say Y when you have a board with digital TV support.
 
 config MEDIA_RADIO_SUPPORT
-	bool "AM/FM radio receivers/transmitters"
+	bool
+	prompt "AM/FM radio receivers/transmitters" if MEDIA_SUPPORT_FILTER
 	default y if !MEDIA_SUPPORT_FILTER
 	help
 	  Enable AM/FM radio support.
@@ -98,7 +101,8 @@ config MEDIA_RADIO_SUPPORT
 	  Say Y when you have a board with radio support.
 
 config MEDIA_SDR_SUPPORT
-	bool "Software defined radio"
+	bool
+	prompt "Software defined radio" if MEDIA_SUPPORT_FILTER
 	default y if !MEDIA_SUPPORT_FILTER
 	help
 	  Enable software defined radio support.
@@ -106,7 +110,8 @@ config MEDIA_SDR_SUPPORT
 	  Say Y when you have a software defined radio device.
 
 config MEDIA_CEC_SUPPORT
-	bool "HDMI CEC"
+	bool
+	prompt "HDMI CEC support" if MEDIA_SUPPORT_FILTER
 	default y if !MEDIA_SUPPORT_FILTER
 	help
 	  Enable support for HDMI CEC (Consumer Electronics Control),
@@ -116,7 +121,8 @@ config MEDIA_CEC_SUPPORT
 	  adapter that supports HDMI CEC.
 
 config MEDIA_PLATFORM_SUPPORT
-	bool "Platform-specific devices"
+	bool
+	prompt "Platform-specific devices" if MEDIA_SUPPORT_FILTER
 	default y if !MEDIA_SUPPORT_FILTER
 	help
 	  Enable support for complex cameras, codecs, and other hardware
@@ -129,7 +135,8 @@ config MEDIA_PLATFORM_SUPPORT
 	  Say Y when you want to be able so see such devices.
 
 config MEDIA_TEST_SUPPORT
-	bool "Test drivers"
+	bool
+	prompt "Test drivers" if MEDIA_SUPPORT_FILTER
 	default y if !MEDIA_SUPPORT_FILTER
 	help
 	  Those drivers should not be used on production Kernels, but
-- 
2.25.1

