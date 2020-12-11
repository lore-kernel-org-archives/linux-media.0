Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC0AC4361B
	for <linux-media@archiver.kernel.org>; Fri, 11 Dec 2020 23:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D51A2336E
	for <linux-media@archiver.kernel.org>; Fri, 11 Dec 2020 23:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407130AbgLKXXF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 11 Dec 2020 18:23:05 -0500
Received: from retiisi.eu ([95.216.213.190]:49052 "EHLO hillosipuli.retiisi.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407127AbgLKXWz (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 11 Dec 2020 18:22:55 -0500
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 9D721634C89
        for <linux-media@vger.kernel.org>; Sat, 12 Dec 2020 01:20:45 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 1/1] Documentation: media: Update pixel rate formula for C-PHY
Date:   Sat, 12 Dec 2020 01:13:27 +0200
Message-Id: <20201211231327.30416-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Update the formula to calculate the pixel rate on the link for C-PHY.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 Documentation/driver-api/media/csi2.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/media/csi2.rst b/Documentation/driver-api/media/csi2.rst
index e3bbc6baf0f0..11c52b0be8b8 100644
--- a/Documentation/driver-api/media/csi2.rst
+++ b/Documentation/driver-api/media/csi2.rst
@@ -35,7 +35,7 @@ ability to start and stop the stream.
 
 The value of the V4L2_CID_PIXEL_RATE is calculated as follows::
 
-	pixel_rate = link_freq * 2 * nr_of_lanes / bits_per_sample
+	pixel_rate = link_freq * 2 * nr_of_lanes * 16 / k / bits_per_sample
 
 where
 
@@ -53,6 +53,8 @@ where
      - Two bits are transferred per clock cycle per lane.
    * - bits_per_sample
      - Number of bits per sample.
+   * - k
+     - 16 for D-PHY and 7 for C-PHY
 
 The transmitter drivers must, if possible, configure the CSI-2
 transmitter to *LP-11 mode* whenever the transmitter is powered on but
-- 
2.29.2

