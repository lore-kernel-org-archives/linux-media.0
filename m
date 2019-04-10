Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0035FC10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 15:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B891D20850
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 15:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387437AbfDJPsC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:48:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38413 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbfDJPsB (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 11:48:01 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hEFS0-0006yd-LP; Wed, 10 Apr 2019 17:47:48 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hEFRy-0002gj-EW; Wed, 10 Apr 2019 17:47:46 +0200
Date:   Wed, 10 Apr 2019 17:47:46 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     p.zabel@pengutronix.de, javierm@redhat.co,
        laurent.pinchart@ideasonboard.com, linux-media@vger.kernel.org,
        sakari.ailus@linux.intel.com, hans.verkuil@cisco.com,
        jacopo+renesas@jmondi.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v5 00/13] TVP5150 new features
Message-ID: <20190410154746.dsh2nxeucwbwwluo@pengutronix.de>
References: <20190405060317.11240-1-m.felsch@pengutronix.de>
 <20190406081933.3cc761e8@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190406081933.3cc761e8@coco.lan>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 17:43:30 up 81 days, 20:25, 70 users,  load average: 0.01, 0.08,
 0.10
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

On 19-04-06 08:19, Mauro Carvalho Chehab wrote:
> Hi Marco,
> 
> Em Fri,  5 Apr 2019 08:03:04 +0200
> Marco Felsch <m.felsch@pengutronix.de> escreveu:
> 
> > Hi,
> > 
> > few months ago I send my v4 of this series [1] unfortunately I got no
> > feedback from Mauro but Jacopos feedback was quite helpfull =)
> > 
> > After my v4 I send another series which adds a generic way to parse
> > connector endpoints [2]. To make it easier for everyone I squashed both
> > series [1,2] into this one.
> > 
> > I recognized that patch ("media: v4l2-subdev: add stubs for
> > v4l2_subdev_get_try_*") was a possible blocker for this series so I
> > factored the patch out [3].
> > 
> > My main goal with the v5 was to simplify the link_setup() code a lot.
> > There were also some build-dep issues which I fixed too. Last
> > significant improvement is done on patch ("media: tvp5150: add
> > support to limit tv norms on connector").
> > 
> > I've tested it on a custom hardware and compile tested it too.
> > 
> > @Mauro
> > Please let me know how I can help you to speed up the review progress
> > since I wanted to get those changes merged in the near future =)
> 
> I asked Hans to do the review. I prefer that he would do reviews
> on patches from V4L2 drivers. Also, I'm currently OOT.

Thanks for your reply. Sorry for asking but what does that mean for the
tvp5150 related patches?

@Hans or Sakari
Do you have some feedback or concerns about patch 1-3? I integrated
Jacopo's feedback and wanna send a v6 tomorrow or on friday. Depending on
your feedback.

Regards,
  Marco

> > 
> > @Sakari, Hans
> > I've added you to the series since I made some core changes.
> > 
> > New patches (wasn't part of [1] or [2]):
> >   media: dt-bindings: tvp5150: cleanup bindings stlye
> >   media: dt-bindings: tvp5150: add optional tvnorms documentation
> >   media: tvp5150: make debug output more readable
> > 
> > New (squashed) patches (was part of [2]):
> >   dt-bindings: connector: analog: add tv norms property
> >   media: v4l2-fwnode: add v4l2_fwnode_connector
> >   media: v4l2-fwnode: add initial connector parsing support
> >   media: tvp5150: add support to limit tv norms on connector
> > 
> > Droped patches:
> >   media: v4l2-subdev: add stubs for v4l2_subdev_get_try_*
> > 
> > [1] https://patchwork.ozlabs.org/cover/1032891/
> > [2] https://patchwork.kernel.org/cover/10794703/
> > [3] https://www.mail-archive.com/linux-media@vger.kernel.org/msg146065.html
> > 
> > Regards,
> > 	Marco
> > 
> > Javier Martinez Canillas (1):
> >   partial revert of "[media] tvp5150: add HW input connectors support"
> > 
> > Marco Felsch (11):
> >   dt-bindings: connector: analog: add tv norms property
> >   media: v4l2-fwnode: add v4l2_fwnode_connector
> >   media: v4l2-fwnode: add initial connector parsing support
> >   media: tvp5150: add input source selection of_graph support
> >   media: dt-bindings: tvp5150: Add input port connectors DT bindings
> >   media: tvp5150: add FORMAT_TRY support for get/set selection handlers
> >   media: tvp5150: add s_power callback
> >   media: dt-bindings: tvp5150: cleanup bindings stlye
> >   media: dt-bindings: tvp5150: add optional tvnorms documentation
> >   media: tvp5150: add support to limit tv norms on connector
> >   media: tvp5150: make debug output more readable
> > 
> > Michael Tretter (1):
> >   media: tvp5150: initialize subdev before parsing device tree
> > 
> >  .../display/connector/analog-tv-connector.txt |   4 +
> >  .../devicetree/bindings/media/i2c/tvp5150.txt | 125 +++-
> >  drivers/media/i2c/tvp5150.c                   | 673 +++++++++++++-----
> >  drivers/media/v4l2-core/v4l2-fwnode.c         | 113 +++
> >  include/dt-bindings/media/tvnorms.h           |  42 ++
> >  include/dt-bindings/media/tvp5150.h           |   2 -
> >  include/media/v4l2-connector.h                |  34 +
> >  include/media/v4l2-fwnode.h                   |  49 ++
> >  8 files changed, 850 insertions(+), 192 deletions(-)
> >  create mode 100644 include/dt-bindings/media/tvnorms.h
> >  create mode 100644 include/media/v4l2-connector.h
> > 
> 
> 
> 
> Thanks,
> Mauro
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
