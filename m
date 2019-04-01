Return-Path: <SRS0=Gl4L=SD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5122EC10F05
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 12:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297DC20870
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 12:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfDAMfd (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:35:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:38107 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfDAMfd (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 1 Apr 2019 08:35:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 05:35:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,296,1549958400"; 
   d="scan'208";a="130442472"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga008.jf.intel.com with ESMTP; 01 Apr 2019 05:35:30 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 9CE77206EA; Mon,  1 Apr 2019 15:35:29 +0300 (EEST)
Date:   Mon, 1 Apr 2019 15:35:29 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc:     laurent.pinchart@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se, luca@lucaceresoli.net,
        ian.arkver.dev@gmail.com, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v4 18/31] v4l: subdev: Add [GS]_ROUTING subdev ioctls and
 operations
Message-ID: <20190401123529.eohlzpeuzztprdbz@paasikivi.fi.intel.com>
References: <20190328200608.9463-1-jacopo+renesas@jmondi.org>
 <20190328200608.9463-19-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190328200608.9463-19-jacopo+renesas@jmondi.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, Mar 28, 2019 at 09:05:55PM +0100, Jacopo Mondi wrote:
> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> 
> - Add sink and source streams for multiplexed links
> - Copy the argument back in case of an error. This is needed to let the
>   caller know the number of routes.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
> - Expand and refine documentation.
> - Make the 'routes' pointer a __u64 __user pointer so that a compat32
>   version of the ioctl is not required.
> - Add struct v4l2_subdev_krouting to be used for subdevice operations.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  drivers/media/v4l2-core/v4l2-ioctl.c  | 25 ++++++++++++++++-
>  drivers/media/v4l2-core/v4l2-subdev.c | 36 ++++++++++++++++++++++++
>  include/media/v4l2-subdev.h           | 22 +++++++++++++++
>  include/uapi/linux/v4l2-subdev.h      | 40 +++++++++++++++++++++++++++
>  4 files changed, 122 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index ac87c3e37280..091f25526e72 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -19,6 +19,7 @@
>  #include <linux/kernel.h>
>  #include <linux/version.h>
>  
> +#include <linux/v4l2-subdev.h>
>  #include <linux/videodev2.h>
>  
>  #include <media/v4l2-common.h>
> @@ -2968,6 +2969,21 @@ static int check_array_args(unsigned int cmd, void *parg, size_t *array_size,
>  		}
>  		break;
>  	}
> +
> +	case VIDIOC_SUBDEV_G_ROUTING:
> +	case VIDIOC_SUBDEV_S_ROUTING: {
> +		struct v4l2_subdev_routing *route = parg;
> +
> +		if (route->num_routes > 256)
> +			return -EINVAL;
> +
> +		*user_ptr = (void __user *)route->routes;
> +		*kernel_ptr = (void *)&route->routes;

void ** --- it's a pointer to a pointer.

> +		*array_size = sizeof(struct v4l2_subdev_route)
> +			    * route->num_routes;
> +		ret = 1;
> +		break;
> +	}
>  	}
>  
>  	return ret;

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
