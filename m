Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44642C10F14
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 14:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F642171F
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 14:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfDLOpH (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:45:07 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:55859 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfDLOpH (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 10:45:07 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 31FEC2001B;
        Fri, 12 Apr 2019 14:45:01 +0000 (UTC)
Date:   Fri, 12 Apr 2019 16:45:51 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        sakari.ailus@linux.intel.com, laurent.pinchart@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, dave.stevenson@raspberrypi.org
Subject: Re: [RFC 2/5] media: adv748x: Post-pone IO10 write to power up
Message-ID: <20190412144551.wivieg3ue2inj5j3@uno.localdomain>
References: <20190316154801.20460-1-jacopo+renesas@jmondi.org>
 <20190316154801.20460-3-jacopo+renesas@jmondi.org>
 <e72d1698-baed-6d80-3453-51d77cbf9d07@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aeniegxz6gqjl3y7"
Content-Disposition: inline
In-Reply-To: <e72d1698-baed-6d80-3453-51d77cbf9d07@ideasonboard.com>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--aeniegxz6gqjl3y7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Kieran,

On Fri, Apr 12, 2019 at 03:15:46PM +0100, Kieran Bingham wrote:
> Hi Jacopo,
>
> On 16/03/2019 15:47, Jacopo Mondi wrote:
> > Post-pone the write of the ADV748X_IO_10 register that controls the active
> > routing between the CP and AFE cores to the 4-lanes CSI-2 TXA at TX
> > power-up time.
>
> "by caching its configuration in the driver state."
>
> >
> > While at there, use the 'csi4_in_sel' name, which matches the register
>
> 'While at it, use the...'
>
> Except I'm not sure csi4_in_sel is the right name for the cached values
> as below...
>
>
> > field description in the manual, in place of 'io_10' which is the full
> > register name.
> >
>
> This has a fixes tag, but doesn't state what the actual problem is?
>

As reported in the cover letter, please see:
"[PATCH] media: adv748x: Don't disable CSI-2 on link_setup"

> Can I assume that the problem is that the configuration here is being
> written to the hardware before it is powered up or such?
>
> Or perhaps reading through the patch again, is it that the call to
> link_setup can affect running streams?

The issue I was trying to solve, even with the first patch is that
going through a link disable (eg. at media graph reset time) wrote to
the csi4_in_sel register a 0 value, when both TXA and TXB routing
where disabled and this causes issues on some HDMI transmiters, for
reason Ian and Hans tried to expand but about which I'm not yet sure
about.

The idea here is to cache the routing settings at link_setup time
(upon activation or deactivation of a link) and apply them to hardware
at tx power up time, which happens at s_stream(1).

In this way, if streaming is started, we know at least one link is
enabled and we can write to csi4_in_sel.

>
>
>
> > Fixes: 9423ca350df7 ("media: adv748x: Implement TX link_setup callback")
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > ---
> >  drivers/media/i2c/adv748x/adv748x-core.c | 53 ++++++++++++++----------
> >  drivers/media/i2c/adv748x/adv748x.h      |  2 +
> >  2 files changed, 33 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/media/i2c/adv748x/adv748x-core.c b/drivers/media/i2c/adv748x/adv748x-core.c
> > index 0e5a75eb6d75..02135741b1a6 100644
> > --- a/drivers/media/i2c/adv748x/adv748x-core.c
> > +++ b/drivers/media/i2c/adv748x/adv748x-core.c
> > @@ -305,23 +305,35 @@ static int adv748x_power_down_tx(struct adv748x_csi2 *tx)
> >
> >  int adv748x_tx_power(struct adv748x_csi2 *tx, bool on)
> >  {
> > -	int val;
> > +	u8 io10_mask = ADV748X_IO_10_CSI1_EN | ADV748X_IO_10_CSI4_EN |
> > +		       ADV748X_IO_10_CSI4_IN_SEL_AFE;
> > +	struct adv748x_state *state = tx->state;
> > +	int ret;
> >
> >  	if (!is_tx_enabled(tx))
> >  		return 0;
> >
> > -	val = tx_read(tx, ADV748X_CSI_FS_AS_LS);
> > -	if (val < 0)
> > -		return val;
> > +	ret = tx_read(tx, ADV748X_CSI_FS_AS_LS);
> > +	if (ret < 0)
> > +		return ret;
> >
> >  	/*
> >  	 * This test against BIT(6) is not documented by the datasheet, but was
> >  	 * specified in the downstream driver.
> >  	 * Track with a WARN_ONCE to determine if it is ever set by HW.
> >  	 */
> > -	WARN_ONCE((on && val & ADV748X_CSI_FS_AS_LS_UNKNOWN),
> > +	WARN_ONCE((on && ret & ADV748X_CSI_FS_AS_LS_UNKNOWN),
> >  			"Enabling with unknown bit set");
> >
> > +	/* Configure TXA routing. */
>
> Should TXA routing be configured even on TXB power up? This function
> handles both TX code paths. (Edit: possibly yes)
>

The comment is wrong, thanks for noticing.

> Can the logic that determines state->csi4_in_sel value simply be moved
> here (or to an independent adv748x_configure_routing() function)?
>

It has to be changed at link_setup time in rensponse to a media link
activation or deactivation.

> I think this patch means that changes to routing will now only take
> effect when starting or stopping a stream, is that right? (If so - could
> that go into the commit message please?)
>

Well...

 Post-pone the write of the ADV748X_IO_10 register that controls the active
 routing between the CP and AFE cores to the 4-lanes CSI-2 TXA at TX
 power-up time.

Doesn't it say that? Or what confused you is that s_stream->s_power(1)
and I should mention streaming instead of power up?

>
>
>
> > +	if (on) {
> > +		ret = io_clrset(state, ADV748X_IO_10, io10_mask,
> > +				state->csi4_in_sel);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +
> >  	return on ? adv748x_power_up_tx(tx) : adv748x_power_down_tx(tx);
> >  }
> >
> > @@ -337,10 +349,7 @@ static int adv748x_link_setup(struct media_entity *entity,
> >  	struct adv748x_state *state = v4l2_get_subdevdata(sd);
> >  	struct adv748x_csi2 *tx = adv748x_sd_to_csi2(sd);
> >  	bool enable = flags & MEDIA_LNK_FL_ENABLED;
> > -	u8 io10_mask = ADV748X_IO_10_CSI1_EN |
> > -		       ADV748X_IO_10_CSI4_EN |
> > -		       ADV748X_IO_10_CSI4_IN_SEL_AFE;
> > -	u8 io10 = 0;
> > +	u8 csi4_in_sel = 0;
> >
> >  	/* Refuse to enable multiple links to the same TX at the same time. */
> >  	if (enable && tx->src)
> > @@ -359,17 +368,19 @@ static int adv748x_link_setup(struct media_entity *entity,
> >
> >  	if (state->afe.tx) {
> >  		/* AFE Requires TXA enabled, even when output to TXB */
> > -		io10 |= ADV748X_IO_10_CSI4_EN;
> > +		csi4_in_sel |= ADV748X_IO_10_CSI4_EN;
> >  		if (is_txa(tx))
> > -			io10 |= ADV748X_IO_10_CSI4_IN_SEL_AFE;
> > +			csi4_in_sel |= ADV748X_IO_10_CSI4_IN_SEL_AFE;
>
> Hrm ... this is the one part that I think can't be determined without
> caching some sort of value to state the routing.
>

Yes

> >  		else
> > -			io10 |= ADV748X_IO_10_CSI1_EN;
> > +			csi4_in_sel |= ADV748X_IO_10_CSI1_EN;
> >  	}
> >
> >  	if (state->hdmi.tx)
> > -		io10 |= ADV748X_IO_10_CSI4_EN;
> > +		csi4_in_sel |= ADV748X_IO_10_CSI4_EN;
> >
> > -	return io_clrset(state, ADV748X_IO_10, io10_mask, io10);
> > +	state->csi4_in_sel = csi4_in_sel;
> > +
> > +	return 0;
> >  }
> >
> >  static const struct media_entity_operations adv748x_tx_media_ops = {
> > @@ -485,7 +496,6 @@ static int adv748x_sw_reset(struct adv748x_state *state)
> >  static int adv748x_reset(struct adv748x_state *state)
> >  {
> >  	int ret;
> > -	u8 regval = 0;
> >
> >  	ret = adv748x_sw_reset(state);
> >  	if (ret < 0)
> > @@ -504,6 +514,12 @@ static int adv748x_reset(struct adv748x_state *state)
> >  	if (ret)
> >  		return ret;
> >
>
> Should adv748x_reset() reset the state->csi4_in_sel cached value to 0
> before setting it?

I should better check when reset happens, and if it happens only when
links have been disabled or not.
If links are disabled, the variable gets zeroed by the link_setup
callback. If reset happens with links active, we should not zero it
otherwise we lose the configuration

>
>
> > +	/* Conditionally enable TXa and TXb. */
> > +	if (is_tx_enabled(&state->txa))
> > +		state->csi4_in_sel |= ADV748X_IO_10_CSI4_EN;
> > +	if (is_tx_enabled(&state->txb))
> > +		state->csi4_in_sel |= ADV748X_IO_10_CSI1_EN;
>
> This makes it looks like the naming "csi4_in_sel" is less appropriate,
> as it covers both CSI4 and CSI1...
>

Blame the hw designers :)

> Also, this is confusing two terms, between the 'enable' and the 'select'
>
> The _EN bits looks like they control the activation of the CSI
> transmitter, where as the 'select' bits control the routing.
>

You are righ. csi4_in_sel should only control the 3 bits used for
routing, while enabling and disabling of the TXes is controlled by
other bits of the io_10 register.
I'll look into changing the name back

> As the is_tx_enabled($TX) state is constant, perhaps that bit could be
> inferred later when the register is written, and doesn't need to be
> cached here?

I'll consider that, thanks

Thanks
  j

>
>
> > +
> >  	/* Reset TXA and TXB */
> >  	adv748x_tx_power(&state->txa, 1);
> >  	adv748x_tx_power(&state->txa, 0);
> > @@ -513,13 +529,6 @@ static int adv748x_reset(struct adv748x_state *state)
> >  	/* Disable chip powerdown & Enable HDMI Rx block */
> >  	io_write(state, ADV748X_IO_PD, ADV748X_IO_PD_RX_EN);
> >
> > -	/* Conditionally enable TXa and TXb. */
> > -	if (is_tx_enabled(&state->txa))
> > -		regval |= ADV748X_IO_10_CSI4_EN;
> > -	if (is_tx_enabled(&state->txb))
> > -		regval |= ADV748X_IO_10_CSI1_EN;
> > -	io_write(state, ADV748X_IO_10, regval);
> > -
> >  	/* Use vid_std and v_freq as freerun resolution for CP */
> >  	cp_clrset(state, ADV748X_CP_CLMP_POS, ADV748X_CP_CLMP_POS_DIS_AUTO,
> >  					      ADV748X_CP_CLMP_POS_DIS_AUTO);
> > diff --git a/drivers/media/i2c/adv748x/adv748x.h b/drivers/media/i2c/adv748x/adv748x.h
> > index 4a5a6445604f..27c116d09284 100644
> > --- a/drivers/media/i2c/adv748x/adv748x.h
> > +++ b/drivers/media/i2c/adv748x/adv748x.h
> > @@ -196,6 +196,8 @@ struct adv748x_state {
> >  	struct adv748x_afe afe;
> >  	struct adv748x_csi2 txa;
> >  	struct adv748x_csi2 txb;
> > +
> > +	unsigned int csi4_in_sel;
> >  };
> >
> >  #define adv748x_hdmi_to_state(h) container_of(h, struct adv748x_state, hdmi)
> > --
> > 2.21.0
> >
>
> --
> Regards
> --
> Kieran

--aeniegxz6gqjl3y7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAlywpJ8ACgkQcjQGjxah
VjxEUQ/6A4gd+8h2TtUAPdZdnpKuXa/javsQZrPomhuj7NGmovhS7qLoUfnSXSQd
pMdASYFIyB7F0clsVcTl0Tiy4voRb5GC4PiV55l9XR7ASSleiSYKOavCgiE0aH3Z
nQJX4ce7mKsbb4Ls1NiJRR6Pc+HZ2avVFwuhN5wrADd7G0nqYzJmOjixEEpCLuLu
osP4ZI3JPFz52WBc/ltFUu142hNtlPSST4DzB6l5Kb2v48yLBx2DQz/akQo271De
i8HZCdq0tSjGiUKlVhMVAef9uDnaw7ErPOc76M+05MrRmU/BwbJQI37dOyGoWb95
EcppS5XCJTRKHa2ajpfUZW3DrHCrwr915GFHoiXza0HIS320bW+LIKcEyn9V0B2P
kYhcNKZ2g3n86zSM2oVhsbiEps8SjPdCZxQiywtoZ0GdjFiVJ31wJ7dNu6/KkUg+
ivg7WAPIiODquVjWz0HrtmUXSiImYejQEAathU2DFxxuK/D3gntcKHlYt73y2097
NABI+saOyVcWhTAQX636XSVuXAgLVMBJB5aFvt50JuBnno4kOluWsOXCCUfkrsXd
oWjBauJtaFRJ4Qo5yNEEGZnX9AXhXqA64LcDKyXdJU/qqOdxF7QUWemuOQiZ9IA4
O7ttV8VzzelthrB/0DWXfD568utF9CMGQb13jUj+2sv8x7ydJNE=
=rhZ8
-----END PGP SIGNATURE-----

--aeniegxz6gqjl3y7--
