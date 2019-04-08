Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F8CC10F14
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 11:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8E720863
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 11:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="xZfd0R6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfDHLMq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:12:46 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46578 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfDHLMp (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 07:12:45 -0400
Received: by mail-lf1-f68.google.com with SMTP id r25so578150lfn.13
        for <linux-media@vger.kernel.org>; Mon, 08 Apr 2019 04:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wGyD/YpceSGIakU+VGp33RVRi5T7dXbaavopDH91BDk=;
        b=xZfd0R6aNFC62jdH5lAj7/df1eTHUhsaQynhLIjtFvtQ4BF59qE5WyO4lLFqkiaZGX
         9N/GjFe8j5KyZ/VwecWm0Zsoxxwq4W4Gw2S26JMbKIRMizKxOQJWeefE5pjzVGjMlDzF
         SVa8VQPAlYmPMgT8Lyw1u8j4HTqAdVAcY3FI1sqL87Xo4U3jndNZwElBozgq5vATqonG
         lLX8Erjel9sxiyUSHGWNNd3nit6eehbhL35cnA67rFKqNIqzTe7vY9qcQ0JSLrfNXShX
         iVkmK5IJ7XFn7iweJfq/YpW0q2ojKzEvmOS8pFc1OPqJSE79X6nXdL0WtEC9oD+/Z+Qp
         nbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wGyD/YpceSGIakU+VGp33RVRi5T7dXbaavopDH91BDk=;
        b=Sh47uYuojkiXyKKs/AEifsjVUR39UdlaB8HwqDY2GRqvhTLQbfCuqT4JkBWl/RKZf8
         0lyKcAjxoJueuKYDnPT7/c74u8Ipes6ZQnNT9yVthJd2Ss88Cf+0TRr6I0g2hPwKl8NK
         fTCvW1WUjDM9oLxm0Ysbx8kAKYBymCRPx3x0J2pkL2wNJkVk6mNaM1+/bjkQ94ULc3eI
         1hiT0s8C3AobQieUjXVX3rUiTW5hU5q92GuSWTfsSrPpyExGEjUTxWISATV9MG1qGjXI
         maSOu54xVBL1lrdwhYPNFiVSUwRTzlvonwIYR/YcbkmIY9neFEtb+6LfCsKomvSVSmSq
         KCUg==
X-Gm-Message-State: APjAAAWC7kvlvKS9A5IuXO13TpcbzmNmBXxdOJVWpXPp9fsMtWexBysR
        lqb7HtvKpV+t8NHf9IXWNrbvZA==
X-Google-Smtp-Source: APXvYqzUQBeijyh9x2uJUHBHKAF0pnnQPJwjwaXOxvrMHAbqw/qgad0NJi069tMz2lDBeX5+JlfRxQ==
X-Received: by 2002:ac2:59db:: with SMTP id x27mr9452916lfn.108.1554721962730;
        Mon, 08 Apr 2019 04:12:42 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id n6sm1109262lfh.6.2019.04.08.04.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 04:12:41 -0700 (PDT)
Date:   Mon, 8 Apr 2019 13:12:41 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Steve Longerbeam <slongerbeam@gmail.com>
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
Subject: Re: [PATCH v3 3/9] media: rcar-vin: Create a group notifier
Message-ID: <20190408111241.GF15350@bigcity.dyn.berto.se>
References: <20190405161639.GA10433@vmlxhi-102.adit-jv.com>
 <25dc2668-d270-ebf8-b014-88bbb7a6f243@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25dc2668-d270-ebf8-b014-88bbb7a6f243@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Steve, Eugeniu,

On 2019-04-05 17:04:50 -0700, Steve Longerbeam wrote:
> Hi Niklas, all,
> 
> 
> On 4/5/19 9:16 AM, Eugeniu Rosca wrote:
> > Hi Niklas, Jacopo cc: Steve
> > 
> > Apologize for reviving this old thread. Just one question below.
> > 
> > On 2018-05-24 10:14:52, Niklas Söderlund wrote:
> > 
> > [..]
> > 
> > > > +
> > > >   #define vin_to_source(vin)		((vin)->parallel->subdev)
> > > This in particular I hate and at some point I hope to remove it or
> > > move  it to rcar-v4l2.c. :-) But that is a task for later and not
> > > related to  your patch-set.
> > What about below patch excerpt (courtesy of Steve) which is currently
> > under review in our tree? If we are on the same page here, we would
> > happily contribute a patch to you based on below.
> 
> I can submit this patch to media-tree ML for formal review.

I see no problem with the patch itself but as you point out bellow there 
are other patches which makes of the change I assume? The change to 
vin_to_source() on it's own would not add much value as vin_to_source() 
is currently only used in the none-mc parts of the driver where the 
change bellow would never be used.

My dream would be to one day drop the none-mc mode of this driver, or 
split it out to a rcar-vin-legacy module or something ;-)

