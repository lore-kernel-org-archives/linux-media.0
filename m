Return-Path: <SRS0=aREJ=UZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA0CC48BD8
	for <linux-media@archiver.kernel.org>; Wed, 26 Jun 2019 07:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB362086D
	for <linux-media@archiver.kernel.org>; Wed, 26 Jun 2019 07:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfFZHo2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:44:28 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:57875 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727009AbfFZHo2 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 26 Jun 2019 03:44:28 -0400
Received: from tschai.fritz.box ([46.9.252.75])
        by smtp-cloud8.xs4all.net with ESMTPA
        id g2bNh3RUP7KeZg2bShhHoK; Wed, 26 Jun 2019 09:44:27 +0200
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 05/16] m2m-deinterlace: set device_caps in struct video_device
Date:   Wed, 26 Jun 2019 09:44:10 +0200
Message-Id: <20190626074421.38739-6-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626074421.38739-1-hverkuil-cisco@xs4all.nl>
References: <20190626074421.38739-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfK5lngGVNa+o3sMUctkGWqBSwmYTdwh9qXbm6bcB1vfyH7RxcPDxrwCVg8cgs+jACveYg4HHrUQnKwy+MnlHag+f1uaaf99B+b+4kJd9myxOnEnMgUhc
 v/3Wvz9gnARXXwv3HmHZWFUDjFCSKmcwlamPmGmqPF7BJC/1Mq3N3o5Pq8cPHkSxzfqafaa2BAH26h6oASjgOAKCMwCrn5tS1yKx1aT+8bdv6Oy6y7ykeetU
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Instead of filling in the struct v4l2_capability device_caps
field, fill in the struct video_device device_caps field.

That way the V4L2 core knows what the capabilities of the
video device are.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/platform/m2m-deinterlace.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/media/platform/m2m-deinterlace.c b/drivers/media/platform/m2m-deinterlace.c
index beb7fd7442fb..485fcf36ce32 100644
--- a/drivers/media/platform/m2m-deinterlace.c
+++ b/drivers/media/platform/m2m-deinterlace.c
@@ -437,15 +437,6 @@ static int vidioc_querycap(struct file *file, void *priv,
 	strscpy(cap->driver, MEM2MEM_NAME, sizeof(cap->driver));
 	strscpy(cap->card, MEM2MEM_NAME, sizeof(cap->card));
 	strscpy(cap->bus_info, MEM2MEM_NAME, sizeof(cap->card));
-	/*
-	 * This is only a mem-to-mem video device. The capture and output
-	 * device capability flags are left only for backward compatibility
-	 * and are scheduled for removal.
-	 */
-	cap->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_VIDEO_OUTPUT |
-			   V4L2_CAP_VIDEO_M2M | V4L2_CAP_STREAMING;
-	cap->capabilities = cap->device_caps | V4L2_CAP_DEVICE_CAPS;
-
 	return 0;
 }
 
@@ -972,6 +963,7 @@ static const struct video_device deinterlace_videodev = {
 	.minor		= -1,
 	.release	= video_device_release_empty,
 	.vfl_dir	= VFL_DIR_M2M,
+	.device_caps	= V4L2_CAP_VIDEO_M2M | V4L2_CAP_STREAMING,
 };
 
 static const struct v4l2_m2m_ops m2m_ops = {
-- 
2.20.1

