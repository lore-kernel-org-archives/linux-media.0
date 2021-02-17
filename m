Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C9AC433E0
	for <linux-media@archiver.kernel.org>; Wed, 17 Feb 2021 18:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E92064E42
	for <linux-media@archiver.kernel.org>; Wed, 17 Feb 2021 18:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbhBQSMz (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 17 Feb 2021 13:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbhBQSMv (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 17 Feb 2021 13:12:51 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B851C061574;
        Wed, 17 Feb 2021 10:12:09 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id 0A2E91F45514
From:   Helen Koike <helen.koike@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, kernel@collabora.com,
        linux-kernel@vger.kernel.org,
        Helen Koike <helen.koike@collabora.com>
Subject: [PATCH] test-media: wrap vivid code around $vivid variable
Date:   Wed, 17 Feb 2021 15:11:57 -0300
Message-Id: <20210217181157.28285-1-helen.koike@collabora.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The script was trying to load vivid and run some commands on top of it
even when $vivid = 0.
Wrap all vivid code under $vivid variable.

Signed-off-by: Helen Koike <helen.koike@collabora.com>
---
 contrib/test/test-media | 66 ++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/contrib/test/test-media b/contrib/test/test-media
index 10b7e89d..8cd8bc37 100755
--- a/contrib/test/test-media
+++ b/contrib/test/test-media
@@ -146,29 +146,29 @@ if [ $kmemleak -eq 1 ]; then
 	echo clear >/sys/kernel/debug/kmemleak
 fi
 
-rmmod vivid 2&>/dev/null
-modprobe vivid n_devs=3 multiplanar=1,2,2 cache_hints=1,0,0 #allocators=0,1,1
-sleep 1
+if [ $vivid -eq 1 ]; then
+	rmmod vivid 2&>/dev/null
+	modprobe vivid n_devs=3 multiplanar=1,2,2 cache_hints=1,0,0 #allocators=0,1,1
+	sleep 1
 
-tmp=`mktemp`
+	tmp=`mktemp`
 
-if ! $v4l2_ctl -z platform:vivid-002 -d vivid-002-vid-cap ; then
-	echo "FAIL: the vivid module failed to load" | tee -a $tmp
-	echo "Grand Total for vivid: Succeeded: 0, Failed: 1, Warnings: 0" | tee -a $tmp
-	echo "Final Summary: 1, Succeeded: 0, Failed: 1, Warnings: 0"
-	exit 0
-fi
+	if ! $v4l2_ctl -z platform:vivid-002 -d vivid-002-vid-cap ; then
+		echo "FAIL: the vivid module failed to load" | tee -a $tmp
+		echo "Grand Total for vivid: Succeeded: 0, Failed: 1, Warnings: 0" | tee -a $tmp
+		echo "Final Summary: 1, Succeeded: 0, Failed: 1, Warnings: 0"
+		exit 0
+	fi
 
-$v4l2_ctl -z platform:vivid-000 -d vivid-000-vid-cap -i3 -v width=3840,height=2160,pixelformat=NV24
-$v4l2_ctl -z platform:vivid-000 -d vivid-000-vid-out -o1 -x width=3840,height=2160,pixelformat=NV24
-$v4l2_ctl -z platform:vivid-001 -d vivid-001-vid-cap -i3 -v width=3840,height=2160,pixelformat=NM16
-$v4l2_ctl -z platform:vivid-001 -d vivid-001-vid-out -o1 -x width=3840,height=2160,pixelformat=NM16
-$v4l2_ctl -z platform:vivid-002 -d vivid-002-vid-cap -i3 -v width=3840,height=2160,pixelformat=NV24
-$v4l2_ctl -z platform:vivid-002 -d vivid-002-vid-out -o1 -x width=3840,height=2160,pixelformat=NM16
+	$v4l2_ctl -z platform:vivid-000 -d vivid-000-vid-cap -i3 -v width=3840,height=2160,pixelformat=NV24
+	$v4l2_ctl -z platform:vivid-000 -d vivid-000-vid-out -o1 -x width=3840,height=2160,pixelformat=NV24
+	$v4l2_ctl -z platform:vivid-001 -d vivid-001-vid-cap -i3 -v width=3840,height=2160,pixelformat=NM16
+	$v4l2_ctl -z platform:vivid-001 -d vivid-001-vid-out -o1 -x width=3840,height=2160,pixelformat=NM16
+	$v4l2_ctl -z platform:vivid-002 -d vivid-002-vid-cap -i3 -v width=3840,height=2160,pixelformat=NV24
+	$v4l2_ctl -z platform:vivid-002 -d vivid-002-vid-out -o1 -x width=3840,height=2160,pixelformat=NM16
 
-echo
+	echo
 
-if [ $vivid -eq 1 ]; then
 	dmesg -n notice
 	echo
 	echo vivid compliance tests, contiguous planes | tee /dev/kmsg
@@ -287,6 +287,18 @@ if [ $vivid -eq 1 ]; then
 	echo
 	echo
 	echo
+
+	date
+	echo
+	echo unbind vivid | tee /dev/kmsg
+	echo
+	echo -n vivid.0 >/sys/bus/platform/drivers/vivid/unbind
+	sleep $unbind_time
+	echo
+	echo rmmod vivid | tee /dev/kmsg
+	echo
+	rmmod vivid
+	sleep $rmmod_time
 fi
 
 if [ $vim2m -eq 1 ]; then
@@ -300,7 +312,7 @@ if [ $vim2m -eq 1 ]; then
 		echo "FAIL: the vim2m module failed to load" | tee -a $tmp
 		echo "Grand Total for vim2m: Succeeded: 0, Failed: 1, Warnings: 0" | tee -a $tmp
 		echo "Final Summary: 1, Succeeded: 0, Failed: 1, Warnings: 0"
-		rmmod vivid
+		rmmod vim2m
 		exit 0
 	fi
 
@@ -373,7 +385,7 @@ if [ $vimc -eq 1 ]; then
 		echo "FAIL: the vimc module failed to load" | tee -a $tmp
 		echo "Grand Total for vimc: Succeeded: 0, Failed: 1, Warnings: 0" | tee -a $tmp
 		echo "Final Summary: 1, Succeeded: 0, Failed: 1, Warnings: 0"
-		rmmod vivid
+		rmmod vimc
 		exit 0
 	fi
 
@@ -467,7 +479,7 @@ if [ $vicodec -eq 1 ]; then
 		echo "FAIL: the vicodec module failed to load" | tee -a $tmp
 		echo "Grand Total for vicodec: Succeeded: 0, Failed: 1, Warnings: 0" | tee -a $tmp
 		echo "Final Summary: 1, Succeeded: 0, Failed: 1, Warnings: 0"
-		rmmod vivid
+		rmmod vicodec
 		exit 0
 	fi
 
@@ -603,18 +615,6 @@ if [ $vicodec -eq 1 ]; then
 	echo
 fi
 
-date
-echo
-echo unbind vivid | tee /dev/kmsg
-echo
-echo -n vivid.0 >/sys/bus/platform/drivers/vivid/unbind
-sleep $unbind_time
-echo
-echo rmmod vivid | tee /dev/kmsg
-echo
-rmmod vivid
-sleep $rmmod_time
-
 if [ $vidtv -eq 1 ]; then
 	rmmod dvb_vidtv_bridge dvb_vidtv_tuner dvb_vidtv_demod 2&>/dev/null
 	modprobe vidtv
-- 
2.30.1