> 
> But there are also other patches to rcar-vin applied to the tree mentioned
> by Eugeniu, which can broadly be described as:
> 
> 1. If the rcar-csi2 sub-device's source pad format is changed via media-ctl,
> the connected VIN's crop bounds (vin->source rectangle) will be stale, since
> vin->source must always be equal to the source pad rectangle. So we have a
> patch that will catch the asynchronous V4L2_EVENT_SOURCE_CHANGE event sent
> from the rcar-csi2 sub-device when its source pad format is changed. In
> response, the VIN connected to that rcar-csi2 sub-device will reset the crop
> bounds to the new source pad format rectangle. In order to make this work
> however...

I'm no expert on when the crop/selection rectangles shall be reset and 
have wrestled with this in the past for this driver. I have partial 
rework of how formats especially crop/selection works planed. My goal of 
that is to try and make it simpler and more straight forward taking 
ideas from the vivid driver. There are some limitations in my 
implementation of this in the current driver which prevents me from 
adding sequential formats and enable the UDS scaler.

> 
> 2. Sub-device events need to be forwarded to the VIN's that have enabled
> media links to the reporting sub-device. Currently, sub-device events are
> only forwarded to VIN7, because the notifier is registered only from VIN7,
> and so the sub-devices are registered only to the v4l2_dev owned by VIN7. So
> we have a set of patches that fix this: sub-device events get forwarded to
> the VIN's that have connected media paths to that sub-device. Besides
> allowing to reset the VIN crop bounds rectangle asynchronously, this also
> seems to be logically the correct behavior. It also makes the user interface
> a little more intuitive: userland knows which VIN it is capturing on, and
> that is the same VIN that will be receiving sub-device events in the active
> pipeline.

This is a problem I ponder from time to time, happy to hear I'm not the 
only one :-) My view is that events are somewhat not functional in the 
media controller world and should be fixed at the framework level, maybe 
by moving them from the vdev to the mdev :-)

I think it's great that you worked on the problem but I'm a bit 
concerned with addressing this on a driver basis. Maybe this is 
something to bring up at the next v4l2 summit? I might be wrong here and 
there already is a consensus to address this as you describe in each
driver. Do you have any insights on the topic?

> 
> 3. We have some patches under review that allow alternate -> none field
> mode. That is, source sub-device is sending alternate fields (top, bottom,
> top, ...), and userland is configured to receive those fields unmodified by
> setting field type to none. rcar-dma then detects and reports the field type
> of the captured field (top or bottom) in (struct v4l2_buffer)->field. Doing
> this allows for de-interlacing the captured fields using the FDP1 mem2mem
> device.

Interesting, maybe I'm missing something but would it not be a better 
solution to add support for V4L2_FIELD_ALTERNATE to rcar-vin instead of 
abusing V4L2_FIELD_NONE?

> 
> There are some other miscellaneous patches that I can submit, but the above
> describes the bulk of the changes.

I'm happy to see work being done on the driver and would of course like 
to help you get all changes upstream so that all your use-cases would 
work out-of-the-box.

> 
> Before I start on porting these patches to the media-tree, do the above
> changes make general sense, or are there fundamental problems with those
> ideas?
> 
> TIA,
> Steve
> 
> 
> > 
> > Subject: [PATCH] media: rcar-vin: Generalize vin_to_source()
> > 
> > Change the vin_to_source() macro to an inline function that will
> > retrieve the source subdevice for both media-control and non
> > media-control mode.
> > 
> > Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> > ---
> > [..]
> > 
> > diff --git a/drivers/media/platform/rcar-vin/rcar-vin.h b/drivers/media/platform/rcar-vin/rcar-vin.h
> > index 0b13b34d03e3..29d8c4a80c35 100644
> > --- a/drivers/media/platform/rcar-vin/rcar-vin.h
> > +++ b/drivers/media/platform/rcar-vin/rcar-vin.h
> > @@ -217,7 +217,21 @@ struct rvin_dev {
> >   	v4l2_std_id std;
> >   };
> > -#define vin_to_source(vin)		((vin)->parallel->subdev)
> > +static inline struct v4l2_subdev *
> > +vin_to_source(struct rvin_dev *vin)
> > +{
> > +	if (vin->info->use_mc) {
> > +		struct media_pad *pad;
> > +
> > +		pad = media_entity_remote_pad(&vin->pad);
> > +		if (!pad)
> > +			return NULL;
> > +
> > +		return media_entity_to_v4l2_subdev(pad->entity);
> > +	}
> > +
> > +	return vin->parallel->subdev;
> > +}
> >   /* Debug */
> >   #define vin_dbg(d, fmt, arg...)		dev_dbg(d->dev, fmt, ##arg)
> > 
> > Best regards,
> > Eugeniu.
> 

-- 
Regards,
Niklas Söderlund
