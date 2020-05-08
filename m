Return-Path: <SRS0=aj5L=6W=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE00C54E4A
	for <linux-media@archiver.kernel.org>; Fri,  8 May 2020 13:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AD0F249EC
	for <linux-media@archiver.kernel.org>; Fri,  8 May 2020 13:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943445;
	bh=HQV8+pfPplk0V+kgDADCRrsaL77q+O7ZgggINhSPIYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h+E9lGHDRWz/zQsweh0SnO6hSJ5XrvXlCyuiKL563p7T7hitQoOElIK9H1KR7Y0Na
	 1vf/15va9+gDkrKJUTGjLYQV8QQ8iD7hxqoQsUmKw9E1slIWfj0bFfwOm2Zir8RB2/
	 N2gVP3YmFe/NMTKMU12gt9zuzmZBTke5wvEjft+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbgEHNKm (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 8 May 2020 09:10:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730485AbgEHNKl (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 8 May 2020 09:10:41 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67A3B249AC;
        Fri,  8 May 2020 13:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588943440;
        bh=HQV8+pfPplk0V+kgDADCRrsaL77q+O7ZgggINhSPIYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2D6szX+nH/r0SxIkIphIHV9s8ZSsnzPxtEMB8/VHYJqFSHiB8YPoK8wU5HpwvNf2n
         c1IPVF+fgdX1cCLS/KFchwjWdTyYbK8I9NqKT5G/fbXybXV2xpdJkYIEP46P79NgjE
         FMeAc6AIs1WhyXSipfD8Rp9kQL/XUQOlMVid3NSM=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jX2ly-000Z95-DD; Fri, 08 May 2020 15:10:38 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>
Subject: [PATCH v9 1/5] media: open.rst: better document device node naming
Date:   Fri,  8 May 2020 15:10:33 +0200
Message-Id: <dac0e7a2b8511e9fc3499dbf92abebe3eb6eb6da.1588943181.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1588943181.git.mchehab+huawei@kernel.org>
References: <cover.1588943181.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Right now, only kAPI documentation describes the device naming.
However, such description is needed at the uAPI too. Add it,
and describe how to get an unique identify for a given device.

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../userspace-api/media/v4l/open.rst          | 43 +++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/open.rst b/Documentation/userspace-api/media/v4l/open.rst
index 38046ef20141..86816b247a17 100644
--- a/Documentation/userspace-api/media/v4l/open.rst
+++ b/Documentation/userspace-api/media/v4l/open.rst
@@ -14,12 +14,14 @@ Opening and Closing Devices
 ***************************
 
 
-Device Naming
-=============
+.. _v4l2_device_naming:
+
+V4L2 Device Node Naming
+=======================
 
 V4L2 drivers are implemented as kernel modules, loaded manually by the
 system administrator or automatically when a device is first discovered.
-The driver modules plug into the "videodev" kernel module. It provides
+The driver modules plug into the ``videodev`` kernel module. It provides
 helper functions and a common application interface specified in this
 document.
 
@@ -30,6 +32,41 @@ option CONFIG_VIDEO_FIXED_MINOR_RANGES. In that case minor numbers
 are allocated in ranges depending on the device node type (video, radio,
 etc.).
 
+The device nodes supported by the Video4Linux subsystem are:
+
+======================== ======================================================
+Default device node name Usage
+======================== ======================================================
+``/dev/videoX``		 Video input/output devices
+``/dev/vbiX``		 Vertical blank data (i.e. closed captions, teletext)
+``/dev/radioX``		 Radio tuners and modulators
+``/dev/swradioX``	 Software Defined Radio tuners and modulators
+``/dev/v4l-touchX``	 Touch sensors
+``/dev/v4l-sudevX``	 Video sub-devices (used by sensors and other I2C
+			 devices)\ [#]_
+======================== ======================================================
+
+Where ``X`` is a non-negative number.
+
+.. note::
+
+   1. The actual device node name is system-dependent, as udev rules may apply.
+   2. There is no guarantee that ``X`` will remain the same for the same
+      device, as the number depends on the device driver's probe order.
+      If you need an unique name, udev default rules produce
+      ``/dev/v4l/by-id/`` and ``/dev/v4l/by-path/`` directories containing
+      links that can be used uniquely to identify a V4L2 device node::
+
+	$ tree /dev/v4l
+	/dev/v4l
+	├── by-id
+	│   └── usb-OmniVision._USB_Camera-B4.04.27.1-video-index0 -> ../../video0
+	└── by-path
+	    └── pci-0000:00:14.0-usb-0:2:1.0-video-index0 -> ../../video0
+
+.. [#] **V4L2 sub-device nodes** (e. g. ``/dev/v4l-sudevX``) use a different
+       set of system calls, as covered at :ref:`subdev`.
+
 Many drivers support "video_nr", "radio_nr" or "vbi_nr" module
 options to select specific video/radio/vbi node numbers. This allows the
 user to request that the device node is named e.g. /dev/video5 instead
-- 
2.26.2

