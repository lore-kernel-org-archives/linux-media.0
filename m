Return-Path: <SRS0=aOuj=6V=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2F5C38A24
	for <linux-media@archiver.kernel.org>; Thu,  7 May 2020 07:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2135A208E4
	for <linux-media@archiver.kernel.org>; Thu,  7 May 2020 07:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgEGHHB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 7 May 2020 03:07:01 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:46630 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgEGHHB (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 7 May 2020 03:07:01 -0400
From:   Lars Wendler <polynomial-c@gentoo.org>
To:     linux-media@vger.kernel.org
Cc:     Lars Wendler <polynomial-c@gentoo.org>
Subject: [PATCH] v4l-utils: configure.ac: Avoid bashisms
Date:   Thu,  7 May 2020 09:05:48 +0200
Message-Id: <20200507070547.21954-1-polynomial-c@gentoo.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

as these cause possible misbehavior when running with non-bash shells

Gentoo-bug: https://bugs.gentoo.org/721374
Signed-off-by: Lars Wendler <polynomial-c@gentoo.org>
---
 configure.ac | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index c49f2c37..54459393 100644
--- a/configure.ac
+++ b/configure.ac
@@ -542,13 +542,13 @@ AM_CONDITIONAL([WITH_QVIDCAP],	    [test x${qt_desktop_opengl} = xyes -a x$enabl
 AM_CONDITIONAL([WITH_V4L_PLUGINS],  [test x$enable_dyn_libv4l != xno -a x$enable_shared != xno])
 AM_CONDITIONAL([WITH_V4L_WRAPPERS], [test x$enable_dyn_libv4l != xno -a x$enable_shared != xno])
 AM_CONDITIONAL([WITH_QTGL],	    [test x${qt_desktop_opengl} = xyes])
-AM_CONDITIONAL([WITH_GCONV],        [test x$enable_gconv = xyes -a x$enable_shared == xyes -a x$with_gconvdir != x -a -f $with_gconvdir/gconv-modules])
+AM_CONDITIONAL([WITH_GCONV],        [test x$enable_gconv = xyes -a x$enable_shared = xyes -a x$with_gconvdir != x -a -f $with_gconvdir/gconv-modules])
 AM_CONDITIONAL([WITH_V4L2_CTL_LIBV4L], [test x${enable_v4l2_ctl_libv4l} != xno])
 AM_CONDITIONAL([WITH_V4L2_CTL_STREAM_TO], [test x${enable_v4l2_ctl_stream_to} != xno])
-AM_CONDITIONAL([WITH_V4L2_CTL_32], [test x${enable_v4l2_ctl_32} == xyes])
+AM_CONDITIONAL([WITH_V4L2_CTL_32], [test x${enable_v4l2_ctl_32} = xyes])
 AM_CONDITIONAL([WITH_V4L2_COMPLIANCE], [test x$ac_cv_func_fork = xyes])
 AM_CONDITIONAL([WITH_V4L2_COMPLIANCE_LIBV4L], [test x$ac_cv_func_fork = xyes -a x${enable_v4l2_compliance_libv4l} != xno])
-AM_CONDITIONAL([WITH_V4L2_COMPLIANCE_32], [test x$ac_cv_func_fork = xyes -a x${enable_v4l2_compliance_32} == xyes])
+AM_CONDITIONAL([WITH_V4L2_COMPLIANCE_32], [test x$ac_cv_func_fork = xyes -a x${enable_v4l2_compliance_32} = xyes])
 AM_CONDITIONAL([WITH_BPF],          [test x$enable_bpf != xno -a x$libelf_pkgconfig = xyes -a x$CLANG = xclang])
 
 # append -static to libtool compile and link command to enforce static libs
-- 
2.26.2

