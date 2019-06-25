Return-Path: <SRS0=f2lN=UY=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C29AC48BD4
	for <linux-media@archiver.kernel.org>; Tue, 25 Jun 2019 13:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F76208CA
	for <linux-media@archiver.kernel.org>; Tue, 25 Jun 2019 13:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfFYNZ1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:25:27 -0400
Received: from gofer.mess.org ([88.97.38.141]:37235 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbfFYNZ1 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 25 Jun 2019 09:25:27 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 273C160739; Tue, 25 Jun 2019 14:25:26 +0100 (BST)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Subject: [PATCH v4l-utils] ir-ctl: increase limit to match kernel
Date:   Tue, 25 Jun 2019 14:25:26 +0100
Message-Id: <20190625132526.18749-1-sean@mess.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This changed in kernel v5.3. In earlier versions, EINVAL
will be returned.

Signed-off-by: Sean Young <sean@mess.org>
---
 utils/ir-ctl/ir-ctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/utils/ir-ctl/ir-ctl.c b/utils/ir-ctl/ir-ctl.c
index ad830612..03c2791d 100644
--- a/utils/ir-ctl/ir-ctl.c
+++ b/utils/ir-ctl/ir-ctl.c
@@ -53,8 +53,8 @@
        __result; })
 #endif
 
-/* See drivers/media/rc/ir-lirc-codec.c line 23 */
-#define LIRCBUF_SIZE	512
+/* See drivers/media/rc/lirc_dev.c line 22 */
+#define LIRCBUF_SIZE 1024
 #define IR_DEFAULT_TIMEOUT 125000
 
 const char *argp_program_version = "IR raw version " V4L_UTILS_VERSION;
-- 
2.11.0

