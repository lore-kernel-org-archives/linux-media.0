Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1425C433E6
	for <linux-media@archiver.kernel.org>; Mon, 21 Dec 2020 17:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C2782311C
	for <linux-media@archiver.kernel.org>; Mon, 21 Dec 2020 17:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgLURfV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 21 Dec 2020 12:35:21 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46157 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLURfV (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 21 Dec 2020 12:35:21 -0500
X-Originating-IP: 2.224.242.101
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 9A4C2E0007;
        Mon, 21 Dec 2020 17:34:34 +0000 (UTC)
Date:   Mon, 21 Dec 2020 18:34:46 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, mchehab@kernel.org,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        roman.kovalivskyi@globallogic.com, dafna.hirschfeld@collabora.com,
        dave.stevenson@raspberrypi.org, naush@raspberrypi.com,
        erosca@de.adit-jv.com, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 01/30] dt-bindings: media: i2c: Rename ov5647.yaml
Message-ID: <20201221173446.z7mtvasohwyjukdp@uno.localdomain>
References: <20201119161956.756455-1-jacopo@jmondi.org>
 <20201119161956.756455-2-jacopo@jmondi.org>
 <20201125091526.GI3940@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201125091526.GI3940@paasikivi.fi.intel.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello,

On Wed, Nov 25, 2020 at 11:15:26AM +0200, Sakari Ailus wrote:
> Cc Rob + DT list.
>

Gentle ping.

Sakari, am I mistaken or last time we discussed this, the series is
ready for being collected (pending this ack I assume)

I wonder if it needs a rebase (pretty sure it does)

Thanks
  j

> On Thu, Nov 19, 2020 at 05:19:27PM +0100, Jacopo Mondi wrote:
> > Rename 'ov5647.yaml' as 'ovti,ov5647.yaml' and update the
> > MAINTAINERS file entry accordingly.
> >
> > Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> > ---
> >  .../bindings/media/i2c/{ov5647.yaml => ovti,ov5647.yaml}        | 0
> >  MAINTAINERS                                                     | 2 +-
> >  2 files changed, 1 insertion(+), 1 deletion(-)
> >  rename Documentation/devicetree/bindings/media/i2c/{ov5647.yaml => ovti,ov5647.yaml} (100%)
> >
> > diff --git a/Documentation/devicetree/bindings/media/i2c/ov5647.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5647.yaml
> > similarity index 100%
> > rename from Documentation/devicetree/bindings/media/i2c/ov5647.yaml
> > rename to Documentation/devicetree/bindings/media/i2c/ovti,ov5647.yaml
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 69d55ed67e1cf..3f2acc3a78687 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12928,7 +12928,7 @@ M:	Jacopo Mondi <jacopo@jmondi.org>
> >  L:	linux-media@vger.kernel.org
> >  S:	Maintained
> >  T:	git git://linuxtv.org/media_tree.git
> > -F:	Documentation/devicetree/bindings/media/i2c/ov5647.yaml
> > +F:	Documentation/devicetree/bindings/media/i2c/ovti,ov5647.yaml
> >  F:	drivers/media/i2c/ov5647.c
> >
> >  OMNIVISION OV5670 SENSOR DRIVER
> > --
> > 2.29.1
> >
>
> --
> Sakari Ailus
