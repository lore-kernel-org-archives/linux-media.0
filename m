Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EC1C282CE
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 09:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F9221872
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 09:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="PETiCoHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfDLJN0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:13:26 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34336 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbfDLJNZ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 05:13:25 -0400
Received: by mail-lf1-f65.google.com with SMTP id h5so4015330lfm.1
        for <linux-media@vger.kernel.org>; Fri, 12 Apr 2019 02:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RJioxNL/tDdtn+PGeAnBQhQy4cwLWf7IyFa/W6kjIkM=;
        b=PETiCoHYOKV1f8XfP3Twk8cjflndJiOR/oeu4LysuPGfkgGiVCV5n7+D482jl70OCm
         wn+zzYPqJGTJj8AsIsr5oaRYOWrfO8xRc6ZD1/lZO/xt+tlrBEppzziQCnhuOfKo/jFI
         SeAXlXLKh6k6ZVmv2nqyYUBawGfmlsPcdmiiiCzdzYRGS+rjxmLHfWBDUIn4j1JZk9W6
         wo0BG80057x4e/iFLwY6HeAd5l1sy37HAy9TifJttJKBBShj/Sjze30dcgb0tF95KTn0
         IbPRnNbD/uAE7WfFUZoTtKv76xrqvJ0pkd+d7bw6B1QeOpRavMoEmA3TXQ7U3Yx8nv2K
         Asgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RJioxNL/tDdtn+PGeAnBQhQy4cwLWf7IyFa/W6kjIkM=;
        b=Sx1UOW7oWZR+j+wC2OCS+fqEAhag9FfBqV4/xqlLp1/Azv/SOC8Xq3k/2dgy1zZZrh
         SYWlzkpIWi3TqremaRyBcwxMcilBFMc9K3/igc+yZL9kb+oYzmz+PqiPQ2MBIRjDVlXV
         PR+JB7KYZgvfVTIG1yW/+gsinXw5A+w+QH3KeGRpouYQeSOVKxAUuYlHiYOBeA8OZMm1
         pBPOLNAtKciUP7I/jsmRuQxOswU/X5VMhkmmPDQlvZIDQRqL2xC8AAjwd0xnTBttPUr6
         JQo1cmIQWSmaSeB2tTQIfuS6IEsRUHZGGTDg9t1AfaD/5qd17kqq4V4ZrCegPG/KbriK
         VIhA==
X-Gm-Message-State: APjAAAWvrpBvU+AWGZ+p2fnhphOjZ2zADkrYI9L5JkNVP0VsKGUOEy1e
        NlgeRMYjGIGhrHuwXRyk0rsX6Q==
X-Google-Smtp-Source: APXvYqwwacLmv8c5cQSI1+tQfZQfevsHEOzFGjOlG44OncaRpFkmypKBAcjfpIed/EmJWuQYkO8bhg==
X-Received: by 2002:ac2:4357:: with SMTP id o23mr7976441lfl.146.1555060403026;
        Fri, 12 Apr 2019 02:13:23 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id x30sm8102986ljd.38.2019.04.12.02.13.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 02:13:22 -0700 (PDT)
From:   "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund@ragnatech.se>
X-Google-Original-From: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Date:   Fri, 12 Apr 2019 11:13:21 +0200
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4] rcar-csi2: Propagate the FLD signal for NTSC and PAL
Message-ID: <20190412091321.GI30887@bigcity.dyn.berto.se>
References: <20190411203444.23515-1-niklas.soderlund+renesas@ragnatech.se>
 <20190412084346.6lreffkpuuj7slqb@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190412084346.6lreffkpuuj7slqb@uno.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Jacopo,

Thanks for your feedback.

