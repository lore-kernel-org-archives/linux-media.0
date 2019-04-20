Return-Path: <SRS0=iC2Y=SW=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B91C282E2
	for <linux-media@archiver.kernel.org>; Sat, 20 Apr 2019 13:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F82421855
	for <linux-media@archiver.kernel.org>; Sat, 20 Apr 2019 13:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BRQtkPTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfDTNJS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 20 Apr 2019 09:09:18 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:51206 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDTNJS (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 20 Apr 2019 09:09:18 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 975805F;
        Sat, 20 Apr 2019 15:09:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1555765755;
        bh=oXAgjgghA3CzA87INJL4FtpGi1uQs/Ua+dmWjdZP0a0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BRQtkPTfAHOzxwpZWCAtuHRom5e7xvie4vN40RgSBT0/OzyeGuwxs2I3M33qkSTKn
         FCm/UfE/VNGmZxkwWiiXbb3WT499iHgXl67Zm960/NxijJg6M5KQpCblrD7DUjrVJd
         OkcwIv81cn3RW7BBH2bRBKSEBqYXxzCuFXcHAwys=
Date:   Sat, 20 Apr 2019 16:09:06 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 0/9] R-Car DU: Add missing RGB pixel formats
Message-ID: <20190420130906.GA4964@pendragon.ideasonboard.com>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Dave,

On Thu, Mar 28, 2019 at 09:07:14AM +0200, Laurent Pinchart wrote:
> Hello,
> 
> This patch series adds support for 16 missing RGB formats to the DU
> driver. To do is, the formats are first added to the VSP1 driver.
> Patches 1/9 to 3/9 define those formats in the V4L2 API, patches 4/9 to
> 6/9 add them to the VSP driver, and patches 7/9 to 9/9 finally add them
> to the DU driver.

This series touches both V4L2 and DRM drivers. I think it would be
easier to merge it through the V4L2 tree, as the changes on the DRM side
as minimal (see patches 7/9 to 9/9). Would that be OK with you ? I will
of course make sure to avoid conflict with the R-Car DU patches already
merged in your tree.

> There's nothing very special here, but those patches are likely very
> error-prone due to the many instances of very similar constructs. I
> would thus appreciate careful review.
> 
> The new V4L2 4CCs match (or at least should match if I haven't made any
> mistake) the DRM 4CCs, but the names of the format macros differ in
> order to stick to the V4L2 naming scheme.
> 
> Laurent Pinchart (9):
>   v4l: Add definitions for missing 32-bit RGB formats
>   v4l: Add definitions for missing 16-bit RGB4444 formats
>   v4l: Add definitions for missing 16-bit RGB555 formats
>   media: vsp1: Add support for missing 32-bit RGB formats
>   media: vsp1: Add support for missing 16-bit RGB444 formats
>   media: vsp1: Add support for missing 16-bit RGB555 formats
>   drm: rcar-du: Add support for missing 32-bit RGB formats
>   drm: rcar-du: Add support for missing 16-bit RGB4444 formats
>   drm: rcar-du: Add support for missing 16-bit RGB1555 formats
> 
>  .../media/uapi/v4l/pixfmt-packed-rgb.rst      | 436 ++++++++++++++++++
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c         |  80 ++++
>  drivers/media/platform/vsp1/vsp1_pipe.c       |  70 +++
>  include/uapi/linux/videodev2.h                |  16 +
>  4 files changed, 602 insertions(+)

-- 
Regards,

Laurent Pinchart
