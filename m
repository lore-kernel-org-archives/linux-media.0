Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747FBC05027
	for <linux-media@archiver.kernel.org>; Sun, 12 Feb 2023 21:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjBLVw0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 12 Feb 2023 16:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBLVw0 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 12 Feb 2023 16:52:26 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00DBEB76
        for <linux-media@vger.kernel.org>; Sun, 12 Feb 2023 13:52:24 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AB78F4DD;
        Sun, 12 Feb 2023 22:52:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1676238742;
        bh=e8hWe4eyDFVqly1rYeAFmuxBUo9lO2uONV+bFxdbO9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVRfTc/tI/ULgT5tQRUpzJdhfcth0JLccl6/zFl0gncJpSaKXTJEWiW7hKse1Au/d
         J4ZVuposGaaSkCkEMk+RLblzfZRsGqFfZRLJ5dVHYS8PYDFXQO46oynA3dTxHM1VJ9
         kWV7imChvQdpEc2FF/CbQdaVvaT5DbEfTilRb9UU=
Date:   Sun, 12 Feb 2023 23:52:22 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, sakari.ailus@linux.intel.com,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        niklas.soderlund+renesas@ragnatech.se,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        satish.nagireddy@getcruise.com
Subject: Re: [PATCH v3 0/3] v4l-utils: support multiplexed streams
Message-ID: <Y+lflqx9IAP2dM/8@pendragon.ideasonboard.com>
References: <20230210115546.199809-1-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230210115546.199809-1-tomi.valkeinen@ideasonboard.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Tomi,

Thank you for the patches.

On Fri, Feb 10, 2023 at 01:55:43PM +0200, Tomi Valkeinen wrote:
> Hi,
> 
> v4l2-ctl and media-ctl are updated to allow configuring routes and
> setting configs per stream.
> 
> v4l2-compliance is updated to always set the new stream field, and to do
> some testing for multiplexed subdevs.
> 
> v2 of the series can be found from:
> 
> https://lore.kernel.org/all/20220714132116.132498-1-tomi.valkeinen@ideasonboard.com/
> 
> v3 is just a rebase on top of latest master, which contains the most
> recent headers from the kernel.
> 
> Uses of V4L2_SUBDEV_ROUTE_FL_IMMUTABLE and V4L2_SUBDEV_ROUTE_FL_SOURCE
> have been dropped as they don't exist in the mainline.

Just for information, I've applied this on top of the meson conversion,
there's no conflict and it compiles fine.

> Tomi Valkeinen (3):
>   v4l2-ctl: Add routing and streams support
>   media-ctl: add support for routes and streams
>   v4l2-ctl/compliance: add routing and streams multiplexed streams
> 
>  utils/media-ctl/libmediactl.c               |  41 +++
>  utils/media-ctl/libv4l2subdev.c             | 283 +++++++++++++++++--
>  utils/media-ctl/media-ctl.c                 | 121 ++++++--
>  utils/media-ctl/mediactl.h                  |  16 ++
>  utils/media-ctl/options.c                   |  15 +-
>  utils/media-ctl/options.h                   |   1 +
>  utils/media-ctl/v4l2subdev.h                |  58 +++-
>  utils/v4l2-compliance/v4l2-compliance.cpp   | 120 ++++++--
>  utils/v4l2-compliance/v4l2-compliance.h     |   8 +-
>  utils/v4l2-compliance/v4l2-test-subdevs.cpp |  43 ++-
>  utils/v4l2-ctl/v4l2-ctl-subdev.cpp          | 288 +++++++++++++++++---
>  utils/v4l2-ctl/v4l2-ctl.cpp                 |   2 +
>  utils/v4l2-ctl/v4l2-ctl.h                   |   2 +
>  13 files changed, 874 insertions(+), 124 deletions(-)

-- 
Regards,

Laurent Pinchart
