Return-Path: <SRS0=ytLV=SL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B20C10F0E
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 13:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CD62084C
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 13:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="p5TVHc4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfDINZS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:25:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46001 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbfDINZR (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 9 Apr 2019 09:25:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id y6so14429040ljd.12
        for <linux-media@vger.kernel.org>; Tue, 09 Apr 2019 06:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fQfLkONmNAk63CARVr2LESPq+T25TBHaKuJAarMPekg=;
        b=p5TVHc4MEgnVIFl8ynQbRTqhg91WBScP+sSbgf8COQE+g5EBEPujisos4cOYhKQOGE
         r3lcnv966BICMUIJWscVsqLZ80a9Cu//dxxb1HbJ/FdkycNMALNkErT30xz/5LKuW59s
         ZK/n8W8zvSrAVdn/Q3JdELMP05OUZtkimZkkbnE4rG9hFLvxQChUKQzfSh/IQuf1zks/
         OAEraEkizyIHTuurTOoaAoDmyA/lrmkclhR0PNS1S5U+R5o6hcza9Ld0L+UIbdCKCTt/
         oxYQtgs7lSZr0NfwxZXbUShU0T6fDQoL7iJTLrBM7rkmM7iZNcQLJqOnW5DO8QNIJMdh
         UCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fQfLkONmNAk63CARVr2LESPq+T25TBHaKuJAarMPekg=;
        b=ApwSMXn38tPdMhESPNMIYEblUPELH+ZBomagIYk4rNRGMfHytMuFXlwdWckaaH24iZ
         700N4Bl5VXjPRBNJZ0m5ZiXYjX6rAae3n+zHR7iPr9dDFOw2bHRmTNb1dIOGwZts/D1z
         pypi73ut3RfgFMVQYqSCnfhZ7jRpvGBmBkCnP3s3DkAZocr3XEpnQrAgtJp8qtdDLnGG
         mThBHUlLFzjapq9YxREgTt+Ua00wH9YzvS4GBfXvMIaOLDskRGZBUO3WEgbzFo0aLeJF
         giR62PxKVTQTMbb0wrcAdQ00CiyCiPX+8hKMn/S+QF6UnRzmTTZBdOKdyUmLqHNLczdJ
         8GZw==
X-Gm-Message-State: APjAAAVQSXXqC3XkFN+am2JDsMVxCRNabjtd140KFWjTr0xVt/7LopWC
        S1k4MtLYM+Pbvb4Ym+d0yDbpfg==
X-Google-Smtp-Source: APXvYqxxbgun7bsKfTBPK1mdT9eSIq5hsSuGFZ+lqbXj1cnkuMSZ/gIWMhNaAz6NBiqbYOKPsJNeKA==
X-Received: by 2002:a2e:9649:: with SMTP id z9mr2645682ljh.92.1554816314373;
        Tue, 09 Apr 2019 06:25:14 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id s16sm5485056lji.61.2019.04.09.06.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 06:25:13 -0700 (PDT)
Date:   Tue, 9 Apr 2019 15:25:13 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        "George G. Davis" <george_davis@mentor.com>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Michael Rodin <mrodin@de.adit-jv.com>,
        Eugen Friedrich <efriedrich@de.adit-jv.com>,
        harsha.manjulamallikarjun@in.bosch.com,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v3 3/9] media: rcar-vin: Create a group notifier
Message-ID: <20190409132512.GO15350@bigcity.dyn.berto.se>
References: <20190405161639.GA10433@vmlxhi-102.adit-jv.com>
 <25dc2668-d270-ebf8-b014-88bbb7a6f243@gmail.com>
 <20190408111241.GF15350@bigcity.dyn.berto.se>
 <df6fa3bf-bf21-50b0-2cad-a613e2a43ce0@gmail.com>
 <76121e08-246a-a1d8-3d49-7d52f92b7c9e@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76121e08-246a-a1d8-3d49-7d52f92b7c9e@ideasonboard.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Steve, Kieran,