On 2019-04-12 10:43:46 +0200, Jacopo Mondi wrote:
> Hi Niklas,
>    I'm rebasing v4l2-mux series on top of your new VIN patches and
> on this on I'm not sure how to proceed. Please see below.
> 
> Please also note this comment is not strictly on this patch, and should not
> block its acceptance...
> 
> On Thu, Apr 11, 2019 at 10:34:44PM +0200, Niklas Söderlund wrote:
> > Depending on which video standard is used the driver needs to setup the
> > hardware to correctly handle fields. If stream is identified as NTSC
> > or PAL setup field detection and propagate the field detection signal.
> >
> > Later versions of the datasheet have been updated to make it clear
> > that FLD register should be set to 0 when dealing with non-interlaced
> > field formats.
> >
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > ---
> >  drivers/media/platform/rcar-vin/rcar-csi2.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/rcar-vin/rcar-csi2.c
> > index 799e526fd3df5554..c1b38ebd061dbc35 100644
> > --- a/drivers/media/platform/rcar-vin/rcar-csi2.c
> > +++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
> > @@ -68,6 +68,7 @@ struct rcar_csi2;
> >  /* Field Detection Control */
> >  #define FLD_REG				0x1c
> >  #define FLD_FLD_NUM(n)			(((n) & 0xff) << 16)
> > +#define FLD_DET_SEL(n)			(((n) & 0x3) << 4)
> >  #define FLD_FLD_EN4			BIT(3)
> >  #define FLD_FLD_EN3			BIT(2)
> >  #define FLD_FLD_EN2			BIT(1)
> > @@ -475,7 +476,7 @@ static int rcsi2_calc_mbps(struct rcar_csi2 *priv, unsigned int bpp)
> >  static int rcsi2_start_receiver(struct rcar_csi2 *priv)
> >  {
> >  	const struct rcar_csi2_format *format;
> > -	u32 phycnt, vcdt = 0, vcdt2 = 0;
> > +	u32 phycnt, vcdt = 0, vcdt2 = 0, fld = 0;
> >  	unsigned int i;
> >  	int mbps, ret;
> >
> > @@ -507,6 +508,16 @@ static int rcsi2_start_receiver(struct rcar_csi2 *priv)
> >  			vcdt2 |= vcdt_part << ((i % 2) * 16);
> >  	}
> >
> > +	if (priv->mf.field == V4L2_FIELD_ALTERNATE) {
> 
> How would you handle this once priv->mf is expanded to become an array
> of 'struct v4l2_mbus_framefmt' entries [1] ? Which of them is relevant for
> field detection?
> 
> 
> > +		fld = FLD_DET_SEL(1) | FLD_FLD_EN4 | FLD_FLD_EN3 | FLD_FLD_EN2
> > +			| FLD_FLD_EN;
> > +
> > +		if (priv->mf.height == 240)
> 
> Same question here, even if I assume we could cycle on the entries and
> collect the maximum size.

Well as the hardware do not support field detection of PAL and NTSC at 
the same time one would need to either disallow that and fail stream on 
or pick one and move on. Not sure which one would be best.

> 
> Thanks
>   j
> 
> [1] Introduced by:
> "rcar-csi2: use frame description information to configure CSI-2 bus"
> > +			fld |= FLD_FLD_NUM(0);
> > +		else
> > +			fld |= FLD_FLD_NUM(1);
> > +	}
> > +
> >  	phycnt = PHYCNT_ENABLECLK;
> >  	phycnt |= (1 << priv->lanes) - 1;
> >
> > @@ -549,8 +560,7 @@ static int rcsi2_start_receiver(struct rcar_csi2 *priv)
> >  	rcsi2_write(priv, PHYCNT_REG, phycnt);
> >  	rcsi2_write(priv, LINKCNT_REG, LINKCNT_MONITOR_EN |
> >  		    LINKCNT_REG_MONI_PACT_EN | LINKCNT_ICLK_NONSTOP);
> > -	rcsi2_write(priv, FLD_REG, FLD_FLD_NUM(2) | FLD_FLD_EN4 |
> > -		    FLD_FLD_EN3 | FLD_FLD_EN2 | FLD_FLD_EN);
> > +	rcsi2_write(priv, FLD_REG, fld);
> >  	rcsi2_write(priv, PHYCNT_REG, phycnt | PHYCNT_SHUTDOWNZ);
> >  	rcsi2_write(priv, PHYCNT_REG, phycnt | PHYCNT_SHUTDOWNZ | PHYCNT_RSTZ);
> >
> > --
> > 2.21.0
> >



-- 
Regards,
Niklas Söderlund
