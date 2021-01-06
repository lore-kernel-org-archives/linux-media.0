Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8884AC433DB
	for <linux-media@archiver.kernel.org>; Wed,  6 Jan 2021 22:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF9323158
	for <linux-media@archiver.kernel.org>; Wed,  6 Jan 2021 22:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbhAFWy0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 6 Jan 2021 17:54:26 -0500
Received: from retiisi.eu ([95.216.213.190]:43002 "EHLO hillosipuli.retiisi.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbhAFWyZ (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 6 Jan 2021 17:54:25 -0500
Received: from valkosipuli.localdomain (unknown [IPv6:fd35:1bc8:1a6:d3d5::80:2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id F335B634C87;
        Thu,  7 Jan 2021 00:53:23 +0200 (EET)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1kxHgB-000163-PF; Thu, 07 Jan 2021 00:53:23 +0200
Date:   Thu, 7 Jan 2021 00:53:23 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, Rui Miguel Silva <rmfrfs@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 59/75] dt-bindings: media: fsl,imx7-mipi-csi2: Drop
 fsl,csis-hs-settle property
Message-ID: <20210106225323.GE850@valkosipuli.retiisi.org.uk>
References: <20210105152852.5733-1-laurent.pinchart@ideasonboard.com>
 <20210105152852.5733-60-laurent.pinchart@ideasonboard.com>
 <20210106224959.GD850@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106224959.GD850@valkosipuli.retiisi.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, Jan 07, 2021 at 12:49:59AM +0200, Sakari Ailus wrote:
> Hi Laurent,
> 
> On Tue, Jan 05, 2021 at 05:28:36PM +0200, Laurent Pinchart wrote:
> > The fsl,csis-hs-settle property isn't used by the driver anymore. Drop
> > it.
> 
> How does it configure the hardware now without this?

Please ignore, I found patch 68. :-)

-- 
Sakari Ailus