On 2019-04-09 10:10:45 +0100, Kieran Bingham wrote:
> Hi Steve, Niklas,
> 
> Just a small 2-cents below:
> 
> On 09/04/2019 04:58, Steve Longerbeam wrote:
> > 
> > 
> > On 4/8/19 4:12 AM, Niklas Söderlund wrote:
> >> Hi Steve, Eugeniu,
> >>
> >> On 2019-04-05 17:04:50 -0700, Steve Longerbeam wrote:
> >>> Hi Niklas, all,
> >>>
> >>>
> >>> On 4/5/19 9:16 AM, Eugeniu Rosca wrote:
> >>>> Hi Niklas, Jacopo cc: Steve
> >>>>
> >>>> Apologize for reviving this old thread. Just one question below.
> >>>>
> >>>> On 2018-05-24 10:14:52, Niklas Söderlund wrote:
> >>>>
> >>>> [..]
> >>>>
> >>>>>> +
> >>>>>>    #define vin_to_source(vin)        ((vin)->parallel->subdev)
> >>>>> This in particular I hate and at some point I hope to remove it or
> >>>>> move  it to rcar-v4l2.c. :-) But that is a task for later and not
> >>>>> related to  your patch-set.
> >>>> What about below patch excerpt (courtesy of Steve) which is currently
> >>>> under review in our tree? If we are on the same page here, we would
> >>>> happily contribute a patch to you based on below.
> >>> I can submit this patch to media-tree ML for formal review.
> >> I see no problem with the patch itself but as you point out bellow there
> >> are other patches which makes of the change I assume? The change to
> >> vin_to_source() on it's own would not add much value as vin_to_source()
> >> is currently only used in the none-mc parts of the driver where the
> >> change bellow would never be used.
> >>
> >> My dream would be to one day drop the none-mc mode of this driver, or
> >> split it out to a rcar-vin-legacy module or something ;-)
> > 
> > Yes, that's something that has been confusing me. Why does there need to
> > be a distinction between a media control mode non-mc mode in the
> > rcar-vin driver? I understand the "digital"/"parallel" mode is to handle
> > sensors with a parallel interface (as opposed to MIPI CSI-2), but why
> > not make the parallel sensors also require media-control
> > (enabling/disable media links, etc.)?
> > 
> > 

The issue is backward compatibility. The original driver targeted 
Renesas Gen2 board which was relatively simple and might even pre-date 
the media controller api. When I extended the diver to support Gen3 
boards which are more complex I had to add media controller support to 
the driver. There is a huge overlap (rcar-dma.c) between Gen2 and Gen3 
and it seemed silly to have two drivers.

As a side note Jacopo added support for the parallel node in the media 
controller for Gen3 boards which have the same pipeline as Gen2. So 
everything needed to remove the none MC code paths are in the driver but 
I'm afraid that would upset current users on Gen2 ;-)

> >>
> >>> But there are also other patches to rcar-vin applied to the tree
> >>> mentioned
> >>> by Eugeniu, which can broadly be described as:
> >>>
> >>> 1. If the rcar-csi2 sub-device's source pad format is changed via
> >>> media-ctl,
> >>> the connected VIN's crop bounds (vin->source rectangle) will be
> >>> stale, since
> >>> vin->source must always be equal to the source pad rectangle. So we
> >>> have a
> >>> patch that will catch the asynchronous V4L2_EVENT_SOURCE_CHANGE event
> >>> sent
> >>> from the rcar-csi2 sub-device when its source pad format is changed. In
> >>> response, the VIN connected to that rcar-csi2 sub-device will reset
> >>> the crop
> >>> bounds to the new source pad format rectangle. In order to make this
> >>> work
> >>> however...
> >> I'm no expert on when the crop/selection rectangles shall be reset and
> >> have wrestled with this in the past for this driver. I have partial
> >> rework of how formats especially crop/selection works planed. My goal of
> >> that is to try and make it simpler and more straight forward taking
> >> ideas from the vivid driver. There are some limitations in my
> >> implementation of this in the current driver which prevents me from
> >> adding sequential formats and enable the UDS scaler.
> > 
> > Ok. What I did for imx-media driver is to export a function from the
> > video capture interface that allows the source sub-device connected to
> > the capture interface to call it when the source pad format changes,
> > which gives the capture interface the chance to adjust compose window
> > (unlike rcar-vin, imx capture interface doesn't crop or scale, the
> > connected source subdev does that, but it does pad the compose window so
> > it needs to know the original compose window, sorry hope I haven't lost
> > you). Anyway I think catching the V4L2_EVENT_SOURCE_CHANGE event is
> > maybe a cleaner way to update the crop bounds in rcar-vin than using an
> > exported function.
> > 

