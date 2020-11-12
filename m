Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E371CC2D0E4
	for <linux-media@archiver.kernel.org>; Thu, 12 Nov 2020 22:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7058120872
	for <linux-media@archiver.kernel.org>; Thu, 12 Nov 2020 22:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="QCIKKJU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgKLW6t (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgKLW6t (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 12 Nov 2020 17:58:49 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFF7C0613D4
        for <linux-media@vger.kernel.org>; Thu, 12 Nov 2020 14:58:49 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id u19so4745335lfr.7
        for <linux-media@vger.kernel.org>; Thu, 12 Nov 2020 14:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VsZAT3c2Wp04io6V/x9bm6gTFw5KVzI2cdGFZoc091k=;
        b=QCIKKJU4cD2hpLD3LyZHOdZjOSYnQggJDpq7AhcEqXHqjkVJFlTPDMEErvlFlmqjMb
         Zq09yQFxI2UKUT2BJy6nc7XrokbIj+96OXX4UVcNkeWFm9HH04zchnDx/h9SWinmFvmL
         I2gCxCjI8Y7KQtb4znIk5fPzwqtwarnxX3PFmG1xI/7YzgVKKFYwA3n15UoD4ZeBjIf3
         +pPzOSQcBsvKpLfU/Qa00j2umKtsjaqRhNgHrayP+Qwy08kENM7qRiiPJyfvpg2cX6G1
         HvLAAMJcKd37JBmHKDUzfRAPtgcb8IXzZEgBWqI/ooKJOHy01wBePNGGazGtPmnUBO3a
         Etbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VsZAT3c2Wp04io6V/x9bm6gTFw5KVzI2cdGFZoc091k=;
        b=BtplqUi27XuFap1RH3X8zVQEN1+Xd1ldykDR/t0B83UEBLLZ+YZETfmLrvNY2A1VD/
         KzbFkARw1PCLheRjrBQgU+lbsG3I2ySXJW24Eu9KR8S153DV0UoiwG1SlH3o3iv0J5CI
         8lBvYI+9G2VPIpqA6yn+Z9cYcJRuG8Au3cuNAMCh4cr7AR1+hySPhmh6SbUcefA81mqO
         phig5/3UzAtX8s/HysQFNy9wNBm0Zea4zXA5nUtLFl7Nk+hHTkyONYga9iimLrCTue9H
         rH59JENtmzA/wBqjS28vltcK7iih2lOedooNWBiORBhgBtukDYNb/DDwOXLXnXOcTcTe
         xrvQ==
X-Gm-Message-State: AOAM533xG7xm745Uu/3y6GlCU6MY4npr9tGctJZ/euwYGvGn22Zq/uhU
        z4nFrhm0bUlI3kRHe6KEP62zGccViTncqA==
X-Google-Smtp-Source: ABdhPJxWkcqcb0Zm94VJGTftjuKsUM1w4S/sOWzaC1EY5f34WRPhNgaKiV3voJfurC7o+6FwuDRHLg==
X-Received: by 2002:a19:c815:: with SMTP id y21mr665411lff.589.1605221927781;
        Thu, 12 Nov 2020 14:58:47 -0800 (PST)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id y65sm641232lfa.289.2020.11.12.14.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:58:47 -0800 (PST)
Date:   Thu, 12 Nov 2020 23:58:46 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc:     koji.matsuoka.xm@renesas.com, laurent.pinchart@ideasonboard.com,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] media: rcar-vin: Remove unused macro
Message-ID: <20201112225846.GA1603296@oden.dyn.berto.se>
References: <20201112160851.99750-1-jacopo+renesas@jmondi.org>
 <20201112160851.99750-2-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201112160851.99750-2-jacopo+renesas@jmondi.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Jacopo,

Thanks for your patch.

On 2020-11-12 17:08:50 +0100, Jacopo Mondi wrote:
> The VNCSI_IFMD_CSI_CHSEL_MASK is not used: remove it.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/media/platform/rcar-vin/rcar-dma.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/platform/rcar-vin/rcar-dma.c b/drivers/media/platform/rcar-vin/rcar-dma.c
> index f6e84fa29bce..378514a75bc2 100644
> --- a/drivers/media/platform/rcar-vin/rcar-dma.c
> +++ b/drivers/media/platform/rcar-vin/rcar-dma.c
> @@ -137,7 +137,6 @@
>  #define VNCSI_IFMD_DES1		(1 << 26)
>  #define VNCSI_IFMD_DES0		(1 << 25)
>  #define VNCSI_IFMD_CSI_CHSEL(n) (((n) & 0xf) << 0)
> -#define VNCSI_IFMD_CSI_CHSEL_MASK 0xf
>  
>  /* Video n scaling control register (Gen3) */
>  #define VNUDS_CTRL_AMD		(1 << 30)
> -- 
> 2.29.1
> 

-- 
Regards,
Niklas Söderlund
