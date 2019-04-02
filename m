Return-Path: <SRS0=Nq74=SE=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A23C43381
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 07:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103C320830
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 07:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfDBHYV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:24:21 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:34903 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725778AbfDBHYV (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 2 Apr 2019 03:24:21 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id BDmJh1nnmiLOmBDmNhekOc; Tue, 02 Apr 2019 09:24:19 +0200
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH v2] au0828: stop video streaming only when last user stops
Message-ID: <4f9f2e84-f053-b84d-b3c7-6abe22bddf5d@xs4all.nl>
Date:   Tue, 2 Apr 2019 09:24:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFHU0JdapDvm1FoTTusV83EqA9GFq20iu0n6w4RAg1JcDa4BQwXU/XOOoTPeRR+XAJdieBdUCIcvhlAAEUaVrkVfHzHHeBQ04TdVZphLpWn3nMcskuW1
 H3qur7lt1X8ZIJbeuv9K8tTHL//VlSOqHHOCYtVQfbaunE35bIx7pBzQbR0P66dp8srkdDpiSsrwJ01Ahb/0CtuHnJ73qb8jkjw=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

If the application was streaming from both videoX and vbiX, and streaming
from videoX was stopped, then the vbi streaming also stopped.

The cause being that stop_streaming for video stopped the subdevs as well,
instead of only doing that if dev->streaming_users reached 0.

au0828_stop_vbi_streaming was also wrong since it didn't stop the subdevs
at all when dev->streaming_users reached 0.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
Change since v1: v4l2_device_call_all(&dev->v4l2_dev, 0, video, s_stream, 1)
was done for video only, not for vbi. This is obviously wrong when starting
vbi first, but also caused weird behavior since attempting to start a second
vbi capture would stop the first.
---
diff --git a/drivers/media/usb/au0828/au0828-video.c b/drivers/media/usb/au0828/au0828-video.c
index 536bd8bbb624..4bde3db83aa2 100644
--- a/drivers/media/usb/au0828/au0828-video.c
+++ b/drivers/media/usb/au0828/au0828-video.c
@@ -842,9 +842,9 @@ int au0828_start_analog_streaming(struct vb2_queue *vq, unsigned int count)
 			return rc;
 		}

+		v4l2_device_call_all(&dev->v4l2_dev, 0, video, s_stream, 1);
+
 		if (vq->type == V4L2_BUF_TYPE_VIDEO_CAPTURE) {
-			v4l2_device_call_all(&dev->v4l2_dev, 0, video,
-						s_stream, 1);
 			dev->vid_timeout_running = 1;
 			mod_timer(&dev->vid_timeout, jiffies + (HZ / 10));
 		} else if (vq->type == V4L2_BUF_TYPE_VBI_CAPTURE) {
@@ -864,10 +864,11 @@ static void au0828_stop_streaming(struct vb2_queue *vq)

 	dprintk(1, "au0828_stop_streaming called %d\n", dev->streaming_users);

-	if (dev->streaming_users-- == 1)
+	if (dev->streaming_users-- == 1) {
 		au0828_uninit_isoc(dev);
+		v4l2_device_call_all(&dev->v4l2_dev, 0, video, s_stream, 0);
+	}

-	v4l2_device_call_all(&dev->v4l2_dev, 0, video, s_stream, 0);
 	dev->vid_timeout_running = 0;
 	del_timer_sync(&dev->vid_timeout);

@@ -896,8 +897,10 @@ void au0828_stop_vbi_streaming(struct vb2_queue *vq)
 	dprintk(1, "au0828_stop_vbi_streaming called %d\n",
 		dev->streaming_users);

-	if (dev->streaming_users-- == 1)
+	if (dev->streaming_users-- == 1) {
 		au0828_uninit_isoc(dev);
+		v4l2_device_call_all(&dev->v4l2_dev, 0, video, s_stream, 0);
+	}

 	spin_lock_irqsave(&dev->slock, flags);
 	if (dev->isoc_ctl.vbi_buf != NULL) {