I agree V4L2_EVENT_SOURCE_CHANGE could be a nice way of doing this if 
the event routing is sorted out.

> > 
> > 
> >>
> >>> 2. Sub-device events need to be forwarded to the VIN's that have enabled
> >>> media links to the reporting sub-device. Currently, sub-device events
> >>> are
> >>> only forwarded to VIN7, because the notifier is registered only from
> >>> VIN7,
> >>> and so the sub-devices are registered only to the v4l2_dev owned by
> >>> VIN7. So
> >>> we have a set of patches that fix this: sub-device events get
> >>> forwarded to
> >>> the VIN's that have connected media paths to that sub-device. Besides
> >>> allowing to reset the VIN crop bounds rectangle asynchronously, this
> >>> also
> >>> seems to be logically the correct behavior. It also makes the user
> >>> interface
> >>> a little more intuitive: userland knows which VIN it is capturing on,
> >>> and
> >>> that is the same VIN that will be receiving sub-device events in the
> >>> active
> >>> pipeline.
> >> This is a problem I ponder from time to time, happy to hear I'm not the
> >> only one :-) My view is that events are somewhat not functional in the
> >> media controller world and should be fixed at the framework level, maybe
> >> by moving them from the vdev to the mdev :-)
> > 
> > How about embedding the 'struct v4l2_device' into 'struct rvin_group'
> > instead of 'struct rvin_dev'? That probably makes more sense, the
> > v4l2_dev keeps track of media-device-wide info such as the list of
> > sub-devices in the graph, so it seems more appropriate to create only
> > one instance of v4l2_dev. That will force rcar-vin to lookup the correct
> > VINs to forward the event to, since v4l2_dev is no longer attached to
> > the VINs.

It might solve the event routing problem but will create others. For 
example each VIN instance can have a private notifier if it has a 
parallel subdevice and be part of VIN group for the ones coming from 
CSI-2.

> > 
> > But moving events from v4l2 to media (e.g. media entities send events to
> > the mdev, rather than v4l2 sub-devices sending events to the v4l2_dev)
> > is also an interesting idea.

I think this is the right way to go.

> > 
> >> I think it's great that you worked on the problem but I'm a bit
> >> concerned with addressing this on a driver basis. Maybe this is
> >> something to bring up at the next v4l2 summit? I might be wrong here and
> >> there already is a consensus to address this as you describe in each
> >> driver. Do you have any insights on the topic?
> > 
> > I haven't been tuned into that topic, but yes I agree that events need a
> > better framework.
> > 
> > 
> >>
> >>> 3. We have some patches under review that allow alternate -> none field
> >>> mode. That is, source sub-device is sending alternate fields (top,
> >>> bottom,
> >>> top, ...), and userland is configured to receive those fields
> >>> unmodified by
> >>> setting field type to none. rcar-dma then detects and reports the
> >>> field type
> >>> of the captured field (top or bottom) in (struct v4l2_buffer)->field.
> >>> Doing
> >>> this allows for de-interlacing the captured fields using the FDP1
> >>> mem2mem
> >>> device.
> >> Interesting, maybe I'm missing something but would it not be a better
> >> solution to add support for V4L2_FIELD_ALTERNATE to rcar-vin instead of
> >> abusing V4L2_FIELD_NONE?
> > 
> > Well, from 6c51f646f6 ("media: rcar-vin: fix handling of single field
> > frames (top, bottom and alternate fields)"),
> > 
> > "There was never proper support in the VIN driver to deliver ALTERNATING
> > field format to user-space, remove this field option. The problem is
> > that ALTERNATING field order requires the sequence numbers of buffers
> > returned to userspace to reflect if fields were dropped or not,
> > something which is not possible with the VIN drivers capture logic."
> > 
> > Is that still a concern, or can alternate mode be brought back but with
> > possibly the above limitation?
> 
> I think that might have been before we added the scratch buffer to
> support continuous capture?
> 
> Now that we have that - I think we should be able to correctly track
> dropped frames right?

I think you are correct Kieran, we now have the scratch buffer so it 
should be possible to add proper support for delivering ALTERNATING to 
userspace. I'm sure we find new issues on the way tho ;-)

> 
> 
> > 
> > Also, there is this paragraph in [1] regarding V4L2_FIELD_NONE, so it
> > sounds like using this field type in this way may not be too much abuse :)

