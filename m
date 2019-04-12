Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDB7C282DA
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 14:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6427221872
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 14:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lBMMjoU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfDLOPw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:15:52 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:41258 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfDLOPw (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 10:15:52 -0400
Received: from [192.168.0.20] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C3714549;
        Fri, 12 Apr 2019 16:15:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1555078549;
        bh=8WicnBXPfM5dYwNKL3BgjuWUxvhU2U12IY0unTCaGkI=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lBMMjoU5f90eN+tSRbpUX6fd+hXM7ycJhCBPiy8xX9CQGimd+VUgoOtvLqRRnup3o
         UQ/E/C+jyYUu9HelQOk95anaDupvnh/1AFzOdEoDGEmxr4o6xYt65nz94FlAeeK8QG
         HjNRdt5K1bHmYUvbvvfGbiMGReQWQ9CVAKsPtnUk=
Reply-To: kieran.bingham@ideasonboard.com
Subject: Re: [RFC 2/5] media: adv748x: Post-pone IO10 write to power up
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        sakari.ailus@linux.intel.com, laurent.pinchart@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se
Cc:     linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        dave.stevenson@raspberrypi.org
References: <20190316154801.20460-1-jacopo+renesas@jmondi.org>
 <20190316154801.20460-3-jacopo+renesas@jmondi.org>
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kieran.bingham@ideasonboard.com; keydata=
 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
 sbsRB8KNNvVXBOVNwko86rQqF9drZuw=
Organization: Ideas on Board
Message-ID: <e72d1698-baed-6d80-3453-51d77cbf9d07@ideasonboard.com>
Date:   Fri, 12 Apr 2019 15:15:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190316154801.20460-3-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Jacopo,

On 16/03/2019 15:47, Jacopo Mondi wrote:
> Post-pone the write of the ADV748X_IO_10 register that controls the active
> routing between the CP and AFE cores to the 4-lanes CSI-2 TXA at TX
> power-up time.

"by caching its configuration in the driver state."

> 
> While at there, use the 'csi4_in_sel' name, which matches the register

'While at it, use the...'

Except I'm not sure csi4_in_sel is the right name for the cached values
as below...


> field description in the manual, in place of 'io_10' which is the full
> register name.
> 

This has a fixes tag, but doesn't state what the actual problem is?

Can I assume that the problem is that the configuration here is being
written to the hardware before it is powered up or such?

Or perhaps reading through the patch again, is it that the call to
link_setup can affect running streams?



> Fixes: 9423ca350df7 ("media: adv748x: Implement TX link_setup callback")
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  drivers/media/i2c/adv748x/adv748x-core.c | 53 ++++++++++++++----------
>  drivers/media/i2c/adv748x/adv748x.h      |  2 +
>  2 files changed, 33 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/media/i2c/adv748x/adv748x-core.c b/drivers/media/i2c/adv748x/adv748x-core.c
> index 0e5a75eb6d75..02135741b1a6 100644
> --- a/drivers/media/i2c/adv748x/adv748x-core.c
> +++ b/drivers/media/i2c/adv748x/adv748x-core.c
> @@ -305,23 +305,35 @@ static int adv748x_power_down_tx(struct adv748x_csi2 *tx)
> 
>  int adv748x_tx_power(struct adv748x_csi2 *tx, bool on)
>  {
> -	int val;
> +	u8 io10_mask = ADV748X_IO_10_CSI1_EN | ADV748X_IO_10_CSI4_EN |
> +		       ADV748X_IO_10_CSI4_IN_SEL_AFE;
> +	struct adv748x_state *state = tx->state;
> +	int ret;
> 
>  	if (!is_tx_enabled(tx))
>  		return 0;
> 
> -	val = tx_read(tx, ADV748X_CSI_FS_AS_LS);
> -	if (val < 0)
> -		return val;
> +	ret = tx_read(tx, ADV748X_CSI_FS_AS_LS);
> +	if (ret < 0)
> +		return ret;
> 
>  	/*
>  	 * This test against BIT(6) is not documented by the datasheet, but was
>  	 * specified in the downstream driver.
>  	 * Track with a WARN_ONCE to determine if it is ever set by HW.
>  	 */
> -	WARN_ONCE((on && val & ADV748X_CSI_FS_AS_LS_UNKNOWN),
> +	WARN_ONCE((on && ret & ADV748X_CSI_FS_AS_LS_UNKNOWN),
>  			"Enabling with unknown bit set");
> 
> +	/* Configure TXA routing. */

Should TXA routing be configured even on TXB power up? This function
handles both TX code paths. (Edit: possibly yes)

Can the logic that determines state->csi4_in_sel value simply be moved
here (or to an independent adv748x_configure_routing() function)?

I think this patch means that changes to routing will now only take
effect when starting or stopping a stream, is that right? (If so - could
that go into the commit message please?)




> +	if (on) {
> +		ret = io_clrset(state, ADV748X_IO_10, io10_mask,
> +				state->csi4_in_sel);
> +		if (ret)
> +			return ret;
> +	}
> +
> +
>  	return on ? adv748x_power_up_tx(tx) : adv748x_power_down_tx(tx);
>  }
> 
> @@ -337,10 +349,7 @@ static int adv748x_link_setup(struct media_entity *entity,
>  	struct adv748x_state *state = v4l2_get_subdevdata(sd);
>  	struct adv748x_csi2 *tx = adv748x_sd_to_csi2(sd);
>  	bool enable = flags & MEDIA_LNK_FL_ENABLED;
> -	u8 io10_mask = ADV748X_IO_10_CSI1_EN |
> -		       ADV748X_IO_10_CSI4_EN |
> -		       ADV748X_IO_10_CSI4_IN_SEL_AFE;
> -	u8 io10 = 0;
> +	u8 csi4_in_sel = 0;
> 
>  	/* Refuse to enable multiple links to the same TX at the same time. */
>  	if (enable && tx->src)
> @@ -359,17 +368,19 @@ static int adv748x_link_setup(struct media_entity *entity,
> 
>  	if (state->afe.tx) {
>  		/* AFE Requires TXA enabled, even when output to TXB */
> -		io10 |= ADV748X_IO_10_CSI4_EN;
> +		csi4_in_sel |= ADV748X_IO_10_CSI4_EN;
>  		if (is_txa(tx))
> -			io10 |= ADV748X_IO_10_CSI4_IN_SEL_AFE;
> +			csi4_in_sel |= ADV748X_IO_10_CSI4_IN_SEL_AFE;

Hrm ... this is the one part that I think can't be determined without
caching some sort of value to state the routing.

>  		else
> -			io10 |= ADV748X_IO_10_CSI1_EN;
> +			csi4_in_sel |= ADV748X_IO_10_CSI1_EN;
>  	}
> 
>  	if (state->hdmi.tx)
> -		io10 |= ADV748X_IO_10_CSI4_EN;
> +		csi4_in_sel |= ADV748X_IO_10_CSI4_EN;
> 
> -	return io_clrset(state, ADV748X_IO_10, io10_mask, io10);
> +	state->csi4_in_sel = csi4_in_sel;
> +
> +	return 0;
>  }
> 
>  static const struct media_entity_operations adv748x_tx_media_ops = {
> @@ -485,7 +496,6 @@ static int adv748x_sw_reset(struct adv748x_state *state)
>  static int adv748x_reset(struct adv748x_state *state)
>  {
>  	int ret;
> -	u8 regval = 0;
> 
>  	ret = adv748x_sw_reset(state);
>  	if (ret < 0)
> @@ -504,6 +514,12 @@ static int adv748x_reset(struct adv748x_state *state)
>  	if (ret)
>  		return ret;
> 

Should adv748x_reset() reset the state->csi4_in_sel cached value to 0
before setting it?


> +	/* Conditionally enable TXa and TXb. */
> +	if (is_tx_enabled(&state->txa))
> +		state->csi4_in_sel |= ADV748X_IO_10_CSI4_EN;
> +	if (is_tx_enabled(&state->txb))
> +		state->csi4_in_sel |= ADV748X_IO_10_CSI1_EN;

This makes it looks like the naming "csi4_in_sel" is less appropriate,
as it covers both CSI4 and CSI1...

Also, this is confusing two terms, between the 'enable' and the 'select'

The _EN bits looks like they control the activation of the CSI
transmitter, where as the 'select' bits control the routing.

As the is_tx_enabled($TX) state is constant, perhaps that bit could be
inferred later when the register is written, and doesn't need to be
cached here?


> +
>  	/* Reset TXA and TXB */
>  	adv748x_tx_power(&state->txa, 1);
>  	adv748x_tx_power(&state->txa, 0);
> @@ -513,13 +529,6 @@ static int adv748x_reset(struct adv748x_state *state)
>  	/* Disable chip powerdown & Enable HDMI Rx block */
>  	io_write(state, ADV748X_IO_PD, ADV748X_IO_PD_RX_EN);
> 
> -	/* Conditionally enable TXa and TXb. */
> -	if (is_tx_enabled(&state->txa))
> -		regval |= ADV748X_IO_10_CSI4_EN;
> -	if (is_tx_enabled(&state->txb))
> -		regval |= ADV748X_IO_10_CSI1_EN;
> -	io_write(state, ADV748X_IO_10, regval);
> -
>  	/* Use vid_std and v_freq as freerun resolution for CP */
>  	cp_clrset(state, ADV748X_CP_CLMP_POS, ADV748X_CP_CLMP_POS_DIS_AUTO,
>  					      ADV748X_CP_CLMP_POS_DIS_AUTO);
> diff --git a/drivers/media/i2c/adv748x/adv748x.h b/drivers/media/i2c/adv748x/adv748x.h
> index 4a5a6445604f..27c116d09284 100644
> --- a/drivers/media/i2c/adv748x/adv748x.h
> +++ b/drivers/media/i2c/adv748x/adv748x.h
> @@ -196,6 +196,8 @@ struct adv748x_state {
>  	struct adv748x_afe afe;
>  	struct adv748x_csi2 txa;
>  	struct adv748x_csi2 txb;
> +
> +	unsigned int csi4_in_sel;
>  };
> 
>  #define adv748x_hdmi_to_state(h) container_of(h, struct adv748x_state, hdmi)
> --
> 2.21.0
> 

-- 
Regards
--
Kieran
