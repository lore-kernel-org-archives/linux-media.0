Return-Path: <SRS0=lJ6v=AW=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E95C433E1
	for <linux-media@archiver.kernel.org>; Sat, 11 Jul 2020 05:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55BB220720
	for <linux-media@archiver.kernel.org>; Sat, 11 Jul 2020 05:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="h5/w4tXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgGKFYb (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 11 Jul 2020 01:24:31 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:41174 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgGKFYb (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 11 Jul 2020 01:24:31 -0400
Received: from pyrite.rasen.tech (unknown [IPv6:2400:4051:61:600:2c71:1b79:d06d:5032])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 420B272C;
        Sat, 11 Jul 2020 07:24:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594445068;
        bh=FQOD3dys9oUJGL7BVMiDHKD6tDhGGpN2w1Aq1iBNmF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h5/w4tXaLAdwk+a3Rcp2IuRfdaVBWdLBXmfHmkETh2pmsRdYi56FmC22SUHRlmgDO
         qbQQx3vXG1Z5Q2LoAxAZKpqZDQ9BbQGj0MIp5vA44GeEX6+fMWsE4A588dOLS9Ct92
         uPdHiL8MStj2lUyFLpsoec9GvMQz2SqLYwsZgg1k=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        laurent.pinchart@ideasonboard.com, hverkuil@xs4all.nl
Subject: [PATCH v3 2/6] v4l2-ctl: Add version command
Date:   Sat, 11 Jul 2020 14:24:10 +0900
Message-Id: <20200711052414.492535-2-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200711052414.492535-1-paul.elder@ideasonboard.com>
References: <20200711052414.492535-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add a --version option to v4l2-ctl to retrieve the version of v4l2-ctl.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

---
Changes in v3:
- embed PACKAGE_VERSION instead of string concatenation
---
 utils/v4l2-ctl/v4l2-ctl-common.cpp | 1 +
 utils/v4l2-ctl/v4l2-ctl.cpp        | 9 +++++++++
 utils/v4l2-ctl/v4l2-ctl.h          | 1 +
 3 files changed, 11 insertions(+)

diff --git a/utils/v4l2-ctl/v4l2-ctl-common.cpp b/utils/v4l2-ctl/v4l2-ctl-common.cpp
index 47f5da1a..9b785cbf 100644
--- a/utils/v4l2-ctl/v4l2-ctl-common.cpp
+++ b/utils/v4l2-ctl/v4l2-ctl-common.cpp
@@ -121,6 +121,7 @@ void common_usage()
 	       "  --silent           only set the result code, do not print any messages\n"
 	       "  --sleep <secs>     sleep <secs>, call QUERYCAP and close the file handle\n"
 	       "  --verbose          turn on verbose ioctl status reporting\n"
+	       "  --version          show version information\n"
 	       );
 }
 
diff --git a/utils/v4l2-ctl/v4l2-ctl.cpp b/utils/v4l2-ctl/v4l2-ctl.cpp
index 4972591e..ac66b814 100644
--- a/utils/v4l2-ctl/v4l2-ctl.cpp
+++ b/utils/v4l2-ctl/v4l2-ctl.cpp
@@ -284,6 +284,7 @@ static struct option long_options[] = {
 	{"stream-out-user", optional_argument, 0, OptStreamOutUser},
 	{"stream-out-dmabuf", no_argument, 0, OptStreamOutDmaBuf},
 	{"list-patterns", no_argument, 0, OptListPatterns},
+	{"version", no_argument, 0, OptVersion},
 	{0, 0, 0, 0}
 };
 
@@ -306,6 +307,11 @@ static void usage_all()
        edid_usage();
 }
 
+static void version()
+{
+	printf("v4l2-ctl %s\n", PACKAGE_VERSION);
+}
+
 int test_ioctl(int fd, unsigned long cmd, void *arg)
 {
 	return options[OptUseWrapper] ? v4l2_ioctl(fd, cmd, arg) : ioctl(fd, cmd, arg);
@@ -1245,6 +1251,9 @@ int main(int argc, char **argv)
 		case OptSleep:
 			secs = strtoul(optarg, 0L, 0);
 			break;
+		case OptVersion:
+			version();
+			return 0;
 		case ':':
 			fprintf(stderr, "Option '%s' requires a value\n",
 					argv[optind]);
diff --git a/utils/v4l2-ctl/v4l2-ctl.h b/utils/v4l2-ctl/v4l2-ctl.h
index 28e50471..27a3ca35 100644
--- a/utils/v4l2-ctl/v4l2-ctl.h
+++ b/utils/v4l2-ctl/v4l2-ctl.h
@@ -263,6 +263,7 @@ enum Option {
 	OptHelpStreaming,
 	OptHelpEdid,
 	OptHelpAll,
+	OptVersion,
 	OptLast = 512
 };
 
-- 
2.27.0

