Return-Path: <SRS0=gA2F=S4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470C5C43219
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 19:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258C320675
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 19:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfDZTwr (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:52:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40770 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfDZTwr (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 26 Apr 2019 15:52:47 -0400
Received: from localhost.localdomain (unknown [IPv6:2804:431:9718:9080:61b7:f4a4:2020:fc95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id F05A62756D0;
        Fri, 26 Apr 2019 20:52:42 +0100 (BST)
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, helen.koike@collabora.com,
        kernel@collabora.com, lucmaga@gmail.com,
        lkcamp@lists.libreplanetbr.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v5 14/14] media: vimc: Create multiplanar parameter
Date:   Fri, 26 Apr 2019 16:51:14 -0300
Message-Id: <20190426195114.5002-15-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426195114.5002-1-andrealmeid@collabora.com>
References: <20190426195114.5002-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Create multiplanar kernel module parameter to define if the driver is
running in single planar or in multiplanar mode. Define the device
capabilities according to the multiplanar kernel parameter. A device can't
support both CAP_VIDEO_CAPTURE and CAP_VIDEO_CAPTURE_MPLANAR at the
same time.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
Acked-by: Helen Koike <helen.koike@collabora.com>
---
Changes in v5: none

Change in v4:
- Split commit with "Add handler for multiplanar fmt ioctls" 

Change in v3:
- Squash commit with "Add handler for multiplanar fmt ioctls" 
- Remove functions that only did the `IS_MULTIPLANAR(vcap)` check
- Assign ioctls according to device capabilities

Changes in v2:
- Squash commits to create multiplanar module parameter and to define
the device capabilities
- Move the creation of the multiplanar parameter to the end of
history, so it's only added when all required changes are applied

 drivers/media/platform/vimc/vimc-capture.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/vimc/vimc-capture.c b/drivers/media/platform/vimc/vimc-capture.c
index 932d622d56ca..c5959b8e21f7 100644
--- a/drivers/media/platform/vimc/vimc-capture.c
+++ b/drivers/media/platform/vimc/vimc-capture.c
@@ -28,6 +28,10 @@
 
 #define VIMC_CAP_DRV_NAME "vimc-capture"
 
+static unsigned int multiplanar;
+module_param(multiplanar, uint, 0000);
+MODULE_PARM_DESC(multiplanar, "0 (default) creates a single planar device, 1 creates a multiplanar device.");
+
 /* Checks if the device supports multiplanar capture */
 #define IS_MULTIPLANAR(vcap) \
 	(vcap->vdev.device_caps & V4L2_CAP_VIDEO_CAPTURE_MPLANE)
@@ -597,7 +601,9 @@ static int vimc_cap_comp_bind(struct device *comp, struct device *master,
 
 	/* Initialize the vb2 queue */
 	q = &vcap->queue;
-	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+	q->type = multiplanar ?
+		V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE :
+		V4L2_BUF_TYPE_VIDEO_CAPTURE;
 	q->io_modes = VB2_MMAP | VB2_DMABUF | VB2_USERPTR;
 	q->drv_priv = vcap;
 	q->buf_struct_size = sizeof(struct vimc_cap_buffer);
@@ -627,7 +633,9 @@ static int vimc_cap_comp_bind(struct device *comp, struct device *master,
 
 	/* Initialize the video_device struct */
 	vdev = &vcap->vdev;
-	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
+	vdev->device_caps = (multiplanar ?
+			V4L2_CAP_VIDEO_CAPTURE_MPLANE :
+			V4L2_CAP_VIDEO_CAPTURE) | V4L2_CAP_STREAMING;
 	vdev->entity.ops = &vimc_cap_mops;
 	vdev->release = vimc_cap_release;
 	vdev->fops = &vimc_cap_fops;
-- 
2.21.0

