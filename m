Return-Path: <SRS0=ytLV=SL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708DFC10F0E
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 03:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CDA20880
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 03:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSEnTsTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfDID6e (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 23:58:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46630 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfDID6e (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 23:58:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id q1so8486220pgv.13;
        Mon, 08 Apr 2019 20:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1nGWruY/lEUM0t+IhZV7qheBmlrcq/V/JF9qbPCBL4A=;
        b=DSEnTsTSytA9Emqmq0wPdRfarFbh7RfOG0qc7qvbsYgtKDQR7ik7ZIKZEtwfuzgx+g
         cNJgVUO45chrwkJIJyB2w26y/dNYf7yN2VeqqB8RRDbDArnjQWh2WLotVeys42x/P7Ht
         iazSAZ+PsUWWDzd8Lmdn+Sp6oMbQ6GUUmYIeI7v1E+M0zleN1pqOsGnLs13mOQ6GEEOa
         J4VvTzm9JS9QjHwXDFwI0LmVKkxXwOp4p/duaWz/zpthBOg+fqwMNwUy3hWEZ83EW+l2
         p3S4C/Zg7f1kVYWtMMgzc9BIBRiVKP9mVFDwXFkc/7G+nxHxIdMy/bVsskV6k80LVDfZ
         iDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1nGWruY/lEUM0t+IhZV7qheBmlrcq/V/JF9qbPCBL4A=;
        b=dOZ5BcnjGOZfOk9g6A613mlAq4wm7qS0pzq5SVYfW6txazfIQp2iYizJPJUbIaKvmL
         W4Iz0L4F6reAwSNANhdt/RMnTwAjNTAnBwkCtfO5IZEvyOoKbeUdqD0TMBOHmKUnuUsr
         LBShaJJn1JOmn5tFuM/5Ratmw4jtRNDBaLxi0IINpAtvdXzEM1X7OZwejXjsknoOuBpk
         8O4ikZvXpp75Sa9jX3TodPlSy1fTGm1qRL9yNgNiTD3qwX8E/uHGhIRDBqJFmGozo6F5
         3IC0TOta6Mp0QoVQt9FVY7c46+2xL9w0Zcxfrzswx4WaVISITkM1hGq6b7SuopEtY1+q
         lL3A==
X-Gm-Message-State: APjAAAWU2zxK/38x1NoQZwLhQ5sz2iP7xuz0NoJKjwjewjwaSMOU5u7t
        upYDNvg8i+zTTfO/JseGFkg=
X-Google-Smtp-Source: APXvYqxE4cfyShTlAqcP7zDYZa/wmEHgldhZ+HhvnlTrhyvtIpWHf43aS7sKEheW4gSNJupoBnUTgQ==
X-Received: by 2002:a62:14d7:: with SMTP id 206mr33329697pfu.162.1554782312713;
        Mon, 08 Apr 2019 20:58:32 -0700 (PDT)
Received: from [192.168.1.59] (c-73-202-231-77.hsd1.ca.comcast.net. [73.202.231.77])
        by smtp.gmail.com with ESMTPSA id 75sm56869001pfr.55.2019.04.08.20.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 20:58:31 -0700 (PDT)
Subject: Re: [PATCH v3 3/9] media: rcar-vin: Create a group notifier
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
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
 <25dc2668-d270-ebf8-b014-88bbb7a6f243@gmail.com>
 <20190408111241.GF15350@bigcity.dyn.berto.se>
From:   Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <df6fa3bf-bf21-50b0-2cad-a613e2a43ce0@gmail.com>
Date:   Mon, 8 Apr 2019 20:58:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408111241.GF15350@bigcity.dyn.berto.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org



On 4/8/19 4:12 AM, Niklas Söderlund wrote:
> Hi Steve, Eugeniu,
>
> On 2019-04-05 17:04:50 -0700, Steve Longerbeam wrote:
>> Hi Niklas, all,
>>
>>
>> On 4/5/19 9:16 AM, Eugeniu Rosca wrote:
>>> Hi Niklas, Jacopo cc: Steve
>>>
>>> Apologize for reviving this old thread. Just one question below.
>>>
>>> On 2018-05-24 10:14:52, Niklas Söderlund wrote:
>>>
>>> [..]
>>>
>>>>> +
>>>>>    #define vin_to_source(vin)		((vin)->parallel->subdev)
>>>> This in particular I hate and at some point I hope to remove it or
>>>> move  it to rcar-v4l2.c. :-) But that is a task for later and not
>>>> related to  your patch-set.
>>> What about below patch excerpt (courtesy of Steve) which is currently
>>> under review in our tree? If we are on the same page here, we would
>>> happily contribute a patch to you based on below.
>> I can submit this patch to media-tree ML for formal review.
> I see no problem with the patch itself but as you point out bellow there
> are other patches which makes of the change I assume? The change to
> vin_to_source() on it's own would not add much value as vin_to_source()
> is currently only used in the none-mc parts of the driver where the
> change bellow would never be used.
>
> My dream would be to one day drop the none-mc mode of this driver, or
> split it out to a rcar-vin-legacy module or something ;-)

