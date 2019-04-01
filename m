Return-Path: <SRS0=Gl4L=SD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7491CC43381
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 11:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4508A20870
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 11:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfDALSG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:18:06 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:53887 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726274AbfDALSG (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 1 Apr 2019 07:18:06 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id AuwzhgjYwUjKfAux2h4fcM; Mon, 01 Apr 2019 13:18:05 +0200
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH] au0828: stop video streaming only when last user stops
Message-ID: <6add9687-d261-889f-af30-635b065a49c9@xs4all.nl>
Date:   Mon, 1 Apr 2019 13:18:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNCJZbLrWlMI9YKfOOW8wZ0TSbZ5mLIMmmedLc4RWJ/P4QaZh5sSVd/wYYpvOMlcwiwte0uuFe04IAEWhhX8v9vgU8uTu0twuUee0Fhm2jsNeACmZuRW
 0PGtByA84AZdOla5kmsBd07OpYmAkgirZYaiNs5W0y50onmJ15R/dGWKNoJlL7SmMV3/RS2rETBiyS6nP2/gcw8rhcRH1bTjm4Y=
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
diff --git a/drivers/media/usb/au0828/au0828-video.c b/drivers/media/usb/au0828/au0828-video.c
index e17047b94b87..fb8e42c74653 100644
--- a/drivers/media/usb/au0828/au0828-video.c
+++ b/drivers/media/usb/au0828/au0828-video.c
@@ -861,10 +861,11 @@ static void au0828_stop_streaming(struct vb2_queue *vq)

 	dprintk(1, "au0828_stop_streaming called %d\n", dev->streaming_users);

-	if (dev->streaming_users-- == 1)
+	if (dev->streaming_users-- == 1) {
 		au0828_uninit_isoc(dev);
+		v4l2_device_call_all(&dev->v4l2_dev, 0, video, s_stream, 0);
+	}

-	v4l2_device_call_all(&dev->v4l2_dev, 0, video, s_stream, 0);
 	dev->vid_timeout_running = 0;
 	del_timer_sync(&dev->vid_timeout);

@@ -893,8 +894,10 @@ void au0828_stop_vbi_streaming(struct vb2_queue *vq)
 	dprintk(1, "au0828_stop_vbi_streaming called %d\n",
 		dev->streaming_users);

-	if (dev->streaming_users-- == 1)
+	if (dev->streaming_users-- == 1) {
 		au0828_uninit_isoc(dev);
+		v4l2_device_call_all(&dev->v4l2_dev, 0, video, s_stream, 0);
+	}

 	spin_lock_irqsave(&dev->slock, flags);
 	if (dev->isoc_ctl.vbi_buf != NULL) {
