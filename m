Return-Path: <SRS0=0Sen=32=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A560C3B183
	for <linux-media@archiver.kernel.org>; Thu,  6 Feb 2020 15:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24BE20838
	for <linux-media@archiver.kernel.org>; Thu,  6 Feb 2020 15:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581001919;
	bh=H6v8m9+eTb8TJjP7/IX9nuNDh4mqr7FOvBYBGbPbrrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NXtaGUuTygyFQSbnqK6vir5ioQMTXukx1/8hWtzWNgo+OJlMBYhXSO0E3ZBI+rz2O
	 23nQ3lTM5TNRKRqR2R/wA3iL/UcZbmu4tElMggUMiw9mM+SIDVqIbmxtVSb7irXT5w
	 t4ow68nBcI6Q6MqGk0/pgrLw0M5cZpmoiCe6ihK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgBFPLm (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:11:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37526 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgBFPLm (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 6 Feb 2020 10:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CdqmLOZ5sQ/Aflxvzy0izWi/tvqp/in3SnUYEGpwbcw=; b=c9XnhoYKCB1t/Ir0JOCrXRdVmI
        4j2ExvLFcfIDC1WGd7F6hP5uLaq0meoHKIdmwf1+by44zO90p4L+0RN9bqNYW68wSIZMS/bbCYxO6
        eCCjFdeXgKm8eMbxr48U9CWdKDUVX8Sb1dPT4bs1qzKpAC2S9r8przpKsUZoj86HmJkhYwRk7PoDW
        Gdz/xTw5gciIvoxC572NhQJ5QPKKCJBZy8URSs6/hDo/ITyBF1R663YINYNYAOyu1veNK37D03tuN
        12j8H873ffk2r5GjtEnp7qt0vpZ9FmeG27kZeLvCS6FbHPJ3+Rq/vOTLXtxAh5MoDFrn9GkAxLuRm
        DKXAMaTQ==;
Received: from [179.95.15.160] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izioc-000437-U5; Thu, 06 Feb 2020 15:11:42 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1izioW-002oNQ-0v; Thu, 06 Feb 2020 16:11:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 09/11] docs: misc-devices/c2port.txt: convert to ReST format
Date:   Thu,  6 Feb 2020 16:11:28 +0100
Message-Id: <0a053afb27db3fe13443ea54885ef9afcf480b34.1581001737.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581001737.git.mchehab+huawei@kernel.org>
References: <cover.1581001737.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

- Use copyright symbol;
- use title markups;
- adjust indentation;
- mark literal blocks as such.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../misc-devices/{c2port.txt => c2port.rst}   | 58 ++++++++++---------
 Documentation/misc-devices/index.rst          |  1 +
 2 files changed, 32 insertions(+), 27 deletions(-)
 rename Documentation/misc-devices/{c2port.txt => c2port.rst} (59%)

diff --git a/Documentation/misc-devices/c2port.txt b/Documentation/misc-devices/c2port.rst
similarity index 59%
rename from Documentation/misc-devices/c2port.txt
rename to Documentation/misc-devices/c2port.rst
index ea7344465610..258e1c1d43c7 100644
--- a/Documentation/misc-devices/c2port.txt
+++ b/Documentation/misc-devices/c2port.rst
@@ -1,7 +1,11 @@
-			C2 port support
-			---------------
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
-(C) Copyright 2007 Rodolfo Giometti <giometti@enneenne.com>
+===============
+C2 port support
+===============
+
+|copy| Copyright 2007 Rodolfo Giometti <giometti@enneenne.com>
 
 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
@@ -32,10 +36,10 @@ The C2 Interface main references are at (http://www.silabs.com)
 Silicon Laboratories site], see:
 
 - AN127: FLASH Programming via the C2 Interface at
-http://www.silabs.com/Support Documents/TechnicalDocs/an127.pdf 
+  http://www.silabs.com/Support Documents/TechnicalDocs/an127.pdf
 
 - C2 Specification at
-http://www.silabs.com/pages/DownloadDoc.aspx?FILEURL=Support%20Documents/TechnicalDocs/an127.pdf&src=SearchResults
+  http://www.silabs.com/pages/DownloadDoc.aspx?FILEURL=Support%20Documents/TechnicalDocs/an127.pdf&src=SearchResults
 
 however it implements a two wire serial communication protocol (bit
 banging) designed to enable in-system programming, debugging, and
@@ -47,44 +51,44 @@ Using the driver
 ----------------
 
 Once the driver is loaded you can use sysfs support to get C2port's
-info or read/write in-system flash.
+info or read/write in-system flash::
 
-# ls /sys/class/c2port/c2port0/
-access            flash_block_size  flash_erase       rev_id
-dev_id            flash_blocks_num  flash_size        subsystem/
-flash_access      flash_data        reset             uevent
+  # ls /sys/class/c2port/c2port0/
+  access            flash_block_size  flash_erase       rev_id
+  dev_id            flash_blocks_num  flash_size        subsystem/
+  flash_access      flash_data        reset             uevent
 
 Initially the C2port access is disabled since you hardware may have
 such lines multiplexed with other devices so, to get access to the
-C2port, you need the command:
+C2port, you need the command::
 
-# echo 1 > /sys/class/c2port/c2port0/access
+  # echo 1 > /sys/class/c2port/c2port0/access
 
 after that you should read the device ID and revision ID of the
-connected micro controller:
+connected micro controller::
 
-# cat /sys/class/c2port/c2port0/dev_id
-8
-# cat /sys/class/c2port/c2port0/rev_id
-1
+  # cat /sys/class/c2port/c2port0/dev_id
+  8
+  # cat /sys/class/c2port/c2port0/rev_id
+  1
 
 However, for security reasons, the in-system flash access in not
-enabled yet, to do so you need the command:
+enabled yet, to do so you need the command::
 
-# echo 1 > /sys/class/c2port/c2port0/flash_access
+  # echo 1 > /sys/class/c2port/c2port0/flash_access
 
-After that you can read the whole flash:
+After that you can read the whole flash::
 
-# cat /sys/class/c2port/c2port0/flash_data > image
+  # cat /sys/class/c2port/c2port0/flash_data > image
 
-erase it:
+erase it::
 
-# echo 1 > /sys/class/c2port/c2port0/flash_erase
+  # echo 1 > /sys/class/c2port/c2port0/flash_erase
 
-and write it:
+and write it::
 
-# cat image > /sys/class/c2port/c2port0/flash_data
+  # cat image > /sys/class/c2port/c2port0/flash_data
 
-after writing you have to reset the device to execute the new code:
+after writing you have to reset the device to execute the new code::
 
-# echo 1 > /sys/class/c2port/c2port0/reset
+  # echo 1 > /sys/class/c2port/c2port0/reset
diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index 04f5dab2384c..c2e880d78734 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -16,6 +16,7 @@ fit into other categories.
 
    ad525x_dpot
    eeprom
+   c2port
    ibmvmc
    ics932s401
    isl29003
-- 
2.24.1

