Return-Path: <SRS0=Dnes=SH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAD1C4360F
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 11:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487D5206B6
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 11:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbfDELYC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:24:02 -0400
Received: from gofer.mess.org ([88.97.38.141]:48483 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730642AbfDELYC (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 5 Apr 2019 07:24:02 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 4F1086023D; Fri,  5 Apr 2019 12:24:00 +0100 (BST)
Date:   Fri, 5 Apr 2019 12:24:00 +0100
From:   Sean Young <sean@mess.org>
To:     Brad Love <brad@nextdimension.cc>
Cc:     linux-media@vger.kernel.org, mchehab@kernel.org
Subject: Re: [PATCH 2/2] cx25840-core: Set media controller taint for pads
Message-ID: <20190405112359.mqnsk2ffg56o6s32@gofer.mess.org>
References: <1547515448-15258-1-git-send-email-brad@nextdimension.cc>
 <1547515448-15258-3-git-send-email-brad@nextdimension.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547515448-15258-3-git-send-email-brad@nextdimension.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Jan 14, 2019 at 07:24:08PM -0600, Brad Love wrote:
> Fixes: 9d6d20e652 ("v4l2-mc: switch it to use the new approach to setup pipelines")
> 
> Without "taint" set for signal type, devices
> with analog capture fail during probe:
> 
> [    5.821715] cx231xx 3-2:1.1: v4l2 driver version 0.0.3
> [    5.955721] cx231xx 3-2:1.1: Registered video device video0 [v4l2]
> [    5.955797] cx231xx 3-2:1.1: Registered VBI device vbi0
> [    5.955802] cx231xx 3-2:1.1: video EndPoint Addr 0x84, Alternate settings: 5
> [    5.955805] cx231xx 3-2:1.1: VBI EndPoint Addr 0x85, Alternate settings: 2
> [    5.955807] cx231xx 3-2:1.1: sliced CC EndPoint Addr 0x86, Alternate settings: 2
> [    5.955834] cx231xx 3-2:1.1: V4L2 device vbi0 deregistered
> [    5.955889] cx231xx 3-2:1.1: V4L2 device video0 deregistered
> [    5.959131] cx231xx: probe of 3-2:1.1 failed with error -22
> [    5.959190] usbcore: registered new interface driver cx231xx
> 
> 
> This sets the taint as follows:
> - sink pads to PAD_SIGNAL_ANALOG
> - source pads to PAD_SIGNAL_DV

This patch no longer applies, looks like similar fix was done in
commit 46c039d06b6ecabb94bd16c3a999b28dc83b79ce.

Sean

> 
> 
> Signed-off-by: Brad Love <brad@nextdimension.cc>
> ---
>  drivers/media/i2c/cx25840/cx25840-core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/i2c/cx25840/cx25840-core.c b/drivers/media/i2c/cx25840/cx25840-core.c
> index b23d8e4..0c94be5 100644
> --- a/drivers/media/i2c/cx25840/cx25840-core.c
> +++ b/drivers/media/i2c/cx25840/cx25840-core.c
> @@ -5225,8 +5225,12 @@ static int cx25840_probe(struct i2c_client *client,
>  	 * those extra inputs. So, let's add it only when needed.
>  	 */
>  	state->pads[CX25840_PAD_INPUT].flags = MEDIA_PAD_FL_SINK;
> +	state->pads[CX25840_PAD_INPUT].sig_type = PAD_SIGNAL_ANALOG;
>  	state->pads[CX25840_PAD_VID_OUT].flags = MEDIA_PAD_FL_SOURCE;
> +	state->pads[CX25840_PAD_VID_OUT].sig_type = PAD_SIGNAL_DV;
>  	state->pads[CX25840_PAD_VBI_OUT].flags = MEDIA_PAD_FL_SOURCE;
> +	state->pads[CX25840_PAD_VBI_OUT].sig_type = PAD_SIGNAL_DV;
> +
>  	sd->entity.function = MEDIA_ENT_F_ATV_DECODER;
>  
>  	ret = media_entity_pads_init(&sd->entity, ARRAY_SIZE(state->pads),
> -- 
> 2.7.4