My bad I should have said using instead of abusing, sorry about that :-) 
I did not know that this was a valid use-case for FIELD_NONE so yes I 
think it could be used if we can't solve the requirements for adding 
ALTERNATING.

> > 
> > "Images are in progressive format, not interlaced. The driver may also
> > indicate this order when it cannot distinguish
> > between|V4L2_FIELD_TOP|and|V4L2_FIELD_BOTTOM|."
> > 
> > [1] https://linuxtv.org/downloads/v4l-dvb-apis/uapi/v4l/field-order.html
> > 
> > 
> > Steve
> > 
> >>
> >>> There are some other miscellaneous patches that I can submit, but the
> >>> above
> >>> describes the bulk of the changes.
> >> I'm happy to see work being done on the driver and would of course like
> >> to help you get all changes upstream so that all your use-cases would
> >> work out-of-the-box.
> >>
> >>> Before I start on porting these patches to the media-tree, do the above
> >>> changes make general sense, or are there fundamental problems with those
> >>> ideas?
> >>>
> >>> TIA,
> >>> Steve
> >>>
> >>>
> >>>> Subject: [PATCH] media: rcar-vin: Generalize vin_to_source()
> >>>>
> >>>> Change the vin_to_source() macro to an inline function that will
> >>>> retrieve the source subdevice for both media-control and non
> >>>> media-control mode.
> >>>>
> >>>> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> >>>> ---
> >>>> [..]
> >>>>
> >>>> diff --git a/drivers/media/platform/rcar-vin/rcar-vin.h
> >>>> b/drivers/media/platform/rcar-vin/rcar-vin.h
> >>>> index 0b13b34d03e3..29d8c4a80c35 100644
> >>>> --- a/drivers/media/platform/rcar-vin/rcar-vin.h
> >>>> +++ b/drivers/media/platform/rcar-vin/rcar-vin.h
> >>>> @@ -217,7 +217,21 @@ struct rvin_dev {
> >>>>        v4l2_std_id std;
> >>>>    };
> >>>> -#define vin_to_source(vin)        ((vin)->parallel->subdev)
> >>>> +static inline struct v4l2_subdev *
> >>>> +vin_to_source(struct rvin_dev *vin)
> >>>> +{
> >>>> +    if (vin->info->use_mc) {
> >>>> +        struct media_pad *pad;
> >>>> +
> >>>> +        pad = media_entity_remote_pad(&vin->pad);
> >>>> +        if (!pad)
> >>>> +            return NULL;
> >>>> +
> >>>> +        return media_entity_to_v4l2_subdev(pad->entity);
> >>>> +    }
> >>>> +
> >>>> +    return vin->parallel->subdev;
> >>>> +}
> >>>>    /* Debug */
> >>>>    #define vin_dbg(d, fmt, arg...)        dev_dbg(d->dev, fmt, ##arg)
> >>>>
> >>>> Best regards,
> >>>> Eugeniu.
> > 
> 
> -- 
> Regards
> --
> Kieran

-- 
Regards,
Niklas Söderlund
