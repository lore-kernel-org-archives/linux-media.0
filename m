Return-Path: <SRS0=ytLV=SL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F714C282DE
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 14:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F372064B
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 14:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfDIOuF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:50:05 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58419 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfDIOuF (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 9 Apr 2019 10:50:05 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hDs4Z-0005vk-Gm
        for linux-media@vger.kernel.org; Tue, 09 Apr 2019 16:50:03 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Subject: [PATCH v4l-utils v2 4/4] cec-compliance: add colors
Date:   Tue,  9 Apr 2019 16:49:58 +0200
Message-Id: <20190409144958.31233-5-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409144958.31233-1-p.zabel@pengutronix.de>
References: <20190409144958.31233-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Use color codes to mark OK, warn, and FAIL messages with green, bold,
and bright red accents, respectively.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 utils/cec-compliance/cec-compliance.1.in |  5 +++
 utils/cec-compliance/cec-compliance.cpp  | 42 +++++++++++++++++++++---
 utils/cec-compliance/cec-compliance.h    | 12 +++++--
 3 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/utils/cec-compliance/cec-compliance.1.in b/utils/cec-compliance/cec-compliance.1.in
index 205561f186e1..fa96fb01b1e9 100644
--- a/utils/cec-compliance/cec-compliance.1.in
+++ b/utils/cec-compliance/cec-compliance.1.in
@@ -106,6 +106,11 @@ Exit this application when the first warning occurs instead of continuing.
 \fB\-s\fR, \fB\-\-skip\-info\fR
 Skip the Driver Info output section.
 .TP
+\fB\-C\fR, \fB\-\-color\fR \fI<when>\fR
+Highlight OK/warn/fail/FAIL strings with colors. OK is marked green, warn is
+marked bold, and fail/FAIL are marked bright red if enabled. \fI<when>\fR can
+be \fIalways\fR, \fInever\fR, or \fIauto\fR (the default).
+.TP
 \fB\-n\fR, \fB\-\-no\-warnings\fR
 Turn off warning messages.
 .TP
diff --git a/utils/cec-compliance/cec-compliance.cpp b/utils/cec-compliance/cec-compliance.cpp
index 1f70adef0d3f..3818ce583d0f 100644
--- a/utils/cec-compliance/cec-compliance.cpp
+++ b/utils/cec-compliance/cec-compliance.cpp
@@ -36,6 +36,7 @@
 enum Option {
 	OptSetAdapter = 'a',
 	OptTestAdapter = 'A',
+	OptColor = 'C',
 	OptSetDevice = 'd',
 	OptSetDriver = 'D',
 	OptExitOnFail = 'E',
@@ -101,6 +102,7 @@ static int app_result;
 static int tests_total, tests_ok;
 
 bool show_info;
+bool show_colors;
 bool show_warnings = true;
 bool exit_on_fail;
 bool exit_on_warn;
@@ -120,6 +122,7 @@ static struct option long_options[] = {
 	{"timeout", required_argument, 0, OptTimeout},
 	{"trace", no_argument, 0, OptTrace},
 	{"verbose", no_argument, 0, OptVerbose},
+	{"color", required_argument, 0, OptColor},
 	{"skip-info", no_argument, 0, OptSkipInfo},
 	{"wall-clock", no_argument, 0, OptWallClock},
 	{"interactive", no_argument, 0, OptInteractive},
@@ -211,6 +214,8 @@ static void usage(void)
 	       "\n"
 	       "  -E, --exit-on-fail Exit on the first fail.\n"
 	       "  -h, --help         Display this help message\n"
+	       "  -C, --color <when> Highlight OK/warn/fail/FAIL strings with colors\n"
+	       "                     <when> can be set to always, never, or auto (the default)\n"
 	       "  -n, --no-warnings  Turn off warning messages\n"
 	       "  -s, --skip-info    Skip Driver Info output\n"
 	       "  -T, --trace        Trace all called ioctls\n"
@@ -726,20 +731,23 @@ const char *ok(int res)
 	static char buf[100];
 
 	if (res == NOTSUPPORTED) {
-		strcpy(buf, "OK (Not Supported)");
+		strcpy(buf, show_colors ? COLOR_GREEN("OK") " (Not Supported)" :
+		       "OK (Not Supported)");
 		res = 0;
 	} else if (res == PRESUMED_OK) {
-		strcpy(buf, "OK (Presumed)");
+		strcpy(buf, show_colors ? COLOR_GREEN("OK") " (Presumed)" :
+		       "OK (Presumed)");
 		res = 0;
 	} else if (res == REFUSED) {
-		strcpy(buf, "OK (Refused)");
+		strcpy(buf, show_colors ? COLOR_GREEN("OK") " (Refused)" :
+		       "OK (Refused)");
 		res = 0;
 	} else
-		strcpy(buf, "OK");
+		strcpy(buf, show_colors ? COLOR_GREEN("OK") : "OK");
 	tests_total++;
 	if (res) {
 		app_result = res;
-		sprintf(buf, "FAIL");
+		sprintf(buf, show_colors ? COLOR_RED("FAIL") : "FAIL");
 	} else {
 		tests_ok++;
 	}
@@ -1056,6 +1064,18 @@ int main(int argc, char **argv)
 	int fd = -1;
 	int ch;
 	int i;
+	const char *env_media_apps_color = getenv("MEDIA_APPS_COLOR");
+
+	if (!env_media_apps_color || !strcmp(env_media_apps_color, "auto"))
+		show_colors = isatty(STDOUT_FILENO);
+	else if (!strcmp(env_media_apps_color, "always"))
+		show_colors = true;
+	else if (!strcmp(env_media_apps_color, "never"))
+		show_colors = false;
+	else {
+		fprintf(stderr,
+			"cec-compliance: invalid value for MEDIA_APPS_COLOR environment variable\n");
+	}
 
 	for (i = 0; long_options[i].name; i++) {
 		if (!isalpha(long_options[i].val))
@@ -1115,6 +1135,18 @@ int main(int argc, char **argv)
 		case OptTimeout:
 			long_timeout = strtoul(optarg, NULL, 0);
 			break;
+		case OptColor:
+			if (!strcmp(optarg, "always"))
+				show_colors = true;
+			else if (!strcmp(optarg, "never"))
+				show_colors = false;
+			else if (!strcmp(optarg, "auto"))
+				show_colors = isatty(STDOUT_FILENO);
+			else {
+				usage();
+				exit(1);
+			}
+			break;
 		case OptNoWarnings:
 			show_warnings = false;
 			break;
diff --git a/utils/cec-compliance/cec-compliance.h b/utils/cec-compliance/cec-compliance.h
index 2ebf2d5d9027..d7460b6244e2 100644
--- a/utils/cec-compliance/cec-compliance.h
+++ b/utils/cec-compliance/cec-compliance.h
@@ -111,6 +111,7 @@ struct short_audio_desc {
 #define SAD_EXT_TYPE_LPCM_3D_AUDIO		13
 
 extern bool show_info;
+extern bool show_colors;
 extern bool show_warnings;
 extern bool exit_on_fail;
 extern bool exit_on_warn;
@@ -192,6 +193,10 @@ struct remote_subtest {
 #define cec_phys_addr_exp(pa) \
 	((pa) >> 12), ((pa) >> 8) & 0xf, ((pa) >> 4) & 0xf, (pa) & 0xf
 
+#define COLOR_GREEN(s) "\033[32m" s "\033[0m"
+#define COLOR_RED(s) "\033[1;31m" s "\033[0m"
+#define COLOR_BOLD(s) "\033[1m" s "\033[0m"
+
 #define info(fmt, args...) 					\
 	do {							\
 		if (show_info)					\
@@ -218,7 +223,9 @@ struct remote_subtest {
 ({									\
 	warnings++;							\
 	if (show_warnings)						\
-		printf("\t\twarn: %s(%d): " fmt, __FILE__, __LINE__, ##args);	\
+		printf("\t\%s: %s(%d): " fmt,				\
+		       show_colors ? COLOR_BOLD("warn") : "warn",	\
+		       __FILE__, __LINE__, ##args);			\
 	if (exit_on_warn)						\
 		exit(1);						\
 	0;								\
@@ -236,7 +243,8 @@ struct remote_subtest {
 
 #define fail(fmt, args...) 						\
 ({ 									\
-	printf("\t\tfail: %s(%d): " fmt, __FILE__, __LINE__, ##args);	\
+	printf("\t\t%s: %s(%d): " fmt, show_colors ?			\
+	       COLOR_RED("fail") : "fail", __FILE__, __LINE__, ##args);	\
 	if (exit_on_fail)						\
 		exit(1);						\
 	FAIL;								\
-- 
2.20.1

