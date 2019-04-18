Return-Path: <SRS0=rYAI=SU=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9E2C10F0E
	for <linux-media@archiver.kernel.org>; Thu, 18 Apr 2019 11:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8660E214DA
	for <linux-media@archiver.kernel.org>; Thu, 18 Apr 2019 11:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388301AbfDRLOC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 18 Apr 2019 07:14:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbfDRLOC (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 18 Apr 2019 07:14:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A9922319939D;
        Thu, 18 Apr 2019 11:14:02 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-101.ams2.redhat.com [10.36.117.101])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E01C85D6A9;
        Thu, 18 Apr 2019 11:14:01 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Gregor Jasny <gjasny@googlemail.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] configure.ac: Add AM_GNU_GETTEXT_VERSION([0.19.8])
Date:   Thu, 18 Apr 2019 13:14:00 +0200
Message-Id: <20190418111400.4410-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 18 Apr 2019 11:14:02 +0000 (UTC)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add AM_GNU_GETTEXT_VERSION([0.19.8]) so that autoreconf will properly
run autopoint instead of failing because build-aux/config.rpath is
not copied.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 configure.ac | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure.ac b/configure.ac
index 4970eece..a8d215f3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -96,6 +96,7 @@ PKG_PROG_PKG_CONFIG
 DX_DOT_FEATURE(ON)
 DX_INIT_DOXYGEN($PACKAGE_NAME, doxygen_libdvbv5.cfg)
 ALL_LINGUAS=""
+AM_GNU_GETTEXT_VERSION([0.19.8])
 AM_GNU_GETTEXT([external])
 
 LIBDVBV5_DOMAIN="libdvbv5"
-- 
2.21.0

