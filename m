Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFB2C10F0E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 16:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67ECF20850
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 16:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CyeHKwiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfDLQoV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:44:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36057 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDLQoU (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 12:44:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so11791528wml.1
        for <linux-media@vger.kernel.org>; Fri, 12 Apr 2019 09:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y86imlr0wPlIhVynzIQp/e0Fa10GFECSTb9qzdx6U+c=;
        b=CyeHKwiBwA3mp3yDHmHKbfSdm4iC0C4KUYAlMXK9dak6c3BzjUg3NW16k0Yshd4YPd
         M3ao+xtyrHTIJ0+5A/a9XBRg3jYpT6vxtObWri3E0SMX1LTtzCckxdlXjGzLt7TPPoZu
         xQlGZ/+mMX/z8mzHuGpWtQtuJtn1//8Igeg7Ezf6KXciKb9r9N8D4K1efv3qHajWF173
         OdkV+U4EEl/DFeH5Sl43cH/NvX48BFitk5TsCykmWR8GhvqAiHBwYfQIPMP2HhF/A4In
         B/oKTIhkwhujm7elkiHYtx+hrg//LdA8ZN43WfIhT/SQsrCa3YQcl7BZgw/g/oLIzwS0
         nPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y86imlr0wPlIhVynzIQp/e0Fa10GFECSTb9qzdx6U+c=;
        b=Z+RFhz9xwsjUIbTi2NeWCAacav0lBtOdDzKvByfhG+6dM2BvaSDMZU5u5wXXycjF2V
         AHREs7B8o9XngF36iZREtEgMK3L0LYtbGxIU8gOvCLFy61OKeK34mWIK6O5+gdGdf6En
         +xBwAVJeShcc7KphgF1u6sEz34EFOTgPlBJUGQNIexaWV4gS+B0td81ReIwL1Z4EXGo/
         TOw0CLZtoif2V7RQf8SdkexJSE9jwWZ6R1lcyb3LonIyTTJbm1OrQK5iHibuHLLRFEjy
         KXfePMebz2WoweJItND/TsYDfxEe+fJnUCL0n/CHHaA7oWHmwsp/dQeaEzeIRoDbzug2
         MLWg==
X-Gm-Message-State: APjAAAUmz4bglBUpq2hO9P+Dqfr3A2ZF4sD1WeFkkdQn31+qpFrC+/EV
        T/42dSQBMzHU3T007zA+xxWRHs4pwq0=
X-Google-Smtp-Source: APXvYqyOMZPo4TwfASsa9lkjCV1ypXMV6MVwI0E0zK70L/ijF8lmcu60txmyZ0AeKo0qfSXupE4J0A==
X-Received: by 2002:a1c:a70f:: with SMTP id q15mr11656571wme.28.1555087458374;
        Fri, 12 Apr 2019 09:44:18 -0700 (PDT)
Received: from arch-late.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id l12sm49781805wrt.31.2019.04.12.09.44.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 09:44:17 -0700 (PDT)
From:   Rui Miguel Silva <rui.silva@linaro.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     devel@driverdev.osuosl.org, linux-media@vger.kernel.org,
        Rui Miguel Silva <rui.silva@linaro.org>
Subject: [PATCH] media: staging/imx: add media device to capture register
Date:   Fri, 12 Apr 2019 17:44:00 +0100
Message-Id: <20190412164400.1270-1-rui.silva@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

When register the capture media device it is assumed that the device
data is the media device. In the imx6 case is but in the imx7 is not
case. The device data is the csi structure.

Add the explicit argument of the media device that we want to
associate with the capture device.

Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 drivers/staging/media/imx/imx-ic-prpencvf.c   | 2 +-
 drivers/staging/media/imx/imx-media-capture.c | 6 +++---
 drivers/staging/media/imx/imx-media-csi.c     | 2 +-
 drivers/staging/media/imx/imx-media.h         | 3 ++-
 drivers/staging/media/imx/imx7-media-csi.c    | 2 +-
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index 5c8e6ad8c025..3ca1422f6154 100644
--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -1270,7 +1270,7 @@ static int prp_registered(struct v4l2_subdev *sd)
 	if (ret)
 		return ret;
 
-	ret = imx_media_capture_device_register(priv->vdev);
+	ret = imx_media_capture_device_register(priv->md, priv->vdev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
index 9703c85b19c4..7688238a3396 100644
--- a/drivers/staging/media/imx/imx-media-capture.c
+++ b/drivers/staging/media/imx/imx-media-capture.c
@@ -706,7 +706,8 @@ void imx_media_capture_device_error(struct imx_media_video_dev *vdev)
 }
 EXPORT_SYMBOL_GPL(imx_media_capture_device_error);
 
-int imx_media_capture_device_register(struct imx_media_video_dev *vdev)
+int imx_media_capture_device_register(struct imx_media_dev *md,
+				      struct imx_media_video_dev *vdev)
 {
 	struct capture_priv *priv = to_capture_priv(vdev);
 	struct v4l2_subdev *sd = priv->src_sd;
@@ -715,8 +716,7 @@ int imx_media_capture_device_register(struct imx_media_video_dev *vdev)
 	struct v4l2_subdev_format fmt_src;
 	int ret;
 
-	/* get media device */
-	priv->md = dev_get_drvdata(sd->v4l2_dev->dev);
+	priv->md = md;
 
 	vfd->v4l2_dev = sd->v4l2_dev;
 
diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 3b7517348666..3408ec023d29 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1806,7 +1806,7 @@ static int csi_registered(struct v4l2_subdev *sd)
 	if (ret)
 		goto free_fim;
 
-	ret = imx_media_capture_device_register(priv->vdev);
+	ret = imx_media_capture_device_register(priv->md, priv->vdev);
 	if (ret)
 		goto free_fim;
 
diff --git a/drivers/staging/media/imx/imx-media.h b/drivers/staging/media/imx/imx-media.h
index ae964c8d5be1..c3a8512bd10f 100644
--- a/drivers/staging/media/imx/imx-media.h
+++ b/drivers/staging/media/imx/imx-media.h
@@ -271,7 +271,8 @@ int imx_media_of_add_csi(struct imx_media_dev *imxmd,
 struct imx_media_video_dev *
 imx_media_capture_device_init(struct v4l2_subdev *src_sd, int pad);
 void imx_media_capture_device_remove(struct imx_media_video_dev *vdev);
-int imx_media_capture_device_register(struct imx_media_video_dev *vdev);
+int imx_media_capture_device_register(struct imx_media_dev *md,
+				       struct imx_media_video_dev *vdev);
 void imx_media_capture_device_unregister(struct imx_media_video_dev *vdev);
 struct imx_media_buffer *
 imx_media_capture_device_next_buf(struct imx_media_video_dev *vdev);
diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
index 3fba7c27c0ec..a907c5feb3eb 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -1124,7 +1124,7 @@ static int imx7_csi_registered(struct v4l2_subdev *sd)
 	if (ret < 0)
 		return ret;
 
-	ret = imx_media_capture_device_register(csi->vdev);
+	ret = imx_media_capture_device_register(csi->imxmd, csi->vdev);
 	if (ret < 0)
 		return ret;
 
-- 
2.21.0

