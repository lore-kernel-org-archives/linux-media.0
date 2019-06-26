Return-Path: <SRS0=aREJ=UZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F79C48BD3
	for <linux-media@archiver.kernel.org>; Wed, 26 Jun 2019 07:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF81B2086D
	for <linux-media@archiver.kernel.org>; Wed, 26 Jun 2019 07:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfFZHoa (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:44:30 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:45505 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727025AbfFZHo3 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 26 Jun 2019 03:44:29 -0400
Received: from tschai.fritz.box ([46.9.252.75])
        by smtp-cloud8.xs4all.net with ESMTPA
        id g2bNh3RUP7KeZg2bThhHol; Wed, 26 Jun 2019 09:44:28 +0200
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 08/16] pxa_camera: set device_caps in struct video_device
Date:   Wed, 26 Jun 2019 09:44:13 +0200
Message-Id: <20190626074421.38739-9-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626074421.38739-1-hverkuil-cisco@xs4all.nl>
References: <20190626074421.38739-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAMxzN4FUyPeZTym9v7gc0ycLbc7FiT7ilC6KdR/vAZsnW1y5GPq1P9y+j+zRAZI5JfoUdgzCy7wAJHBCrMWWq2CxD0K8657n1s8OscrvzuZi7obxnHF
 0UXPVB1NsmhM69tdw24Pj0WjETUET6jViFvDQOw3IqzJN93/Be6ygk2O1HCR4sCzqesYP/+kJbnU7KUg5FJgZQG16hNJq34S253wMHMSYFgwxwdl78Y9o0yO
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
 drivers/media/platform/pxa_camera.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/platform/pxa_camera.c b/drivers/media/platform/pxa_camera.c
index 1c9bfaabc54c..53682da099c5 100644
--- a/drivers/media/platform/pxa_camera.c
+++ b/drivers/media/platform/pxa_camera.c
@@ -1992,9 +1992,6 @@ static int pxac_vidioc_querycap(struct file *file, void *priv,
 	strscpy(cap->bus_info, "platform:pxa-camera", sizeof(cap->bus_info));
 	strscpy(cap->driver, PXA_CAM_DRV_NAME, sizeof(cap->driver));
 	strscpy(cap->card, pxa_cam_driver_description, sizeof(cap->card));
-	cap->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
-	cap->capabilities = cap->device_caps | V4L2_CAP_DEVICE_CAPS;
-
 	return 0;
 }
 
-- 
2.20.1

