Return-Path: <SRS0=ytLV=SL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A062CC282CE
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 23:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6B920857
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 23:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Scze2EyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfDIXAA (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Apr 2019 19:00:00 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:43308 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfDIXAA (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 9 Apr 2019 19:00:00 -0400
Received: from pendragon.ideasonboard.com (unknown [IPv6:2a02:2788:66a:3eb:db7d:3fc4:b0c5:3fc6])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 126CF33A;
        Wed, 10 Apr 2019 00:59:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1554850797;
        bh=pzNiNgnoA+fMN2mYo1KU8oUicdXYqkYv95JrDBZOVyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Scze2EyBUAxIaVn6QRsMyZvw5boy8DrLIEaMlwEluKTQMY+WbYofmo58W0Kh39IJO
         LBe9dPvgH13Y/gpgw9bNOJXBwkXbPipQZzjur7KqqF6OsEfFSddfWT9W4L4oOWWJS5
         HFdkyH5iFuM1QaFHu9GZ+FyNU6BgphvkncgEQk8o=
Date:   Wed, 10 Apr 2019 01:59:48 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Steve Longerbeam <steve_longerbeam@mentor.com>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "George G. Davis" <george_davis@mentor.com>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Michael Rodin <mrodin@de.adit-jv.com>,
        Eugen Friedrich <efriedrich@de.adit-jv.com>,
        harsha.manjulamallikarjun@in.bosch.com,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v3 3/9] media: rcar-vin: Create a group notifier
Message-ID: <20190409225948.GD9750@pendragon.ideasonboard.com>
References: <20190405161639.GA10433@vmlxhi-102.adit-jv.com>
 <25dc2668-d270-ebf8-b014-88bbb7a6f243@gmail.com>
 <20190408111241.GF15350@bigcity.dyn.berto.se>
 <df6fa3bf-bf21-50b0-2cad-a613e2a43ce0@gmail.com>
 <20190409205745.GB9750@pendragon.ideasonboard.com>
 <3c2c2d04-8028-3511-aba0-0ea6dd5bdc50@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c2c2d04-8028-3511-aba0-0ea6dd5bdc50@mentor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Steve,

On Tue, Apr 09, 2019 at 03:22:47PM -0700, Steve Longerbeam wrote:
> On 4/9/19 1:57 PM, Laurent Pinchart wrote:
> > On Mon, Apr 08, 2019 at 08:58:25PM -0700, Steve Longerbeam wrote:
> >> On 4/8/19 4:12 AM, Niklas Söderlund wrote:
> >>> On 2019-04-05 17:04:50 -0700, Steve Longerbeam wrote:
> >>>> On 4/5/19 9:16 AM, Eugeniu Rosca wrote:
> >>>>> Hi Niklas, Jacopo cc: Steve
> >>>>>
> >>>>> Apologize for reviving this old thread. Just one question below.
> >>>>>
> >>>>> On 2018-05-24 10:14:52, Niklas Söderlund wrote:
> >>>>>
> >>>>> [..]
> >>>>>
> >>>>>>> +
> >>>>>>>     #define vin_to_source(vin)		((vin)->parallel->subdev)
> >>>>>> 
> >>>>>> This in particular I hate and at some point I hope to remove it or
> >>>>>> move  it to rcar-v4l2.c. :-) But that is a task for later and not
> >>>>>> related to  your patch-set.
> >>>>> 
> >>>>> What about below patch excerpt (courtesy of Steve) which is currently
> >>>>> under review in our tree? If we are on the same page here, we would
> >>>>> happily contribute a patch to you based on below.
> >>>> 
> >>>> I can submit this patch to media-tree ML for formal review.
> >>> 
> >>> I see no problem with the patch itself but as you point out bellow there
> >>> are other patches which makes of the change I assume? The change to
> >>> vin_to_source() on it's own would not add much value as vin_to_source()
> >>> is currently only used in the none-mc parts of the driver where the
> >>> change bellow would never be used.
> >>>
> >>> My dream would be to one day drop the none-mc mode of this driver, or
> >>> split it out to a rcar-vin-legacy module or something ;-)
> >> 
> >> Yes, that's something that has been confusing me. Why does there need to
> >> be a distinction between a media control mode non-mc mode in the
> >> rcar-vin driver? I understand the "digital"/"parallel" mode is to handle
> >> sensors with a parallel interface (as opposed to MIPI CSI-2), but why
> >> not make the parallel sensors also require media-control
> >> (enabling/disable media links, etc.)?
> >>
> >>>> But there are also other patches to rcar-vin applied to the tree mentioned
> >>>> by Eugeniu, which can broadly be described as:
> >>>>
> >>>> 1. If the rcar-csi2 sub-device's source pad format is changed via media-ctl,
> >>>> the connected VIN's crop bounds (vin->source rectangle) will be stale, since
> >>>> vin->source must always be equal to the source pad rectangle. So we have a
> >>>> patch that will catch the asynchronous V4L2_EVENT_SOURCE_CHANGE event sent
> >>>> from the rcar-csi2 sub-device when its source pad format is changed. In
> >>>> response, the VIN connected to that rcar-csi2 sub-device will reset the crop
> >>>> bounds to the new source pad format rectangle. In order to make this work
> >>>> however...
> >>> 
> >>> I'm no expert on when the crop/selection rectangles shall be reset and
> >>> have wrestled with this in the past for this driver. I have partial
> >>> rework of how formats especially crop/selection works planed. My goal of
> >>> that is to try and make it simpler and more straight forward taking
> >>> ideas from the vivid driver. There are some limitations in my
> >>> implementation of this in the current driver which prevents me from
> >>> adding sequential formats and enable the UDS scaler.
> >> 
> >> Ok. What I did for imx-media driver is to export a function from the
> >> video capture interface that allows the source sub-device connected to
> >> the capture interface to call it when the source pad format changes,
> >> which gives the capture interface the chance to adjust compose window
> > 
> > That sounds like a big hack, the two devices should be independent.
> > Let's not replicate this, and it should be fixed in the imx driver.
> 
> I admit it's a bit of a hack, but it is there to get around a limitation 
> of media/v4l2 framework. And the two devices are not independent, they 
> are connected the same way other media entities are connected. The 
> media-ctl tool will take care of propagating formats from connected 
> source -> sink sub-devices, but it stops at the sub-device -> 
> video_device interface. First, this propagation should happen in the 
> kernel at the time a source pad format is modified, rather than by a 
> user tool, because it is a media/v4l2 core requirement that source -> 
> sink formats must be equal before streaming starts.

