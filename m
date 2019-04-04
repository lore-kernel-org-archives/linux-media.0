Return-Path: <SRS0=KukI=SG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29ACEC4360F
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 08:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0351D20820
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 08:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfDDIjk (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:39:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:11907 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfDDIjj (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 4 Apr 2019 04:39:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 01:39:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,306,1549958400"; 
   d="scan'208";a="333691768"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga006.fm.intel.com with ESMTP; 04 Apr 2019 01:39:35 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 4F2AB205BD; Thu,  4 Apr 2019 11:39:34 +0300 (EEST)
Date:   Thu, 4 Apr 2019 11:39:34 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     mchehab@kernel.org, rmfrfs@gmail.com, zhengsq@rock-chips.com,
        prabhakar.csengg@gmail.com, corbet@lwn.net,
        wenyou.yang@microchip.com, lkundrak@v3.sk,
        hverkuil-cisco@xs4all.nl, jacopo+renesas@jmondi.org,
        linux-media@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/6] media: v4l2-subdev: add stubs for
 v4l2_subdev_get_try_*
Message-ID: <20190404083933.33ejwyko4xoittux@paasikivi.fi.intel.com>
References: <20190404074002.18730-1-m.felsch@pengutronix.de>
 <20190404074002.18730-2-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404074002.18730-2-m.felsch@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Marco,

On Thu, Apr 04, 2019 at 09:39:57AM +0200, Marco Felsch wrote:
> In case of missing CONFIG_VIDEO_V4L2_SUBDEV_API those helpers aren't
> available. So each driver have to add ifdefs around those helpers or
> add the CONFIG_VIDEO_V4L2_SUBDEV_API as dependcy.
> 
> Make these helpers available in case of CONFIG_VIDEO_V4L2_SUBDEV_API
> isn't set to avoid ifdefs. This approach is less error prone too.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> The patch was previously part of series [1]. Since I want to get
> series [1] merged in 5.2 I split this possible stopper out of the
> serie and prepared a own series for it. I applied Jacopos comments and
> switched to Lubomir's approach [2]. During discussion on series [2]
> Sakari pointed out Hans approach [3] which didn't got into the kernel
> due to Mauro's concerns. So I think this would be the smalles common
> dennominator.
> 
> [1] https://patchwork.kernel.org/cover/10786553/
> [2] https://patchwork.kernel.org/patch/10703029/
> [3] https://patchwork.linuxtv.org/patch/53370/
> ---
>  include/media/v4l2-subdev.h | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
> index a7fa5b80915a..eea792757426 100644
> --- a/include/media/v4l2-subdev.h
> +++ b/include/media/v4l2-subdev.h
> @@ -984,7 +984,34 @@ static inline struct v4l2_rect
>  		pad = 0;
>  	return &cfg[pad].try_compose;
>  }
> -#endif
> +
> +#else /* !defined(CONFIG_VIDEO_V4L2_SUBDEV_API) */
> +
> +static inline struct v4l2_mbus_framefmt
> +*v4l2_subdev_get_try_format(struct v4l2_subdev *sd,
> +			    struct v4l2_subdev_pad_config *cfg,
> +			    unsigned int pad)
> +{
> +	return ERR_PTR(-ENOTTY);
> +}

Almost all users of these functions directly use the struct pointer they
receive from the said functions, without checks for the pointer value.

These drivers now depend on CONFIG_VIDEO_V4L2_SUBDEV_API, but for new
drivers it could be possible to miss that, leading to dereferencing
ERR_PTR(-ENOTTY) as a result if the sub-device API isn't enabled.

I have to say I'm not a huge fan of such a change; it's one more such thing
to remember that results in a kernel crash if you get it wrong.

I wonder if v4l2_subdev_call() could become a bit smarter about this;
checking whether the try format is attempted to be obtained without the
sub-device API being enabled, and returning an error in that case without
passing the IOCTL to the driver at all.

Just an idea. It doesn't have to be in the same patchset.

I'd still prefer enabling subdev API always to decrease the number of
possible different kernel configurations.

I wonder what others think.

> +
> +static inline struct v4l2_rect
> +*v4l2_subdev_get_try_crop(struct v4l2_subdev *sd,
> +			  struct v4l2_subdev_pad_config *cfg,
> +			  unsigned int pad)
> +{
> +	return ERR_PTR(-ENOTTY);
> +}
> +
> +static inline struct v4l2_rect
> +*v4l2_subdev_get_try_compose(struct v4l2_subdev *sd,
> +			     struct v4l2_subdev_pad_config *cfg,
> +			     unsigned int pad)
> +{
> +	return ERR_PTR(-ENOTTY);
> +}
> +
> +#endif /* defined(CONFIG_VIDEO_V4L2_SUBDEV_API) */
>  
>  extern const struct v4l2_file_operations v4l2_subdev_fops;
>  

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
