Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E233C433EF
	for <linux-media@archiver.kernel.org>; Wed, 15 Sep 2021 16:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4453C60EB4
	for <linux-media@archiver.kernel.org>; Wed, 15 Sep 2021 16:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhIOQcl (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 15 Sep 2021 12:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhIOQcl (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 15 Sep 2021 12:32:41 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB09C061574
        for <linux-media@vger.kernel.org>; Wed, 15 Sep 2021 09:31:22 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id AAFA9C63A9; Wed, 15 Sep 2021 17:31:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1631723478; bh=bflhMbhXIMiF1waA1MPECT/hZZcAIFdG8DPXVY32H+M=;
        h=From:To:Cc:Subject:Date:From;
        b=J5VRcZ2MndD7gCoTmsA89QhjeJxCYS29diQGqjH0bzLHDPSF0X1DLbyYo2X1nP14D
         1MuYgvQQpZdKmlXSVGCpKubgZlDdPq4iagSBRazkF3slGarO8OuI/qJzRty3DOy7Vu
         DzBII3hXhAosJsAjqf1Tay7puyR5tDDRLvJ+XgANVjEEKJxl2ctpKPkCGiBvnhoCVU
         8lEXr3EZq6q4CSAYv1tRNtuKOabqcFIv7OjYL7thgY53kzKA79ycUAsc0fXusoB674
         pnWoRsvkv6U6ppbxhsAiNYExj0EIQL55wQJ+n/g/mEVgzIyKH9lhjDYISXeaLa97C4
         FRRwjOoLdchjw==
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Cc:     Norman Rasmussen <norman@rasmussen.co.za>
Subject: [PATCH v4l-utils] ir-ctl: increase the size of the buffer used to read raw files
Date:   Wed, 15 Sep 2021 17:31:18 +0100
Message-Id: <20210915163118.18216-1-sean@mess.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Air conditioner codes typically have 100 pulse/space pairs (12 bytes +
headers). The resulting raw IR line length is 1063, which exceeds the
current 1024 byte buffer, and results in an error trying to parse the
line.

The buffers used to read pulse/space files are significantly larger than
needed so this decreases their size, and allocates the difference to the
buffer used to read raw IR files in order to keep the total size of
buffers the same.

Signed-off-by: Norman Rasmussen <norman@rasmussen.co.za>
Signed-off-by: Sean Young <sean@mess.org>
---
 utils/ir-ctl/ir-ctl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/utils/ir-ctl/ir-ctl.c b/utils/ir-ctl/ir-ctl.c
index 3c3bcca1..34cde11e 100644
--- a/utils/ir-ctl/ir-ctl.c
+++ b/utils/ir-ctl/ir-ctl.c
@@ -60,6 +60,8 @@
 #define LIRCBUF_SIZE 1024
 #define IR_DEFAULT_TIMEOUT 125000
 #define UNSET UINT32_MAX
+/* Maximum number of columns per line */
+#define LINE_SIZE 8192
 
 const char *argp_program_version = "IR ctl version " V4L_UTILS_VERSION;
 const char *argp_program_bug_address = "Sean Young <sean@mess.org>";
@@ -211,7 +213,7 @@ static struct send *read_file_pulse_space(struct arguments *args, const char *fn
 {
 	bool expect_pulse = true;
 	int lineno = 0, lastspace = 0;
-	char line[1024];
+	char line[LINE_SIZE];
 	int len = 0;
 	static const char whitespace[] = " \n\r\t";
 	struct send *f;
@@ -380,7 +382,7 @@ static struct send *read_file_pulse_space(struct arguments *args, const char *fn
 static struct send *read_file_raw(struct arguments *args, const char *fname, FILE *input)
 {
 	int lineno = 0, lastspace = 0;
-	char line[1024];
+	char line[LINE_SIZE];
 	int len = 0;
 	static const char whitespace[] = " \n\r\t,";
 	struct send *f;
@@ -474,7 +476,7 @@ static struct send *read_file_raw(struct arguments *args, const char *fname, FIL
 static struct send *read_file(struct arguments *args, const char *fname)
 {
 	FILE *input = fopen(fname, "r");
-	char line[1024];
+	char line[LINE_SIZE];
 
 	if (!input) {
 		fprintf(stderr, _("%s: could not open: %m\n"), fname);
-- 
2.31.1

