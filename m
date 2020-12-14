Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8DBC1B0E3
	for <linux-media@archiver.kernel.org>; Mon, 14 Dec 2020 11:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B20C9229C6
	for <linux-media@archiver.kernel.org>; Mon, 14 Dec 2020 11:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgLNLFA (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 14 Dec 2020 06:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407268AbgLNLEj (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 14 Dec 2020 06:04:39 -0500
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [IPv6:2001:638:a000:4130:131:188:30:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3C3C061794;
        Mon, 14 Dec 2020 03:03:59 -0800 (PST)
Received: from cipterm0.informatik.uni-erlangen.de (cipterm0.cip.cs.fau.de [IPv6:2001:638:a000:4130:131:188:30:90])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 19366240B99;
        Mon, 14 Dec 2020 12:02:52 +0100 (CET)
Received: by cipterm0.informatik.uni-erlangen.de (Postfix, from userid 67858)
        id 1727C3280146; Mon, 14 Dec 2020 12:02:52 +0100 (CET)
From:   Philipp Gerlesberger <Philipp.Gerlesberger@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     Philipp Gerlesberger <Philipp.Gerlesberger@fau.de>,
        ij72uhux@stud.informatik.uni-erlangen.de,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@i4.cs.fau.de, gregkh@linuxfoundation.org,
        sakari.ailus@linux.intel.com, mchehab@kernel.org
Subject: [PATCH v2 06/12] media: atomisp: Remove defines
Date:   Mon, 14 Dec 2020 12:01:50 +0100
Message-Id: <20201214110156.6152-7-Philipp.Gerlesberger@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201214110156.6152-1-Philipp.Gerlesberger@fau.de>
References: <20201214110156.6152-1-Philipp.Gerlesberger@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Remov defines, they don't make sense.
The programmer should know what things need to be static and what not.
Also leave "inline" out and let the compiler decide

Co-developed-by: Andrey Khlopkov <ij72uhux@stud.informatik.uni-erlangen.de>
Signed-off-by: Andrey Khlopkov <ij72uhux@stud.informatik.uni-erlangen.de>
Signed-off-by: Philipp Gerlesberger <Philipp.Gerlesberger@fau.de>
---
 .../media/atomisp/pci/runtime/rmgr/interface/ia_css_rmgr.h   | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/runtime/rmgr/interface/ia_css_rmgr.h b/drivers/staging/media/atomisp/pci/runtime/rmgr/interface/ia_css_rmgr.h
index 9cd3d92b34c9..45b72e98bc9f 100644
--- a/drivers/staging/media/atomisp/pci/runtime/rmgr/interface/ia_css_rmgr.h
+++ b/drivers/staging/media/atomisp/pci/runtime/rmgr/interface/ia_css_rmgr.h
@@ -21,10 +21,7 @@
 #ifndef __INLINE_RMGR__
 #define STORAGE_CLASS_RMGR_H extern
 #define STORAGE_CLASS_RMGR_C
-#else				/* __INLINE_RMGR__ */
-#define STORAGE_CLASS_RMGR_H static inline
-#define STORAGE_CLASS_RMGR_C static inline
-#endif				/* __INLINE_RMGR__ */
+#endif
 
 /**
  * @brief Initialize resource manager (host/common)
-- 
2.20.1

