Return-Path: <SRS0=aREJ=UZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E884C48BD6
	for <linux-media@archiver.kernel.org>; Wed, 26 Jun 2019 09:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FDF2054F
	for <linux-media@archiver.kernel.org>; Wed, 26 Jun 2019 09:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lVtVU40R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfFZJSd (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:18:33 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:46982 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZJSd (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 26 Jun 2019 05:18:33 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7AFA2510;
        Wed, 26 Jun 2019 11:18:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1561540711;
        bh=jKVxmcm3GqhZiOTNZYwS3o5R8s5pIhN0TXF/3sNtGFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lVtVU40R8Ztt2sEUySPZdjbudghocZTDQn0tnlE9F5an3LIxDZJM2EryQgIV7Zg61
         90o8pIiHmf4dnoECnKSP6MAiZq5LuRfr/JLpc+6dtj7yhrWKMBVt9gOa/RnXcmIOp4
         kzNMQeaknve8qpyo5RiRMQdj45/+MHcbPZxHka5c=
Date:   Wed, 26 Jun 2019 12:16:01 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org
Subject: Re: [PATCH 13/16] vsp1: set device_caps in struct video_device
Message-ID: <20190626091601.GC4776@pendragon.ideasonboard.com>
References: <20190626074421.38739-1-hverkuil-cisco@xs4all.nl>
 <20190626074421.38739-14-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190626074421.38739-14-hverkuil-cisco@xs4all.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Hans,

Thank you for the patch.

On Wed, Jun 26, 2019 at 09:44:18AM +0200, Hans Verkuil wrote:
> Instead of filling in the struct v4l2_capability device_caps
> field, fill in the struct video_device device_caps field.
> 
> That way the V4L2 core knows what the capabilities of the
> video device are.
> 
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/media/platform/vsp1/vsp1_histo.c |  3 +--
>  drivers/media/platform/vsp1/vsp1_video.c | 12 ++++--------
>  2 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/platform/vsp1/vsp1_histo.c b/drivers/media/platform/vsp1/vsp1_histo.c
> index 8b01e99acd20..30d751f2cccf 100644
> --- a/drivers/media/platform/vsp1/vsp1_histo.c
> +++ b/drivers/media/platform/vsp1/vsp1_histo.c
> @@ -426,8 +426,6 @@ static int histo_v4l2_querycap(struct file *file, void *fh,
>  			  | V4L2_CAP_VIDEO_CAPTURE_MPLANE
>  			  | V4L2_CAP_VIDEO_OUTPUT_MPLANE
>  			  | V4L2_CAP_META_CAPTURE;
> -	cap->device_caps = V4L2_CAP_META_CAPTURE
> -			 | V4L2_CAP_STREAMING;
>  
>  	strscpy(cap->driver, "vsp1", sizeof(cap->driver));
>  	strscpy(cap->card, histo->video.name, sizeof(cap->card));
> @@ -556,6 +554,7 @@ int vsp1_histogram_init(struct vsp1_device *vsp1, struct vsp1_histogram *histo,
>  	histo->video.vfl_type = VFL_TYPE_GRABBER;
>  	histo->video.release = video_device_release_empty;
>  	histo->video.ioctl_ops = &histo_v4l2_ioctl_ops;
> +	histo->video.device_caps = V4L2_CAP_META_CAPTURE | V4L2_CAP_STREAMING;
>  
>  	video_set_drvdata(&histo->video, histo);
>  
> diff --git a/drivers/media/platform/vsp1/vsp1_video.c b/drivers/media/platform/vsp1/vsp1_video.c
> index fd98e483b2f4..fee2ec45b1d6 100644
> --- a/drivers/media/platform/vsp1/vsp1_video.c
> +++ b/drivers/media/platform/vsp1/vsp1_video.c
> @@ -955,14 +955,6 @@ vsp1_video_querycap(struct file *file, void *fh, struct v4l2_capability *cap)
>  	cap->capabilities = V4L2_CAP_DEVICE_CAPS | V4L2_CAP_STREAMING
>  			  | V4L2_CAP_VIDEO_CAPTURE_MPLANE
>  			  | V4L2_CAP_VIDEO_OUTPUT_MPLANE;
> -
> -	if (video->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
> -		cap->device_caps = V4L2_CAP_VIDEO_CAPTURE_MPLANE
> -				 | V4L2_CAP_STREAMING;
> -	else
> -		cap->device_caps = V4L2_CAP_VIDEO_OUTPUT_MPLANE
> -				 | V4L2_CAP_STREAMING;
> -

Could you please keep this blank line ? Apart from that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Feel free to merge the patch as part of the series, I don't have any
queued conflicting change.

>  	strscpy(cap->driver, "vsp1", sizeof(cap->driver));
>  	strscpy(cap->card, video->video.name, sizeof(cap->card));
>  	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:%s",
> @@ -1268,11 +1260,15 @@ struct vsp1_video *vsp1_video_create(struct vsp1_device *vsp1,
>  		video->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
>  		video->pad.flags = MEDIA_PAD_FL_SOURCE;
>  		video->video.vfl_dir = VFL_DIR_TX;
> +		video->video.device_caps = V4L2_CAP_VIDEO_OUTPUT_MPLANE |
> +					   V4L2_CAP_STREAMING;
>  	} else {
>  		direction = "output";
>  		video->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
>  		video->pad.flags = MEDIA_PAD_FL_SINK;
>  		video->video.vfl_dir = VFL_DIR_RX;
> +		video->video.device_caps = V4L2_CAP_VIDEO_CAPTURE_MPLANE |
> +					   V4L2_CAP_STREAMING;
>  	}
>  
>  	mutex_init(&video->lock);

-- 
Regards,

Laurent Pinchart
