Return-Path: <SRS0=Aqrg=WL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0CEC3A589
	for <linux-media@archiver.kernel.org>; Thu, 15 Aug 2019 12:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420DB2086C
	for <linux-media@archiver.kernel.org>; Thu, 15 Aug 2019 12:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfHOMk5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 15 Aug 2019 08:40:57 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:32843 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725977AbfHOMk5 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 15 Aug 2019 08:40:57 -0400
Received: from [IPv6:2001:420:44c1:2579:f038:4b04:f67a:276f] ([IPv6:2001:420:44c1:2579:f038:4b04:f67a:276f])
        by smtp-cloud8.xs4all.net with ESMTPA
        id yF3khvfQvDqPeyF3ohY72R; Thu, 15 Aug 2019 14:40:56 +0200
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH] radio/si470x: kill urb on error
Message-ID: <dccc6ba5-e5a5-29f0-ce02-1961144d4467@xs4all.nl>
Date:   Thu, 15 Aug 2019 14:40:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHlei24NZXxjatfcfIfid8wJHmM/BMjZDIueKRYNco6BXV8PMV7EGP46hDmChhPUVDpou5jBForHtMV/514DpD+z8GrwLUfiTlHE2NavB1SOHh1/pwHY
 Uy4vidsiYomLZwtmw3rNFcS7ZSTjdjEMpqEQOxR9UhMOlGmCNIxAOyosU3kwW0BWmW+iD87zkxqTyb8OWqFRnmif7p21CgunvVm2Dd3B9JmDl2MIezWU4xv9
 A2DaaiZ+/H6Qcxv7fLPtJF58H3PSn3VbtNThCbeEOSdVt9oYm60nlcZtlmlTScRk
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

In the probe() function radio->int_in_urb was not killed if an
error occurred in the probe sequence. It was also missing in
the disconnect.

This caused this syzbot issue:

https://syzkaller.appspot.com/bug?extid=2d4fc2a0c45ad8da7e99

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reported-and-tested-by: syzbot+2d4fc2a0c45ad8da7e99@syzkaller.appspotmail.com
---
diff --git a/drivers/media/radio/si470x/radio-si470x-usb.c b/drivers/media/radio/si470x/radio-si470x-usb.c
index 49073747b1e7..fedff68d8c49 100644
--- a/drivers/media/radio/si470x/radio-si470x-usb.c
+++ b/drivers/media/radio/si470x/radio-si470x-usb.c
@@ -734,7 +734,7 @@ static int si470x_usb_driver_probe(struct usb_interface *intf,
 	/* start radio */
 	retval = si470x_start_usb(radio);
 	if (retval < 0)
-		goto err_all;
+		goto err_buf;

 	/* set initial frequency */
 	si470x_set_freq(radio, 87.5 * FREQ_MUL); /* available in all regions */
@@ -749,6 +749,8 @@ static int si470x_usb_driver_probe(struct usb_interface *intf,

 	return 0;
 err_all:
+	usb_kill_urb(radio->int_in_urb);
+err_buf:
 	kfree(radio->buffer);
 err_ctrl:
 	v4l2_ctrl_handler_free(&radio->hdl);
@@ -822,6 +824,7 @@ static void si470x_usb_driver_disconnect(struct usb_interface *intf)
 	mutex_lock(&radio->lock);
 	v4l2_device_disconnect(&radio->v4l2_dev);
 	video_unregister_device(&radio->videodev);
+	usb_kill_urb(radio->int_in_urb);
 	usb_set_intfdata(intf, NULL);
 	mutex_unlock(&radio->lock);
 	v4l2_device_put(&radio->v4l2_dev);
