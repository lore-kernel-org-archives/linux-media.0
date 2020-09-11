Return-Path: <SRS0=cWAp=CU=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740F9C43461
	for <linux-media@archiver.kernel.org>; Fri, 11 Sep 2020 08:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 401E4204FD
	for <linux-media@archiver.kernel.org>; Fri, 11 Sep 2020 08:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgIKIyy (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:54:54 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:48641 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgIKIyw (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 11 Sep 2020 04:54:52 -0400
Received: from uno.localdomain (93-34-118-233.ip49.fastwebnet.it [93.34.118.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 5C214100012;
        Fri, 11 Sep 2020 08:54:46 +0000 (UTC)
Date:   Fri, 11 Sep 2020 10:58:37 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        linux-renesas-soc@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: media: ov772x: Make bus-type
 mandatory
Message-ID: <20200911085837.kyxx3p465ovowcel@uno.localdomain>
References: <20200910162055.614089-1-jacopo+renesas@jmondi.org>
 <20200910162055.614089-3-jacopo+renesas@jmondi.org>
 <20200911053757.GF6566@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200911053757.GF6566@paasikivi.fi.intel.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Sakari,

On Fri, Sep 11, 2020 at 08:37:57AM +0300, Sakari Ailus wrote:
> Hi Jacopo,
>
> On Thu, Sep 10, 2020 at 06:20:54PM +0200, Jacopo Mondi wrote:
> > In order to establish required properties based on the selected
> > bus type, make the 'bus-type' property mandatory. As this change
> > documents an endpoint property, also document the 'remote-endpoint'
> > one now that the 'endpoint' schema has been expanded.
> >
> > Binary compatibility with existing DTB is kept as the driver does not
> > enforce the property to be present, and shall fall-back to default
> > parallel bus configuration, which was the only supported bus type, if
> > the property is not specified.
>
> Could you add a comment on this to the driver, so this feature isn't
> accidentally removed?

Sure, can I send a patch in reply to this series to avoid a v6 ?
>
> --
> Regards,
>
> Sakari Ailus