Yes, that's something that has been confusing me. Why does there need to 
be a distinction between a media control mode non-mc mode in the 
rcar-vin driver? I understand the "digital"/"parallel" mode is to handle 
sensors with a parallel interface (as opposed to MIPI CSI-2), but why 
not make the parallel sensors also require media-control 
(enabling/disable media links, etc.)?


>
>> But there are also other patches to rcar-vin applied to the tree mentioned
>> by Eugeniu, which can broadly be described as:
>>
>> 1. If the rcar-csi2 sub-device's source pad format is changed via media-ctl,
>> the connected VIN's crop bounds (vin->source rectangle) will be stale, since
>> vin->source must always be equal to the source pad rectangle. So we have a
>> patch that will catch the asynchronous V4L2_EVENT_SOURCE_CHANGE event sent
>> from the rcar-csi2 sub-device when its source pad format is changed. In
>> response, the VIN connected to that rcar-csi2 sub-device will reset the crop
>> bounds to the new source pad format rectangle. In order to make this work
>> however...
> I'm no expert on when the crop/selection rectangles shall be reset and
> have wrestled with this in the past for this driver. I have partial
> rework of how formats especially crop/selection works planed. My goal of
> that is to try and make it simpler and more straight forward taking
> ideas from the vivid driver. There are some limitations in my
> implementation of this in the current driver which prevents me from
> adding sequential formats and enable the UDS scaler.

Ok. What I did for imx-media driver is to export a function from the 
video capture interface that allows the source sub-device connected to 
the capture interface to call it when the source pad format changes, 
which gives the capture interface the chance to adjust compose window 
(unlike rcar-vin, imx capture interface doesn't crop or scale, the 
connected source subdev does that, but it does pad the compose window so 
it needs to know the original compose window, sorry hope I haven't lost 
you). Anyway I think catching the V4L2_EVENT_SOURCE_CHANGE event is 
maybe a cleaner way to update the crop bounds in rcar-vin than using an 
exported function.



>
>> 2. Sub-device events need to be forwarded to the VIN's that have enabled
>> media links to the reporting sub-device. Currently, sub-device events are
>> only forwarded to VIN7, because the notifier is registered only from VIN7,
>> and so the sub-devices are registered only to the v4l2_dev owned by VIN7. So
>> we have a set of patches that fix this: sub-device events get forwarded to
>> the VIN's that have connected media paths to that sub-device. Besides
>> allowing to reset the VIN crop bounds rectangle asynchronously, this also
>> seems to be logically the correct behavior. It also makes the user interface
>> a little more intuitive: userland knows which VIN it is capturing on, and
>> that is the same VIN that will be receiving sub-device events in the active
>> pipeline.
> This is a problem I ponder from time to time, happy to hear I'm not the
> only one :-) My view is that events are somewhat not functional in the
> media controller world and should be fixed at the framework level, maybe
> by moving them from the vdev to the mdev :-)

How about embedding the 'struct v4l2_device' into 'struct rvin_group' 
instead of 'struct rvin_dev'? That probably makes more sense, the 
v4l2_dev keeps track of media-device-wide info such as the list of 
sub-devices in the graph, so it seems more appropriate to create only 
one instance of v4l2_dev. That will force rcar-vin to lookup the correct 
VINs to forward the event to, since v4l2_dev is no longer attached to 
the VINs.