That's not right. It's a requirement that the formats are compatible to
start streaming, but it's not a requirement *before* starting streaming.
That's why kernel drivers must not propagate formats between entities,
only within an entity. Doing in-kernel propagation between entities is
an API violation.

> Second, a source pad format change should also be propagated to
> connected video devices. Userland is then free to make modifications
> to the video_device format if the latter supports cropping/scaling
> etc., but the default should be to reset the format at the time the
> connected sub-device format has changed.

For the same reason above, the format on video nodes must be set by
applications. Could you please fix it in the imx driver ?

> >> (unlike rcar-vin, imx capture interface doesn't crop or scale, the
> >> connected source subdev does that, but it does pad the compose window so
> >> it needs to know the original compose window, sorry hope I haven't lost
> >> you). Anyway I think catching the V4L2_EVENT_SOURCE_CHANGE event is
> >> maybe a cleaner way to update the crop bounds in rcar-vin than using an
> >> exported function.
> >>
> >>>> 2. Sub-device events need to be forwarded to the VIN's that have enabled
> >>>> media links to the reporting sub-device. Currently, sub-device events are
> >>>> only forwarded to VIN7, because the notifier is registered only from VIN7,
> >>>> and so the sub-devices are registered only to the v4l2_dev owned by VIN7. So
> >>>> we have a set of patches that fix this: sub-device events get forwarded to
> >>>> the VIN's that have connected media paths to that sub-device. Besides
> >>>> allowing to reset the VIN crop bounds rectangle asynchronously, this also
> >>>> seems to be logically the correct behavior. It also makes the user interface
> >>>> a little more intuitive: userland knows which VIN it is capturing on, and
> >>>> that is the same VIN that will be receiving sub-device events in the active
> >>>> pipeline.
> >>> 
> >>> This is a problem I ponder from time to time, happy to hear I'm not the
> >>> only one :-) My view is that events are somewhat not functional in the
> >>> media controller world and should be fixed at the framework level, maybe
> >>> by moving them from the vdev to the mdev :-)
> >> 
> >> How about embedding the 'struct v4l2_device' into 'struct rvin_group'
> >> instead of 'struct rvin_dev'? That probably makes more sense, the
> >> v4l2_dev keeps track of media-device-wide info such as the list of
> >> sub-devices in the graph, so it seems more appropriate to create only
> >> one instance of v4l2_dev. That will force rcar-vin to lookup the correct
> >> VINs to forward the event to, since v4l2_dev is no longer attached to
> >> the VINs.
> >>
> >> But moving events from v4l2 to media (e.g. media entities send events to
> >> the mdev, rather than v4l2 sub-devices sending events to the v4l2_dev)
> >> is also an interesting idea.
> >>
> >>> I think it's great that you worked on the problem but I'm a bit
> >>> concerned with addressing this on a driver basis. Maybe this is
> >>> something to bring up at the next v4l2 summit? I might be wrong here and
> >>> there already is a consensus to address this as you describe in each
> >>> driver. Do you have any insights on the topic?
> >> 
> >> I haven't been tuned into that topic, but yes I agree that events need a
> >> better framework.
> >>
> >>>> 3. We have some patches under review that allow alternate -> none field
> >>>> mode. That is, source sub-device is sending alternate fields (top, bottom,
> >>>> top, ...), and userland is configured to receive those fields unmodified by
> >>>> setting field type to none. rcar-dma then detects and reports the field type
> >>>> of the captured field (top or bottom) in (struct v4l2_buffer)->field. Doing
> >>>> this allows for de-interlacing the captured fields using the FDP1 mem2mem
> >>>> device.
> >>> 
> >>> Interesting, maybe I'm missing something but would it not be a better
> >>> solution to add support for V4L2_FIELD_ALTERNATE to rcar-vin instead of
> >>> abusing V4L2_FIELD_NONE?
> >> 
> >> Well, from 6c51f646f6 ("media: rcar-vin: fix handling of single field
> >> frames (top, bottom and alternate fields)"),
> >>
> >> "There was never proper support in the VIN driver to deliver ALTERNATING
> >> field format to user-space, remove this field option. The problem is
> >> that ALTERNATING field order requires the sequence numbers of buffers
> >> returned to userspace to reflect if fields were dropped or not,
> >> something which is not possible with the VIN drivers capture logic."
> >>
> >> Is that still a concern, or can alternate mode be brought back but with
> >> possibly the above limitation?
> >>
> >> Also, there is this paragraph in [1] regarding V4L2_FIELD_NONE, so it
> >> sounds like using this field type in this way may not be too much abuse :)
> >>
> >> "Images are in progressive format, not interlaced. The driver may also
> >> indicate this order when it cannot distinguish
> >> between|V4L2_FIELD_TOP|and|V4L2_FIELD_BOTTOM|."
> >>
> >> [1] https://linuxtv.org/downloads/v4l-dvb-apis/uapi/v4l/field-order.html
> >>
> >>>> There are some other miscellaneous patches that I can submit, but the above
> >>>> describes the bulk of the changes.
> >>> I'm happy to see work being done on the driver and would of course like
> >>> to help you get all changes upstream so that all your use-cases would
> >>> work out-of-the-box.
> >>>
> >>>> Before I start on porting these patches to the media-tree, do the above
> >>>> changes make general sense, or are there fundamental problems with those
> >>>> ideas?
> >>>>
> >>>>> Subject: [PATCH] media: rcar-vin: Generalize vin_to_source()
> >>>>>
> >>>>> Change the vin_to_source() macro to an inline function that will
> >>>>> retrieve the source subdevice for both media-control and non
> >>>>> media-control mode.
> >>>>>
> >>>>> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> >>>>> ---
> >>>>> [..]
> >>>>>
> >>>>> diff --git a/drivers/media/platform/rcar-vin/rcar-vin.h b/drivers/media/platform/rcar-vin/rcar-vin.h
> >>>>> index 0b13b34d03e3..29d8c4a80c35 100644
> >>>>> --- a/drivers/media/platform/rcar-vin/rcar-vin.h
> >>>>> +++ b/drivers/media/platform/rcar-vin/rcar-vin.h
> >>>>> @@ -217,7 +217,21 @@ struct rvin_dev {
> >>>>>     	v4l2_std_id std;
> >>>>>     };
> >>>>> -#define vin_to_source(vin)		((vin)->parallel->subdev)
> >>>>> +static inline struct v4l2_subdev *
> >>>>> +vin_to_source(struct rvin_dev *vin)
> >>>>> +{
> >>>>> +	if (vin->info->use_mc) {
> >>>>> +		struct media_pad *pad;
> >>>>> +
> >>>>> +		pad = media_entity_remote_pad(&vin->pad);
> >>>>> +		if (!pad)
> >>>>> +			return NULL;
> >>>>> +
> >>>>> +		return media_entity_to_v4l2_subdev(pad->entity);
> >>>>> +	}
> >>>>> +
> >>>>> +	return vin->parallel->subdev;
> >>>>> +}
> >>>>>     /* Debug */
> >>>>>     #define vin_dbg(d, fmt, arg...)		dev_dbg(d->dev, fmt, ##arg)
> >>>>>

-- 
Regards,

Laurent Pinchart
