Return-Path: <SRS0=7UeB=VA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A369BC06513
	for <linux-media@archiver.kernel.org>; Wed,  3 Jul 2019 14:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E2921881
	for <linux-media@archiver.kernel.org>; Wed,  3 Jul 2019 14:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfGCOMP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:12:15 -0400
Received: from gofer.mess.org ([88.97.38.141]:41179 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfGCOMO (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 3 Jul 2019 10:12:14 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 0B25561A6D; Wed,  3 Jul 2019 15:12:12 +0100 (BST)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Cc:     Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v4l-utils 2/2] gen_keytables.pl: remove duplicate scancodes from keymap
Date:   Wed,  3 Jul 2019 15:12:12 +0100
Message-Id: <20190703141212.31719-2-sean@mess.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190703141212.31719-1-sean@mess.org>
References: <20190703141212.31719-1-sean@mess.org>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

One scancode can only be mapped to one keycode. In addition, the
toml is invalid so the keymap cannot be loaded.

Cc: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Sean Young <sean@mess.org>
---
 utils/keytable/gen_keytables.pl | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/utils/keytable/gen_keytables.pl b/utils/keytable/gen_keytables.pl
index 8f3a87e6..c14aded3 100755
--- a/utils/keytable/gen_keytables.pl
+++ b/utils/keytable/gen_keytables.pl
@@ -76,6 +76,7 @@ sub parse_file($$)
 	my $legacy = shift;
 
 	my $num_tables = 0;
+	my %scancodes = ();
 	$warn = 0;
 
 	next if ($filename =~ m/\.mod.c/);
@@ -101,6 +102,7 @@ sub parse_file($$)
 			$keyname =~ s/_table$//;
 			$read = 1;
 			$num_tables++;
+			%scancodes = ();
 			next;
 		}
 		if (m/struct\s+rc_map_list.*=\s+{/) {
@@ -142,7 +144,15 @@ sub parse_file($$)
 
 		if ($read) {
 			if (m/(0x[\dA-Fa-f]+)[\s\,]+(KEY|BTN)(\_[^\s\,\}]+)/) {
-				$out .= "$1 = \"$2$3\"\n";
+				my $scancode = hex($1);
+				my $keycode = "$2$3";
+
+				if (exists($scancodes{$scancode})) {
+					printf STDERR "WARNING: duplicate scancode $1 in file $filename, set to $keycode and $scancodes{$scancode}\n";
+				} else {
+					$out .= "$1 = \"$keycode\"\n";
+					$scancodes{$scancode} = $keycode;
+				}
 				next;
 			}
 			if (m/\}/) {
-- 
2.21.0

