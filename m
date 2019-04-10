Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B622AC10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 10:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B962133D
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 10:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbfDJKby (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:31:54 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59411 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729778AbfDJKby (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 06:31:54 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hEAW6-0003a8-1c; Wed, 10 Apr 2019 12:31:42 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hEAW4-0006DV-BU; Wed, 10 Apr 2019 12:31:40 +0200
Date:   Wed, 10 Apr 2019 12:31:40 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, jacopo+renesas@jmondi.org,
        robh+dt@kernel.org, p.zabel@pengutronix.de, javierm@redhat.co,
        laurent.pinchart@ideasonboard.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v5 03/13] media: v4l2-fwnode: add initial connector
 parsing support
Message-ID: <20190410103140.xbf4vchwyv2h7u4q@pengutronix.de>
References: <20190405060317.11240-1-m.felsch@pengutronix.de>
 <20190405060317.11240-4-m.felsch@pengutronix.de>
 <20190405130631.nl2magnbtasxoqle@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405130631.nl2magnbtasxoqle@uno.localdomain>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:52:40 up 81 days, 14:34, 70 users,  load average: 0.07, 0.05,
 0.03
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Jacopo,

On 19-04-05 15:06, Jacopo Mondi wrote:
> Hi Marco,
>    thanks for the patch

thanks for the fast response =)

