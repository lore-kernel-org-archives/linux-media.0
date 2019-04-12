Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D01C10F0E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 13:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828AD20818
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 13:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfDLNFM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:05:12 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34959 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfDLNFM (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 09:05:12 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hEvrb-000684-8r; Fri, 12 Apr 2019 15:05:03 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hEvra-0002qO-Qq; Fri, 12 Apr 2019 15:05:02 +0200
Date:   Fri, 12 Apr 2019 15:05:02 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, jacopo+renesas@jmondi.org,
        robh+dt@kernel.org, p.zabel@pengutronix.de, javierm@redhat.co,
        laurent.pinchart@ideasonboard.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v5 02/13] media: v4l2-fwnode: add v4l2_fwnode_connector
Message-ID: <20190412130502.g4boj4odgtkdqizr@pengutronix.de>
References: <20190405060317.11240-1-m.felsch@pengutronix.de>
 <20190405060317.11240-3-m.felsch@pengutronix.de>
 <abb9a8d6-bfdb-499c-7278-e6015f2c66d7@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abb9a8d6-bfdb-499c-7278-e6015f2c66d7@xs4all.nl>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:01:48 up 83 days, 17:43, 71 users,  load average: 0.41, 0.18,
 0.06
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Hans,

On 19-04-12 14:17, Hans Verkuil wrote:
> On 4/5/19 8:03 AM, Marco Felsch wrote:
> > Currently every driver needs to parse the connector endpoints by it self.
> > This is the initial work to make this generic. The generic connector has
> > some common fields and some connector specific parts. The generic one
> > includes:
> >   - type
> >   - label
> >   - remote_port (the port where the connector is connected to)
> >   - remote_id   (the endpoint where the connector is connected to)
> > 
> > The specific fields are within a union, since only one of them can be
> > available at the time. Since this is the initial support the patch adds
> > only the analog-connector specific ones.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  include/media/v4l2-connector.h | 34 ++++++++++++++++++++++++++++++++++
> >  include/media/v4l2-fwnode.h    | 33 +++++++++++++++++++++++++++++++++
> >  2 files changed, 67 insertions(+)
> >  create mode 100644 include/media/v4l2-connector.h
> > 
> > diff --git a/include/media/v4l2-connector.h b/include/media/v4l2-connector.h
> > new file mode 100644
> > index 000000000000..967336e38215
> > --- /dev/null
> > +++ b/include/media/v4l2-connector.h
> > @@ -0,0 +1,34 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * v4l2-connector.h
> > + *
> > + * V4L2 connector types.
> > + *
> > + * Copyright 2019 Pengutronix, Marco Felsch <kernel@pengutronix.de>
> > + */
> > +
> > +#ifndef V4L2_CONNECTOR_H
> > +#define V4L2_CONNECTOR_H
> > +
> > +#define V4L2_CONNECTOR_MAX_LABEL 41
> > +
> > +/**
> > + * enum v4l2_connector_type - connector type
> > + * @V4L2_CON_UNKNOWN:   unknown connector type, no V4L2 connetor configuration
> > + * @V4L2_CON_COMPOSITE: analog composite connector
> > + * @V4L2_CON_SVIDEO:    analog svideo connector
> > + * @V4L2_CON_VGA:       analog vga connector
> > + * @V4L2_CON_DVI:	analog or digital dvi connector
> 
> I would drop VGA and DVI for now. Only add them if they are needed. These
> connectors are rarely seen these days.

Okay, dropping shouldn't be a problem.

> > + * @V4L2_CON_HDMI:      digital hdmi connetor
> 
> connetor -> connector

Yes, thanks and thanks for the review.

Regards,

	Marco

> 
> Regards,
> 
> 	Hans
> 
> > + */
> > +enum v4l2_connector_type {
> > +	V4L2_CON_UNKNOWN,
> > +	V4L2_CON_COMPOSITE,
> > +	V4L2_CON_SVIDEO,
> > +	V4L2_CON_VGA,
> > +	V4L2_CON_DVI,
> > +	V4L2_CON_HDMI,
> > +};
> > +
> > +#endif /* V4L2_CONNECTOR_H */
> > +
> > diff --git a/include/media/v4l2-fwnode.h b/include/media/v4l2-fwnode.h
> > index 6c07825e18b9..04344b71656f 100644
> > --- a/include/media/v4l2-fwnode.h
> > +++ b/include/media/v4l2-fwnode.h
> > @@ -22,6 +22,7 @@
> >  #include <linux/list.h>
> >  #include <linux/types.h>
> >  
> > +#include <media/v4l2-connector.h>
> >  #include <media/v4l2-mediabus.h>
> >  #include <media/v4l2-subdev.h>
> >  
> > @@ -126,6 +127,38 @@ struct v4l2_fwnode_link {
> >  	unsigned int remote_port;
> >  };
> >  
> > +/**
> > + * struct v4l2_fwnode_connector_analog - analog connector data structure
> > + * @supported_tvnorms: tv norms this connector supports, set to V4L2_STD_ALL
> > + *                     if no restrictions are specified.
> > + */
> > +struct v4l2_fwnode_connector_analog {
> > +	v4l2_std_id supported_tvnorms;
> > +};
> > +
> > +/** struct v4l2_fwnode_connector - the connector data structure
> > + * @remote_port: identifier of the port the remote endpoint belongs to
> > + * @remote_id: identifier of the id the remote endpoint belongs to
> > + * @label: connetor label
> > + * @type: connector type
> > + * @connector: union with connector configuration data struct
> > + * @connector.analog: embedded &struct v4l2_fwnode_connector_analog.
> > + *                    Used if connector is of type analog.
> > + */
> > +struct v4l2_fwnode_connector {
> > +	/* common fields for all v4l2_fwnode_connectors */
> > +	unsigned int remote_port;
> > +	unsigned int remote_id;
> > +	char label[V4L2_CONNECTOR_MAX_LABEL];
> > +	enum v4l2_connector_type type;
> > +
> > +	/* connector specific fields */
> > +	union {
> > +		struct v4l2_fwnode_connector_analog analog;
> > +		/* future connectors */
> > +	} connector;
> > +};
> > +
> >  /**
> >   * v4l2_fwnode_endpoint_parse() - parse all fwnode node properties
> >   * @fwnode: pointer to the endpoint's fwnode handle
> > 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
