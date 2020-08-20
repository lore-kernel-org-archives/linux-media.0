Return-Path: <SRS0=344h=B6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D71C433E4
	for <linux-media@archiver.kernel.org>; Thu, 20 Aug 2020 13:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CF6522B3F
	for <linux-media@archiver.kernel.org>; Thu, 20 Aug 2020 13:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="M5k/IcWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgHTNgS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:36:18 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:50310 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbgHTNgE (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 20 Aug 2020 09:36:04 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3836823D;
        Thu, 20 Aug 2020 15:35:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1597930557;
        bh=LO026DofghxZOUTi7uhTczGgRIOw/flGDjkJIXgeQck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M5k/IcWLclH5sKJAGa4Zx1vaYIWEgZoGvXFLc6KpI0aQeACtU0wnjh26RZ1x6FFZE
         Nzee95pCC6no/xut3DmCwPq/Q2soj9hzOWL+UC/DBTpQpHrJHIUPwv3vVDOpMOi3dQ
         lW0MQKyK4HNr6EBFe2wyAbj3npP65kTfvwviwpOk=
Date:   Thu, 20 Aug 2020 16:35:39 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Ariel D'Alessandro <ariel@vanguardiasur.com.ar>,
        linux-media@vger.kernel.org, sean@mess.org, p.zabel@pengutronix.de,
        ezequiel@collabora.com, nicolas@ndufresne.ca,
        kieran.bingham@ideasonboard.com, gjasny@googlemail.com,
        xavier.claessens@collabora.com, nicolas.dufresne@collabora.com,
        user.vdr@gmail.com
Subject: Re: [PATCH v4l-utils v3 2/2] Add support for meson building
Message-ID: <20200820133539.GF6593@pendragon.ideasonboard.com>
References: <20200806155519.79748-1-ariel@vanguardiasur.com.ar>
 <20200806155519.79748-3-ariel@vanguardiasur.com.ar>
 <c5c1859a-34b2-bdb2-c3ac-3a0c96d7c019@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c5c1859a-34b2-bdb2-c3ac-3a0c96d7c019@xs4all.nl>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Hans,

On Thu, Aug 20, 2020 at 02:42:56PM +0200, Hans Verkuil wrote:
> On 06/08/2020 17:55, Ariel D'Alessandro wrote:
> > Supports building libraries and tools found in contrib/, lib/ and
> > utils/ directories, along with the implemented gettext translations.
> > 
> > Also supports generating plain HTML documentation and manual pages using
> > Doxygen.
> > 
> > Co-developed-by: Ezequiel Garcia <ezequiel@collabora.com>
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > Acked-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > Acked-by: Gregor Jasny <gjasny@googlemail.com>
> > [Gregor: Control symbol visibility]
> > Signed-off-by: Gregor Jasny <gjasny@googlemail.com>
> > Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
> > ---
> >  .gitignore                                    |    1 +
> >  Makefile.am                                   |    3 +-
> >  README.md                                     |   85 +-
> >  contrib/Makefile.am                           |    3 +-
> >  contrib/cobalt-ctl/Makefile.am                |    2 +
> >  contrib/cobalt-ctl/meson.build                |    8 +
> >  contrib/decode_tm6000/Makefile.am             |    2 +
> >  contrib/decode_tm6000/meson.build             |   14 +
> >  contrib/gconv/Makefile.am                     |    2 +-
> >  contrib/gconv/meson.build                     |   44 +
> >  contrib/meson.build                           |   13 +
> >  contrib/rds-saa6588/Makefile.am               |    2 +
> >  contrib/rds-saa6588/meson.build               |    7 +
> >  contrib/test/Makefile.am                      |    3 +-
> >  contrib/test/meson.build                      |  143 +
> >  contrib/xc3028-firmware/Makefile.am           |    2 +-
> >  contrib/xc3028-firmware/meson.build           |   11 +
> >  doc/Doxyfile.in                               | 2351 +++++++++++++++++
> 
> 2351 lines to add this file?!
> 
> Is this really needed? And if so, please add this in a separate patch in the
> next version. This huge file pollutes the diff, making it very hard to review.

Note that Doxyfile.in is generated by Doxygen. I agree Doygen support
could be split to a separate to ease review, possibly with one patch
that adds the generated file, and a second patch that modifies it.

-- 
Regards,

Laurent Pinchart
