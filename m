Return-Path: <SRS0=Dnes=SH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F61C4360F
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 07:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D4B20700
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 07:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfDEH0U (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:26:20 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50377 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfDEH0U (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 5 Apr 2019 03:26:20 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hCJEm-0007gO-Hj; Fri, 05 Apr 2019 09:26:08 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hCJEi-0006a3-R1; Fri, 05 Apr 2019 09:26:04 +0200
Date:   Fri, 5 Apr 2019 09:26:04 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>, mchehab@kernel.org,
        rmfrfs@gmail.com, zhengsq@rock-chips.com,
        prabhakar.csengg@gmail.com, corbet@lwn.net,
        wenyou.yang@microchip.com, lkundrak@v3.sk,
        hverkuil-cisco@xs4all.nl, jacopo+renesas@jmondi.org,
        linux-media@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/6] media: v4l2-subdev: add stubs for
 v4l2_subdev_get_try_*
Message-ID: <20190405072604.2wul74tibybdw644@pengutronix.de>
References: <20190404074002.18730-1-m.felsch@pengutronix.de>
 <20190404074002.18730-2-m.felsch@pengutronix.de>
 <20190404083933.33ejwyko4xoittux@paasikivi.fi.intel.com>
 <20190404143947.do4lmvxrvnzubtl7@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404143947.do4lmvxrvnzubtl7@uno.localdomain>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:07:37 up 76 days, 10:49, 66 users,  load average: 0.12, 0.15,
 0.07
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Sakari, Jacopo,

On 19-04-04 16:39, Jacopo Mondi wrote:
> Hi Marco, Sakari,
> 
> On Thu, Apr 04, 2019 at 11:39:34AM +0300, Sakari Ailus wrote:
> > Hi Marco,
> >
> > On Thu, Apr 04, 2019 at 09:39:57AM +0200, Marco Felsch wrote:
> > > In case of missing CONFIG_VIDEO_V4L2_SUBDEV_API those helpers aren't
> > > available. So each driver have to add ifdefs around those helpers or
> > > add the CONFIG_VIDEO_V4L2_SUBDEV_API as dependcy.
> > >
> > > Make these helpers available in case of CONFIG_VIDEO_V4L2_SUBDEV_API
> > > isn't set to avoid ifdefs. This approach is less error prone too.
> > >
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> > > The patch was previously part of series [1]. Since I want to get
> > > series [1] merged in 5.2 I split this possible stopper out of the
> > > serie and prepared a own series for it. I applied Jacopos comments and
> > > switched to Lubomir's approach [2]. During discussion on series [2]
> > > Sakari pointed out Hans approach [3] which didn't got into the kernel
> > > due to Mauro's concerns. So I think this would be the smalles common
> > > dennominator.
> > >
> > > [1] https://patchwork.kernel.org/cover/10786553/
> > > [2] https://patchwork.kernel.org/patch/10703029/
> > > [3] https://patchwork.linuxtv.org/patch/53370/
> > > ---
> > >  include/media/v4l2-subdev.h | 29 ++++++++++++++++++++++++++++-
> > >  1 file changed, 28 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
> > > index a7fa5b80915a..eea792757426 100644
> > > --- a/include/media/v4l2-subdev.h
> > > +++ b/include/media/v4l2-subdev.h
> > > @@ -984,7 +984,34 @@ static inline struct v4l2_rect
> > >  		pad = 0;
> > >  	return &cfg[pad].try_compose;
> > >  }
> > > -#endif
> > > +
> > > +#else /* !defined(CONFIG_VIDEO_V4L2_SUBDEV_API) */
> > > +
> > > +static inline struct v4l2_mbus_framefmt
> > > +*v4l2_subdev_get_try_format(struct v4l2_subdev *sd,
> > > +			    struct v4l2_subdev_pad_config *cfg,
> > > +			    unsigned int pad)
> > > +{
> > > +	return ERR_PTR(-ENOTTY);
> > > +}
> >
> > Almost all users of these functions directly use the struct pointer they
> > receive from the said functions, without checks for the pointer value.
> >
> > These drivers now depend on CONFIG_VIDEO_V4L2_SUBDEV_API, but for new
> > drivers it could be possible to miss that, leading to dereferencing
> > ERR_PTR(-ENOTTY) as a result if the sub-device API isn't enabled.
> >
> > I have to say I'm not a huge fan of such a change; it's one more such thing
> > to remember that results in a kernel crash if you get it wrong.
> >
> 
> Unfortunately, I have to agree with Sakari here
>

