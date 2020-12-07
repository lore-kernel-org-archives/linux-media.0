Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1413CC2BB40
	for <linux-media@archiver.kernel.org>; Mon,  7 Dec 2020 21:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB4AA2396F
	for <linux-media@archiver.kernel.org>; Mon,  7 Dec 2020 21:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgLGV0u (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 7 Dec 2020 16:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgLGV0t (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 7 Dec 2020 16:26:49 -0500
Received: from hillosipuli.retiisi.eu (unknown [IPv6:2a01:4f9:c010:4572::e8:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6062C061285
        for <linux-media@vger.kernel.org>; Mon,  7 Dec 2020 13:23:20 -0800 (PST)
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id E1851634C93;
        Mon,  7 Dec 2020 23:23:12 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org
Subject: [PATCH 09/24] v4l: uapi: ccs: Add controls for CCS alternative analogue gain
Date:   Mon,  7 Dec 2020 23:15:15 +0200
Message-Id: <20201207211530.21180-10-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201207211530.21180-1-sakari.ailus@linux.intel.com>
References: <20201207211530.21180-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add two new controls for alternative analogue gain some CCS compliant
camera sensors support.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 Documentation/userspace-api/media/drivers/ccs.rst | 13 +++++++++++++
 include/uapi/linux/ccs.h                          |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/userspace-api/media/drivers/ccs.rst b/Documentation/userspace-api/media/drivers/ccs.rst
index ae02168ccd89..a4bac75e36dd 100644
--- a/Documentation/userspace-api/media/drivers/ccs.rst
+++ b/Documentation/userspace-api/media/drivers/ccs.rst
@@ -81,4 +81,17 @@ obtained from the following controls:
 The analogue gain (``x`` in the formula) is controlled through
 ``V4L2_CID_ANALOGUE_GAIN`` in this case.
 
+Alternate analogue gain model
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The CCS defines another analogue gain model called alternate analogue gain. In
+this case, the formula to calculate actual gain consists of linear and
+exponential parts:
+
+	gain = linear * 2 ^ exponent
+
+The ``linear`` and ``exponent`` factors can be set using the
+``V4L2_CID_CCS_ANALOGUE_LINEAR_GAIN`` and
+``V4L2_CID_CCS_ANALOGUE_EXPONENTIAL_GAIN`` controls, respectively
+
 **Copyright** |copy| 2020 Intel Corporation
diff --git a/include/uapi/linux/ccs.h b/include/uapi/linux/ccs.h
index 2aeea7e0622e..6880958ab7b4 100644
--- a/include/uapi/linux/ccs.h
+++ b/include/uapi/linux/ccs.h
@@ -10,5 +10,7 @@
 #define V4L2_CID_CCS_ANALOGUE_GAIN_C0		(V4L2_CID_USER_CCS_BASE + 2)
 #define V4L2_CID_CCS_ANALOGUE_GAIN_M1		(V4L2_CID_USER_CCS_BASE + 3)
 #define V4L2_CID_CCS_ANALOGUE_GAIN_C1		(V4L2_CID_USER_CCS_BASE + 4)
+#define V4L2_CID_CCS_ANALOGUE_LINEAR_GAIN	(V4L2_CID_USER_CCS_BASE + 5)
+#define V4L2_CID_CCS_ANALOGUE_EXPONENTIAL_GAIN	(V4L2_CID_USER_CCS_BASE + 6)
 
 #endif
-- 
2.29.2

