Return-Path: <SRS0=AvQq=CB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB79DC433DF
	for <linux-media@archiver.kernel.org>; Sun, 23 Aug 2020 16:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C57E12074D
	for <linux-media@archiver.kernel.org>; Sun, 23 Aug 2020 16:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgHWQsN (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 23 Aug 2020 12:48:13 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:45888 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbgHWQsK (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sun, 23 Aug 2020 12:48:10 -0400
From:   James Le Cuirot <chewi@gentoo.org>
To:     linux-media@vger.kernel.org
Cc:     James Le Cuirot <chewi@gentoo.org>
Subject: [PATCH] configure.ac: Add --without-libudev option to avoid automagic dep
Date:   Sun, 23 Aug 2020 17:47:44 +0100
Message-Id: <20200823164744.6191-1-chewi@gentoo.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Signed-off-by: James Le Cuirot <chewi@gentoo.org>
---
 configure.ac | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/configure.ac b/configure.ac
index d9f43ab5..e6134d08 100644
--- a/configure.ac
+++ b/configure.ac
@@ -291,16 +291,23 @@ else
    AC_MSG_WARN(ALSA library not available)
 fi
 
-PKG_CHECK_MODULES(libudev, libudev, have_libudev=yes, have_libudev=no)
-if test "x$have_libudev" = "xyes"; then
-	AC_DEFINE([HAVE_LIBUDEV], [], [Use libudev])
-	LIBUDEV_CFLAGS="$libudev_CFLAGS"
-	LIBUDEV_LIBS="$libudev_LIBS"
-	AC_SUBST(LIBUDEV_CFLAGS)
-	AC_SUBST(LIBUDEV_LIBS)
-else
-   AC_MSG_WARN(udev library not available)
-fi
+AC_ARG_WITH([libudev],
+            AS_HELP_STRING([--without-libudev], [Do not use udev library]),
+            [],
+            [with_libudev=yes])
+
+have_libudev=no
+
+AS_IF([test "x$with_libudev" != xno -o "x$enable_libdvbv5" != xno],
+      [PKG_CHECK_MODULES(libudev, libudev, have_libudev=yes, [])
+       AS_IF([test "x$have_libudev" = xyes],
+             [AC_DEFINE([HAVE_LIBUDEV], [], [Use libudev])
+              LIBUDEV_CFLAGS="$libudev_CFLAGS"
+              LIBUDEV_LIBS="$libudev_LIBS"
+              AC_SUBST(LIBUDEV_CFLAGS)
+              AC_SUBST(LIBUDEV_LIBS)],
+             AC_MSG_WARN(udev library not available)
+            )])
 
 AC_SUBST([JPEG_LIBS])
 
-- 
2.26.2

