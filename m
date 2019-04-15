Return-Path: <SRS0=JUE0=SR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9008C10F0E
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 08:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE37B20881
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 08:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfDOIop (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:44:45 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:42568 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfDOIop (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Apr 2019 04:44:45 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 1D52925AD6F;
        Mon, 15 Apr 2019 18:44:43 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 151F89403F0; Mon, 15 Apr 2019 10:44:40 +0200 (CEST)
Date:   Mon, 15 Apr 2019 10:44:40 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        laurent.pinchart@ideasonboard.com, geert+renesas@glider.be,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: renesas: r8a77980: Add "renesas,id" to
 VIN
Message-ID: <20190415084440.zj3r2lthxbcaaqn6@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9797b2c6-58b0-954c-0d8d-f60c95ebc8e1@cogentembedded.com>
 <20190412120053.GB1980@bigcity.dyn.berto.se>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, Apr 12, 2019 at 02:00:53PM +0200, Niklas Söderlund wrote:
> Hi Jacopo,
> 
> Thanks for your patch.
> 
> On 2019-04-12 13:38:32 +0200, Jacopo Mondi wrote:
> > Add the "renesas,id" property to VIN nodes in the R-Car V3H R8A77980
> > device tree.
> > 
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> 
> Reviewed-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>

...

On Sat, Apr 13, 2019 at 09:25:08PM +0300, Sergei Shtylyov wrote:
> On 04/12/2019 02:38 PM, Jacopo Mondi wrote:
> 
> > Add the "renesas,id" property to VIN nodes in the R-Car V3H R8A77980
> > device tree.
> > 
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > ---
> > 
> > I do not have a V3H board to test on, but I suspect VIN failed to probe
> > on V3H before these 2 patches.
> 
>    Yes, probably. The upstream patch wasn't ever runtime tested, so this
> went unnoticed. The BSPs use the old soc_camera driver.
> 
> > If that's the case, these patches would merit
> > Fixes: 3182aa4e0bf4 ("arm64: dts: renesas: r8a77980: add CSI2/VIN support")
> 
>    I'm OK with that.
> 
> > Sergei, do you still have a V3H board around? Could I have your Tested-by
> > tag if things are fine now?
> 
>    I have V3H Stater Kit on my desk but I don't think it has VINs wired to
> anything...

...

Thanks everyone,

I have applied this for inclusion in v5.2 with the fixes tag.

