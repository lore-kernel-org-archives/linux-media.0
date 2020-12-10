Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632E8C433FE
	for <linux-media@archiver.kernel.org>; Thu, 10 Dec 2020 11:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223EF23B85
	for <linux-media@archiver.kernel.org>; Thu, 10 Dec 2020 11:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389177AbgLJK45 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 10 Dec 2020 05:56:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:56190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389165AbgLJK4g (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 10 Dec 2020 05:56:36 -0500
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] media: ext-ctrls-codec.rst: simplify a few tables
Date:   Thu, 10 Dec 2020 11:55:46 +0100
Message-Id: <3979524f134cf28fea77c9795266eca447a5b8c3.1607597287.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1607597287.git.mchehab+huawei@kernel.org>
References: <cover.1607597287.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Those tables nicely fits on PDF output without any hack.
Yet, they are using a very small font, and have tabularcolumns.

Clean it up, and convert it to an ASCII artwork, as it
makes easier to see that no hacks are needed to display it ;-)

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../media/v4l/ext-ctrls-codec.rst             | 78 +++++--------------
 1 file changed, 19 insertions(+), 59 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 08c317ae0910..abf64e5500e0 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -2762,47 +2762,21 @@ enum v4l2_mpeg_video_hevc_profile -
 enum v4l2_mpeg_video_hevc_level -
     Selects the desired level for HEVC encoder.
 
-.. raw:: latex
-
-    \footnotesize
-
-.. tabularcolumns:: |p{9.0cm}|p{8.0cm}|
-
-.. flat-table::
-    :header-rows:  0
-    :stub-columns: 0
-
-    * - ``V4L2_MPEG_VIDEO_HEVC_LEVEL_1``
-      - Level 1.0
-    * - ``V4L2_MPEG_VIDEO_HEVC_LEVEL_2``
-      - Level 2.0
-    * - ``V4L2_MPEG_VIDEO_HEVC_LEVEL_2_1``
-      - Level 2.1
-    * - ``V4L2_MPEG_VIDEO_HEVC_LEVEL_3``
-      - Level 3.0
-    * - ``V4L2_MPEG_VIDEO_HEVC_LEVEL_3_1``
-      - Level 3.1
-    * - ``V4L2_MPEG_VIDEO_HEVC_LEVEL_4``
-      - Level 4.0
-    * - ``V4L2_MPEG_VIDEO_HEVC_LEVEL_4_1``
-      - Level 4.1
-    * - ``V4L2_MPEG_VIDEO_HEVC_LEVEL_5``
-      - Level 5.0
-    * - ``V4L2_MPEG_VIDEO_HEVC_LEVEL_5_1``
-      - Level 5.1
-    * - ``V4L2_MPEG_VIDEO_HEVC_LEVEL_5_2``
-      - Level 5.2
-    * - ``V4L2_MPEG_VIDEO_HEVC_LEVEL_6``
-      - Level 6.0
-    * - ``V4L2_MPEG_VIDEO_HEVC_LEVEL_6_1``
-      - Level 6.1
-    * - ``V4L2_MPEG_VIDEO_HEVC_LEVEL_6_2``
-      - Level 6.2
-
-.. raw:: latex
-
-    \normalsize
-
+==================================	=========
+``V4L2_MPEG_VIDEO_HEVC_LEVEL_1``	Level 1.0
+``V4L2_MPEG_VIDEO_HEVC_LEVEL_2``	Level 2.0
+``V4L2_MPEG_VIDEO_HEVC_LEVEL_2_1``	Level 2.1
+``V4L2_MPEG_VIDEO_HEVC_LEVEL_3``	Level 3.0
+``V4L2_MPEG_VIDEO_HEVC_LEVEL_3_1``	Level 3.1
+``V4L2_MPEG_VIDEO_HEVC_LEVEL_4``	Level 4.0
+``V4L2_MPEG_VIDEO_HEVC_LEVEL_4_1``	Level 4.1
+``V4L2_MPEG_VIDEO_HEVC_LEVEL_5``	Level 5.0
+``V4L2_MPEG_VIDEO_HEVC_LEVEL_5_1``	Level 5.1
+``V4L2_MPEG_VIDEO_HEVC_LEVEL_5_2``	Level 5.2
+``V4L2_MPEG_VIDEO_HEVC_LEVEL_6``	Level 6.0
+``V4L2_MPEG_VIDEO_HEVC_LEVEL_6_1``	Level 6.1
+``V4L2_MPEG_VIDEO_HEVC_LEVEL_6_2``	Level 6.2
+==================================	=========
 
 ``V4L2_CID_MPEG_VIDEO_HEVC_FRAME_RATE_RESOLUTION (integer)``
     Indicates the number of evenly spaced subintervals, called ticks, within
@@ -2821,24 +2795,10 @@ enum v4l2_mpeg_video_hevc_tier -
     this flag to 1 indicates High tier. High tier is for applications requiring
     high bit rates.
 
-.. raw:: latex
-
-    \footnotesize
-
-.. tabularcolumns:: |p{9.0cm}|p{8.0cm}|
-
-.. flat-table::
-    :header-rows:  0
-    :stub-columns: 0
-
-    * - ``V4L2_MPEG_VIDEO_HEVC_TIER_MAIN``
-      - Main tier.
-    * - ``V4L2_MPEG_VIDEO_HEVC_TIER_HIGH``
-      - High tier.
-
-.. raw:: latex
-
-    \normalsize
+==================================	==========
+``V4L2_MPEG_VIDEO_HEVC_TIER_MAIN``	Main tier.
+``V4L2_MPEG_VIDEO_HEVC_TIER_HIGH``	High tier.
+==================================	==========
 
 
 ``V4L2_CID_MPEG_VIDEO_HEVC_MAX_PARTITION_DEPTH (integer)``
-- 
2.29.2

