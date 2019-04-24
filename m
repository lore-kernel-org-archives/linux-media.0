Return-Path: <SRS0=rHfj=S2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13197C10F11
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 13:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED2B21902
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 13:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbfDXN6I (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:58:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56978 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730633AbfDXN6I (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 24 Apr 2019 09:58:08 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 8E470282BC3
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, helen.koike@collabora.com,
        kernel@collabora.com, lucmaga@gmail.com,
        lkcamp@lists.libreplanetbr.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v3 01/14] media: vimc: Remove unnecessary stream checks
Date:   Wed, 24 Apr 2019 10:56:29 -0300
Message-Id: <20190424135642.31973-2-andrealmeid@collabora.com>
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

Change the way subdevices check if the stream is running. Verify the stream
pointer instead of src_frame. This makes easier to get rid of the void* and
u8* in the subdevices structs. Also, remove redundant checks for stream.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
Acked-by: Helen Koike <helen.koike@collabora.com>
---
Changes in v3:
- None

Changes in v2:
- Squashed commits that remove unnecessary checks together
- Reworded commit message

 drivers/media/platform/vimc/vimc-debayer.c | 5 +----
 drivers/media/platform/vimc/vimc-scaler.c  | 7 ++-----
 drivers/media/platform/vimc/vimc-sensor.c  | 6 +-----
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/vimc/vimc-debayer.c b/drivers/media/platform/vimc/vimc-debayer.c
index 281f9c1a7249..b221f26e01cf 100644
--- a/drivers/media/platform/vimc/vimc-debayer.c
+++ b/drivers/media/platform/vimc/vimc-debayer.c
@@ -270,7 +270,7 @@ static int vimc_deb_set_fmt(struct v4l2_subdev *sd,
 
 	if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE) {
 		/* Do not change the format while stream is on */
-		if (vdeb->src_frame)
+		if (vdeb->ved.stream)
 			return -EBUSY;
 
 		sink_fmt = &vdeb->sink_fmt;
@@ -337,9 +337,6 @@ static int vimc_deb_s_stream(struct v4l2_subdev *sd, int enable)
 		const struct v4l2_format_info *pix_info;
 		unsigned int frame_size;
 
-		if (vdeb->src_frame)
-			return 0;
-
 		/* We only support translating bayer to RGB24 */
 		if (src_pixelformat != V4L2_PIX_FMT_RGB24) {
 			dev_err(vdeb->dev,
diff --git a/drivers/media/platform/vimc/vimc-scaler.c b/drivers/media/platform/vimc/vimc-scaler.c
index 8aecf8e92031..617f2920b86b 100644
--- a/drivers/media/platform/vimc/vimc-scaler.c
+++ b/drivers/media/platform/vimc/vimc-scaler.c
@@ -158,7 +158,7 @@ static int vimc_sca_set_fmt(struct v4l2_subdev *sd,
 
 	if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE) {
 		/* Do not change the format while stream is on */
-		if (vsca->src_frame)
+		if (vsca->ved.stream)
 			return -EBUSY;
 
 		sink_fmt = &vsca->sink_fmt;
@@ -213,9 +213,6 @@ static int vimc_sca_s_stream(struct v4l2_subdev *sd, int enable)
 		const struct v4l2_format_info *pix_info;
 		unsigned int frame_size;
 
-		if (vsca->src_frame)
-			return 0;
-
 		if (!vimc_sca_is_pixfmt_supported(pixelformat)) {
 			dev_err(vsca->dev, "pixfmt (0x%08x) is not supported\n",
 				pixelformat);
@@ -337,7 +334,7 @@ static void *vimc_sca_process_frame(struct vimc_ent_device *ved,
 						    ved);
 
 	/* If the stream in this node is not active, just return */
-	if (!vsca->src_frame)
+	if (!ved->stream)
 		return ERR_PTR(-EINVAL);
 
 	vimc_sca_fill_src_frame(vsca, sink_frame);
diff --git a/drivers/media/platform/vimc/vimc-sensor.c b/drivers/media/platform/vimc/vimc-sensor.c
index 081e54204c9f..1b2b75b27952 100644
--- a/drivers/media/platform/vimc/vimc-sensor.c
+++ b/drivers/media/platform/vimc/vimc-sensor.c
@@ -141,7 +141,7 @@ static int vimc_sen_set_fmt(struct v4l2_subdev *sd,
 
 	if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE) {
 		/* Do not change the format while stream is on */
-		if (vsen->frame)
+		if (vsen->ved.stream)
 			return -EBUSY;
 
 		mf = &vsen->mbus_format;
@@ -197,10 +197,6 @@ static int vimc_sen_s_stream(struct v4l2_subdev *sd, int enable)
 		const struct v4l2_format_info *pix_info;
 		unsigned int frame_size;
 
-		if (vsen->kthread_sen)
-			/* tpg is already executing */
-			return 0;
-
 		/* Calculate the frame size */
 		pix_info = v4l2_format_info(pixelformat);
 		frame_size = vsen->mbus_format.width * pix_info->bpp[0] *
-- 
2.21.0

