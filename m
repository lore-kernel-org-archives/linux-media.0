Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A4CC433C1
	for <linux-media@archiver.kernel.org>; Tue, 23 Mar 2021 01:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F44E6198E
	for <linux-media@archiver.kernel.org>; Tue, 23 Mar 2021 01:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCWB43 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 22 Mar 2021 21:56:29 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:54594 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhCWB4I (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 22 Mar 2021 21:56:08 -0400
X-Greylist: delayed 508 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Mar 2021 21:56:08 EDT
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 2BFDB980239;
        Tue, 23 Mar 2021 09:47:34 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] media: test-drivers: Remove duplicate include of string.h
Date:   Tue, 23 Mar 2021 09:47:24 +0800
Message-Id: <20210323014724.137234-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQh4YGE0eHR5DSk5LVkpNSk1PTU9LTk1NTktVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0JITlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORg6Ihw6DD8KODpWAU8TLEMa
        ITwKFEtVSlVKTUpNT01PS05MTElJVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTUtDNwY+
X-HM-Tid: 0a785cc40fdad992kuws2bfdb980239
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

linux/string.h has been included at line 21, so remove the 
duplicate one at line 22.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/media/test-drivers/vidtv/vidtv_psi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_psi.c b/drivers/media/test-drivers/vidtv/vidtv_psi.c
index 47ed7907db8d..c11ac8dca73d 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_psi.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_psi.c
@@ -19,7 +19,6 @@
 #include <linux/ratelimit.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/string.h>
 #include <linux/time.h>
 #include <linux/types.h>
 
-- 
2.25.1

