Return-Path: <SRS0=Gl4L=SD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0A7C43381
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 14:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CED208E4
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 14:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554130476;
	bh=WyovtLypaObKdnxxXOrjsm96PbsjLmcI42lS0gtwfUQ=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To:List-ID:From;
	b=1bHkmE/ZzlpQuFXVceoKPu5Se120WfNIQFK/7EDpfO/7pts8izZahF8pnxekXb53M
	 rsIaTcyitEnE9eSPfDfxzpqNsyQAlq8LZGMZrZlsH5B4HgA8UatSRuDlWlik1Mgzdu
	 0Vx90mHKNVll7lSE3lQ6y/+eb9F5mh5YdMFeGRGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfDAOyf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:54:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfDAOyf (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 1 Apr 2019 10:54:35 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE1CD20880;
        Mon,  1 Apr 2019 14:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554130475;
        bh=WyovtLypaObKdnxxXOrjsm96PbsjLmcI42lS0gtwfUQ=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=IbXGw9XWncealp/c3HjCiqkju9S8ubi3YO0lXrZJ0SEki437yON8anaFlGiUo/ymK
         AwI7d8jRm2uBFJVgdVwqvl9+qEyjHeeDVF1OMiQ4oi4vAMMypIjblXYTdfdK4h8yyH
         durd87qFhmiO1XHzg3kFTs09TBGPkQa4b8jAJB8M=
Subject: Re: [PATCH] au0828: stop video streaming only when last user stops
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
References: <6add9687-d261-889f-af30-635b065a49c9@xs4all.nl>
Cc:     shuah <shuah@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <7033738c-a4b3-2751-ba30-fab0f323dc30@kernel.org>
Date:   Mon, 1 Apr 2019 08:54:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <6add9687-d261-889f-af30-635b065a49c9@xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/1/19 5:18 AM, Hans Verkuil wrote:
> If the application was streaming from both videoX and vbiX, and streaming
> from videoX was stopped, then the vbi streaming also stopped.
> 
> The cause being that stop_streaming for video stopped the subdevs as well,
> instead of only doing that if dev->streaming_users reached 0.
> 
> au0828_stop_vbi_streaming was also wrong since it didn't stop the subdevs
> at all when dev->streaming_users reached 0.
> 
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
> diff --git a/drivers/media/usb/au0828/au0828-video.c b/drivers/media/usb/au0828/au0828-video.c
> index e17047b94b87..fb8e42c74653 100644
> --- a/drivers/media/usb/au0828/au0828-video.c
> +++ b/drivers/media/usb/au0828/au0828-video.c
> @@ -861,10 +861,11 @@ static void au0828_stop_streaming(struct vb2_queue *vq)
> 
>   	dprintk(1, "au0828_stop_streaming called %d\n", dev->streaming_users);
> 
> -	if (dev->streaming_users-- == 1)
> +	if (dev->streaming_users-- == 1) {
>   		au0828_uninit_isoc(dev);
> +		v4l2_device_call_all(&dev->v4l2_dev, 0, video, s_stream, 0);
> +	}
> 
> -	v4l2_device_call_all(&dev->v4l2_dev, 0, video, s_stream, 0);
>   	dev->vid_timeout_running = 0;
>   	del_timer_sync(&dev->vid_timeout);
> 
> @@ -893,8 +894,10 @@ void au0828_stop_vbi_streaming(struct vb2_queue *vq)
>   	dprintk(1, "au0828_stop_vbi_streaming called %d\n",
>   		dev->streaming_users);
> 
> -	if (dev->streaming_users-- == 1)
> +	if (dev->streaming_users-- == 1) {
>   		au0828_uninit_isoc(dev);
> +		v4l2_device_call_all(&dev->v4l2_dev, 0, video, s_stream, 0);
> +	}
> 
>   	spin_lock_irqsave(&dev->slock, flags);
>   	if (dev->isoc_ctl.vbi_buf != NULL) {
> 


Thanks. I will test the series with this patch and send v15

thanks again,
-- Shuah
