Return-Path: <SRS0=AJrZ=SI=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39EDC282DC
	for <linux-media@archiver.kernel.org>; Sat,  6 Apr 2019 00:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C312221871
	for <linux-media@archiver.kernel.org>; Sat,  6 Apr 2019 00:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLk1TMfk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfDFAFA (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 5 Apr 2019 20:05:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52809 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDFAE7 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 5 Apr 2019 20:04:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so8319430wma.2;
        Fri, 05 Apr 2019 17:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pLZ3CZZf+WBwXELqg6A+r9bdvOzaetAYnoCneUV6jes=;
        b=DLk1TMfkNzACjhswAC6n6Hjo9H29cF9oxrOJ2RyoFttBnYprRvUrhUBN8fYxswCbhx
         HTZgqoVfII6hM0jVJ1fw7SXgMz9ZT44XpalWDYO/QHbdoBZ9olUHXMa5qdVPPpqDtjDh
         aKc/QI2ykYaVSkHXyu7zy4mqfrT32i3j1ICB+hVkXuTS97b2i/k17NP08DbX0PH4rU6f
         5Vp9GNtsk1Zipt15LTmuE3sYtgCRhfnFaYHP+UN1pFTEJF/uJwMwM4FNgc5BNucTNLHL
         l7V2QYBUvtBrLi7CIC38e6ygbXwmlMeF3YqugQ3i3oWBDgTgL/gS6Ead+xue06ugdyyU
         cL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pLZ3CZZf+WBwXELqg6A+r9bdvOzaetAYnoCneUV6jes=;
        b=nJaXz4tx+CBgUuXVYwgi41rci9EkHDnX37FqXR97RgNpSPFAn0NdBeP7euxK1WxZuW
         pOBQCBE8w3rxPHFtPFxb6ilpJqwL3K0k9SodY+F0uEp4IHeCz8DJKFSUM1kqyVoAG9rX
         Mk+7gGYnSvl+OHgGdXpvNpUnUpGeeRWvOFwS6Z93Mdr3cJnL1I/1fbYbTe7v/Iosplzr
         dK+5lxj9jzHi/oYYshz38WkOgd1pGnbVCmSEkZLLDu6bZLv3AcpRXmOmgsK+w/9gpZvK
         S4zbQh9s3eop4f7SPdxdW+i/QtpKUfTeNcLDluqs3iExZgveuqZxPFYRDGWg9n4e+f9B
         d8uw==
X-Gm-Message-State: APjAAAXpTjkFQSrGRRuFvvs8taqv6IsylIzpCfT6gdAvCaiVbvuApC1U
        9FN7GyB2lcs1lSzZut9rLX4=
X-Google-Smtp-Source: APXvYqyASPVJLByTvG1bOnMCMKOZj8PslN1BRAggByzUfNnKYh1vDUgIepF6XgLwY0FFTf+DfbgHPw==
X-Received: by 2002:a1c:b646:: with SMTP id g67mr10139369wmf.125.1554509096836;
        Fri, 05 Apr 2019 17:04:56 -0700 (PDT)
Received: from [172.30.88.187] (sjewanfw1-nat.mentorg.com. [139.181.7.34])
        by smtp.gmail.com with ESMTPSA id a17sm2471133wmg.40.2019.04.05.17.04.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 17:04:55 -0700 (PDT)
Subject: Re: [PATCH v3 3/9] media: rcar-vin: Create a group notifier
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        "George G. Davis" <george_davis@mentor.com>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Michael Rodin <mrodin@de.adit-jv.com>,
        Eugen Friedrich <efriedrich@de.adit-jv.com>,
        harsha.manjulamallikarjun@in.bosch.com,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
References: <20190405161639.GA10433@vmlxhi-102.adit-jv.com>
From:   Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <25dc2668-d270-ebf8-b014-88bbb7a6f243@gmail.com>
Date:   Fri, 5 Apr 2019 17:04:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405161639.GA10433@vmlxhi-102.adit-jv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Niklas, all,


On 4/5/19 9:16 AM, Eugeniu Rosca wrote:
> Hi Niklas, Jacopo cc: Steve
>
> Apologize for reviving this old thread. Just one question below.
>
> On 2018-05-24 10:14:52, Niklas Söderlund wrote:
>
> [..]
>
>>> +
>>>   #define vin_to_source(vin)		((vin)->parallel->subdev)
>> This in particular I hate and at some point I hope to remove it or
>> move  it to rcar-v4l2.c. :-) But that is a task for later and not
>> related to  your patch-set.
> What about below patch excerpt (courtesy of Steve) which is currently
> under review in our tree? If we are on the same page here, we would
> happily contribute a patch to you based on below.

