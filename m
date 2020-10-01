Return-Path: <SRS0=N3gP=DI=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7BBC47425
	for <linux-media@archiver.kernel.org>; Thu,  1 Oct 2020 07:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1CA321707
	for <linux-media@archiver.kernel.org>; Thu,  1 Oct 2020 07:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601538912;
	bh=KKNX+CUOdotCG/f7NnoLC+ebCjKw91cITKw8LfV7ljE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wIhgnF4K/l7ByzrnrZPvy9q7skOrfftewx4x3vEBm5PW0yPSS2sMPNcRH190CntWY
	 tOZvfQYcPF8j3/pQVFqX2bNRg7Rpb6b8hGP4iaOEaY8Lx0ASB1AURt5Pbnz17E8afs
	 RdLpti9SodrNBsWgq7R5Ehc51IoQN0Kw4ljpYw9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbgJAHyq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 1 Oct 2020 03:54:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgJAHyl (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 1 Oct 2020 03:54:41 -0400
Received: from coco.lan (ip5f5ad5d2.dynamic.kabel-deutschland.de [95.90.213.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 209C221707;
        Thu,  1 Oct 2020 07:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601538880;
        bh=KKNX+CUOdotCG/f7NnoLC+ebCjKw91cITKw8LfV7ljE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jPKhCPpQAFcA3HJ6KciG3sDNi7p5PRBSqUW2HQmsVSbPOKDyU4xE3D0XXMNwcsslz
         Dq8/aeKSf44ITUSddqj5sTNotgwgpCWU7hwdEVChqR123ugDJmZs2nlJIHAhBVWVxC
         jB4ixnvH9n2t7Rqiz/JmRRh7IrSwZvXslbh5IQVU=
Date:   Thu, 1 Oct 2020 09:54:35 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     gregkh@linuxfoundation.org, hverkuil@xs4all.nl,
        laurent.pinchart@ideasonboard.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH RFT/RFC v2 28/47] staging: media: zoran: convert mdelay
 to udelay
Message-ID: <20201001095435.47c7d36c@coco.lan>
In-Reply-To: <1601058657-14042-29-git-send-email-clabbe@baylibre.com>
References: <1601058657-14042-1-git-send-email-clabbe@baylibre.com>
        <1601058657-14042-29-git-send-email-clabbe@baylibre.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Fri, 25 Sep 2020 18:30:38 +0000
Corentin Labbe <clabbe@baylibre.com> escreveu:

> As asked by checkpath, let's use udelay.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/staging/media/zoran/zoran_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/zoran/zoran_device.c b/drivers/staging/media/zoran/zoran_device.c
> index 0ecb044f8e8f..4c9f6eafd130 100644
> --- a/drivers/staging/media/zoran/zoran_device.c
> +++ b/drivers/staging/media/zoran/zoran_device.c
> @@ -1332,9 +1332,9 @@ void zoran_init_hardware(struct zoran *zr)
>  void zr36057_restart(struct zoran *zr)
>  {
>  	btwrite(0, ZR36057_SPGPPCR);
> -	mdelay(1);
> +	udelay(1000);
>  	btor(ZR36057_SPGPPCR_SoftReset, ZR36057_SPGPPCR);
> -	mdelay(1);
> +	udelay(1000);

Ok, this is still on staging, so I'm willing to accept it, but
why aren't you using usleep_range() instead?

mdelay/udelay should be used only when the delay time should
be as precise as possible, as what they do is to keep the CPU
busy during the wait time.

I doubt that this is the case here. So, I would use,
instead, something like:

	usleep_range(1000, 2000)

(assuming that 4ms is still a reasonable time for the soft
reset to happen).

>  
>  	/* assert P_Reset */
>  	btwrite(0, ZR36057_JPC);



Thanks,
Mauro
