Return-Path: <SRS0=N3gP=DI=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E6DC4741F
	for <linux-media@archiver.kernel.org>; Thu,  1 Oct 2020 20:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A593F2085B
	for <linux-media@archiver.kernel.org>; Thu,  1 Oct 2020 20:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbgJAUHQ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 1 Oct 2020 16:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgJAUHQ (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 1 Oct 2020 16:07:16 -0400
Received: from hillosipuli.retiisi.eu (hillosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::81:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E84C0613D0;
        Thu,  1 Oct 2020 13:07:15 -0700 (PDT)
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::80:2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id EAA6A634C87;
        Thu,  1 Oct 2020 23:06:50 +0300 (EEST)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1kO4qo-0000sq-Ou; Thu, 01 Oct 2020 23:06:50 +0300
Date:   Thu, 1 Oct 2020 23:06:50 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: media: imx214: Convert to json-schema
Message-ID: <20201001200650.GM2024@valkosipuli.retiisi.org.uk>
References: <20200910162030.614029-1-jacopo+renesas@jmondi.org>
 <CAPybu_0+mga9FvOs=aWS90sVnb1ZvYYuP2AUckov60jAXyPqXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPybu_0+mga9FvOs=aWS90sVnb1ZvYYuP2AUckov60jAXyPqXw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Ricardo,

On Fri, Sep 11, 2020 at 08:28:40AM +0200, Ricardo Ribalda Delgado wrote:
> Thanks for the port
> 
> 
> On Thu, Sep 10, 2020 at 6:17 PM Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> >
> > Convert the imx214 bindings document to json-schema and update
> > the MAINTAINERS file accordingly.
> >
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Signed-off-by: Ricardo Ribalda <ribalda@kernel.org>

Sob or Acked-by?

-- 
Sakari Ailus
