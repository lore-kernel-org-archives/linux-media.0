Return-Path: <SRS0=Gl4L=SD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5D9C43381
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 22:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2282146E
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 22:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554156079;
	bh=Pk8AMH+WVE8j8GaZ8ZvUAVclHxma1fI8eW9+3oXorjk=;
	h=Subject:To:References:From:Cc:Date:In-Reply-To:List-ID:From;
	b=MA2tXxFGdqnnAqDKWvz3uuF1WLq5cb1TLpJ437orPmb7HonPdUp/Vy2Wuy/mZTHaG
	 bXEqIMnxfFAQhfuWQm1utWuubDmEXE0Ntue2IqSJHfyGqPj7P2Yd/Duv/k9uwF36J5
	 WOwo2iXVDbHZIGNy0kjB33xbhzgg7PqPrsNkS08w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbfDAWBT (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Apr 2019 18:01:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbfDAWBT (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 1 Apr 2019 18:01:19 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 284D82082C;
        Mon,  1 Apr 2019 22:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554156078;
        bh=Pk8AMH+WVE8j8GaZ8ZvUAVclHxma1fI8eW9+3oXorjk=;
        h=Subject:To:References:From:Cc:Date:In-Reply-To:From;
        b=zWGb/DfQg9NnY9DvT2YaJvlBlh6lNgkJJH8iwAXI+/ZDnfsmHBSwvf9apG6fuVbpD
         XS3XD34tCOcuDluS71/WOCfKFZOMcnzWAK9LCcsAFOb0wIzZcqh8mNwibwNQWu7iiC
         51an5SOLN0Ub8MCZ0Ui8rq5SYMDoOEqMrniaMf14=
Subject: Re: [PATCH] au0828: stop video streaming only when last user stops
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
References: <6add9687-d261-889f-af30-635b065a49c9@xs4all.nl>
 <7033738c-a4b3-2751-ba30-fab0f323dc30@kernel.org>
From:   shuah <shuah@kernel.org>
Cc:     shuah <shuah@kernel.org>
Message-ID: <449bce44-8a4f-7a81-de35-776afdce2e6a@kernel.org>
Date:   Mon, 1 Apr 2019 16:01:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <7033738c-a4b3-2751-ba30-fab0f323dc30@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Hans,

On 4/1/19 8:54 AM, shuah wrote:
> On 4/1/19 5:18 AM, Hans Verkuil wrote:
>> If the application was streaming from both videoX and vbiX, and streaming
>> from videoX was stopped, then the vbi streaming also stopped.
>>
>> The cause being that stop_streaming for video stopped the subdevs as 
>> well,
>> instead of only doing that if dev->streaming_users reached 0.
>>
>> au0828_stop_vbi_streaming was also wrong since it didn't stop the subdevs
>> at all when dev->streaming_users reached 0.
>>
>> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
>> ---
>> diff --git a/drivers/media/usb/au0828/au0828-video.c 
>> b/drivers/media/usb/au0828/au0828-video.c
>> index e17047b94b87..fb8e42c74653 100644
>> --- a/drivers/media/usb/au0828/au0828-video.c
>> +++ b/drivers/media/usb/au0828/au0828-video.c
>> @@ -861,10 +861,11 @@ static void au0828_stop_streaming(struct 
>> vb2_queue *vq)
>>
>>       dprintk(1, "au0828_stop_streaming called %d\n", 
>> dev->streaming_users);
>>
>> -    if (dev->streaming_users-- == 1)
>> +    if (dev->streaming_users-- == 1) {
>>           au0828_uninit_isoc(dev);
>> +        v4l2_device_call_all(&dev->v4l2_dev, 0, video, s_stream, 0);
>> +    }
>>
>> -    v4l2_device_call_all(&dev->v4l2_dev, 0, video, s_stream, 0);
>>       dev->vid_timeout_running = 0;
>>       del_timer_sync(&dev->vid_timeout);
>>
>> @@ -893,8 +894,10 @@ void au0828_stop_vbi_streaming(struct vb2_queue *vq)
>>       dprintk(1, "au0828_stop_vbi_streaming called %d\n",
>>           dev->streaming_users);
>>
>> -    if (dev->streaming_users-- == 1)
>> +    if (dev->streaming_users-- == 1) {
>>           au0828_uninit_isoc(dev);
>> +        v4l2_device_call_all(&dev->v4l2_dev, 0, video, s_stream, 0);
>> +    }
>>
>>       spin_lock_irqsave(&dev->slock, flags);
>>       if (dev->isoc_ctl.vbi_buf != NULL) {
>>
> 
> 
> Thanks. I will test the series with this patch and send v15
> 

I made VBI shareable and ran tests with your patch. If I were to start
VBI capture while VBI stream is active, the active VBI stream stops:

1. Start qv4l2 -V /dev/vbi0
     Start capture - Streaming active

2. Start qv4l2 -V /dev/vbi0
    Start capture - Streaming active
    Streaming won't start and the first stream stops.

I think there is still something that needs fixing in au0828.

If I were to start v4l2-ctl video streaming and then start
VBI streams - all 3 work correctly. I think

I am sending the patch series with audio, video, and VBI shareable
with this known issue. We will have to figure this out.

thanks,
-- Shuah