But moving events from v4l2 to media (e.g. media entities send events to 
the mdev, rather than v4l2 sub-devices sending events to the v4l2_dev) 
is also an interesting idea.

> I think it's great that you worked on the problem but I'm a bit
> concerned with addressing this on a driver basis. Maybe this is
> something to bring up at the next v4l2 summit? I might be wrong here and
> there already is a consensus to address this as you describe in each
> driver. Do you have any insights on the topic?

I haven't been tuned into that topic, but yes I agree that events need a 
better framework.


>
>> 3. We have some patches under review that allow alternate -> none field
>> mode. That is, source sub-device is sending alternate fields (top, bottom,
>> top, ...), and userland is configured to receive those fields unmodified by
>> setting field type to none. rcar-dma then detects and reports the field type
>> of the captured field (top or bottom) in (struct v4l2_buffer)->field. Doing
>> this allows for de-interlacing the captured fields using the FDP1 mem2mem
>> device.
> Interesting, maybe I'm missing something but would it not be a better
> solution to add support for V4L2_FIELD_ALTERNATE to rcar-vin instead of
> abusing V4L2_FIELD_NONE?

Well, from 6c51f646f6 ("media: rcar-vin: fix handling of single field 
frames (top, bottom and alternate fields)"),

"There was never proper support in the VIN driver to deliver ALTERNATING 
field format to user-space, remove this field option. The problem is 
that ALTERNATING field order requires the sequence numbers of buffers 
returned to userspace to reflect if fields were dropped or not, 
something which is not possible with the VIN drivers capture logic."

Is that still a concern, or can alternate mode be brought back but with 
possibly the above limitation?

Also, there is this paragraph in [1] regarding V4L2_FIELD_NONE, so it 
sounds like using this field type in this way may not be too much abuse :)

"Images are in progressive format, not interlaced. The driver may also 
indicate this order when it cannot distinguish 
between|V4L2_FIELD_TOP|and|V4L2_FIELD_BOTTOM|."

[1] https://linuxtv.org/downloads/v4l-dvb-apis/uapi/v4l/field-order.html


Steve

>
>> There are some other miscellaneous patches that I can submit, but the above
>> describes the bulk of the changes.
> I'm happy to see work being done on the driver and would of course like
> to help you get all changes upstream so that all your use-cases would
> work out-of-the-box.
>
>> Before I start on porting these patches to the media-tree, do the above
>> changes make general sense, or are there fundamental problems with those
>> ideas?
>>
>> TIA,
>> Steve
>>
>>
>>> Subject: [PATCH] media: rcar-vin: Generalize vin_to_source()
>>>
>>> Change the vin_to_source() macro to an inline function that will
>>> retrieve the source subdevice for both media-control and non
>>> media-control mode.
>>>
>>> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
>>> ---
>>> [..]
>>>
>>> diff --git a/drivers/media/platform/rcar-vin/rcar-vin.h b/drivers/media/platform/rcar-vin/rcar-vin.h
>>> index 0b13b34d03e3..29d8c4a80c35 100644
>>> --- a/drivers/media/platform/rcar-vin/rcar-vin.h
>>> +++ b/drivers/media/platform/rcar-vin/rcar-vin.h
>>> @@ -217,7 +217,21 @@ struct rvin_dev {
>>>    	v4l2_std_id std;
>>>    };
>>> -#define vin_to_source(vin)		((vin)->parallel->subdev)
>>> +static inline struct v4l2_subdev *
>>> +vin_to_source(struct rvin_dev *vin)
>>> +{
>>> +	if (vin->info->use_mc) {
>>> +		struct media_pad *pad;
>>> +
>>> +		pad = media_entity_remote_pad(&vin->pad);
>>> +		if (!pad)
>>> +			return NULL;
>>> +
>>> +		return media_entity_to_v4l2_subdev(pad->entity);
>>> +	}
>>> +
>>> +	return vin->parallel->subdev;
>>> +}
>>>    /* Debug */
>>>    #define vin_dbg(d, fmt, arg...)		dev_dbg(d->dev, fmt, ##arg)
>>>
>>> Best regards,
>>> Eugeniu.

