Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B04C10F0E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 09:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC3F206B7
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 09:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfDLJUc (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:20:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33682 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfDLJUc (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 05:20:32 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2C6292808CE;
        Fri, 12 Apr 2019 10:20:31 +0100 (BST)
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>, linux-media@vger.kernel.org
Cc:     kernel@collabora.com, Tomasz Figa <tfiga@chromium.org>,
        Hirokazu Honda <hiroh@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v3 1/2] media: exynos4-is: Properly report _MPLANE caps
Date:   Fri, 12 Apr 2019 11:20:26 +0200
Message-Id: <20190412092027.20410-1-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The fimc-isp-video.c and fimc-lite.c were missing the
V4L2_CAP_VIDEO_CAPTURE_MPLANE flag when reporting device caps.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
Changes in v3:
- New patch
---
 drivers/media/platform/exynos4-is/fimc-isp-video.c | 4 +++-
 drivers/media/platform/exynos4-is/fimc-lite.c      | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/exynos4-is/fimc-isp-video.c b/drivers/media/platform/exynos4-is/fimc-isp-video.c
index bb35a2017f21..8cd7b1c6565c 100644
--- a/drivers/media/platform/exynos4-is/fimc-isp-video.c
+++ b/drivers/media/platform/exynos4-is/fimc-isp-video.c
@@ -349,7 +349,9 @@ static int isp_video_querycap(struct file *file, void *priv,
 {
 	struct fimc_isp *isp = video_drvdata(file);
 
-	__fimc_vidioc_querycap(&isp->pdev->dev, cap, V4L2_CAP_STREAMING);
+	__fimc_vidioc_querycap(&isp->pdev->dev, cap,
+			       V4L2_CAP_STREAMING |
+			       V4L2_CAP_VIDEO_CAPTURE_MPLANE);
 	return 0;
 }
 
diff --git a/drivers/media/platform/exynos4-is/fimc-lite.c b/drivers/media/platform/exynos4-is/fimc-lite.c
index 96f0a8a0dcae..13dfa5e39139 100644
--- a/drivers/media/platform/exynos4-is/fimc-lite.c
+++ b/drivers/media/platform/exynos4-is/fimc-lite.c
@@ -659,7 +659,7 @@ static int fimc_lite_querycap(struct file *file, void *priv,
 	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:%s",
 					dev_name(&fimc->pdev->dev));
 
-	cap->device_caps = V4L2_CAP_STREAMING;
+	cap->device_caps = V4L2_CAP_VIDEO_CAPTURE_MPLANE | V4L2_CAP_STREAMING;
 	cap->capabilities = cap->device_caps | V4L2_CAP_DEVICE_CAPS;
 	return 0;
 }
-- 
2.20.1

