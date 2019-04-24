Return-Path: <SRS0=rHfj=S2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18948C282CE
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 13:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7F621900
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 13:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfDXN7E (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:59:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57086 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfDXN7D (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 24 Apr 2019 09:59:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id F0702282C27
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, helen.koike@collabora.com,
        kernel@collabora.com, lucmaga@gmail.com,
        lkcamp@lists.libreplanetbr.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v3 11/14] media: vimc: sen: Add support for multiplanar formats
Date:   Wed, 24 Apr 2019 10:56:39 -0300
Message-Id: <20190424135642.31973-12-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424135642.31973-1-andrealmeid@collabora.com>
References: <20190424135642.31973-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This commit adapts vimc-sensor to handle multiplanar pixel formats,
adapting the memory allocation and TPG configuration.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
Changes in v3:
- Adapt to new vimc_frame

Changes in v2:
- Fix alignment issues
- Remove unnecessary variable assignment
- Reuse and share the code to free the memory of planes with a goto

 drivers/media/platform/vimc/vimc-sensor.c | 52 +++++++++++++----------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/media/platform/vimc/vimc-sensor.c b/drivers/media/platform/vimc/vimc-sensor.c
index 3495a3f3dd60..d933a1db309c 100644
--- a/drivers/media/platform/vimc/vimc-sensor.c
+++ b/drivers/media/platform/vimc/vimc-sensor.c
@@ -97,16 +97,17 @@ static int vimc_sen_get_fmt(struct v4l2_subdev *sd,
 static void vimc_sen_tpg_s_format(struct vimc_sen_device *vsen)
 {
 	u32 pixelformat = vsen->ved.stream->producer_pixfmt;
-	const struct v4l2_format_info *pix_info;
-
-	pix_info = v4l2_format_info(pixelformat);
+	unsigned int i;
 
 	tpg_reset_source(&vsen->tpg, vsen->mbus_format.width,
 			 vsen->mbus_format.height, vsen->mbus_format.field);
-	tpg_s_bytesperline(&vsen->tpg, 0,
-			   vsen->mbus_format.width * pix_info->bpp[0]);
 	tpg_s_buf_height(&vsen->tpg, vsen->mbus_format.height);
 	tpg_s_fourcc(&vsen->tpg, pixelformat);
+
+	for (i = 0; i < tpg_g_planes(&vsen->tpg); i++)
+		tpg_s_bytesperline(&vsen->tpg, i,
+				   vsen->frame.fmt.plane_fmt[i].bytesperline);
+
 	/* TODO: add support for V4L2_FIELD_ALTERNATE */
 	tpg_s_field(&vsen->tpg, vsen->mbus_format.field, false);
 	tpg_s_colorspace(&vsen->tpg, vsen->mbus_format.colorspace);
@@ -182,8 +183,12 @@ static struct vimc_frame *vimc_sen_process_frame(struct vimc_ent_device *ved,
 {
 	struct vimc_sen_device *vsen = container_of(ved, struct vimc_sen_device,
 						    ved);
+	unsigned int i;
+
+	for (i = 0; i < tpg_g_planes(&vsen->tpg); i++)
+		tpg_fill_plane_buffer(&vsen->tpg, 0, i,
+				      vsen->frame.plane_addr[i]);
 
-	tpg_fill_plane_buffer(&vsen->tpg, 0, 0, vsen->frame.plane_addr[0]);
 	return &vsen->frame;
 }
 
@@ -191,36 +196,39 @@ static int vimc_sen_s_stream(struct v4l2_subdev *sd, int enable)
 {
 	struct vimc_sen_device *vsen =
 				container_of(sd, struct vimc_sen_device, sd);
+	unsigned int i, ret = 0;
 
 	if (enable) {
-		u32 pixelformat = vsen->ved.stream->producer_pixfmt;
-		const struct v4l2_format_info *pix_info;
-		unsigned int frame_size;
-
 		/* Calculate the frame size */
-		pix_info = v4l2_format_info(pixelformat);
-		frame_size = vsen->mbus_format.width * pix_info->bpp[0] *
-			     vsen->mbus_format.height;
-
+		vimc_fill_frame(&vsen->frame, vsen->ved.stream->producer_pixfmt,
+				vsen->mbus_format.width,
+				vsen->mbus_format.height,
+				vsen->ved.stream->multiplanar);
 		/*
 		 * Allocate the frame buffer. Use vmalloc to be able to
 		 * allocate a large amount of memory
 		 */
-		vsen->frame.plane_addr[0] = vmalloc(frame_size);
-		if (!vsen->frame.plane_addr[0])
-			return -ENOMEM;
+		for (i = 0; i < vsen->frame.fmt.num_planes; i++) {
+			vsen->frame.plane_addr[i] =
+				vmalloc(vsen->frame.fmt.plane_fmt[i].sizeimage);
+			if (!vsen->frame.plane_addr[i]) {
+				ret = -ENOMEM;
+				goto free_planes;
+			}
+		}
 
 		/* configure the test pattern generator */
 		vimc_sen_tpg_s_format(vsen);
 
 	} else {
-
-		vfree(vsen->frame.plane_addr[0]);
-		vsen->frame.plane_addr[0] = NULL;
-		return 0;
+free_planes:
+		for (i = 0; i < vsen->frame.fmt.num_planes; i++) {
+			vfree(vsen->frame.plane_addr[i]);
+			vsen->frame.plane_addr[i] = NULL;
+		}
 	}
 
-	return 0;
+	return ret;
 }
 
 static const struct v4l2_subdev_core_ops vimc_sen_core_ops = {
-- 
2.21.0

