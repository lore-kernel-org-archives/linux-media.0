Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8102AECAAD5
	for <linux-media@archiver.kernel.org>; Mon, 29 Aug 2022 16:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiH2QHD (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 29 Aug 2022 12:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiH2QHC (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 29 Aug 2022 12:07:02 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C5D861CF
        for <linux-media@vger.kernel.org>; Mon, 29 Aug 2022 09:07:01 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0D7AE505;
        Mon, 29 Aug 2022 18:06:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1661789219;
        bh=JdNtPYXOx+LxyUaRCVn5c/dAMMyZpvSezi8ocGcwoFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=frZiSBwKT6+Cf/gEBwLlFyuLeR2/2bl4jhrC+bAmZOlL69/Ev/RkeQ6VLXnvU1ue4
         V40Hs21X1QoiY8T5Em2ot/paB/G7V3l+kuShDIYdRcg6DU5iH32v6EiGMerkcDXtyy
         jS3UIz4elsRPPw1gda+f6UniHyXX32RhPh7A3BJ4=
Date:   Mon, 29 Aug 2022 19:06:49 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, sakari.ailus@linux.intel.com,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        niklas.soderlund+renesas@ragnatech.se,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Pratyush Yadav <p.yadav@ti.com>,
        Kishon Vijay Abraham <kishon@ti.com>,
        satish.nagireddy@getcruise.com, Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v13 02/34] media: media-entity.h: add include for min()
Message-ID: <YwzkGdw0nzHVqnjT@pendragon.ideasonboard.com>
References: <20220810121122.3149086-1-tomi.valkeinen@ideasonboard.com>
 <20220810121122.3149086-3-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220810121122.3149086-3-tomi.valkeinen@ideasonboard.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Tomi,

Thank you for the patch.

On Wed, Aug 10, 2022 at 03:10:50PM +0300, Tomi Valkeinen wrote:
> ./include/media/media-entity.h:595:34: error: implicit declaration of function ‘min’
> 
> Include kernel.h to get the definition for min().
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  include/media/media-entity.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/media/media-entity.h b/include/media/media-entity.h
> index a9a1c0ec5d1c..3e3d06c1ec36 100644
> --- a/include/media/media-entity.h
> +++ b/include/media/media-entity.h
> @@ -15,6 +15,7 @@
>  #include <linux/bug.h>
>  #include <linux/container_of.h>
>  #include <linux/fwnode.h>
> +#include <linux/kernel.h>

This should be minmax.h. With this fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  #include <linux/list.h>
>  #include <linux/media.h>
>  #include <linux/types.h>

-- 
Regards,

Laurent Pinchart
