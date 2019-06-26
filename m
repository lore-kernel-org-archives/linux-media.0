Return-Path: <SRS0=aREJ=UZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2D2C48BD6
	for <linux-media@archiver.kernel.org>; Wed, 26 Jun 2019 07:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D2A2133F
	for <linux-media@archiver.kernel.org>; Wed, 26 Jun 2019 07:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfFZHof (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:44:35 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:33505 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727074AbfFZHoe (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 26 Jun 2019 03:44:34 -0400
Received: from tschai.fritz.box ([46.9.252.75])
        by smtp-cloud8.xs4all.net with ESMTPA
        id g2bNh3RUP7KeZg2bZhhHr5; Wed, 26 Jun 2019 09:44:33 +0200
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 14/16] omap_vout: set device_caps in struct video_device
Date:   Wed, 26 Jun 2019 09:44:19 +0200
Message-Id: <20190626074421.38739-15-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626074421.38739-1-hverkuil-cisco@xs4all.nl>
References: <20190626074421.38739-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfK+/Pbz5AvVRS1UXU0Q+52J2RxkY5FhgzLDB7sohwTo/fiN9pebdyzcaCjbxkK2vR7DqhueB1Zu7CMp1bdJhQuRHVIbe3YpcpuwNWYx5TJE306tEpJXZ
 MO/QhiNklhvqyEGvgfyKDcpX9OuwwoATWZdH63viwN37dHB+rNJ4kxFAapeUwUutKEk1sgx3QpM+1p+iN/AUd2xxiF9JjTe6uRySX5ISg/bf6NFUxwLkvoC2
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
 drivers/media/platform/omap/omap_vout.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/omap/omap_vout.c b/drivers/media/platform/omap/omap_vout.c
index cb6a9e3946b6..29f9c2a3ce2b 100644
--- a/drivers/media/platform/omap/omap_vout.c
+++ b/drivers/media/platform/omap/omap_vout.c
@@ -1044,10 +1044,6 @@ static int vidioc_querycap(struct file *file, void *fh,
 	strscpy(cap->driver, VOUT_NAME, sizeof(cap->driver));
 	strscpy(cap->card, vout->vfd->name, sizeof(cap->card));
 	cap->bus_info[0] = '\0';
-	cap->device_caps = V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_OUTPUT |
-		V4L2_CAP_VIDEO_OUTPUT_OVERLAY;
-	cap->capabilities = cap->device_caps | V4L2_CAP_DEVICE_CAPS;
-
 	return 0;
 }
 
@@ -1870,6 +1866,8 @@ static int __init omap_vout_setup_video_data(struct omap_vout_device *vout)
 	vfd->fops = &omap_vout_fops;
 	vfd->v4l2_dev = &vout->vid_dev->v4l2_dev;
 	vfd->vfl_dir = VFL_DIR_TX;
+	vfd->device_caps = V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_OUTPUT |
+			   V4L2_CAP_VIDEO_OUTPUT_OVERLAY;
 	mutex_init(&vout->lock);
 
 	vfd->minor = -1;
-- 
2.20.1

