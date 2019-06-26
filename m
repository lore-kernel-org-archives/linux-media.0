Return-Path: <SRS0=aREJ=UZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5FCC4646B
	for <linux-media@archiver.kernel.org>; Wed, 26 Jun 2019 07:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7AC52086D
	for <linux-media@archiver.kernel.org>; Wed, 26 Jun 2019 07:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfFZHoe (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:44:34 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:41161 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727000AbfFZHod (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 26 Jun 2019 03:44:33 -0400
Received: from tschai.fritz.box ([46.9.252.75])
        by smtp-cloud8.xs4all.net with ESMTPA
        id g2bNh3RUP7KeZg2bVhhHpc; Wed, 26 Jun 2019 09:44:33 +0200
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH 12/16] sh_veu/sh_vou: set device_caps in struct video_device
Date:   Wed, 26 Jun 2019 09:44:17 +0200
Message-Id: <20190626074421.38739-13-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626074421.38739-1-hverkuil-cisco@xs4all.nl>
References: <20190626074421.38739-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfK+/Pbz5AvVRS1UXU0Q+52J2RxkY5FhgzLDB7sohwTo/fiN9pebdyzcaCjbxkK2vR7DqhueB1Zu7CMp1bdJhQuRHVIbe3YpcpuwNWYx5TJE306tEpJXZ
 MO/QhiNklhvqyGaW1x0hMTxjmtVUCPu9St0xEmMqDTZtfWL6YC1EEaxm0CF1eGdF25eYzb4na6xk1gUW6mgd53Q9RVW+4Lgvx9MzWiitBXCp60ZJNdeJ6Y41
 nC5lgEY+3INHQvKCi7XbHg==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Instead of filling in the struct v4l2_capability device_caps
field, fill in the struct video_device device_caps field.

That way the V4L2 core knows what the capabilities of the
video device are.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/media/platform/sh_veu.c | 4 +---
 drivers/media/platform/sh_vou.c | 5 ++---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/sh_veu.c b/drivers/media/platform/sh_veu.c
index 5a9ba05c996e..ab39d6c80920 100644
--- a/drivers/media/platform/sh_veu.c
+++ b/drivers/media/platform/sh_veu.c
@@ -348,9 +348,6 @@ static int sh_veu_querycap(struct file *file, void *priv,
 	strscpy(cap->driver, "sh-veu", sizeof(cap->driver));
 	strscpy(cap->card, "sh-mobile VEU", sizeof(cap->card));
 	strscpy(cap->bus_info, "platform:sh-veu", sizeof(cap->bus_info));
-	cap->device_caps = V4L2_CAP_VIDEO_M2M | V4L2_CAP_STREAMING;
-	cap->capabilities = cap->device_caps | V4L2_CAP_DEVICE_CAPS;
-
 	return 0;
 }
 
@@ -1039,6 +1036,7 @@ static const struct video_device sh_veu_videodev = {
 	.minor		= -1,
 	.release	= video_device_release_empty,
 	.vfl_dir	= VFL_DIR_M2M,
+	.device_caps	= V4L2_CAP_VIDEO_M2M | V4L2_CAP_STREAMING,
 };
 
 static const struct v4l2_m2m_ops sh_veu_m2m_ops = {
diff --git a/drivers/media/platform/sh_vou.c b/drivers/media/platform/sh_vou.c
index 5799aa4b9323..1fe573a90f0d 100644
--- a/drivers/media/platform/sh_vou.c
+++ b/drivers/media/platform/sh_vou.c
@@ -381,9 +381,6 @@ static int sh_vou_querycap(struct file *file, void  *priv,
 	strscpy(cap->card, "SuperH VOU", sizeof(cap->card));
 	strscpy(cap->driver, "sh-vou", sizeof(cap->driver));
 	strscpy(cap->bus_info, "platform:sh-vou", sizeof(cap->bus_info));
-	cap->device_caps = V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_READWRITE |
-			   V4L2_CAP_STREAMING;
-	cap->capabilities = cap->device_caps | V4L2_CAP_DEVICE_CAPS;
 	return 0;
 }
 
@@ -1218,6 +1215,8 @@ static const struct video_device sh_vou_video_template = {
 	.ioctl_ops	= &sh_vou_ioctl_ops,
 	.tvnorms	= V4L2_STD_525_60, /* PAL only supported in 8-bit non-bt656 mode */
 	.vfl_dir	= VFL_DIR_TX,
+	.device_caps	= V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_READWRITE |
+			  V4L2_CAP_STREAMING,
 };
 
 static int sh_vou_probe(struct platform_device *pdev)
-- 
2.20.1

