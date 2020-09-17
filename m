Return-Path: <SRS0=7MnB=C2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8CFC433E2
	for <linux-media@archiver.kernel.org>; Thu, 17 Sep 2020 01:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C7DD206C9
	for <linux-media@archiver.kernel.org>; Thu, 17 Sep 2020 01:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EzklzLbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgIQBBJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 16 Sep 2020 21:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgIQBBI (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 16 Sep 2020 21:01:08 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BC1C061756;
        Wed, 16 Sep 2020 17:55:40 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 40158276;
        Thu, 17 Sep 2020 02:55:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1600304132;
        bh=dVOVV/GxRt6VRbIhe9+Mhj7FeD4Atu7DUpK8hdKY2g8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EzklzLbjMke8Uw78/j9GePpcmrrB0IQTionyIbdpz2SeyaJuQWcKMwi1OZ8lmzWLf
         knMphUKY6BqfBRI52YYavYU7BYIHNd8TH0SEAR8jIV7xlSVKcq+Q/6RtkXhXQL8SGJ
         zU2E72/zEgscwpDiq62VTHztWvg0pTybjxWkwGXM=
Date:   Thu, 17 Sep 2020 03:55:02 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ramesh Shanmugasundaram <rashanmu@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 0/3] Document r8a77990 DRIF support
Message-ID: <20200917005502.GQ3853@pendragon.ideasonboard.com>
References: <20200916105949.24858-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200916105949.24858-1-fabrizio.castro.jz@renesas.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Fabrizio,

Thank you for the patches.

On Wed, Sep 16, 2020 at 11:59:46AM +0100, Fabrizio Castro wrote:
> Dear All,
> 
> this series documents DRIF support for the r8a77990
> (a.k.a. R-Car E3).

This looks good to me, but I'd like to give Rob an opportunity to review
the DT bindings. As we're already at v5.9-rc5, this will likely mean
missing the v5.10 merge window (the linux-media tree closes at -rc6). I
don't see this series being urgent, but please let me know if you
disagree.

> Fabrizio Castro (3):
>   MAINTAINERS: Add Fabrizio Castro to Renesas DRIF
>   media: dt-bindings: media: renesas,drif: Convert to json-schema
>   media: dt-bindings: media: renesas,drif: Add r8a77990 support
> 
>  .../bindings/media/renesas,drif.txt           | 177 ------------
>  .../bindings/media/renesas,drif.yaml          | 271 ++++++++++++++++++
>  MAINTAINERS                                   |   3 +-
>  3 files changed, 273 insertions(+), 178 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/renesas,drif.txt
>  create mode 100644 Documentation/devicetree/bindings/media/renesas,drif.yaml

-- 
Regards,

Laurent Pinchart
