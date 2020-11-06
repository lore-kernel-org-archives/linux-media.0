Return-Path: <SRS0=vajg=EM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A57C55178
	for <linux-media@archiver.kernel.org>; Fri,  6 Nov 2020 08:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5227020A8B
	for <linux-media@archiver.kernel.org>; Fri,  6 Nov 2020 08:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R2rTxWy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgKFIWs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 6 Nov 2020 03:22:48 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55758 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKFIWs (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 6 Nov 2020 03:22:48 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A68MimK005665;
        Fri, 6 Nov 2020 02:22:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604650964;
        bh=Gvj1a9VvK5HiOxpFrAhqJ6CgkKx54KzKc+CFuUe9kbw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=R2rTxWy5UlwKcWsKjTArylteKwdXmCnUnpYhP3+ngixuMvzm2PJxiAZ4Cww8KVa7a
         AH3nS9IrNkV/43fxZJZg522wNq1RBZjBwO1kNOdj+dMzYeOQSxqMvZ/GeF6BsuMFs2
         XqC0JJVHpJwCCKoyZaubZ/N8Hz0H1IxPOiTSA0oU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A68Mhdk027942
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Nov 2020 02:22:43 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 6 Nov
 2020 02:22:43 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 6 Nov 2020 02:22:43 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A68Mgp9033515;
        Fri, 6 Nov 2020 02:22:43 -0600
Date:   Fri, 6 Nov 2020 13:52:41 +0530
From:   Nikhil Devshatwar <nikhil.nd@ti.com>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: <linux-firmware.lore.kernel.org>
CC:     <linux-firmware@kernel.org>, <linux-media@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>, Benoit Parrot <bparrot@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2] vpdma: Move firmware to ti directory
Message-ID: <20201106082241.m6pu6u4ywla6fic5@NiksLab>
References: <20201028184249.11293-1-nikhil.nd@ti.com>
 <6b7cb928-909f-36fd-3949-ba9fb32f7cfd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6b7cb928-909f-36fd-3949-ba9fb32f7cfd@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 09:07-20201029, Tomi Valkeinen wrote:
> On 28/10/2020 20:42, Nikhil Devshatwar wrote:
> > Current ti-connectivity location for the firmware is not the
> > correct place. It has all the wireless connectivity related firmwares.
> > Move the vpdma firmware to the ti specific directory.
> > 
> > Fixes: 5b30b383ce ("linux-firmware: Add new VPDMA firmware 1b8.bin")
> > Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>

ping

Please merge this, so that I can update the kernel patch

Regards,
Nikhil D

> > ---
> >  WHENCE                                |   2 +-
> >  {ti-connectivity => ti}/vpdma-1b8.bin | Bin
> >  2 files changed, 1 insertion(+), 1 deletion(-)
> >  rename {ti-connectivity => ti}/vpdma-1b8.bin (100%)
> > 
> > diff --git a/WHENCE b/WHENCE
> > index 473f6fb..d4efee2 100644
> > --- a/WHENCE
> > +++ b/WHENCE
> > @@ -2705,7 +2705,7 @@ Licence: Redistributable. See LICENCE.tda7706-firmware.txt for details.
> >  
> >  Driver: ti-vpe - Texas Instruments V4L2 driver for Video Processing Engine
> >  
> > -File: ti-connectivity/vpdma-1b8.bin
> > +File: ti/vpdma-1b8.bin
> >  
> >  Licence: Redistributable. See LICENCE.ti-tspa for details.
> >  
> > diff --git a/ti-connectivity/vpdma-1b8.bin b/ti/vpdma-1b8.bin
> > similarity index 100%
> > rename from ti-connectivity/vpdma-1b8.bin
> > rename to ti/vpdma-1b8.bin
> 
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
>  Tomi
> 
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
