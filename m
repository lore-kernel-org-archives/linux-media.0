Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E31C282DF
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 08:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD51E20880
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 08:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfDHIqO (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:46:14 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53005 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfDHIqL (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 04:46:11 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hDPus-00075y-1g
        for linux-media@vger.kernel.org; Mon, 08 Apr 2019 10:46:10 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Subject: [PATCH v4l-utils 2/2] v4l2-compliance: add colors
Date:   Mon,  8 Apr 2019 10:45:58 +0200
Message-Id: <20190408084558.2979-3-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408084558.2979-1-p.zabel@pengutronix.de>
References: <20190408084558.2979-1-p.zabel@pengutronix.de>
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

If the output is a terminal, use color codes to mark OK, warn, and
FAIL messages with green, bold, and bright red accents, respectively.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 utils/v4l2-compliance/v4l2-compliance.cpp | 11 ++++++++---
 utils/v4l2-compliance/v4l2-compliance.h   | 15 ++++++++++++---
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/utils/v4l2-compliance/v4l2-compliance.cpp b/utils/v4l2-compliance/v4l2-compliance.cpp
index f7611d75cb1b..488e746d055d 100644
--- a/utils/v4l2-compliance/v4l2-compliance.cpp
+++ b/utils/v4l2-compliance/v4l2-compliance.cpp
@@ -89,6 +89,7 @@ static int grand_total, grand_ok, grand_warnings;
 bool show_info;
 bool no_progress;
 bool show_warnings = true;
+bool show_colors;
 bool exit_on_fail;
 bool exit_on_warn;
 bool is_vivid;
@@ -250,15 +251,17 @@ const char *ok(int res)
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
@@ -1630,6 +1633,8 @@ int main(int argc, char **argv)
 	bool direct = !options[OptUseWrapper];
 	int fd;
 
+	show_colors = isatty(STDOUT_FILENO);
+
 	if (type == MEDIA_TYPE_UNKNOWN)
 		type = mi_media_detect_type(device.c_str());
 	if (type == MEDIA_TYPE_CANT_STAT) {
diff --git a/utils/v4l2-compliance/v4l2-compliance.h b/utils/v4l2-compliance/v4l2-compliance.h
index f7e1ea5d7124..7909c3822cd0 100644
--- a/utils/v4l2-compliance/v4l2-compliance.h
+++ b/utils/v4l2-compliance/v4l2-compliance.h
@@ -52,6 +52,7 @@
 extern bool show_info;
 extern bool show_warnings;
 extern bool no_progress;
+extern bool show_colors;
 extern bool exit_on_fail;
 extern bool exit_on_warn;
 extern bool is_vivid; // We're testing the vivid driver
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

