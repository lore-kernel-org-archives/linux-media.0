Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA42C282CE
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 23:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC1A218C3
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 23:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfDLXpk (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 19:45:40 -0400
Received: from bin-mail-out-05.binero.net ([195.74.38.228]:48017 "EHLO
        bin-mail-out-05.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727059AbfDLXpi (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 19:45:38 -0400
X-Halon-ID: 0f81d693-5d7d-11e9-8fa2-005056917a89
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (unknown [89.233.230.99])
        by bin-vsp-out-01.atm.binero.net (Halon) with ESMTPA
        id 0f81d693-5d7d-11e9-8fa2-005056917a89;
        Sat, 13 Apr 2019 01:45:32 +0200 (CEST)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 8/8] rcar-vin: Merge Gen2 and Gen3 file operations
Date:   Sat, 13 Apr 2019 01:43:59 +0200
Message-Id: <20190412234359.5079-9-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412234359.5079-1-niklas.soderlund+renesas@ragnatech.se>
References: <20190412234359.5079-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

After the rework of the Gen2 file operations it's now trivial to merge
the Gen2 and Gen3 versions.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/media/platform/rcar-vin/rcar-v4l2.c | 96 ++++-----------------
 1 file changed, 16 insertions(+), 80 deletions(-)

diff --git a/drivers/media/platform/rcar-vin/rcar-v4l2.c b/drivers/media/platform/rcar-vin/rcar-v4l2.c
index 58d0b59ee1247c8f..2c9cae4b7abe925c 100644
--- a/drivers/media/platform/rcar-vin/rcar-v4l2.c
+++ b/drivers/media/platform/rcar-vin/rcar-v4l2.c
@@ -781,14 +781,19 @@ static int rvin_open(struct file *file)
 	if (ret)
 		goto err_pm;
 
-	if (v4l2_fh_is_singular_file(file)) {
-		ret = rvin_power_parallel(vin, 1);
+	if (vin->info->use_mc) {
+		ret = v4l2_pipeline_pm_use(&vin->vdev.entity, 1);
 		if (ret < 0)
 			goto err_open;
+	} else {
+		if (v4l2_fh_is_singular_file(file)) {
+			ret = rvin_power_parallel(vin, 1);
+			if (ret < 0)
+				goto err_open;
 
-		v4l2_ctrl_handler_setup(&vin->ctrl_handler);
+			v4l2_ctrl_handler_setup(&vin->ctrl_handler);
+		}
 	}
-
 	mutex_unlock(&vin->lock);
 
 	return 0;
@@ -816,12 +821,12 @@ static int rvin_release(struct file *file)
 	/* the release helper will cleanup any on-going streaming */
 	ret = _vb2_fop_release(file, NULL);
 
-	/*
-	 * If this was the last open file.
-	 * Then de-initialize hw module.
-	 */
-	if (fh_singular)
-		rvin_power_parallel(vin, 0);
+	if (vin->info->use_mc) {
+		v4l2_pipeline_pm_use(&vin->vdev.entity, 0);
+	} else {
+		if (fh_singular)
+			rvin_power_parallel(vin, 0);
+	}
 
 	pm_runtime_put(vin->dev);
 
@@ -840,74 +845,6 @@ static const struct v4l2_file_operations rvin_fops = {
 	.read		= vb2_fop_read,
 };
 
-/* -----------------------------------------------------------------------------
- * Media controller file operations
- */
-
-static int rvin_mc_open(struct file *file)
-{
-	struct rvin_dev *vin = video_drvdata(file);
-	int ret;
-
-	ret = mutex_lock_interruptible(&vin->lock);
-	if (ret)
-		return ret;
-
-	ret = pm_runtime_get_sync(vin->dev);
-	if (ret < 0)
-		goto err_unlock;
-
-	ret = v4l2_pipeline_pm_use(&vin->vdev.entity, 1);
-	if (ret < 0)
-		goto err_pm;
-
-	file->private_data = vin;
-
-	ret = v4l2_fh_open(file);
-	if (ret)
-		goto err_v4l2pm;
-
-	mutex_unlock(&vin->lock);
-
-	return 0;
-err_v4l2pm:
-	v4l2_pipeline_pm_use(&vin->vdev.entity, 0);
-err_pm:
-	pm_runtime_put(vin->dev);
-err_unlock:
-	mutex_unlock(&vin->lock);
-
-	return ret;
-}
-
-static int rvin_mc_release(struct file *file)
-{
-	struct rvin_dev *vin = video_drvdata(file);
-	int ret;
-
-	mutex_lock(&vin->lock);
-
-	/* the release helper will cleanup any on-going streaming. */
-	ret = _vb2_fop_release(file, NULL);
-
-	v4l2_pipeline_pm_use(&vin->vdev.entity, 0);
-	pm_runtime_put(vin->dev);
-
-	mutex_unlock(&vin->lock);
-
-	return ret;
-}
-
-static const struct v4l2_file_operations rvin_mc_fops = {
-	.owner		= THIS_MODULE,
-	.unlocked_ioctl	= video_ioctl2,
-	.open		= rvin_mc_open,
-	.release	= rvin_mc_release,
-	.poll		= vb2_fop_poll,
-	.mmap		= vb2_fop_mmap,
-	.read		= vb2_fop_read,
-};
-
 void rvin_v4l2_unregister(struct rvin_dev *vin)
 {
 	if (!video_is_registered(&vin->vdev))
@@ -948,6 +885,7 @@ int rvin_v4l2_register(struct rvin_dev *vin)
 	snprintf(vdev->name, sizeof(vdev->name), "VIN%u output", vin->id);
 	vdev->release = video_device_release_empty;
 	vdev->lock = &vin->lock;
+	vdev->fops = &rvin_fops;
 	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING |
 		V4L2_CAP_READWRITE;
 
@@ -959,10 +897,8 @@ int rvin_v4l2_register(struct rvin_dev *vin)
 	vin->format.colorspace = RVIN_DEFAULT_COLORSPACE;
 
 	if (vin->info->use_mc) {
-		vdev->fops = &rvin_mc_fops;
 		vdev->ioctl_ops = &rvin_mc_ioctl_ops;
 	} else {
-		vdev->fops = &rvin_fops;
 		vdev->ioctl_ops = &rvin_ioctl_ops;
 		rvin_reset_format(vin);
 	}
-- 
2.21.0

