Return-Path: <SRS0=0Sen=32=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65B0C33CAC
	for <linux-media@archiver.kernel.org>; Thu,  6 Feb 2020 14:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8645C217F4
	for <linux-media@archiver.kernel.org>; Thu,  6 Feb 2020 14:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581000640;
	bh=CCB9J07T/80+IsrntbbRDukpQNpe71X8YA4l6vdAkPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ipBuoztjuM2aI3xstiqxaW7if8mxgreUPzBM8+1uyOKUOXCM5Jo5biXu91N6+5TKg
	 +AViOho2A8l3Te7iU7UuNRSL/o/pdNrNSPq7udU12+rYExn39BFXbpvKMfmaqOgibD
	 dgFkLIqTomPKbMaNBkTEaRUNmPsrtaT4ONKx1inY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgBFOuj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 6 Feb 2020 09:50:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55430 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbgBFOug (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 6 Feb 2020 09:50:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5C1Pl5mrdwkmC0Ibs5rVWyWq5pet5BdrcnU/u0rt7EY=; b=qZcDoAGDg0MYMoNi5f/YswxUcA
        KEyAKBhWTbJS9NBZl2F/rAvbiE/o0j1oFijDiy4iIpc4NGBN+XNSZWdPQ8wojJvfJrvB1aR3+mC4S
        AtK27e2GTd3hI4yY0M2tJekaB3+ToviXhygfvnVjBv+RGV/uQxwGD+K7wzV+w+ygEDSnjqRXTSUAY
        9CcAP4VPIs0x60gFAGIdl0cvEtsdU/A11wVl/sWxbUD2jrurT7pS5fQaSuoZNjwZgn/N0buXinQm+
        sD5JeUbqbbIbwH+Gp9mhHzl7t9ckd6NdRUANGOUBhTNw84RbIbMw8NEsCNc7mKjpAftsAz6x+FgWx
        KeKV7yNg==;
Received: from [179.95.15.160] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iziUE-0004IT-Rf; Thu, 06 Feb 2020 14:50:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1iziU6-002nKT-AN; Thu, 06 Feb 2020 15:50:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-um@lists.infradead.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 03/27] docs: virt: user_mode_linux.rst: update compiling instructions
Date:   Thu,  6 Feb 2020 15:50:00 +0100
Message-Id: <b678c16fb34280d844c278b8acfb2f53124f50ab.1581000481.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581000481.git.mchehab+huawei@kernel.org>
References: <cover.1581000481.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Instead of pointing for a pre-2.4 and a seaparate patch,
update it to match current upstream, as UML was merged
a long time ago.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/virt/uml/user_mode_linux.rst | 62 ++++------------------
 1 file changed, 9 insertions(+), 53 deletions(-)

diff --git a/Documentation/virt/uml/user_mode_linux.rst b/Documentation/virt/uml/user_mode_linux.rst
index 6085d2c0f8a8..e0632d80753e 100644
--- a/Documentation/virt/uml/user_mode_linux.rst
+++ b/Documentation/virt/uml/user_mode_linux.rst
@@ -5,7 +5,7 @@ User Mode Linux HOWTO
 =====================
 
 :Author:  User Mode Linux Core Team
-:Last-updated: Mon Nov 18 14:16:16 EST 2002
+:Last-updated: Sat Jan 25 16:07:55 CET 2020
 
 This document describes the use and abuse of Jeff Dike's User Mode
 Linux: a port of the Linux kernel as a normal Intel Linux process.
@@ -223,23 +223,15 @@ Linux: a port of the Linux kernel as a normal Intel Linux process.
 
 
   Compiling the user mode kernel is just like compiling any other
-  kernel.  Let's go through the steps, using 2.4.0-prerelease (current
-  as of this writing) as an example:
+  kernel.
 
 
-  1. Download the latest UML patch from
-     the download page <http://user-mode-linux.sourceforge.net/
-
-     In this example, the file is uml-patch-2.4.0-prerelease.bz2.
-
-
-  2. Download the matching kernel from your favourite kernel mirror,
+  1. Download the latest kernel from your favourite kernel mirror,
      such as:
 
-     ftp://ftp.ca.kernel.org/pub/kernel/v2.4/linux-2.4.0-prerelease.tar.bz2
+     https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/linux-5.4.14.tar.xz
 
-
-  3. Make a directory and unpack the kernel into it::
+  2. Make a directory and unpack the kernel into it::
 
        host%
        mkdir ~/uml
@@ -248,21 +240,10 @@ Linux: a port of the Linux kernel as a normal Intel Linux process.
        cd ~/uml
 
        host%
-       tar -xzvf linux-2.4.0-prerelease.tar.bz2
+       tar xvf linux-5.4.14.tar.xz
 
 
-
-  4. Apply the patch using::
-
-       host%
-       cd ~/uml/linux
-
-       host%
-       bzcat uml-patch-2.4.0-prerelease.bz2 | patch -p1
-
-
-
-  5. Run your favorite config; ``make xconfig ARCH=um`` is the most
+  3. Run your favorite config; ``make xconfig ARCH=um`` is the most
      convenient.  ``make config ARCH=um`` and ``make menuconfig ARCH=um``
      will work as well.  The defaults will give you a useful kernel.  If
      you want to change something, go ahead, it probably won't hurt
@@ -276,34 +257,9 @@ Linux: a port of the Linux kernel as a normal Intel Linux process.
 
 
 
-  6. Finish with ``make linux ARCH=um``: the result is a file called
+  4. Finish with ``make linux ARCH=um``: the result is a file called
      ``linux`` in the top directory of your source tree.
 
-  Make sure that you don't build this kernel in /usr/src/linux.  On some
-  distributions, /usr/include/asm is a link into this pool.  The user-
-  mode build changes the other end of that link, and things that include
-  <asm/anything.h> stop compiling.
-
-  The sources are also available from cvs at the project's cvs page,
-  which has directions on getting the sources. You can also browse the
-  CVS pool from there.
-
-  If you get the CVS sources, you will have to check them out into an
-  empty directory. You will then have to copy each file into the
-  corresponding directory in the appropriate kernel pool.
-
-  If you don't have the latest kernel pool, you can get the
-  corresponding user-mode sources with::
-
-
-       host% cvs co -r v_2_3_x linux
-
-
-
-
-  where 'x' is the version in your pool. Note that you will not get the
-  bug fixes and enhancements that have gone into subsequent releases.
-
 
 2.2.  Compiling and installing kernel modules
 ---------------------------------------------
@@ -416,7 +372,7 @@ Linux: a port of the Linux kernel as a normal Intel Linux process.
 3.1.  Running UML
 -----------------
 
-  It runs on 2.2.15 or later, and all 2.4 kernels.
+  It runs on 2.2.15 or later, and all kernel versions since 2.4.
 
 
   Booting UML is straightforward.  Simply run 'linux': it will try to
-- 
2.24.1

