Return-Path: <SRS0=ytLV=SL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD34C282CE
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 14:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B4C2064B
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 14:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfDIOuH (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:50:07 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59137 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfDIOuF (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 9 Apr 2019 10:50:05 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hDs4Z-0005vk-EP
        for linux-media@vger.kernel.org; Tue, 09 Apr 2019 16:50:03 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Subject: [PATCH v4l-utils v2 2/4] v4l2-compliance: add colors
Date:   Tue,  9 Apr 2019 16:49:56 +0200
Message-Id: <20190409144958.31233-3-p.zabel@pengutronix.de>
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
 utils/v4l2-compliance/v4l2-compliance.1.in |  5 +++
 utils/v4l2-compliance/v4l2-compliance.cpp  | 37 ++++++++++++++++++++--
 utils/v4l2-compliance/v4l2-compliance.h    | 15 +++++++--
 3 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/utils/v4l2-compliance/v4l2-compliance.1.in b/utils/v4l2-compliance/v4l2-compliance.1.in
index 77b84ba6022f..39f0229d7af1 100644
--- a/utils/v4l2-compliance/v4l2-compliance.1.in
+++ b/utils/v4l2-compliance/v4l2-compliance.1.in
@@ -167,6 +167,11 @@ signal is present on all inputs or that all outputs are hooked up.
 Exit this application when the first failure occurs instead of continuing
 with a possible inconsistent state.
 .TP
+\fB\-C\fR, \fB\-\-color\fR \fI<when>\fR
+Highlight OK/warn/fail/FAIL strings with colors. OK is marked green, warn is
+marked bold, and fail/FAIL are marked bright red if enabled. \fI<when>\fR can
+be \fIalways\fR, \fInever\fR, or \fIauto\fR (the default).
+.TP
 \fB\-n\fR, \fB\-\-no\-warnings\fR
 Turn off warning messages. They are still counted in the summary, but you won't see them.
 .TP
diff --git a/utils/v4l2-compliance/v4l2-compliance.cpp b/utils/v4l2-compliance/v4l2-compliance.cpp
index f7611d75cb1b..e5bafc0738ea 100644
--- a/utils/v4l2-compliance/v4l2-compliance.cpp
+++ b/utils/v4l2-compliance/v4l2-compliance.cpp
@@ -54,6 +54,7 @@
 enum Option {
 	OptStreamAllIO = 'a',
 	OptStreamAllColorTest = 'c',
+	OptColor = 'C',
 	OptSetDevice = 'd',
 	OptSetExpBufDevice = 'e',
 	OptExitOnFail = 'E',
@@ -89,6 +90,7 @@ static int grand_total, grand_ok, grand_warnings;
 bool show_info;
 bool no_progress;
 bool show_warnings = true;
+bool show_colors;
 bool exit_on_fail;
 bool exit_on_warn;
 bool is_vivid;
@@ -135,6 +137,7 @@ static struct option long_options[] = {
 	{"media-bus-info", required_argument, 0, OptMediaBusInfo},
 	{"help", no_argument, 0, OptHelp},
 	{"verbose", no_argument, 0, OptVerbose},
+	{"color", required_argument, 0, OptColor},
 	{"no-warnings", no_argument, 0, OptNoWarnings},
 	{"no-progress", no_argument, 0, OptNoProgress},
 	{"exit-on-fail", no_argument, 0, OptExitOnFail},
@@ -234,6 +237,8 @@ static void usage(void)
 	printf("                     then this defaults to 90%%.\n");
 	printf("  -E, --exit-on-fail Exit on the first fail.\n");
 	printf("  -h, --help         Display this help message.\n");
+	printf("  -C, --color <when> Highlight OK/warn/fail/FAIL strings with colors\n");
+	printf("                     <when> can be set to always, never, or auto (the default)\n");
 	printf("  -n, --no-warnings  Turn off warning messages.\n");
 	printf("  -P, --no-progress  Turn off progress messages.\n");
 	printf("  -T, --trace        Trace all called ioctls.\n");
@@ -250,15 +255,17 @@ const char *ok(int res)
 	static char buf[100];
 
 	if (res == ENOTTY) {
-		strcpy(buf, "OK (Not Supported)");
+		strcpy(buf, show_colors ?
+		       COLOR_GREEN("OK") " (Not Supported)" :
+		       "OK (Not Supported)");
 		res = 0;
 	} else {
-		strcpy(buf, "OK");
+		strcpy(buf, show_colors ? COLOR_GREEN("OK") : "OK");
 	}
 	tests_total++;
 	if (res) {
 		app_result = res;
-		sprintf(buf, "FAIL");
+		sprintf(buf, show_colors ? COLOR_RED("FAIL") : "FAIL");
 	} else {
 		tests_ok++;
 	}
@@ -1432,6 +1439,7 @@ int main(int argc, char **argv)
 	media_type type = MEDIA_TYPE_UNKNOWN;
 	struct node expbuf_node;
 	std::string media_bus_info;
+	const char *env_media_apps_color = getenv("MEDIA_APPS_COLOR");
 
 	/* command args */
 	int ch;
@@ -1461,6 +1469,17 @@ int main(int argc, char **argv)
 		printf("Running on 2.6.%d\n", kernel_version);
 	printf("\n");
 
+	if (!env_media_apps_color || !strcmp(env_media_apps_color, "auto"))
+		show_colors = isatty(STDOUT_FILENO);
+	else if (!strcmp(env_media_apps_color, "always"))
+		show_colors = true;
+	else if (!strcmp(env_media_apps_color, "never"))
+		show_colors = false;
+	else {
+		fprintf(stderr,
+			"v4l2-compliance: invalid value for MEDIA_APPS_COLOR environment variable\n");
+	}
+
 	for (i = 0; long_options[i].name; i++) {
 		if (!isalpha(long_options[i].val))
 			continue;
@@ -1591,6 +1610,18 @@ int main(int argc, char **argv)
 				}
 			}
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
diff --git a/utils/v4l2-compliance/v4l2-compliance.h b/utils/v4l2-compliance/v4l2-compliance.h
index f7e1ea5d7124..152a6c6d9c76 100644
--- a/utils/v4l2-compliance/v4l2-compliance.h
+++ b/utils/v4l2-compliance/v4l2-compliance.h
@@ -50,6 +50,7 @@
 #endif
 
 extern bool show_info;
+extern bool show_colors;
 extern bool show_warnings;
 extern bool no_progress;
 extern bool exit_on_fail;
@@ -185,17 +186,24 @@ private:
 	std::set<int> fhs;
 };
 
+#define COLOR_GREEN(s) "\033[32m" s "\033[0m"
+#define COLOR_RED(s) "\033[1;31m" s "\033[0m"
+#define COLOR_BOLD(s) "\033[1m" s "\033[0m"
+
 #define info(fmt, args...) 					\
 	do {							\
 		if (show_info)					\
- 			printf("\t\tinfo: " fmt, ##args);	\
+			printf("\t\tinfo: " fmt, ##args);	\
 	} while (0)
 
 #define warn(fmt, args...) 					\
 	do {							\
 		warnings++;					\
 		if (show_warnings)				\
- 			printf("\t\twarn: %s(%d): " fmt, __FILE__, __LINE__, ##args);	\
+			printf("\t\t%s: %s(%d): " fmt,		\
+			       show_colors ?			\
+			       COLOR_BOLD("warn") : "warn",	\
+			       __FILE__, __LINE__, ##args);	\
 		if (exit_on_warn)				\
 			exit(1);				\
 	} while (0)
@@ -218,7 +226,8 @@ private:
 
 #define fail(fmt, args...) 						\
 ({ 									\
- 	printf("\t\tfail: %s(%d): " fmt, __FILE__, __LINE__, ##args);	\
+	printf("\t\t%s: %s(%d): " fmt, show_colors ?			\
+	       COLOR_RED("fail") : "fail", __FILE__, __LINE__, ##args);	\
 	if (exit_on_fail)						\
 		exit(1);						\
 	1;								\
-- 
2.20.1

