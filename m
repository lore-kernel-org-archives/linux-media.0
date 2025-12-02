Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86153302CC6
	for <linux-media@vger.kernel.org>; Tue,  2 Dec 2025 07:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764661965; cv=none; b=NpLYxFzTDjHvsa+bYfep/r0/+lMtSr+DSTFsUInWgCL+KIix98taN+2ZaNxcRitftlAzafRmPu9l28OUnZkShe7dc7P8tnP8k5k0RJNbu5ualODXDwnSBRUNtHuhMkEaeZxh3yhzxaZ1WBy64zXCslR9t00WeXNzz1GslZHn32Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764661965; c=relaxed/simple;
	bh=l+1kDlQwSj8hi9St1QMK0LThX9ivBWy30d2SFpWDN2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7ZTVlzgYkQAw9SntU1WhB5KJYbPTcYgr/qeYumFZkGgEZubk1Z1x4M32Y3axyZ/DKQ/k4Q0kXgtvXkxBkO7ayx2uQmlXbUo62iWAo21IpbAlvKklzOiARZm6Dhlh5BXd1K6nJTqHSVwS3/m8K9BWZOcZVP5jHSpx42rwG+V5bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiFvjxtV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiFvjxtV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038EBC4CEF1;
	Tue,  2 Dec 2025 07:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764661965;
	bh=l+1kDlQwSj8hi9St1QMK0LThX9ivBWy30d2SFpWDN2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SiFvjxtVjpaL02gJ90rVtpZewSkAKckdCj/r1d+iGmY+7/ovk1IL/CgM8huhGvmfw
	 iuyZUGef4vGF0lBeY6NtjvQwpb5pWPmlgtNA7aTUKDmxfaDHEbaY/v8+8+9ZsCmfLy
	 f8I+0S8Vg/JQYKBHk+nk0v3h5aB1pGMExVrllp6n7Qx3nEIdkoBgOAOkaiu4J6xfhh
	 EyvpirnGUmpgne9fb7pKGaeoL/i3QABme8wrABOAvUT+IUhj7Iz9XbTWuFIXKMt4WE
	 EwphCJkdz0YIburSyIbtr6b70ErNxN/WFDXOcOJG2kuPm7XLZbRLlnkv5lJd5gBRh9
	 7uTRXZ0hjvzvA==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	laurent.pinchart@ideasonboard.com,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCHv3 07/12] media: omap3isp: rework isp_video_try/set_format
Date: Tue,  2 Dec 2025 08:51:15 +0100
Message-ID: <610abc890990a72d9803aaed4bc50c7d2fb5a395.1764661880.git.hverkuil+cisco@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1764661880.git.hverkuil+cisco@kernel.org>
References: <cover.1764661880.git.hverkuil+cisco@kernel.org>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

isp_video_set_format now calls isp_video_try_format first, ensuring
consistent behavior and removing duplicate code in both functions.

This fixes an v4l2-compliance error:

	fail: v4l2-test-formats.cpp(519): !pix.sizeimage
test VIDIOC_S_FMT: FAIL

Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/platform/ti/omap3isp/ispvideo.c | 59 ++++++++++---------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/media/platform/ti/omap3isp/ispvideo.c b/drivers/media/platform/ti/omap3isp/ispvideo.c
index c52312b39598..adea39b6d930 100644
--- a/drivers/media/platform/ti/omap3isp/ispvideo.c
+++ b/drivers/media/platform/ti/omap3isp/ispvideo.c
@@ -700,11 +700,15 @@ isp_video_get_format(struct file *file, void *fh, struct v4l2_format *format)
 }
 
 static int
-isp_video_set_format(struct file *file, void *fh, struct v4l2_format *format)
+isp_video_try_format(struct file *file, void *fh, struct v4l2_format *format)
 {
-	struct isp_video_fh *vfh = file_to_isp_video_fh(file);
 	struct isp_video *video = video_drvdata(file);
-	struct v4l2_mbus_framefmt fmt;
+	struct v4l2_subdev_format fmt = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	struct v4l2_subdev *subdev;
+	u32 pad;
+	int ret;
 
 	if (format->type != video->type)
 		return -EINVAL;
@@ -744,32 +748,11 @@ isp_video_set_format(struct file *file, void *fh, struct v4l2_format *format)
 		break;
 	}
 
-	/* Fill the bytesperline and sizeimage fields by converting to media bus
-	 * format and back to pixel format.
-	 */
-	isp_video_pix_to_mbus(&format->fmt.pix, &fmt);
-	isp_video_mbus_to_pix(video, &fmt, &format->fmt.pix);
-
-	mutex_lock(&video->mutex);
-	vfh->format = *format;
-	mutex_unlock(&video->mutex);
-
-	return 0;
-}
-
-static int
-isp_video_try_format(struct file *file, void *fh, struct v4l2_format *format)
-{
-	struct isp_video *video = video_drvdata(file);
-	struct v4l2_subdev_format fmt = {
-		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
-	};
-	struct v4l2_subdev *subdev;
-	u32 pad;
-	int ret;
-
-	if (format->type != video->type)
-		return -EINVAL;
+	if (video->type == V4L2_BUF_TYPE_VIDEO_OUTPUT) {
+		isp_video_pix_to_mbus(&format->fmt.pix, &fmt.format);
+		isp_video_mbus_to_pix(video, &fmt.format, &format->fmt.pix);
+		return 0;
+	}
 
 	subdev = isp_video_remote_subdev(video, &pad);
 	if (subdev == NULL)
@@ -786,6 +769,24 @@ isp_video_try_format(struct file *file, void *fh, struct v4l2_format *format)
 	return 0;
 }
 
+static int
+isp_video_set_format(struct file *file, void *fh, struct v4l2_format *format)
+{
+	struct isp_video_fh *vfh = file_to_isp_video_fh(file);
+	struct isp_video *video = video_drvdata(file);
+	int ret;
+
+	ret = isp_video_try_format(file, fh, format);
+	if (ret)
+		return ret;
+
+	mutex_lock(&video->mutex);
+	vfh->format = *format;
+	mutex_unlock(&video->mutex);
+
+	return 0;
+}
+
 static int
 isp_video_get_selection(struct file *file, void *fh, struct v4l2_selection *sel)
 {
-- 
2.51.0