I can submit this patch to media-tree ML for formal review.

But there are also other patches to rcar-vin applied to the tree 
mentioned by Eugeniu, which can broadly be described as:

1. If the rcar-csi2 sub-device's source pad format is changed via 
media-ctl, the connected VIN's crop bounds (vin->source rectangle) will 
be stale, since vin->source must always be equal to the source pad 
rectangle. So we have a patch that will catch the asynchronous 
V4L2_EVENT_SOURCE_CHANGE event sent from the rcar-csi2 sub-device when 
its source pad format is changed. In response, the VIN connected to that 
rcar-csi2 sub-device will reset the crop bounds to the new source pad 
format rectangle. In order to make this work however...

2. Sub-device events need to be forwarded to the VIN's that have enabled 
media links to the reporting sub-device. Currently, sub-device events 
are only forwarded to VIN7, because the notifier is registered only from 
VIN7, and so the sub-devices are registered only to the v4l2_dev owned 
by VIN7. So we have a set of patches that fix this: sub-device events 
get forwarded to the VIN's that have connected media paths to that 
sub-device. Besides allowing to reset the VIN crop bounds rectangle 
asynchronously, this also seems to be logically the correct behavior. It 
also makes the user interface a little more intuitive: userland knows 
which VIN it is capturing on, and that is the same VIN that will be 
receiving sub-device events in the active pipeline.

3. We have some patches under review that allow alternate -> none field 
mode. That is, source sub-device is sending alternate fields (top, 
bottom, top, ...), and userland is configured to receive those fields 
unmodified by setting field type to none. rcar-dma then detects and 
reports the field type of the captured field (top or bottom) in (struct 
v4l2_buffer)->field. Doing this allows for de-interlacing the captured 
fields using the FDP1 mem2mem device.

There are some other miscellaneous patches that I can submit, but the 
above describes the bulk of the changes.

Before I start on porting these patches to the media-tree, do the above 
changes make general sense, or are there fundamental problems with those 
ideas?

TIA,
Steve


>
> Subject: [PATCH] media: rcar-vin: Generalize vin_to_source()
>
> Change the vin_to_source() macro to an inline function that will
> retrieve the source subdevice for both media-control and non
> media-control mode.
>
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> ---
> [..]
>
> diff --git a/drivers/media/platform/rcar-vin/rcar-vin.h b/drivers/media/platform/rcar-vin/rcar-vin.h
> index 0b13b34d03e3..29d8c4a80c35 100644
> --- a/drivers/media/platform/rcar-vin/rcar-vin.h
> +++ b/drivers/media/platform/rcar-vin/rcar-vin.h
> @@ -217,7 +217,21 @@ struct rvin_dev {
>   	v4l2_std_id std;
>   };
>   
> -#define vin_to_source(vin)		((vin)->parallel->subdev)
> +static inline struct v4l2_subdev *
> +vin_to_source(struct rvin_dev *vin)
> +{
> +	if (vin->info->use_mc) {
> +		struct media_pad *pad;
> +
> +		pad = media_entity_remote_pad(&vin->pad);
> +		if (!pad)
> +			return NULL;
> +
> +		return media_entity_to_v4l2_subdev(pad->entity);
> +	}
> +
> +	return vin->parallel->subdev;
> +}
>   
>   /* Debug */
>   #define vin_dbg(d, fmt, arg...)		dev_dbg(d->dev, fmt, ##arg)
>
> Best regards,
> Eugeniu.

