Return-Path: <SRS0=JUE0=SR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FC5C282CE
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 06:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308A720833
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 06:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfDOG7s (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Apr 2019 02:59:48 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:35707 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfDOG7s (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Apr 2019 02:59:48 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 4025EE0008;
        Mon, 15 Apr 2019 06:59:43 +0000 (UTC)
Date:   Mon, 15 Apr 2019 09:00:26 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        sakari.ailus@linux.intel.com, laurent.pinchart@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, dave.stevenson@raspberrypi.org
Subject: Re: [RFC 2/5] media: adv748x: Post-pone IO10 write to power up
Message-ID: <20190415070026.3yq5tbufajptkijf@uno.localdomain>
References: <20190316154801.20460-1-jacopo+renesas@jmondi.org>
 <20190316154801.20460-3-jacopo+renesas@jmondi.org>
 <e72d1698-baed-6d80-3453-51d77cbf9d07@ideasonboard.com>
 <20190412144551.wivieg3ue2inj5j3@uno.localdomain>
 <5c53a56c-ea52-001b-0ea3-ce2f20483702@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vhxj74uterkuh4u6"
Content-Disposition: inline
In-Reply-To: <5c53a56c-ea52-001b-0ea3-ce2f20483702@ideasonboard.com>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--vhxj74uterkuh4u6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Kieran,

On Fri, Apr 12, 2019 at 04:57:45PM +0100, Kieran Bingham wrote:
> Hi Jacopo,
>
> On 12/04/2019 15:45, Jacopo Mondi wrote:
> > Hi Kieran,
> >
> > On Fri, Apr 12, 2019 at 03:15:46PM +0100, Kieran Bingham wrote:
> >> Hi Jacopo,
> >>
> >> On 16/03/2019 15:47, Jacopo Mondi wrote:
> >>> Post-pone the write of the ADV748X_IO_10 register that controls the active
> >>> routing between the CP and AFE cores to the 4-lanes CSI-2 TXA at TX
> >>> power-up time.
> >>
> >> "by caching its configuration in the driver state."
> >>
> >>>
> >>> While at there, use the 'csi4_in_sel' name, which matches the register
> >>
> >> 'While at it, use the...'
> >>
> >> Except I'm not sure csi4_in_sel is the right name for the cached values
> >> as below...
> >>
> >>
> >>> field description in the manual, in place of 'io_10' which is the full
> >>> register name.
> >>>
> >>
> >> This has a fixes tag, but doesn't state what the actual problem is?
> >>
> >
> > As reported in the cover letter, please see:
> > "[PATCH] media: adv748x: Don't disable CSI-2 on link_setup"
>
> Ah I see, I had missed that.
>
> The patch itself should still describe the problem if it's fixing
> something. The cover letter will not be available in the git-log.
>

You're right, I'll expand the commit message.

> Ok, so this patch supersedes "[PATCH] media: adv748x: Don't disable
> CSI-2 on link_setup" ?
>

Yes

> >> Can I assume that the problem is that the configuration here is being
> >> written to the hardware before it is powered up or such?
> >>
> >> Or perhaps reading through the patch again, is it that the call to
> >> link_setup can affect running streams?
> >
> > The issue I was trying to solve, even with the first patch is that
> > going through a link disable (eg. at media graph reset time) wrote to
> > the csi4_in_sel register a 0 value, when both TXA and TXB routing
> > where disabled and this causes issues on some HDMI transmiters, for
> > reason Ian and Hans tried to expand but about which I'm not yet sure
> > about.
>
> Ok, I found that patch and read their comments. So disabling the CSI2
> might trigger a hot-plug event to the transmitter which makes them think
> they have been (physically) disconnected in some way, or triggers them
> to re-read the EDID which will fail. But we don't really know what the
> fault is yet.
>

Correct. Please note that I've seen this happening with one HDMI
transmitter (a chromecast device), while if HDMI source is a laptop
everything's fine...

>
> > The idea here is to cache the routing settings at link_setup time
> > (upon activation or deactivation of a link) and apply them to hardware
> > at tx power up time, which happens at s_stream(1).
> >
> > In this way, if streaming is started, we know at least one link is
> > enabled and we can write to csi4_in_sel.
>
> Overall this seems reasonable, only making a change to io10 when either
> of the stream states are changed.
>

Thanks, I'll re-send (maybe even out of this series if it gets stale).
Could I have your tag on the next iteration?

Thanks
  j

>
> >>> Fixes: 9423ca350df7 ("media: adv748x: Implement TX link_setup callback")
> >>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >>> ---
> >>>  drivers/media/i2c/adv748x/adv748x-core.c | 53 ++++++++++++++----------
> >>>  drivers/media/i2c/adv748x/adv748x.h      |  2 +
> >>>  2 files changed, 33 insertions(+), 22 deletions(-)
> >>>
> >>> diff --git a/drivers/media/i2c/adv748x/adv748x-core.c b/drivers/media/i2c/adv748x/adv748x-core.c
> >>> index 0e5a75eb6d75..02135741b1a6 100644
> >>> --- a/drivers/media/i2c/adv748x/adv748x-core.c
> >>> +++ b/drivers/media/i2c/adv748x/adv748x-core.c
> >>> @@ -305,23 +305,35 @@ static int adv748x_power_down_tx(struct adv748x_csi2 *tx)
> >>>
> >>>  int adv748x_tx_power(struct adv748x_csi2 *tx, bool on)
> >>>  {
> >>> -	int val;
> >>> +	u8 io10_mask = ADV748X_IO_10_CSI1_EN | ADV748X_IO_10_CSI4_EN |
> >>> +		       ADV748X_IO_10_CSI4_IN_SEL_AFE;
> >>> +	struct adv748x_state *state = tx->state;
> >>> +	int ret;
> >>>
> >>>  	if (!is_tx_enabled(tx))
> >>>  		return 0;
> >>>
> >>> -	val = tx_read(tx, ADV748X_CSI_FS_AS_LS);
> >>> -	if (val < 0)
> >>> -		return val;
> >>> +	ret = tx_read(tx, ADV748X_CSI_FS_AS_LS);
> >>> +	if (ret < 0)
> >>> +		return ret;
> >>>
> >>>  	/*
> >>>  	 * This test against BIT(6) is not documented by the datasheet, but was
> >>>  	 * specified in the downstream driver.
> >>>  	 * Track with a WARN_ONCE to determine if it is ever set by HW.
> >>>  	 */
> >>> -	WARN_ONCE((on && val & ADV748X_CSI_FS_AS_LS_UNKNOWN),
> >>> +	WARN_ONCE((on && ret & ADV748X_CSI_FS_AS_LS_UNKNOWN),
> >>>  			"Enabling with unknown bit set");
> >>>
> >>> +	/* Configure TXA routing. */
> >>
> >> Should TXA routing be configured even on TXB power up? This function
> >> handles both TX code paths. (Edit: possibly yes)
> >>
> >
> > The comment is wrong, thanks for noticing.
> >
> >> Can the logic that determines state->csi4_in_sel value simply be moved
> >> here (or to an independent adv748x_configure_routing() function)?
> >>
> >
> > It has to be changed at link_setup time in rensponse to a media link
> > activation or deactivation.
> >
> >> I think this patch means that changes to routing will now only take
> >> effect when starting or stopping a stream, is that right? (If so - could
> >> that go into the commit message please?)
> >>
> >
> > Well...
> >
> >  Post-pone the write of the ADV748X_IO_10 register that controls the active
> >  routing between the CP and AFE cores to the 4-lanes CSI-2 TXA at TX
> >  power-up time.
> >
> > Doesn't it say that? Or what confused you is that s_stream->s_power(1)
> > and I should mention streaming instead of power up?
>
> I think of "Power up" meaning at device probe time (or possibly some
> runtime-pm event time). But yes, I think the distinction that it now
> happens at stream_on/stream_off is important.
>
>
>
> >
> >>
> >>
> >>
> >>> +	if (on) {
> >>> +		ret = io_clrset(state, ADV748X_IO_10, io10_mask,
> >>> +				state->csi4_in_sel);
> >>> +		if (ret)
> >>> +			return ret;
> >>> +	}
> >>> +
> >>> +
> >>>  	return on ? adv748x_power_up_tx(tx) : adv748x_power_down_tx(tx);
> >>>  }
> >>>
> >>> @@ -337,10 +349,7 @@ static int adv748x_link_setup(struct media_entity *entity,
> >>>  	struct adv748x_state *state = v4l2_get_subdevdata(sd);
> >>>  	struct adv748x_csi2 *tx = adv748x_sd_to_csi2(sd);
> >>>  	bool enable = flags & MEDIA_LNK_FL_ENABLED;
> >>> -	u8 io10_mask = ADV748X_IO_10_CSI1_EN |
> >>> -		       ADV748X_IO_10_CSI4_EN |
> >>> -		       ADV748X_IO_10_CSI4_IN_SEL_AFE;
> >>> -	u8 io10 = 0;
> >>> +	u8 csi4_in_sel = 0;
> >>>
> >>>  	/* Refuse to enable multiple links to the same TX at the same time. */
> >>>  	if (enable && tx->src)
> >>> @@ -359,17 +368,19 @@ static int adv748x_link_setup(struct media_entity *entity,
> >>>
> >>>  	if (state->afe.tx) {
> >>>  		/* AFE Requires TXA enabled, even when output to TXB */
> >>> -		io10 |= ADV748X_IO_10_CSI4_EN;
> >>> +		csi4_in_sel |= ADV748X_IO_10_CSI4_EN;
> >>>  		if (is_txa(tx))
> >>> -			io10 |= ADV748X_IO_10_CSI4_IN_SEL_AFE;
> >>> +			csi4_in_sel |= ADV748X_IO_10_CSI4_IN_SEL_AFE;
> >>
> >> Hrm ... this is the one part that I think can't be determined without
> >> caching some sort of value to state the routing.
> >>
> >
> > Yes
>
> But the actual hardware shouldn't be updated if the stream is running
> right? (I wonder if the media-controller would prevent that anyway).
>
>
>
> >
> >>>  		else
> >>> -			io10 |= ADV748X_IO_10_CSI1_EN;
> >>> +			csi4_in_sel |= ADV748X_IO_10_CSI1_EN;
> >>>  	}
> >>>
> >>>  	if (state->hdmi.tx)
> >>> -		io10 |= ADV748X_IO_10_CSI4_EN;
> >>> +		csi4_in_sel |= ADV748X_IO_10_CSI4_EN;
> >>>
> >>> -	return io_clrset(state, ADV748X_IO_10, io10_mask, io10);
> >>> +	state->csi4_in_sel = csi4_in_sel;
> >>> +
> >>> +	return 0;
> >>>  }
> >>>
> >>>  static const struct media_entity_operations adv748x_tx_media_ops = {
> >>> @@ -485,7 +496,6 @@ static int adv748x_sw_reset(struct adv748x_state *state)
> >>>  static int adv748x_reset(struct adv748x_state *state)
> >>>  {
> >>>  	int ret;
> >>> -	u8 regval = 0;
> >>>
> >>>  	ret = adv748x_sw_reset(state);
> >>>  	if (ret < 0)
> >>> @@ -504,6 +514,12 @@ static int adv748x_reset(struct adv748x_state *state)
> >>>  	if (ret)
> >>>  		return ret;
> >>>
> >>
> >> Should adv748x_reset() reset the state->csi4_in_sel cached value to 0
> >> before setting it?
> >
> > I should better check when reset happens, and if it happens only when
> > links have been disabled or not.
> > If links are disabled, the variable gets zeroed by the link_setup
> > callback. If reset happens with links active, we should not zero it
> > otherwise we lose the configuration
>
>
> Ah yes, I missed that the local variable is initialised to zero, and
> this state variable is set to the result at the end of the call...
>
> It does mean that the function ordering will be important here.
>
> It becomes irrelevant if these conditionals move to the same point
> anyway though.
>
>
>
> >
> >>
> >>
> >>> +	/* Conditionally enable TXa and TXb. */
> >>> +	if (is_tx_enabled(&state->txa))
> >>> +		state->csi4_in_sel |= ADV748X_IO_10_CSI4_EN;
> >>> +	if (is_tx_enabled(&state->txb))
> >>> +		state->csi4_in_sel |= ADV748X_IO_10_CSI1_EN;
> >>
> >> This makes it looks like the naming "csi4_in_sel" is less appropriate,
> >> as it covers both CSI4 and CSI1...
> >>
> >
> > Blame the hw designers :)
>
> Always. ... of course they keep blaming us back :D
>
> >
> >> Also, this is confusing two terms, between the 'enable' and the 'select'
> >>
> >> The _EN bits looks like they control the activation of the CSI
> >> transmitter, where as the 'select' bits control the routing.
> >>
> >
> > You are righ. csi4_in_sel should only control the 3 bits used for
> > routing, while enabling and disabling of the TXes is controlled by
> > other bits of the io_10 register.
> > I'll look into changing the name back
> >
> >> As the is_tx_enabled($TX) state is constant, perhaps that bit could be
> >> inferred later when the register is written, and doesn't need to be
> >> cached here?
> >
> > I'll consider that, thanks
>
> I think it's only the routing choice that needs to be stored in the
> state. That would minimise being stored 'globally', and the values could
> be determined at the time of programming the register.
>
> >
> > Thanks
> >   j
> >
> >>
> >>
> >>> +
> >>>  	/* Reset TXA and TXB */
> >>>  	adv748x_tx_power(&state->txa, 1);
> >>>  	adv748x_tx_power(&state->txa, 0);
> >>> @@ -513,13 +529,6 @@ static int adv748x_reset(struct adv748x_state *state)
> >>>  	/* Disable chip powerdown & Enable HDMI Rx block */
> >>>  	io_write(state, ADV748X_IO_PD, ADV748X_IO_PD_RX_EN);
> >>>
> >>> -	/* Conditionally enable TXa and TXb. */
> >>> -	if (is_tx_enabled(&state->txa))
> >>> -		regval |= ADV748X_IO_10_CSI4_EN;
> >>> -	if (is_tx_enabled(&state->txb))
> >>> -		regval |= ADV748X_IO_10_CSI1_EN;
> >>> -	io_write(state, ADV748X_IO_10, regval);
> >>> -
> >>>  	/* Use vid_std and v_freq as freerun resolution for CP */
> >>>  	cp_clrset(state, ADV748X_CP_CLMP_POS, ADV748X_CP_CLMP_POS_DIS_AUTO,
> >>>  					      ADV748X_CP_CLMP_POS_DIS_AUTO);
> >>> diff --git a/drivers/media/i2c/adv748x/adv748x.h b/drivers/media/i2c/adv748x/adv748x.h
> >>> index 4a5a6445604f..27c116d09284 100644
> >>> --- a/drivers/media/i2c/adv748x/adv748x.h
> >>> +++ b/drivers/media/i2c/adv748x/adv748x.h
> >>> @@ -196,6 +196,8 @@ struct adv748x_state {
> >>>  	struct adv748x_afe afe;
> >>>  	struct adv748x_csi2 txa;
> >>>  	struct adv748x_csi2 txb;
> >>> +
> >>> +	unsigned int csi4_in_sel;
> >>>  };
> >>>
> >>>  #define adv748x_hdmi_to_state(h) container_of(h, struct adv748x_state, hdmi)
> >>> --
> >>> 2.21.0
> >>>
>
> --
> Regards
> --
> Kieran

--vhxj74uterkuh4u6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAly0LAoACgkQcjQGjxah
VjxyyQ/9EaGguO4To0cv5qbIMxC+EABjTzFQkmHk41ADbP4YhqvhSlvwTPYLkDg+
vGq9l1ryEqI8M7+sYSnpKMUMMDh5q/yMf3GKTRrC0PreeSarrAaMoHvkCMMF93bD
iKRdli4uABsYBFJTvqGJhTi8petjQmoNtp+a5pOUzVumXtFrJ1BZziRjg9S6y7eh
pHTYHypn4Oo2erls1aieXiIouTqJ9bnqYZ3XRhvqALvy+7dOR7D0ZSg34z7Cv8wW
76HKGJmDyPo3eDi46p4X8sgRp+bdUGprSNtwFWiHs3pQra6nCUtn6P15pFbCZnBZ
QUn5mf8QnsfmT5iIJ/fDuGk/6ccRTPFfnEMUEoNRaHyjiC7UOIjUgHP4S0wv6Y6k
DBm+V6tXjKj7RFhVNR1QSHO8eQnxQTSqN+j9PQmbUMBfI2LQ2HNheuHUybzoOyHI
dG18U9JEedWnswu3DtgWIrZc27sxjZVpkAyI0+MYWdLFuC/3FeOxF0WvZrn5OIcA
g2TkRcQkScxx6HnsGnjXdKf5kQmLlI0lOyGcWhO4ePCIW9Nde9AUZi0/XNXe0bjs
oBP9Nskv4Jw8PKlVsUb60sTiRaAUeVWndXmp7SxBkD8QpJKS56PjT3KAy8XoP1K7
UeaItGh0nmgFBKVoJ8fuV71nUXHxRHgVYvA9EIZiZJN/yvctYkk=
=bQVH
-----END PGP SIGNATURE-----

--vhxj74uterkuh4u6--
