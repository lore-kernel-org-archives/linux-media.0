Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208DCC4743F
	for <linux-media@archiver.kernel.org>; Fri,  4 Jun 2021 22:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 093B961406
	for <linux-media@archiver.kernel.org>; Fri,  4 Jun 2021 22:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhFDWHh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 4 Jun 2021 18:07:37 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:39528 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhFDWHf (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 4 Jun 2021 18:07:35 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DEECC1381;
        Sat,  5 Jun 2021 00:05:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1622844347;
        bh=CFpOwLj9UfAfQeRfyb7g/C11/HUKmWejDfdVp0O45Sg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6gdDnH9+o9FkItHt0G36h3njarxqw08H9MOCr7bZQ8uLM8/Is9o2nTZaoylQ3toP
         NZAKKZAY1qan+E8fZ3Q3iEjxffGATreMyVI/z4Y5skinBr6L3j1VT7ow64r/UcTrWI
         MgNgK/WIY0w+O2g+fnYLRUPPQlzxgHFKS1XgeEQk=
Date:   Sat, 5 Jun 2021 01:05:33 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ramesh Shanmugasundaram <rashanmu@gmail.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] media: dt-bindings: media: renesas,drif: Fix fck
 definition
Message-ID: <YLqjrdsJ8TKaiB1v@pendragon.ideasonboard.com>
References: <20210408202436.3706-1-fabrizio.castro.jz@renesas.com>
 <20210409185420.GA3955417@robh.at.kernel.org>
 <CAL_JsqL5tzJhMzTyyTDnVh=doDknepkk8R0McKsj4U2aqSMFAw@mail.gmail.com>
 <YIhvPCzWOah2kFk7@pendragon.ideasonboard.com>
 <CAL_JsqJU6NGGtHUqfNrRqg5Km5n35LviUrazoU2dL82vB-+BvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_JsqJU6NGGtHUqfNrRqg5Km5n35LviUrazoU2dL82vB-+BvQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Rob,

On Fri, Jun 04, 2021 at 02:38:36PM -0500, Rob Herring wrote:
> On Tue, Apr 27, 2021 at 3:08 PM Laurent Pinchart wrote:
> > On Tue, Apr 27, 2021 at 01:02:57PM -0500, Rob Herring wrote:
> > > On Fri, Apr 9, 2021 at 1:54 PM Rob Herring wrote:
> > > > On Thu, 08 Apr 2021 21:24:36 +0100, Fabrizio Castro wrote:
> > > > > dt_binding_check reports the below error with the latest schema:
> > > > >
> > > > > Documentation/devicetree/bindings/media/renesas,drif.yaml:
> > > > >   properties:clock-names:maxItems: False schema does not allow 1
> > > > > Documentation/devicetree/bindings/media/renesas,drif.yaml:
> > > > >   ignoring, error in schema: properties: clock-names: maxItems
> > > > >
> > > > > This patch fixes the problem.
> > > > >
> > > > > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/media/renesas,drif.yaml | 4 +---
> > > > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > > >
> > > >
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > >
> > > Still failing in linux-next...
> >
> > Sorry, as a standalone fix, I incorrectly thought you'd merge it.
> >
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >
> > and applied to my tree. I'll send a pull request to linux-media when the
> > merge window closes.
> 
> Still failing in linux-next. It's also a failure in Linus' tree, so it
> needs to go in as a fix.

Sorry, been overwhelmed. Feel free to take the patch through your tree
as a fix.

-- 
Regards,

Laurent Pinchart
