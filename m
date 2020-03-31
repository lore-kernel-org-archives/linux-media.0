Return-Path: <SRS0=pkrO=5Q=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB91C43331
	for <linux-media@archiver.kernel.org>; Tue, 31 Mar 2020 12:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C6C20658
	for <linux-media@archiver.kernel.org>; Tue, 31 Mar 2020 12:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbgCaM5B (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 31 Mar 2020 08:57:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:7135 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730473AbgCaM5B (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 31 Mar 2020 08:57:01 -0400
IronPort-SDR: AS7BXanqawueLouMcNl9jIc7wqd2uXu/GrrjxUg91b//fu8mmlbz/LMlIQkJetnSzYzrUqekmO
 fvRKyJUv8qbQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 05:57:00 -0700
IronPort-SDR: 4GtfxegAsZvKcqIX8OQgphkuWcf4/wsKlNmvGx2cA3j/CAzAGWr7/MfSk+oaLGMDrPn8QZjlzr
 6p/WmIw5lNUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; 
   d="scan'208";a="272742955"
Received: from ipu5-build.bj.intel.com ([10.238.232.196])
  by fmsmga004.fm.intel.com with ESMTP; 31 Mar 2020 05:56:58 -0700
From:   Bingbu Cao <bingbu.cao@intel.com>
To:     linux-media@vger.kernel.org
Cc:     sakari.ailus@linux.intel.com, tfiga@chromium.org,
        bingbu.cao@intel.com, bingbu.cao@linux.intel.com
Subject: [PATCH] media: ipu3.rst: add yuv-downscaling into pipeline diagram
Date:   Tue, 31 Mar 2020 21:00:40 +0800
Message-Id: <1585659640-10049-1-git-send-email-bingbu.cao@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

For ipu3 ImgU image processing, the frame data from TNR can feed into
DDR by Output Formatting System or feed into YUV downscaler to do YUV
downscaling for secondary output, which is usually used for display.
current ImgU image pipeline diagram misses the YUV downscaling,
this patch add it to aligh with actual hardware blocks.

Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 Documentation/media/v4l-drivers/ipu3.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/media/v4l-drivers/ipu3.rst b/Documentation/media/v4l-drivers/ipu3.rst
index a694f49491f9..c200cb5fc91b 100644
--- a/Documentation/media/v4l-drivers/ipu3.rst
+++ b/Documentation/media/v4l-drivers/ipu3.rst
@@ -429,16 +429,16 @@ set of parameters as input. The major stages of pipelines are shown here:
        o [label="Total Color Correction"]
        p [label="XNR3"]
        q [label="TNR"]
-       r [label="DDR"]
+       r [label="DDR", style=filled, fillcolor=yellow, shape=cylinder]
+       s [label="YUV Downscaling"]
+       t [label="DDR", style=filled, fillcolor=yellow, shape=cylinder]
 
-       { rank=same; a -> b -> c -> d -> e -> f }
-       { rank=same; g -> h -> i -> j -> k -> l }
-       { rank=same; m -> n -> o -> p -> q -> r }
+       { rank=same; a -> b -> c -> d -> e -> f -> g -> h -> i }
+       { rank=same; j -> k -> l -> m -> n -> o -> p -> q -> s -> t}
 
-       a -> g -> m [style=invis, weight=10]
-
-       f -> g
-       l -> m
+       a -> j [style=invis, weight=10]
+       i -> j
+       q -> r
    }
 
 The table below presents a description of the above algorithms.
-- 
2.7.4

