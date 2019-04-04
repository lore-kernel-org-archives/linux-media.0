Return-Path: <SRS0=KukI=SG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B84C10F0C
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 08:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2187020855
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 08:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfDDIt1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:49:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:12418 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbfDDIt1 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 4 Apr 2019 04:49:27 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 01:49:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,306,1549958400"; 
   d="scan'208";a="132882542"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga006.jf.intel.com with ESMTP; 04 Apr 2019 01:49:23 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 1267C205BD; Thu,  4 Apr 2019 11:49:23 +0300 (EEST)
Date:   Thu, 4 Apr 2019 11:49:22 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Dave Stevenson <dave.stevenson@raspberrypi.org>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        niklas.soderlund+renesas@ragnatech.se,
        kieran.bingham@ideasonboard.com,
        LMML <linux-media@vger.kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [RFC 1/5] v4l: subdev: Add MIPI CSI-2 PHY to frame desc
Message-ID: <20190404084922.bskyos5zn7gtzsgr@paasikivi.fi.intel.com>
References: <20190316154801.20460-1-jacopo+renesas@jmondi.org>
 <20190316154801.20460-2-jacopo+renesas@jmondi.org>
 <20190316175121.wdek74c7tfpmrhde@kekkonen.localdomain>
 <20190318083113.evrnuibomrsumne3@uno.localdomain>
 <CAAoAYcOL-7PFhbN6zEpheH794-jUPbU1R2c1ERbouhtQODyjYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAoAYcOL-7PFhbN6zEpheH794-jUPbU1R2c1ERbouhtQODyjYg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Dave,

On Mon, Mar 18, 2019 at 03:29:55PM +0000, Dave Stevenson wrote:
> Hi Jacopo.
> 
> Sorry, for some reason linux-media messages aren't coming through to
> me at the moment.
> 
> I'm interested mainly for tc358743 rather than adv748x, but they want
> the very similar functionality.
> I'll try to create patches for that source as well.
> 
> On Mon, 18 Mar 2019 at 08:30, Jacopo Mondi <jacopo@jmondi.org> wrote:
> >
> > Hi Sakari,
> > +Maxime because of it's D-PHY work in the phy framework.
> >
> > On Sat, Mar 16, 2019 at 07:51:21PM +0200, Sakari Ailus wrote:
> > > Hi Jacopo,
> > >
> > > On Sat, Mar 16, 2019 at 04:47:57PM +0100, Jacopo Mondi wrote:
> > > > Add PHY-specific parameters to MIPI CSI-2 frame descriptor.
> > > >
> > > > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > > > ---
> > > >  include/media/v4l2-subdev.h | 42 +++++++++++++++++++++++++++++++------
> > > >  1 file changed, 36 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
> > > > index 6311f670de3c..eca9633c83bf 100644
> > > > --- a/include/media/v4l2-subdev.h
> > > > +++ b/include/media/v4l2-subdev.h
> > > > @@ -317,11 +317,33 @@ struct v4l2_subdev_audio_ops {
> > > >     int (*s_stream)(struct v4l2_subdev *sd, int enable);
> > > >  };
> > > >
> > > > +#define V4L2_FRAME_DESC_ENTRY_DPHY_DATA_LANES      4
> > > > +
> > > > +/**
> > > > + * struct v4l2_mbus_frame_desc_entry_csi2_dphy - MIPI D-PHY bus configuration
> > > > + *
> > > > + * @clock_lane:            physical lane index of the clock lane
> > > > + * @data_lanes:            an array of physical data lane indexes
> > > > + * @num_data_lanes:        number of data lanes
> > > > + */
> > > > +struct v4l2_mbus_frame_desc_entry_csi2_dphy {
> > > > +   u8 clock_lane;
> > > > +   u8 data_lanes[V4L2_FRAME_DESC_ENTRY_DPHY_DATA_LANES];
> > > > +   u8 num_data_lanes;
> > >
> > > Do you need more than the number of the data lanes? I'd expect few devices
> > > to be able to do more than that. The PHY type comes already from the
> > > firmware but I guess it's good to do the separation here as well.
> >
> > Indeed lane reordering at run time seems like a quite unusual
> > operation. I would say I could drop that, but then, a structure and a
> > new field in v4l2_mbus_frame_desc for just an u8, isn't it an
> > overkill (unless we know it could be expanded, with say, D-PHY timings
> > as in Maxime's D-PHY phy support implementation. Again, not sure they
> > should be run-time negotiated, but...)
> 
> If we're adding extra information, then can I suggest that the
> clock-noncontinuous flag is also added?
> If you've got muxed CSI2 buses (eg via the FSA642 [1] as a trivial
> CSI2 switch), then there is nothing stopping one source wanting
> continuous clocks, and one not. Encoding it in the receiver's DT node
> therefore doesn't work for one of the sources. Duplication of that
> definition between source and receiver has always seemed a likely
> source of errors to me, but I'm the relative newcomer here.

Do you have such a case somewhere?

As this is typically up to a device configuration (for those that support
it), it should be possible to use the same setting for both the sensors.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
