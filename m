Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9208C4361B
	for <linux-media@archiver.kernel.org>; Thu, 10 Dec 2020 11:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C1623CD4
	for <linux-media@archiver.kernel.org>; Thu, 10 Dec 2020 11:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389251AbgLJK5e (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 10 Dec 2020 05:57:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389220AbgLJK5V (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 10 Dec 2020 05:57:21 -0500
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] media: control.rst: use a table for V4L2_CID_POWER_LINE
Date:   Thu, 10 Dec 2020 11:55:42 +0100
Message-Id: <da0267fcfd377cdbb47938ac524955eb811746c3.1607597287.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1607597287.git.mchehab+huawei@kernel.org>
References: <cover.1607597287.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The default way to document control enums is via tables.

Use one here too. As the table is simple, just use ASCII
artwork.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/userspace-api/media/v4l/control.rst | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/control.rst b/Documentation/userspace-api/media/v4l/control.rst
index 4e5652eb6126..ed5154700308 100644
--- a/Documentation/userspace-api/media/v4l/control.rst
+++ b/Documentation/userspace-api/media/v4l/control.rst
@@ -154,10 +154,13 @@ Control IDs
 ``V4L2_CID_POWER_LINE_FREQUENCY`` ``(enum)``
     Enables a power line frequency filter to avoid flicker. Possible
     values for ``enum v4l2_power_line_frequency`` are:
-    ``V4L2_CID_POWER_LINE_FREQUENCY_DISABLED`` (0),
-    ``V4L2_CID_POWER_LINE_FREQUENCY_50HZ`` (1),
-    ``V4L2_CID_POWER_LINE_FREQUENCY_60HZ`` (2) and
-    ``V4L2_CID_POWER_LINE_FREQUENCY_AUTO`` (3).
+
+    ==========================================  ==
+    ``V4L2_CID_POWER_LINE_FREQUENCY_DISABLED``   0
+    ``V4L2_CID_POWER_LINE_FREQUENCY_50HZ``	 1
+    ``V4L2_CID_POWER_LINE_FREQUENCY_60HZ``	 2
+    ``V4L2_CID_POWER_LINE_FREQUENCY_AUTO``	 3
+    ==========================================  ==
 
 ``V4L2_CID_HUE_AUTO`` ``(boolean)``
     Enables automatic hue control by the device. The effect of setting
-- 
2.29.2

