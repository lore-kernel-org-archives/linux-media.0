Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD150C10F0E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 09:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1251205F4
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 09:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDLJhA (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:37:00 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:38155 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726709AbfDLJhA (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 05:37:00 -0400
Received: from [IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68] ([IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68])
        by smtp-cloud7.xs4all.net with ESMTPA
        id EscBhzhXPNG8zEscChC5oR; Fri, 12 Apr 2019 11:36:57 +0200
Subject: Re: [RFC PATCH v2 1/7] media: v4l2: Get rid of
 ->vidioc_enum_fmt_vid_{cap,out}_mplane
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Mauro Carvalho Chehab <m.chehab@samsung.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        linux-media@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        Hirokazu Honda <hiroh@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Brian Starkey <Brian.Starkey@arm.com>, kernel@collabora.com
References: <20190404081700.30006-1-boris.brezillon@collabora.com>
 <20190404081700.30006-2-boris.brezillon@collabora.com>
 <c13c2c30-f78e-1cf2-26d3-1554e22947c3@xs4all.nl>
 <20190411123636.07990b79@collabora.com>
 <6f8ec61c-1f36-accb-cc00-984d1041aa28@xs4all.nl>
 <20190412102526.53de44ee@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <eb58b8a9-d609-7a12-ede9-87dab1e91e55@xs4all.nl>
Date:   Fri, 12 Apr 2019 11:36:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412102526.53de44ee@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEYRuUN/jYOj1nd28k36SWnm0zeSJe+/OyX7zOsya3utOedSd0ey4iW6thnEbw04BYs4btq3G1KxzxwGOASewgdsZDz64wftvpWuyBvdxQo3OuIKeLII
 97k4yNhfjUuSPI8kj0OD0xzfiV6yH4OW7XEdxstbyiqVnMKUafrIdBA4P13xk1M6CsjuFxmIXuBy440t58OHFqQ5c4FS+tXFsvMsrzVbMAcJ3KmvkQ6uA+Qe
 PpCW/YE9xJ9bK/5//n9ngKS8zzLCMU7VKslMx7fEBHlHPjFCkxHF5CgTuDhPQ5ngOAgHjSfu+6yMo6IedYdzjTAJnJidIWl6j8xKAuMOKKu2Ago14oCLHz63
 gaqI2CKVO5uN3EkENezxbj3jyX79sdBDJhIVfo2zq7s36m0NHll+Mezf3+AjF7AEc4ZtSsAmguNcbax7KBlK2nz4UgW2PdmlkTn66eWw1t1m55ZpOaZ/aaBY
 4DyGMh2VFucxnz0Bm7nhQUcrnCCr3TxyWmNOiNt2qmFa94ptuC+S7YlpIS4JA8+9QyEqs0C+zkdP9wI0on04CinMKbFChhX9l4x3OHczCLFIizNRPO6aLV0N
 9huI9lbCgwfEvvW3NLOb8xsdXPlIFsMwGofkDwrLs14VQg==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/12/19 10:25 AM, Boris Brezillon wrote:
> On Thu, 11 Apr 2019 12:38:06 +0200
> Hans Verkuil <hverkuil@xs4all.nl> wrote:
> 
>>>>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>> index f6d663934648..97ba365218fb 100644
>>>>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>> @@ -1380,6 +1380,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>>>>>  static int v4l_enum_fmt(const struct v4l2_ioctl_ops *ops,
>>>>>  				struct file *file, void *fh, void *arg)
>>>>>  {
>>>>> +	struct video_device *vdev = video_devdata(file);
>>>>>  	struct v4l2_fmtdesc *p = arg;
>>>>>  	int ret = check_fmt(file, p->type);
>>>>>  
>>>>> @@ -1389,30 +1390,30 @@ static int v4l_enum_fmt(const struct v4l2_ioctl_ops *ops,
>>>>>  
>>>>>  	switch (p->type) {
>>>>>  	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
>>>>> +	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>>>>> +		if (!!(vdev->device_caps & V4L2_CAP_VIDEO_CAPTURE_MPLANE) !=    
>>>>
>>>> Hmm. I am not sure if all drivers that set V4L2_CAP_VIDEO_CAPTURE_MPLANE also
>>>> fill in vdev->device_caps. While filling in vdev->device_caps is required for
>>>> new drivers, older drivers often don't do this.
>>>>
>>>> You would have to check all drivers that set V4L2_CAP_VIDEO_CAPTURE/OUTPUT_MPLANE
>>>> to verify that they also set vdev->device_caps. I'm fairly certain the Samsung
>>>> drivers don't fill this in.  
>>>
>>> I'll check that and fix those that don't set the flag. Or do you have
>>> another solution to handle that case?
>>>   
>>
>> There might be other solutions as well, but regardless of that it would be a very
>> good idea for other reasons as well if all MPLANE drivers would fill in vdev->device_caps.
> 
> Looks like all drivers except fimc-isp-video.c have the _MPLANE caps
> properly set/reported.
> 

That's not enough, they need to fill in vdev->device_caps as well. I.e., they shouldn't
fill in device_caps and capabilities in their querycap implementation, instead they
should just set device_caps in the struct video_device. That way the V4L2 core will
know the video device capabilities since it is now stored in an internal structure.

Regards,

	Hans
