Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842DDC10F0E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 12:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC3C2077C
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 12:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDLMRr (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:17:47 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:50420 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbfDLMRr (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 08:17:47 -0400
Received: from [IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68] ([IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68])
        by smtp-cloud7.xs4all.net with ESMTPA
        id Ev7nh0u4gNG8zEv7ohCnHK; Fri, 12 Apr 2019 14:17:44 +0200
Subject: Re: [PATCH v5 02/13] media: v4l2-fwnode: add v4l2_fwnode_connector
To:     Marco Felsch <m.felsch@pengutronix.de>, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, hans.verkuil@cisco.com,
        jacopo+renesas@jmondi.org, robh+dt@kernel.org
Cc:     p.zabel@pengutronix.de, javierm@redhat.co,
        laurent.pinchart@ideasonboard.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
References: <20190405060317.11240-1-m.felsch@pengutronix.de>
 <20190405060317.11240-3-m.felsch@pengutronix.de>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <abb9a8d6-bfdb-499c-7278-e6015f2c66d7@xs4all.nl>
Date:   Fri, 12 Apr 2019 14:17:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405060317.11240-3-m.felsch@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJFe76xnYyHWMdMOtPZH9X5/5XzTTTFiWcrzB5/WMA7ltxyvjdY/xyyGaFUdxxDdZQ1BVrX8wiMxsv9E9pzi2B7UQHwRcPRu4GcOfkN+37QihIbHGp1c
 6iqWj9pLAc213Z3jaGCLqJQLic5oVJHeKthY215eRE2P6yqTZbjS0bh/GuQVgJg7STZEGCia6jDY/Wotnz6ELbXgLhw3zMoQW4L32ah5x8omsxQ9baywO+GO
 7Bq9wjAg+DaTUzTYJWsmGVp/VAi5Z5KMk2bqRsOr2mVKxXIPWqiLNm6ZbTGNG1Lh6FlWB+qcIw+lUDMTvcR/JN9Z2uGvqu/+0GF1VzfGQRqkN1C5QQPnlxy4
 nx+hBS3uI8Z8vu8dbH73ni6kO5mA7C2AQyiCevD/pq/mUIyOhPmDQav4qm2GxspwRP7Cozr/lfyIOQmKh7J831+flW8ggh5BCAcqMPBY7QGnU6TUvg9ScWCS
 F7TjK0YPyOU7YerMwiiIl43UpIRZCXLiiYC8BQTvJI1PHLadEgLyqhwa+esFzR7GB9IAEFHkoNU84XDwvdw+XgXwKUaWwp6ukCrIt7ATNsqvfhOtL21yjnOt
 SJhtcxGAJzw+5jgLB54aAkpF1crsBlTBckBICUqcg9cN5z1Q3jkL7CRQyg7jrz1qfznfXDeBqy4VjgKrZJVoPVhd
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/5/19 8:03 AM, Marco Felsch wrote:
> Currently every driver needs to parse the connector endpoints by it self.
> This is the initial work to make this generic. The generic connector has
> some common fields and some connector specific parts. The generic one
> includes:
>   - type
>   - label
>   - remote_port (the port where the connector is connected to)
>   - remote_id   (the endpoint where the connector is connected to)
> 
> The specific fields are within a union, since only one of them can be
> available at the time. Since this is the initial support the patch adds
> only the analog-connector specific ones.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  include/media/v4l2-connector.h | 34 ++++++++++++++++++++++++++++++++++
>  include/media/v4l2-fwnode.h    | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
>  create mode 100644 include/media/v4l2-connector.h
> 
> diff --git a/include/media/v4l2-connector.h b/include/media/v4l2-connector.h
> new file mode 100644
> index 000000000000..967336e38215
> --- /dev/null
> +++ b/include/media/v4l2-connector.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * v4l2-connector.h
> + *
> + * V4L2 connector types.
> + *
> + * Copyright 2019 Pengutronix, Marco Felsch <kernel@pengutronix.de>
> + */
> +
> +#ifndef V4L2_CONNECTOR_H
> +#define V4L2_CONNECTOR_H
> +
> +#define V4L2_CONNECTOR_MAX_LABEL 41
> +
> +/**
> + * enum v4l2_connector_type - connector type
> + * @V4L2_CON_UNKNOWN:   unknown connector type, no V4L2 connetor configuration
> + * @V4L2_CON_COMPOSITE: analog composite connector
> + * @V4L2_CON_SVIDEO:    analog svideo connector
> + * @V4L2_CON_VGA:       analog vga connector
> + * @V4L2_CON_DVI:	analog or digital dvi connector

I would drop VGA and DVI for now. Only add them if they are needed. These
connectors are rarely seen these days.

> + * @V4L2_CON_HDMI:      digital hdmi connetor

connetor -> connector


Regards,

	Hans

> + */
> +enum v4l2_connector_type {
> +	V4L2_CON_UNKNOWN,
> +	V4L2_CON_COMPOSITE,
> +	V4L2_CON_SVIDEO,
> +	V4L2_CON_VGA,
> +	V4L2_CON_DVI,
> +	V4L2_CON_HDMI,
> +};
> +
> +#endif /* V4L2_CONNECTOR_H */
> +
> diff --git a/include/media/v4l2-fwnode.h b/include/media/v4l2-fwnode.h
> index 6c07825e18b9..04344b71656f 100644
> --- a/include/media/v4l2-fwnode.h
> +++ b/include/media/v4l2-fwnode.h
> @@ -22,6 +22,7 @@
>  #include <linux/list.h>
>  #include <linux/types.h>
>  
> +#include <media/v4l2-connector.h>
>  #include <media/v4l2-mediabus.h>
>  #include <media/v4l2-subdev.h>
>  
> @@ -126,6 +127,38 @@ struct v4l2_fwnode_link {
>  	unsigned int remote_port;
>  };
>  
> +/**
> + * struct v4l2_fwnode_connector_analog - analog connector data structure
> + * @supported_tvnorms: tv norms this connector supports, set to V4L2_STD_ALL
> + *                     if no restrictions are specified.
> + */
> +struct v4l2_fwnode_connector_analog {
> +	v4l2_std_id supported_tvnorms;
> +};
> +
> +/** struct v4l2_fwnode_connector - the connector data structure
> + * @remote_port: identifier of the port the remote endpoint belongs to
> + * @remote_id: identifier of the id the remote endpoint belongs to
> + * @label: connetor label
> + * @type: connector type
> + * @connector: union with connector configuration data struct
> + * @connector.analog: embedded &struct v4l2_fwnode_connector_analog.
> + *                    Used if connector is of type analog.
> + */
> +struct v4l2_fwnode_connector {
> +	/* common fields for all v4l2_fwnode_connectors */
> +	unsigned int remote_port;
> +	unsigned int remote_id;
> +	char label[V4L2_CONNECTOR_MAX_LABEL];
> +	enum v4l2_connector_type type;
> +
> +	/* connector specific fields */
> +	union {
> +		struct v4l2_fwnode_connector_analog analog;
> +		/* future connectors */
> +	} connector;
> +};
> +
>  /**
>   * v4l2_fwnode_endpoint_parse() - parse all fwnode node properties
>   * @fwnode: pointer to the endpoint's fwnode handle
> 

