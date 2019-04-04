Return-Path: <SRS0=KukI=SG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DFCC10F0E
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 16:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DAC2082E
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 16:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="c4SSG2R3";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="MX8MEQ8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfDDQhR (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:37:17 -0400
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:60764 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728629AbfDDQhR (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 4 Apr 2019 12:37:17 -0400
Received: from pps.filterd (m0102628.ppops.net [127.0.0.1])
        by mx07-00252a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x34GY3gm005327
        for <linux-media@vger.kernel.org>; Thu, 4 Apr 2019 17:37:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=pp; bh=5uK7/9EYY08o8S1HCnCPvLwxOXk8QMP8uFKTk1ab91U=;
 b=c4SSG2R3XFlH6If6gPktNNtIt+xyloB4CsN2azLAj656TSeuuFf6hel92Eb/zB0F3870
 0mBtBhE8wvGX1dxS6CoNo5GZzCj6RXGYBb5YPSwn6EOOr0dVv2YWHv4g29aPhw3YTuHo
 tAwDbRSRTyXXwt/+PoZlORxpVjyOxjJyAM0QSbB/LHuEvoswIuvv6FkobEMDZ04yde6r
 XZeVVwKFzFznzq3rc25CLjC7iFuI/Ui8lWqHa512WqOngcO51kvpGBpVItSuoC3FJV4O
 cMi/EJAO9J53POxMxUNo2egtRtMw/jlkx40f0ij1WEBLlz+/gwkw4McHwgdA/dclcaFY 5A== 
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by mx07-00252a01.pphosted.com with ESMTP id 2rhxr5jw21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-media@vger.kernel.org>; Thu, 04 Apr 2019 17:37:15 +0100
Received: by mail-pl1-f197.google.com with SMTP id x5so2126038pll.2
        for <linux-media@vger.kernel.org>; Thu, 04 Apr 2019 09:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5uK7/9EYY08o8S1HCnCPvLwxOXk8QMP8uFKTk1ab91U=;
        b=MX8MEQ8jOrxgdA0Mx7LcW2AAx+Q5uvBh2S2k/vxj9E8NfR8XTQiTO+YbtxvSQ8Bp8E
         Q9fiVBvobhmMlPntrPtNdxArjj4fKxckjUB8WZFRRMJ2vXvAJ++fX3ZcIB1Fa5x5wrdX
         UAXmHhwGTnvPDAN/Mcp+3GtsXI2H1Rhho8xt+47KIKHlMEleUBz8zbrL+a7gBGeFejc6
         9OLJfs2llawAOeqklK8pxlNWRZDzMHOvLTv/D4FEC52V1fFZty7fG/sTW482goDK0mB4
         0GFIX4vKr0MXQO8xuaUYtzpKJmCEngC+/+i4kOVEYNLkLkUCjNOS55CTpXgDEm23yxqG
         VPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5uK7/9EYY08o8S1HCnCPvLwxOXk8QMP8uFKTk1ab91U=;
        b=WkMcmt+DRFhnyZmLgvPK7QPG/6TEkc3ARsbGjSMRbb5ytZytZca2JLMeVTGp/177QU
         PezO0WDUOORK4pFqVj5cjHpnM2Xif2z3g/Vx+U3vniIFDUfxdlRVXfJtz4q7e7Bl1dl/
         14IhQR0B1rcYSUJiBA5wdBb7XAm7z0MejdxWQ4ngUTHyohemhPdWOuh2Dn0EStu+zRg2
         pSNQ6DQuLnt1NoE955dvZ/sWPv8NoVkUGvIup7TyVlkrKY51nMXY9EdCOx//+8cN9WQx
         D3T+OHg45MCTBIbXr/PRSCch2ES+qk0vfmCaUPH498q6cEtGjSWfIxycc2JW5zcPE2fY
         puBw==
X-Gm-Message-State: APjAAAWF4TtMuuG+/oAxLyN/8fd69Fy4vX6EqW44h6RGqY76vhWNT+aY
        HeX138SV2kIqWP8BlhxafmCYg7kYfpaL5IDAfaszErlP55dpgtt3cxHetITn6VSFDKr4Sm6GJCR
        m6MC/5zt7FBon/VINorWux++8XBSj5eeZvqYDvQ==
X-Received: by 2002:a63:d709:: with SMTP id d9mr6598377pgg.38.1554395832704;
        Thu, 04 Apr 2019 09:37:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyC3/JxCqNbiCEl3omwVBvKvSqwQnyZE0QVBdZQi3sHBLI+353epcd/+g4rlL4PTlS7zC9tzP9ZzkvXWqC8hLQ=
X-Received: by 2002:a63:d709:: with SMTP id d9mr6598355pgg.38.1554395832406;
 Thu, 04 Apr 2019 09:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190316154801.20460-1-jacopo+renesas@jmondi.org>
 <20190316154801.20460-2-jacopo+renesas@jmondi.org> <20190316175121.wdek74c7tfpmrhde@kekkonen.localdomain>
 <20190318083113.evrnuibomrsumne3@uno.localdomain> <CAAoAYcOL-7PFhbN6zEpheH794-jUPbU1R2c1ERbouhtQODyjYg@mail.gmail.com>
 <20190404084922.bskyos5zn7gtzsgr@paasikivi.fi.intel.com>
In-Reply-To: <20190404084922.bskyos5zn7gtzsgr@paasikivi.fi.intel.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.org>
Date:   Thu, 4 Apr 2019 17:36:59 +0100
Message-ID: <CAAoAYcO35jUi9H5F5CgmsH=Nc4-MoJtJ2dAR7jvRxs7_=iEQ8w@mail.gmail.com>
Subject: Re: [RFC 1/5] v4l: subdev: Add MIPI CSI-2 PHY to frame desc
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        niklas.soderlund+renesas@ragnatech.se,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        LMML <linux-media@vger.kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-04_08:,,
 signatures=0
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Sakari

On Thu, 4 Apr 2019 at 09:49, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Dave,
>
> On Mon, Mar 18, 2019 at 03:29:55PM +0000, Dave Stevenson wrote:
> > Hi Jacopo.
> >
> > Sorry, for some reason linux-media messages aren't coming through to
> > me at the moment.
> >
> > I'm interested mainly for tc358743 rather than adv748x, but they want
> > the very similar functionality.
> > I'll try to create patches for that source as well.
> >
> > On Mon, 18 Mar 2019 at 08:30, Jacopo Mondi <jacopo@jmondi.org> wrote:
> > >
> > > Hi Sakari,
> > > +Maxime because of it's D-PHY work in the phy framework.
> > >
> > > On Sat, Mar 16, 2019 at 07:51:21PM +0200, Sakari Ailus wrote:
> > > > Hi Jacopo,
> > > >
> > > > On Sat, Mar 16, 2019 at 04:47:57PM +0100, Jacopo Mondi wrote:
> > > > > Add PHY-specific parameters to MIPI CSI-2 frame descriptor.
> > > > >
> > > > > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > > > > ---
> > > > >  include/media/v4l2-subdev.h | 42 +++++++++++++++++++++++++++++++------
> > > > >  1 file changed, 36 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
> > > > > index 6311f670de3c..eca9633c83bf 100644
> > > > > --- a/include/media/v4l2-subdev.h
> > > > > +++ b/include/media/v4l2-subdev.h
> > > > > @@ -317,11 +317,33 @@ struct v4l2_subdev_audio_ops {
> > > > >     int (*s_stream)(struct v4l2_subdev *sd, int enable);
> > > > >  };
> > > > >
> > > > > +#define V4L2_FRAME_DESC_ENTRY_DPHY_DATA_LANES      4
> > > > > +
> > > > > +/**
> > > > > + * struct v4l2_mbus_frame_desc_entry_csi2_dphy - MIPI D-PHY bus configuration
> > > > > + *
> > > > > + * @clock_lane:            physical lane index of the clock lane
> > > > > + * @data_lanes:            an array of physical data lane indexes
> > > > > + * @num_data_lanes:        number of data lanes
> > > > > + */
> > > > > +struct v4l2_mbus_frame_desc_entry_csi2_dphy {
> > > > > +   u8 clock_lane;
> > > > > +   u8 data_lanes[V4L2_FRAME_DESC_ENTRY_DPHY_DATA_LANES];
> > > > > +   u8 num_data_lanes;
> > > >
> > > > Do you need more than the number of the data lanes? I'd expect few devices
> > > > to be able to do more than that. The PHY type comes already from the
> > > > firmware but I guess it's good to do the separation here as well.
> > >
> > > Indeed lane reordering at run time seems like a quite unusual
> > > operation. I would say I could drop that, but then, a structure and a
> > > new field in v4l2_mbus_frame_desc for just an u8, isn't it an
> > > overkill (unless we know it could be expanded, with say, D-PHY timings
> > > as in Maxime's D-PHY phy support implementation. Again, not sure they
> > > should be run-time negotiated, but...)
> >
> > If we're adding extra information, then can I suggest that the
> > clock-noncontinuous flag is also added?
> > If you've got muxed CSI2 buses (eg via the FSA642 [1] as a trivial
> > CSI2 switch), then there is nothing stopping one source wanting
> > continuous clocks, and one not. Encoding it in the receiver's DT node
> > therefore doesn't work for one of the sources. Duplication of that
> > definition between source and receiver has always seemed a likely
> > source of errors to me, but I'm the relative newcomer here.
>
> Do you have such a case somewhere?

There are boards available for the Pi that use the FSA642 to switch
between multiple camera modules [1].
They haven't written any clever drivers as their intended use is
against the (closed) firmware, therefore they currently have to be
identical sensors on each input.
The use of those boards seems to fit pretty cleanly into this
multiplexed CSI bus framework, and there needn't be the limitation of
them being the same sensor.

I acknowledge that the Pi CSI2 receiver driver isn't upstream yet. I
put that on hold as the TC358743 was one of the main devices to be
supported, and without the rest of this patch set passing the number
of lanes in use through then that was pretty dead in the water. It was
less effort to keep the driver in the Pi vendor tree using the
g_mbus_config mechanism that was rejected, rather than holding patches
on an upstreamed driver. Once this set is merged and I can therefore
support TC358743 cleanly I'll be looking again at upstreaming it.

[1] http://www.ivmech.com/magaza/en/development-modules-c-4/ivport-dual-raspberry-pi-camera-module-multiplexer-p-104

> As this is typically up to a device configuration (for those that support
> it), it should be possible to use the same setting for both the sensors.

Are you meaning CSI transmitter or receiver for device configuration?
Most receivers support either, but often have to be told which mode to expect.
TC358743 seems to be one of the few CSI drivers that actually supports
both. None of the others appear to quote the use of
clock-noncontinuous in their DT bindings, but that doesn't guarantee
that that is the actual truth.

So there's no issue at the moment, but there will be issues when you
get the first driver that only supports clock-noncontinuous and
someone wants to mux it.

As I said, having the potential for the two ends to be set differently
in device tree and no way to check at runtime seems like an
unnecessary trap for the unwary. You're now adding a config path from
source to receiver, therefore adding that information removes that
confusion. Just a suggestion.

  Dave
