Return-Path: <SRS0=uXYw=U6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1142AC06511
	for <linux-media@archiver.kernel.org>; Mon,  1 Jul 2019 16:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73BD21473
	for <linux-media@archiver.kernel.org>; Mon,  1 Jul 2019 16:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfGAQiR (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Jul 2019 12:38:17 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:42267 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729264AbfGAQiR (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 1 Jul 2019 12:38:17 -0400
X-Originating-IP: 83.155.44.161
Received: from classic.redhat.com (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id B8A551C0007
        for <linux-media@vger.kernel.org>; Mon,  1 Jul 2019 16:38:15 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-media@vger.kernel.org
Subject: [PATCH 2/2] keytable: Remove comments before processing keymaps
Date:   Mon,  1 Jul 2019 18:38:13 +0200
Message-Id: <20190701163813.25032-2-hadess@hadess.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190701163813.25032-1-hadess@hadess.net>
References: <20190701163813.25032-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Do our best to remove comments from each line we process from the keymap
sources, so as to avoid commented duplicates and false positives
sneaking in to the keymap definitions.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 utils/keytable/gen_keytables.pl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/utils/keytable/gen_keytables.pl b/utils/keytable/gen_keytables.pl
index 3dc74ba6..d73daf58 100755
--- a/utils/keytable/gen_keytables.pl
+++ b/utils/keytable/gen_keytables.pl
@@ -138,6 +138,9 @@ sub parse_file($$)
 		}
 
 		if ($read) {
+			# Remove comments
+			~ s#/\*.*?\*/##sg;
+			~ s#.*\*/##sg;
 			if (m/(0x[\dA-Fa-f]+)[\s\,]+(KEY|BTN)(\_[^\s\,\}]+)/) {
 				$out .= "$1 = \"$2$3\"\n";
 				next;
-- 
2.21.0

