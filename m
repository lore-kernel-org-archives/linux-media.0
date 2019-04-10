Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCB6C10F14
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 16:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88F720830
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 16:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733165AbfDJQum (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:50:42 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:35463 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfDJQum (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 12:50:42 -0400
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 5A489200015;
        Wed, 10 Apr 2019 16:50:37 +0000 (UTC)
Date:   Wed, 10 Apr 2019 18:51:26 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     niklas.soderlund+renesas@ragnatech.se,
        kieran.bingham@ideasonboard.com, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, dave.stevenson@raspberrypi.org
Subject: Re: [RFC 1/5] v4l: subdev: Add MIPI CSI-2 PHY to frame desc
Message-ID: <20190410165126.pgmloncz2v3jswf5@uno.localdomain>
References: <20190316154801.20460-1-jacopo+renesas@jmondi.org>
 <20190316154801.20460-2-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="blckioxblauctyaf"
Content-Disposition: inline
In-Reply-To: <20190316154801.20460-2-jacopo+renesas@jmondi.org>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--blckioxblauctyaf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sakari, Laurent, all..

The more I look at this patch, the less I like it, to be honest...

On Sat, Mar 16, 2019 at 04:47:57PM +0100, Jacopo Mondi wrote:
> Add PHY-specific parameters to MIPI CSI-2 frame descriptor.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  include/media/v4l2-subdev.h | 42 +++++++++++++++++++++++++++++++------
>  1 file changed, 36 insertions(+), 6 deletions(-)
>
> diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
> index 6311f670de3c..eca9633c83bf 100644
> --- a/include/media/v4l2-subdev.h
> +++ b/include/media/v4l2-subdev.h
> @@ -317,11 +317,33 @@ struct v4l2_subdev_audio_ops {
>  	int (*s_stream)(struct v4l2_subdev *sd, int enable);
>  };
>
> +#define V4L2_FRAME_DESC_ENTRY_DPHY_DATA_LANES	4
> +
> +/**
> + * struct v4l2_mbus_frame_desc_entry_csi2_dphy - MIPI D-PHY bus configur=
ation
> + *
> + * @clock_lane:		physical lane index of the clock lane
> + * @data_lanes:		an array of physical data lane indexes
> + * @num_data_lanes:	number of data lanes
> + */
> +struct v4l2_mbus_frame_desc_entry_csi2_dphy {
> +	u8 clock_lane;
> +	u8 data_lanes[V4L2_FRAME_DESC_ENTRY_DPHY_DATA_LANES];
> +	u8 num_data_lanes;
> +};
> +
> +/**
> + * struct v4l2_mbus_frame_desc_entry_csi2_cphy - MIPI C-PHY bus configur=
ation
> + */
> +struct v4l2_mbus_frame_desc_entry_csi2_cphy {
> +	/* TODO */
> +};
> +
>  /**
>   * struct v4l2_mbus_frame_desc_entry_csi2
>   *
> - * @channel: CSI-2 virtual channel
> - * @data_type: CSI-2 data type ID
> + * @channel:	CSI-2 virtual channel
> + * @data_type:	CSI-2 data type ID
>   */
>  struct v4l2_mbus_frame_desc_entry_csi2 {
>  	u8 channel;
> @@ -371,18 +393,26 @@ enum v4l2_mbus_frame_desc_type {
>  	V4L2_MBUS_FRAME_DESC_TYPE_PLATFORM,
>  	V4L2_MBUS_FRAME_DESC_TYPE_PARALLEL,
>  	V4L2_MBUS_FRAME_DESC_TYPE_CCP2,
> -	V4L2_MBUS_FRAME_DESC_TYPE_CSI2,
> +	V4L2_MBUS_FRAME_DESC_TYPE_CSI2_DPHY,
> +	V4L2_MBUS_FRAME_DESC_TYPE_CSI2_CPHY,
>  };
>
>  /**
>   * struct v4l2_mbus_frame_desc - media bus data frame description
> - * @type: type of the bus (enum v4l2_mbus_frame_desc_type)
> - * @entry: frame descriptors array
> - * @num_entries: number of entries in @entry array
> + * @type:		type of the bus (enum v4l2_mbus_frame_desc_type)
> + * @entry:		frame descriptors array
> + * @phy:		PHY specific parameters
> + * @phy.dphy:		MIPI D-PHY specific bus configurations
> + * @phy.cphy:		MIPI C-PHY specific bus configurations
> + * @num_entries:	number of entries in @entry array
>   */
>  struct v4l2_mbus_frame_desc {
>  	enum v4l2_mbus_frame_desc_type type;
>  	struct v4l2_mbus_frame_desc_entry entry[V4L2_FRAME_DESC_ENTRY_MAX];
> +	union {
> +		struct v4l2_mbus_frame_desc_entry_csi2_dphy csi2_dphy;
> +		struct v4l2_mbus_frame_desc_entry_csi2_cphy csi2_cphy;
> +	} phy;

I had a brief look at how v4l2_mbus_frame_desc evolved, and how Sakari
has extended it with stream and CSI-2 specific information in the
v4l-multiplexed series[1] before I've thrown the phy configuration part
in the mix with this patch, and my feeling is that we're maybe bending
the original v4l2_mbus_frame_desc purpose to our needs a bit...

What I'm questioning is if stream and media bus configuration actually
belong here. Sure we could bend this to match our purposes, but
'struct v4l2_mbus_frame_desc' is actually only used in mainline to
transport informations about binary streams, and it fits the purpose,
which is, by the way, also intended in the structure name.

What I think would be more appropriate would be a 'streaming session'
descriptor, that contains entries for up to 4 streams and one phy
configuration part. I would even say that, as this changes are intended
to make frame_desc usable to negotiate multiplexed streams parameters
that are only available on CSI-2 (VC and data type at the protocol level,
and since this patch, a few D-PHY parameters at the phy level) this
could actually be (at least initially) a new CSI-2 specific
structure with a new set of operations associated, so that we can leave
frame_desc alone to be used for binary blob description?

What do you think? Are you comfortable with this change?

Thanks
   j


[1]
https://patchwork.kernel.org/patch/10875871/
https://patchwork.kernel.org/patch/10875873/
https://patchwork.kernel.org/patch/10875879/

=46rom the same series, here it is how frame_desc is now used:
https://patchwork.kernel.org/patch/10875911/
https://patchwork.kernel.org/patch/10875911/

And from this RFC series how it would be used to expose phy
parameters:
https://patchwork.kernel.org/patch/10855937/



>  	unsigned short num_entries;
>  };
>
> --
> 2.21.0
>

--blckioxblauctyaf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAlyuHw4ACgkQcjQGjxah
Vjx3thAAlY2rU/BKEYGdnzMsPYuT+MpL+hIegzGT/nL7m34LrawV7PWId5/KuIdS
Z5IijM8c3ciqP3ghcR6YD7IM0r71b0tE9rFR74vl/KWHIHAgsqTHJfTx+sVkeSx8
YEKHvEo8SCbT3adEG69wI9XrUb4gK/YsASPeK6OO50iAxzdFI866f8luqHPtctz1
NBaxhkVvLlSUkU7l74DXS3L+dX6JCQWhwKA/OOG3cDjsaeolyyK8ogBkVuUvhfMr
Ntl0oawakFSdYjoWqLSSoc0e57y5OUZ5Re8k7OLXGsUraDcPFjVqA5mN91dbQIEg
9JzDybf+DpyUs+kE2xAvHK/0k1Dlkd1ELxd2uoRMzlVY2UBK6NR54ChPBS8vhW0p
LlALk9NatNFXsKbouJi3txvs+xacQdkH65FKhEN4MhBEIm9FFjPbdLP294F9upKu
eIVm2dysklh2LUoK3CWQTFGwdvM5p3um+HgggXAOzU2ZCRYkiFHdQdJ6S72SF48J
PTB89CHo9PHTKXcNGaAmtq5f2i82WS4JzqjgaTiXhShz/i2XIlgbhK8YhTZE2M0/
pJqOnb5mdL+GmakfiQuYYpTHhvp02s5YJbFE3Y/cr9wjVc0iV6tKo7O5J/IoXM4E
G30sGO34N2igbJRtmv2v7++S6wxItgayDSz/2g/2pyTe8hY/VHE=
=JlMp
-----END PGP SIGNATURE-----

--blckioxblauctyaf--
