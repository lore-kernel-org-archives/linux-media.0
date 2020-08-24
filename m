Return-Path: <SRS0=Edv6=CC=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D26C433E1
	for <linux-media@archiver.kernel.org>; Mon, 24 Aug 2020 10:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F372078A
	for <linux-media@archiver.kernel.org>; Mon, 24 Aug 2020 10:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ltY7pv8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHXKzc (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 24 Aug 2020 06:55:32 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:53652 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgHXKzG (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 24 Aug 2020 06:55:06 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 11AE9279;
        Mon, 24 Aug 2020 12:54:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1598266482;
        bh=u1+SIobE8V3Iio4tt3LrtLGU6xPiVxKagnkpOhkuwaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ltY7pv8ITXFgrDpU8KZoRibzKXB6xUA+Mkp3TI4nJFbgxywIlnn+qm4O4jS6ho9uK
         +d6vtCcde9CfMlryT55dsHUPTKNpVJ1kR/viQHSleR+QIP/ueWV/wOD+ZkhHztQklZ
         M8ByPcAh97KyrDNN9sFOXgjqV6lFsgWM+GwfBkpg=
Date:   Mon, 24 Aug 2020 13:54:22 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     linux-media@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Benoit Parrot <bparrot@ti.com>
Subject: Re: [PATCH] media: ti-vpe: cal: Fix compilation on 32-bit ARM
Message-ID: <20200824105422.GB6002@pendragon.ideasonboard.com>
References: <20200823050257.564-1-laurent.pinchart@ideasonboard.com>
 <20200824092303.GP7145@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200824092303.GP7145@valkosipuli.retiisi.org.uk>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Aug 24, 2020 at 12:23:04PM +0300, Sakari Ailus wrote:
> On Sun, Aug 23, 2020 at 08:02:57AM +0300, Laurent Pinchart wrote:
> > When compiled on 32-bit ARM, the CAL driver fails with the FIELD_PREP()
> > macro complaining that the mask is not constant. While all callers of
> > the inline cal_write_field() function pass a constant mask, the mask
> > parameter itself is a variable, which likely doesn't please the
> > compiler.
> > 
> > Fix it by replacing FIELD_PREP() with a manual implementation.
> > 
> > Fixes: 50797fb30b95 ("media: ti-vpe: cal: Turn reg_(read|write)_field() into inline functions")
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Thanks!
> 
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

And I forgot to add

Reported-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Tomi, will you handle this patch ? Could you add the tags ?

-- 
Regards,

Laurent Pinchart