Are those drivers depending on CONFIG_VIDEO_V4L2_SUBDEV_API used by
usb-bridge devices? I Remember that was Mauro's concern on Hans RFC patch.
I'm with you the "depending way" is quite better.

> > I wonder if v4l2_subdev_call() could become a bit smarter about this;
> > checking whether the try format is attempted to be obtained without the
> > sub-device API being enabled, and returning an error in that case without
> > passing the IOCTL to the driver at all.
> 
> I'm not much excited by the idea of specializing v4l2_subdev_call(), I
> had a try and I would be ashemed of sharing that code. If someone
> could come up with something nice we could consider this too.
> 
> For the record, it is not enough to check for V4L2_SUBDEV_API and try
> format, as a few (1?) bridge drivers calls the subdev operation providing a
> 'v4l2_subdev_pad_config' argument, that could be used by the sensor
> drivers in place of the one returned from v4l2_subdev_get_try_*, if
> V4L2_SUBDEV_API is not available

Thats true. One thing to think about your caller. This code won't work
if you are using the existing ov* implementations too since the ceu
don't depend on the subdev-api too.

So including your record increases the complexity.

> 
> Caller:
> https://elixir.bootlin.com/linux/latest/source/drivers/media/platform/renesas-ceu.c#L858
> Sensor:
> https://elixir.bootlin.com/linux/latest/source/drivers/media/i2c/mt9v111.c#L792
> 
> As I wrote both, they could be very well be wrong, but if they're not,
> one other option would be to refuse NULL v4l2_subdev_pad_config arguments
> (changing most of the bridge drivers in mainline) and move the code
> linked above here from the mt9v111 driver to the v4l2_subdev_get_try_*
> functions.
> 
> >
> > Just an idea. It doesn't have to be in the same patchset.
> >
> > I'd still prefer enabling subdev API always to decrease the number of
> > possible different kernel configurations.
> 
> That would be best imho, but Hans' attempt didn't go very far because
> of the issue Marco reported in his cover letter.

Yes, that's also my favourite.

@Mauro
Can you point out your concerns 'again'? Maybe we can apply Hans
approach and will fix the 'maybe' broken usb-bridge devices.

Regards,
	Marco


> 
> Thanks
>   j
> 
> >
> > I wonder what others think.
> >
> > > +
> > > +static inline struct v4l2_rect
> > > +*v4l2_subdev_get_try_crop(struct v4l2_subdev *sd,
> > > +			  struct v4l2_subdev_pad_config *cfg,
> > > +			  unsigned int pad)
> > > +{
> > > +	return ERR_PTR(-ENOTTY);
> > > +}
> > > +
> > > +static inline struct v4l2_rect
> > > +*v4l2_subdev_get_try_compose(struct v4l2_subdev *sd,
> > > +			     struct v4l2_subdev_pad_config *cfg,
> > > +			     unsigned int pad)
> > > +{
> > > +	return ERR_PTR(-ENOTTY);
> > > +}
> > > +
> > > +#endif /* defined(CONFIG_VIDEO_V4L2_SUBDEV_API) */
> > >
> > >  extern const struct v4l2_file_operations v4l2_subdev_fops;
> > >
> >
> > --
> > Regards,
> >
> > Sakari Ailus
> > sakari.ailus@linux.intel.com



-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
