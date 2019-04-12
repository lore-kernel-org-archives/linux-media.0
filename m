Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1320C10F0E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 12:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE872186A
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 12:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfDLMOk (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:14:40 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:33293 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbfDLMOk (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 08:14:40 -0400
Received: from [IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68] ([IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68])
        by smtp-cloud7.xs4all.net with ESMTPA
        id Ev4mh0smhNG8zEv4nhCmTi; Fri, 12 Apr 2019 14:14:38 +0200
Subject: Re: [PATCH v5 01/13] dt-bindings: connector: analog: add tv norms
 property
To:     Marco Felsch <m.felsch@pengutronix.de>, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, hans.verkuil@cisco.com,
        jacopo+renesas@jmondi.org, robh+dt@kernel.org
Cc:     p.zabel@pengutronix.de, javierm@redhat.co,
        laurent.pinchart@ideasonboard.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        Rob Herring <robh@kernel.org>
References: <20190405060317.11240-1-m.felsch@pengutronix.de>
 <20190405060317.11240-2-m.felsch@pengutronix.de>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <17d5a42b-7f9d-e614-2ca6-659a72e33e3d@xs4all.nl>
Date:   Fri, 12 Apr 2019 14:14:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405060317.11240-2-m.felsch@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLWkX/tcvPuVoTw9vgV15MoG5xcpuEyJY/suUm6hiL9U5z/FJ+D44YNIIuwTwjIKcsFqbDvh9RaX4YLCdVwY63k7upzNN8bqd9jUJxsvAApQAiFvSZhg
 eAV3yeebwISld/RZW5m8ex5LBHs5szHlCStGy/SOpwwCWUf+pFrD61DX2Tj9X7Yj287qTlVyLxjMqJS3qyaiBR9f2rlgaBW2ToxXJEZH4AzThaP0mJzUkVMr
 C8SCGxyVEiIZbAavexwrPV6Q0FLlF/MvqBjb26yXSzWKinKyNL249RWdDlI6MPsQd3X29GfYKic2qbNQXlrUBhAFqtD9MW9vLUUITOXX1XPGtVMPsvLsLwWG
 awIEGww9qYLmssBfHK+QroL9UZKmPPsWwB4SCGJ8sG4V9VfnDncIWal1sZF3Yp0sS2oBE18c70R1HxKj503ei23rdQRWJnLqu4K31Q90RY8kR6Jc/STdpBzo
 4HObPP6wRoH6ct7irtuld91gzIHP3DG3Gm1NW3kYoGhgLJ1yintzwnwARrLZpcqWpLxyqY1XW4HfwHYXw+Qb33VO+xn/COCq5sREmYBX6vp6xyywH0T43RkV
 /ZqZsB4kfrIotezwQth+/X2xpqYo3e5EUaRBAMauE+2zdAeAntjtNJJ2htkFefkLeATQkdWKm2XzRoPBPSprcPxkG7fejCuzsjm9ilE/9yMTyg==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/5/19 8:03 AM, Marco Felsch wrote:
> Some connectors no matter if in- or output supports only a limited
> range of tv norms. It doesn't matter if the hardware behind that
> connector supports more than the listed formats since the users are
> restriced by a label e.g. to plug only a camera into this connector
> which uses the PAL format.
> 
> This patch adds the capability to describe such limitation within the
> firmware. There are no format restrictions if the property isn't
> present, so it's completely backward compatible.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../display/connector/analog-tv-connector.txt |  4 ++
>  include/dt-bindings/media/tvnorms.h           | 42 +++++++++++++++++++
>  2 files changed, 46 insertions(+)
>  create mode 100644 include/dt-bindings/media/tvnorms.h
> 
> diff --git a/Documentation/devicetree/bindings/display/connector/analog-tv-connector.txt b/Documentation/devicetree/bindings/display/connector/analog-tv-connector.txt
> index 0c0970c210ab..346f8937a0b7 100644
> --- a/Documentation/devicetree/bindings/display/connector/analog-tv-connector.txt
> +++ b/Documentation/devicetree/bindings/display/connector/analog-tv-connector.txt
> @@ -6,6 +6,9 @@ Required properties:
>  
>  Optional properties:
>  - label: a symbolic name for the connector
> +- tvnorms: limit the supported tv norms on a connector to the given ones else
> +           all tv norms are allowed. Possible video standards are defined in
> +           include/dt-bindings/media/tvnorms.h.
>  
>  Required nodes:
>  - Video port for TV input
> @@ -16,6 +19,7 @@ Example
>  tv: connector {
>  	compatible = "composite-video-connector";
>  	label = "tv";
> +	tvnorms = <(TVNORM_PAL_M | TVNORM_NTSC_M)>;
>  
>  	port {
>  		tv_connector_in: endpoint {
> diff --git a/include/dt-bindings/media/tvnorms.h b/include/dt-bindings/media/tvnorms.h
> new file mode 100644
> index 000000000000..ec3b414a7a00
> --- /dev/null
> +++ b/include/dt-bindings/media/tvnorms.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0-only or X11 */
> +/*
> + * Copyright 2019 Pengutronix, Marco Felsch <kernel@pengutronix.de>
> + */
> +
> +#ifndef _DT_BINDINGS_MEDIA_TVNORMS_H
> +#define _DT_BINDINGS_MEDIA_TVNORMS_H
> +
> +/* one bit for each */
> +#define TVNORM_PAL_B          0x00000001
> +#define TVNORM_PAL_B1         0x00000002
> +#define TVNORM_PAL_G          0x00000004
> +#define TVNORM_PAL_H          0x00000008
> +#define TVNORM_PAL_I          0x00000010
> +#define TVNORM_PAL_D          0x00000020
> +#define TVNORM_PAL_D1         0x00000040
> +#define TVNORM_PAL_K          0x00000080

I would add a TVNORM_PAL here as well that is the OR of the previous defines.

> +
> +#define TVNORM_PAL_M          0x00000100
> +#define TVNORM_PAL_N          0x00000200
> +#define TVNORM_PAL_Nc         0x00000400
> +#define TVNORM_PAL_60         0x00000800
> +
> +#define TVNORM_NTSC_M         0x00001000	/* BTSC */
> +#define TVNORM_NTSC_M_JP      0x00002000	/* EIA-J */
> +#define TVNORM_NTSC_443       0x00004000
> +#define TVNORM_NTSC_M_KR      0x00008000	/* FM A2 */
> +
> +#define TVNORM_SECAM_B        0x00010000
> +#define TVNORM_SECAM_D        0x00020000
> +#define TVNORM_SECAM_G        0x00040000
> +#define TVNORM_SECAM_H        0x00080000
> +#define TVNORM_SECAM_K        0x00100000
> +#define TVNORM_SECAM_K1       0x00200000
> +#define TVNORM_SECAM_L        0x00400000
> +#define TVNORM_SECAM_LC       0x00800000

Same here for SECAM.

> +
> +/* ATSC/HDTV */
> +#define TVNORM_ATSC_8_VSB     0x01000000
> +#define TVNORM_ATSC_16_VSB    0x02000000

I would drop these. The only driver using this is pvrusb2, and I am not
convinced that's right. And in any case, that driver doesn't use the DT.

Regards,

	Hans

> +
> +#endif /* _DT_BINDINGS_MEDIA_TVNORMS_H */
> 

