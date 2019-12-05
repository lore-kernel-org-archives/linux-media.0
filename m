Return-Path: <SRS0=MqeG=Z3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EE2C2D0C0
	for <linux-media@archiver.kernel.org>; Thu,  5 Dec 2019 07:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B480206DB
	for <linux-media@archiver.kernel.org>; Thu,  5 Dec 2019 07:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shaw.ca header.i=@shaw.ca header.b="PSJvHpxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfLEHeT (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 5 Dec 2019 02:34:19 -0500
Received: from smtp-out-so.shaw.ca ([64.59.136.137]:34884 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfLEHeT (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 5 Dec 2019 02:34:19 -0500
Received: from shaw.ca ([70.71.78.228])
        by shaw.ca with ESMTPA
        id cleQi8c1NRnrKcleTi9Y2T; Thu, 05 Dec 2019 00:34:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shaw.ca;
        s=s20180605; t=1575531258;
        bh=V6heS10hzzsIGAU7aQjd3bUnilO+xofCJ3t89D0+cgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PSJvHpxDLYBG0p90M1vVIQlr/EQHgh5mAEuUmmJDR5JkMd1wuNCQ/+QvXdT9ZSoZ9
         qKvZh+fX91/l30yUFcux1ZhOiRDogpyJQSFcbmHyAZzmN6qgmULdQXg8WGIIGcRnja
         P4Atc9sm4/O+zzSdVlfH8pkfI+VweuoSnA6d29cg2xhxPRQsnn2dLpQUdWi8t5nhQd
         ULWReQn5fG4+92/g5Hvfupdzji+QEunFD+uDg3OvUyJCa78lcfnM6tFBXMhgs0isO2
         G8dEULPSt54sIk72vdn5vQzMhpuzG6y1p20PZcY5BbRT6suWaxhwFqOYbGtImwV8ip
         N8G/lMiM58w/Q==
X-Authority-Analysis: v=2.3 cv=L7FjvNb8 c=1 sm=1 tr=0
 a=qDatE6m/3wxSEG8Wq7h0zQ==:117 a=qDatE6m/3wxSEG8Wq7h0zQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=_Dj-zB-qAAAA:8 a=swxBmBvKtDr-IPWf1rsA:9
 a=c-cOe7UV8MviEfHuAVEQ:22
From:   joevt <joevt@shaw.ca>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org
Subject: [PATCH 3/5] edid-decode: more back/front porch switching
Date:   Wed,  4 Dec 2019 23:34:12 -0800
Message-Id: <20191205073414.53672-3-joevt@shaw.ca>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191205073414.53672-1-joevt@shaw.ca>
References: <20191205073414.53672-1-joevt@shaw.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNRI+2yjonfkxDYFUh+DoQZcda613OpF0rHNVmDO9sa+XCCITWfYq1AbNTewEU5yr7FjT9a/mz74d5y3Tr70uw8baeFfGUQiqgKY8696Niy2pyHU1dfD
 6ZmCgEa8Mlb1HQMLkq6niES9CIK05wGDz/04Cbm/SYRVlhRmFNAAboAcVUolDAS+FLPEQn2xb6UaVQ==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fix more instances where back porch is actually front porch (problem started when "so = sync offset" was mistaken for "bp = back porch" instead of "fp = front porch").

Signed-off-by: Joe van Tunen <joevt@shaw.ca>
---
 parse-base-block.cpp      | 12 ++++++------
 parse-displayid-block.cpp |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/parse-base-block.cpp b/parse-base-block.cpp
index 2d384e8..0b6e3d0 100644
--- a/parse-base-block.cpp
+++ b/parse-base-block.cpp
@@ -1302,13 +1302,13 @@ void edid_state::detailed_timings(const char *prefix, const unsigned char *x)
 
 	bool ok = true;
 
-	if (!t.w || !hbl || !t.hbp || !t.hsync || !t.h || !vbl || !t.vbp || !t.vsync) {
+	if (!t.w || !hbl || !t.hfp || !t.hsync || !t.h || !vbl || !t.vfp || !t.vsync) {
 		fail("0 values in the detailed timings:\n"
 		     "    Horizontal Active/Blanking %u/%u\n"
-		     "    Horizontal Backporch/Sync Width %u/%u\n"
+		     "    Horizontal Frontporch/Sync Width %u/%u\n"
 		     "    Vertical Active/Blanking %u/%u\n"
-		     "    Vertical Backporch/Sync Width %u/%u\n",
-		     t.w, hbl, t.hbp, t.hsync, t.h, vbl, t.vbp, t.vsync);
+		     "    Vertical Frontporch/Sync Width %u/%u\n",
+		     t.w, hbl, t.hfp, t.hsync, t.h, vbl, t.vfp, t.vsync);
 		ok = false;
 	}
 
@@ -1324,10 +1324,10 @@ void edid_state::detailed_timings(const char *prefix, const unsigned char *x)
 	       t.pixclk_khz / 1000.0,
 	       t.hor_mm, t.vert_mm,
 	       prefix,
-	       t.w, t.w + t.hbp, t.w + t.hbp + t.hsync, t.w + hbl, t.hfp, t.hsync, t.hbp,
+	       t.w, t.w + t.hfp, t.w + t.hfp + t.hsync, t.w + hbl, t.hfp, t.hsync, t.hbp,
 	       t.hborder ? (std::string(" hborder ") + std::to_string(t.hborder)).c_str() : "",
 	       prefix,
-	       t.h, t.h + t.vbp, t.h + t.vbp + t.vsync, t.h + vbl, t.vfp, t.vsync, t.vbp,
+	       t.h, t.h + t.vfp, t.h + t.vfp + t.vsync, t.h + vbl, t.vfp, t.vsync, t.vbp,
 	       t.vborder ? (std::string(" vborder ") + std::to_string(t.vborder)).c_str() : "",
 	       prefix,
 	       s_sync.c_str(), s_flags.c_str(),
diff --git a/parse-displayid-block.cpp b/parse-displayid-block.cpp
index 403ae7b..3ac3d92 100644
--- a/parse-displayid-block.cpp
+++ b/parse-displayid-block.cpp
@@ -176,8 +176,8 @@ static void parse_displayid_detailed_timing(const unsigned char *x)
 	       "                   %chsync %cvsync\n"
 	       "                   VertFreq: %.3f Hz, HorFreq: %.3f kHz\n",
 	       (double)t.pixclk_khz/1000.0, s.c_str(),
-	       t.w, t.w + t.hbp, t.w + t.hbp + t.hsync, t.w + hbl, t.hfp, t.hsync, t.hbp,
-	       t.h, t.h + t.vbp, t.h + t.vbp + t.vsync, t.h + vbl, t.vfp, t.vsync, t.vbp,
+	       t.w, t.w + t.hfp, t.w + t.hfp + t.hsync, t.w + hbl, t.hfp, t.hsync, t.hbp,
+	       t.h, t.h + t.vfp, t.h + t.vfp + t.vsync, t.h + vbl, t.vfp, t.vsync, t.vbp,
 	       t.pos_pol_hsync ? '+' : '-', t.pos_pol_vsync ? '+' : '-',
 	       (t.pixclk_khz * 1000.0) / ((t.w + hbl) * (t.h + vbl)),
 	       (double)(t.pixclk_khz) / (t.w + hbl)
-- 
2.21.0 (Apple Git-122.2)