> On Fri, Apr 05, 2019 at 08:03:07AM +0200, Marco Felsch wrote:
> > The patch adds the initial connector parsing code, so we can move from a
> > driver specific parsing code to a generic one. Currently only the
> > generic fields and the analog-connector specific fields are parsed. Parsing
> > the other connector specific fields can be added by a simple callbacks.
> >
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >
> > [1] https://patchwork.kernel.org/cover/10794703/
> >
> > v5:
> > - s/strlcpy/strscpy/
> >
> > v2-v4:
> > - nothing since the patch was squashed from series [1] into this
> >   series.
> >
> >  drivers/media/v4l2-core/v4l2-fwnode.c | 113 ++++++++++++++++++++++++++
> >  include/media/v4l2-fwnode.h           |  16 ++++
> >  2 files changed, 129 insertions(+)
> >
> > diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
> > index 20571846e636..a6bbe42ca518 100644
> > --- a/drivers/media/v4l2-core/v4l2-fwnode.c
> > +++ b/drivers/media/v4l2-core/v4l2-fwnode.c
> > @@ -592,6 +592,119 @@ void v4l2_fwnode_put_link(struct v4l2_fwnode_link *link)
> >  }
> >  EXPORT_SYMBOL_GPL(v4l2_fwnode_put_link);
> >
> > +static const struct v4l2_fwnode_connector_conv {
> > +	enum v4l2_connector_type type;
> > +	const char *name;
> > +} connectors[] = {
> > +	{
> > +		.type = V4L2_CON_COMPOSITE,
> > +		.name = "composite-video-connector",
> > +	}, {
> > +		.type = V4L2_CON_SVIDEO,
> > +		.name = "svideo-connector",
> > +	}, {
> > +		.type = V4L2_CON_VGA,
> > +		.name = "vga-connector",
> > +	}, {
> > +		.type = V4L2_CON_DVI,
> > +		.name = "dvi-connector",
> > +	}, {
> > +		.type = V4L2_CON_HDMI,
> > +		.name = "hdmi-connector"
> > +	}
> > +};
> > +
> > +static enum v4l2_connector_type
> > +v4l2_fwnode_string_to_connector_type(const char *con_str)
> > +{
> > +	int i;
> 
> unsigned int

Okay.

> > +
> > +	for (i = 0; i < ARRAY_SIZE(connectors); i++)
> > +		if (!strcmp(con_str, connectors[i].name))
> > +			return connectors[i].type;
> > +
> > +	/* no valid connector found */
> > +	return V4L2_CON_UNKNOWN;
> > +}
> > +
> > +static int
> > +v4l2_fwnode_connector_parse_analog(struct fwnode_handle *fwnode,
> > +				   struct v4l2_fwnode_connector *vc)
> > +{
> > +	u32 tvnorms;
> > +	int ret;
> > +
> > +	ret = fwnode_property_read_u32(fwnode, "tvnorms", &tvnorms);
> > +
> > +	/* set it to V4L2_STD_ALL in case of not specified tvnorms */
> 
> Is this comment needed?

Nope, let me reword it to: "tvnorms is optional"

> > +	vc->connector.analog.supported_tvnorms = ret ? V4L2_STD_ALL : tvnorms;
> 
> empty line before return?

Yes.

> > +	return 0;
> > +}
> > +
> > +int v4l2_fwnode_parse_connector(struct fwnode_handle *__fwnode,
> > +				struct v4l2_fwnode_connector *connector)
> > +{
> > +	struct fwnode_handle *fwnode;
> > +	struct fwnode_endpoint __ep;
> > +	const char *c_type_str, *label;
> > +	int ret;
> > +
> > +	memset(connector, 0, sizeof(*connector));
> > +
> > +	fwnode = fwnode_graph_get_remote_port_parent(__fwnode);
> 
> You should fwnode_handle_put(fwnode) when done and in the error path

Of course.

> > +
> > +	/* 1st parse all common properties */
> > +	/* connector-type is stored within the compatible string */
> > +	ret = fwnode_property_read_string(fwnode, "compatible", &c_type_str);
> > +	if (ret)
> > +		return -EINVAL;
> > +
> > +	connector->type = v4l2_fwnode_string_to_connector_type(c_type_str);
> > +
> > +	fwnode_graph_parse_endpoint(__fwnode, &__ep);
> > +	connector->remote_port = __ep.port;
> > +	connector->remote_id = __ep.id;
> > +
> > +	ret = fwnode_property_read_string(fwnode, "label", &label);
> > +	if (!ret) {
> > +		/* ensure label doesn't exceed V4L2_CONNECTOR_MAX_LABEL size */
> > +		strscpy(connector->label, label, V4L2_CONNECTOR_MAX_LABEL);
> > +	} else {
> > +		/*
> > +		 * labels are optional, if no one is given create one:
> 
> s/no one/none.

Okay.

> > +		 * <connector-type-string>@port<endpoint_port>/ep<endpoint_id>
> > +		 */
> > +		snprintf(connector->label, V4L2_CONNECTOR_MAX_LABEL,
> > +			 "%s@port%u/ep%u", c_type_str, connector->remote_port,
> > +			 connector->remote_id);
> > +	}
> > +
> > +	/* now parse the connector specific properties */
> > +	switch (connector->type) {
> > +		/* fall through */
> 
> Could you move the /* fall through */ comment below case?

Yes.

> > +	case V4L2_CON_COMPOSITE:
> here
> > +	case V4L2_CON_SVIDEO:
> > +		ret = v4l2_fwnode_connector_parse_analog(fwnode, connector);
> > +		break;
> > +		/* fall through */
> > +	case V4L2_CON_VGA:
> here
> > +	case V4L2_CON_DVI:
> here
> > +	case V4L2_CON_HDMI:
> > +		pr_warn("Connector specific parsing is currently not supported for %s\n",
> > +			c_type_str);
> > +		ret = 0;
> > +		break;
> > +		/* fall through */
> > +	case V4L2_CON_UNKNOWN:
> and here
> > +	default:
> > +		pr_err("Unknown connector type\n");
> > +		ret = -EINVAL;
> > +	};
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(v4l2_fwnode_parse_connector);
> > +
> >  static int
> >  v4l2_async_notifier_fwnode_parse_endpoint(struct device *dev,
> >  					  struct v4l2_async_notifier *notifier,
> > diff --git a/include/media/v4l2-fwnode.h b/include/media/v4l2-fwnode.h
> > index 04344b71656f..aa8bbef8589b 100644
> > --- a/include/media/v4l2-fwnode.h
> > +++ b/include/media/v4l2-fwnode.h
> > @@ -269,6 +269,22 @@ int v4l2_fwnode_parse_link(struct fwnode_handle *fwnode,
> >   */
> >  void v4l2_fwnode_put_link(struct v4l2_fwnode_link *link);
> >
> > +/**
> > + * v4l2_fwnode_parse_connector() - parse the connector on endpoint
> > + * @fwnode: pointer to the endpoint's fwnode handle where the connector is
> > + *          connected to.
> 
> No full stop please (even if this is highly unconsistent in this
> header, some lines have it, some don't, but it seems to me the most of
> them do not)

Yes I see it.. damn.

> > + * @connector: pointer to the V4L2 fwnode connector data structure
> > + *
> > + * Fill the connector data structure with the connector type, label and the
> > + * endpoint id and port where the connector belongs to. If no label is present
> > + * a unique one will be created. Labels with more than 40 characters are cut.
> > + *
> > + * Return: %0 on success or a negative error code on failure:
> > + *	   %-EINVAL on parsing failure
> 
> This matches the other function's documentation style. Nice!
> 
> > + */
> > +int v4l2_fwnode_parse_connector(struct fwnode_handle *fwnode,
> > +				struct v4l2_fwnode_connector *connector);
> > +
> 
> All minor comments:
> Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks for the review, I will add it in the next version.

> Thanks
>   j
> 

Regards,
  Marco

> >  /**
> >   * typedef parse_endpoint_func - Driver's callback function to be called on
> >   *	each V4L2 fwnode endpoint.
> > --
> > 2.20.1
> >



-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
