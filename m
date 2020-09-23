Return-Path: <SRS0=mA+5=DA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DFEC4727D
	for <linux-media@archiver.kernel.org>; Wed, 23 Sep 2020 19:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1544E2145D
	for <linux-media@archiver.kernel.org>; Wed, 23 Sep 2020 19:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgIWToV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 23 Sep 2020 15:44:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:34824 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgIWToV (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 23 Sep 2020 15:44:21 -0400
IronPort-SDR: q9wxlg4uMxNEvm/9rJTpwV5E2z1A4tnLRLURLu8WUNMIowmm7HOP31iMXCJjXKAU+K1eih9Lgj
 4hvjoOVCHnxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="222586564"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="222586564"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 12:44:20 -0700
IronPort-SDR: VGl03i4oOocVHNVaTF+XIl4Ki9i05XDbi/antbjsLNodX3vydQnKKh1kkPoMdkHVwJyw5Q1rOW
 XTRyC5T4wj4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="511116597"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga006.fm.intel.com with ESMTP; 23 Sep 2020 12:44:20 -0700
Subject: [PATCH] media: fix Omnivision Intel MAINTAINERS entry
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, tian.shu.qiu@intel.com,
        shawnx.tu@intel.com, bingbu.cao@intel.com,
        linux-media@vger.kernel.org, mchehab@kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Wed, 23 Sep 2020 12:33:56 -0700
Message-Id: <20200923193356.188D717D@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Tianshu Qiu has three MAINTAINERS entries, and one typo.  After being
notified if the typo a few months ago, they didn't act, so here's a
patch.

Tianshu, an ack would be appreciated.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Tianshu Qiu <tian.shu.qiu@intel.com>
Cc: Shawn Tu <shawnx.tu@intel.com>
Cc: Bingbu Cao <bingbu.cao@intel.com>
Cc: linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-kernel@vger.kernel.org
---

 b/MAINTAINERS |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN MAINTAINERS~bad-intel-maintainers MAINTAINERS
--- a/MAINTAINERS~bad-intel-maintainers	2020-09-23 12:24:01.585676846 -0700
+++ b/MAINTAINERS	2020-09-23 12:25:02.959676693 -0700
@@ -12766,7 +12766,7 @@ T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/i2c/ov2685.c
 
 OMNIVISION OV2740 SENSOR DRIVER
-M:	Tianshu Qiu <tian.shu.qiua@intel.com>
+M:	Tianshu Qiu <tian.shu.qiu@intel.com>
 R:	Shawn Tu <shawnx.tu@intel.com>
 R:	Bingbu Cao <bingbu.cao@intel.com>
 L:	linux-media@vger.kernel.org
_
