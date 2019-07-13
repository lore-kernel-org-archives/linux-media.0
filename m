Return-Path: <SRS0=Qizv=VK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA23C742D7
	for <linux-media@archiver.kernel.org>; Sat, 13 Jul 2019 15:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EDF204FD
	for <linux-media@archiver.kernel.org>; Sat, 13 Jul 2019 15:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfGMPmf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 13 Jul 2019 11:42:35 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:43040 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbfGMPmf (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sat, 13 Jul 2019 11:42:35 -0400
Received: from symphony.aura-online.co.uk (154.189.187.81.in-addr.arpa [81.187.189.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: chewi)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 38482347870;
        Sat, 13 Jul 2019 15:42:33 +0000 (UTC)
From:   James Le Cuirot <chewi@gentoo.org>
To:     linux-media@vger.kernel.org
Cc:     James Le Cuirot <chewi@gentoo.org>
Subject: [PATCH] [dtv-scan-tables] Improve Makefile to avoid "Argument list too long" error
Date:   Sat, 13 Jul 2019 16:40:49 +0100
Message-Id: <20190713154048.21291-1-chewi@gentoo.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

I wouldn't expect a foreach loop to be prone to this issue but it's
not the right way to write a Makefile anyway.

Note that conversion failures are now fatal and the dvb-t/ke-Nairobi
file is failing to convert at the moment.

Signed-off-by: James Le Cuirot <chewi@gentoo.org>
---
 Makefile | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 901dc9d..7cdb5bc 100644
--- a/Makefile
+++ b/Makefile
@@ -17,6 +17,8 @@ DVBV3DIRS = atsc dvb-c dvb-s dvb-t
 DVBV5DIRS = $(DVBV3DIRS) isdb-t
 
 DVBV3CHANNELFILES = $(foreach dir,$(DVBV3DIRS),$(wildcard $(dir)/*))
+DVBV3OUTPUTFILES = $(patsubst %,$(DVBV3OUTPUTDIR)/%,$(DVBV3CHANNELFILES))
+DVBV5OUTPUTFILES = $(patsubst %,$(DVBV5OUTPUTDIR)/%,$(DVBV3CHANNELFILES))
 
 DVBFORMATCONVERT_CHANNEL_DVBV5 = -ICHANNEL -ODVBV5
 DVBFORMATCONVERT_CHANNEL_DVBV3 = -IDVBV5 -OCHANNEL
@@ -42,14 +44,16 @@ ifeq ($(DVBV3DIR),)
 DVBV3DIR = dvbv3
 endif
 
-dvbv3:
-	@$(foreach var,$(DVBV3DIRS), $(MKDIR) $(DVBV3OUTPUTDIR)/$(var);)
-	@$(foreach var,$(DVBV3CHANNELFILES), $(DVBFORMATCONVERT) $(DVBFORMATCONVERT_CHANNEL_DVBV3) $(var) $(DVBV3OUTPUTDIR)/$(var);)
+$(DVBV3OUTPUTFILES): $(DVBV3OUTPUTDIR)/%: %
+	@$(MKDIR) "$(dir $@)"
+	@$(DVBFORMATCONVERT) $(DVBFORMATCONVERT_CHANNEL_DVBV3) "$<" "$@"
 
+$(DVBV5OUTPUTFILES): $(DVBV5OUTPUTDIR)/%: $(DVBV3OUTPUTDIR)/%
+	@$(MKDIR) "$(dir $@)"
+	@$(DVBFORMATCONVERT) $(DVBFORMATCONVERT_CHANNEL_DVBV5) "$<" "$@"
 
-dvbv5: $(DVBV3OUTPUTDIR)
-	@$(foreach var,$(DVBV3DIRS), $(MKDIR) $(DVBV5OUTPUTDIR)/$(var);)
-	@$(foreach var,$(DVBV3CHANNELFILES), $(DVBFORMATCONVERT) $(DVBFORMATCONVERT_CHANNEL_DVBV5) $(DVBV3OUTPUTDIR)/$(var) $(DVBV5OUTPUTDIR)/$(var);)
+dvbv3: $(DVBV3OUTPUTFILES)
+dvbv5: $(DVBV5OUTPUTFILES)
 
 install:
 	@mkdir -p $(DATADIR)/$(DVBV5DIR)
-- 
2.21.0

