Return-Path: <SRS0=Lrat=UI=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984FCC28EBD
	for <linux-media@archiver.kernel.org>; Sun,  9 Jun 2019 10:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3948620693
	for <linux-media@archiver.kernel.org>; Sun,  9 Jun 2019 10:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="s60MUrc3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfFIKJJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 9 Jun 2019 06:09:09 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:54696 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbfFIKJC (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sun, 9 Jun 2019 06:09:02 -0400
Received: from pendragon.ideasonboard.com (unknown [IPv6:2a02:a03f:44f0:8500:ca05:8177:199c:fed4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8B1515D;
        Sun,  9 Jun 2019 12:08:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1560074939;
        bh=b9jXzqeBFSZakTzjswAu3ro/H/izrPyfwLi2drTDskQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s60MUrc31snfEWKLrqbhnMhSpUOgJ25Umck0yfjEVuQYMXZuUbmLs5+GVhpAmD+Ye
         x3VNRvbh7owqxw7S0DIAzaAdQFTuX15sIt5asuznLL60dkTbZ8i+HXJMauZJhaKuLd
         O5i4OgkjVE2wGHQSNMMhgO0Hg/GfBB6g1w7+bSZ4=
Date:   Sun, 9 Jun 2019 13:08:45 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] v4l: rcar-fcp: Read IP version register at probe time
Message-ID: <20190609100845.GA4778@pendragon.ideasonboard.com>
References: <20190608125331.29146-1-laurent.pinchart+renesas@ideasonboard.com>
 <CAMuHMdUobhMrDYBoYVo091re7LGrYEGgCsXbMh8a4MrF4zoP7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdUobhMrDYBoYVo091re7LGrYEGgCsXbMh8a4MrF4zoP7g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Geert,

On Sun, Jun 09, 2019 at 10:06:19AM +0200, Geert Uytterhoeven wrote:
> On Sat, Jun 8, 2019 at 2:55 PM Laurent Pinchart wrote:
> > This helps identifying the IP core version, for debugging purpose only
> > for now.
> >
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Thanks for your patch!
> 
> > --- a/drivers/media/platform/rcar-fcp.c
> > +++ b/drivers/media/platform/rcar-fcp.c
> 
> > @@ -138,6 +168,19 @@ static int rcar_fcp_probe(struct platform_device *pdev)
> >
> >         pm_runtime_enable(&pdev->dev);
> >
> > +       mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       fcp->iomem = devm_ioremap_resource(&pdev->dev, mem);
> 
> devm_platform_ioremap_resource()?

Nice, I've thought about adding such a function for some time, I didn't
know it had been merged.

> > +       if (IS_ERR(fcp->iomem))
> > +               return PTR_ERR(fcp->iomem);
> > +
> > +       pm_runtime_get_sync(&pdev->dev);
> > +       version = rcar_fcp_read(fcp, FCP_VCR);
> 
> Please note that rcar_fcp_read() does not exist in upstream nor next,
> and linux-renesas-soc hasn't seen the patch that added it.

That's why it was added in this patch :-)

-- 
Regards,

Laurent Pinchart
