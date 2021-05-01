Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEB0C433B4
	for <linux-media@archiver.kernel.org>; Sat,  1 May 2021 08:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12AEF61418
	for <linux-media@archiver.kernel.org>; Sat,  1 May 2021 08:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbhEAIxB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 1 May 2021 04:53:01 -0400
Received: from gofer.mess.org ([88.97.38.141]:42799 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230117AbhEAIxB (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sat, 1 May 2021 04:53:01 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 94F7EC6470; Sat,  1 May 2021 09:52:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1619859130; bh=QAAo2FxOPXt0CxUB/t/KydtbBVC/yjbVs63LzgBeea8=;
        h=From:To:Subject:Date:From;
        b=KewubVU3V1RWD1DeP/ECh5Tj8Qr6UHW9bWGsVKT4CzZIRLv0qFh3z2c7HFa4cIds8
         mZpwJYXX+/iKKVP2sOc/99Dbj0Py8r9P9/cKhpLKrE4nR+IkhtrDhIOdF+hU8YlXNr
         tzhA0Y6mtTuwORCrj4J/j0pZusouw0hGJrd1xhVdDXRL7PttIGCgNDTOg1Gz7e7t4Y
         HCDGuld8cRJzkEFvDVaVbQ4AQfu4pWZWIo114ISp4zlC6j3CFYAHjJSxD+Tq2ZC1KE
         Bn63Shk61dNRXQLSUeEKDtILeEHLJwVZWNh/mviqLNvJS1wOY3OUNRHWw66doJ3o3o
         KjSZsEqti0CvQ==
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Subject: [PATCH] ir-ctl: include timeout in raw IR and parse timeout in pulse-space file
Date:   Sat,  1 May 2021 09:52:10 +0100
Message-Id: <20210501085210.22343-1-sean@mess.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Signed-off-by: Sean Young <sean@mess.org>
---
 utils/ir-ctl/ir-ctl.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/utils/ir-ctl/ir-ctl.c b/utils/ir-ctl/ir-ctl.c
index bae16050..3c3bcca1 100644
--- a/utils/ir-ctl/ir-ctl.c
+++ b/utils/ir-ctl/ir-ctl.c
@@ -314,7 +314,7 @@ static struct send *read_file_pulse_space(struct arguments *args, const char *fn
 			continue;
 		}
 
-		if (strcmp(keyword, "space") == 0) {
+		if (!strcmp(keyword, "space") || !strcmp(keyword, "timeout")) {
 			if (arg == 0) {
 				fprintf(stderr, _("warning: %s:%d: invalid argument to space '%d'\n"), fname, lineno, arg);
 				continue;
@@ -331,7 +331,7 @@ static struct send *read_file_pulse_space(struct arguments *args, const char *fn
 			}
 			lastspace = lineno;
 			expect_pulse = true;
-		} else if (strcmp(keyword, "pulse") == 0) {
+		} else if (!strcmp(keyword, "pulse")) {
 			if (arg == 0) {
 				fprintf(stderr, _("warning: %s:%d: invalid argument to pulse '%d'\n"), fname, lineno, arg);
 				continue;
@@ -341,7 +341,7 @@ static struct send *read_file_pulse_space(struct arguments *args, const char *fn
 			else
 				f->buf[len++] = arg;
 			expect_pulse = false;
-		} else if (strcmp(keyword, "carrier") == 0) {
+		} else if (!strcmp(keyword, "carrier")) {
 			if (f->carrier != UNSET && f->carrier != arg) {
 				fprintf(stderr, _("warning: %s:%d: carrier already specified\n"), fname, lineno);
 			} else {
@@ -1200,10 +1200,9 @@ int lirc_receive(struct arguments *args, int fd, unsigned features)
 			} else {
 				switch (msg) {
 				case LIRC_MODE2_TIMEOUT:
+					fprintf(out, "-%u\n", val);
 					if (carrier)
-						fprintf(out, "# carrier %uHz, timeout %u\n", carrier, val);
-					else
-						fprintf(out, "# timeout %u\n", val);
+						fprintf(out, " # carrier %uHz, timeout %u\n", carrier, val);
 					leading_space = true;
 					carrier = 0;
 					break;
-- 
2.31.1

