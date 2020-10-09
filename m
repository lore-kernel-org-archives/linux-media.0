Return-Path: <SRS0=wJZ5=DQ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B615C433DF
	for <linux-media@archiver.kernel.org>; Fri,  9 Oct 2020 00:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DC8422254
	for <linux-media@archiver.kernel.org>; Fri,  9 Oct 2020 00:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bJEYtBR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbgJIAue (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 8 Oct 2020 20:50:34 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:49276 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgJIAue (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 8 Oct 2020 20:50:34 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F2B3459E;
        Fri,  9 Oct 2020 02:50:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1602204632;
        bh=e5T8QihRk+jOSotEsEiNFaAS7rUwhdD9RLqqYFePLuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bJEYtBR8FzIakpIzXD35kdSsjFKH+zMdCfrrVhMEnPGXkCULX5xFE8fdJyVznPyix
         jaPQ0L6QrWQXSmFNmEvkAmzyojs6whd1ZxXrOTk1akDzznAJsHeNYOs3mOVhIE7g44
         GzcDvY4YUxqy7hqZHEeEb7ryXmhOcsXiuIQcviJY=
Date:   Fri, 9 Oct 2020 03:49:49 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, Tsuchiya Yuto <kitakar@gmail.com>,
        bingbu.cao@intel.com, Yong Zhi <yong.zhi@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>
Subject: Re: [PATCH 3/3] ipu3-cio2: Only allow setting valid mbus codes
Message-ID: <20201009004949.GC12857@pendragon.ideasonboard.com>
References: <20201008204747.26320-1-sakari.ailus@linux.intel.com>
 <20201008204747.26320-4-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008204747.26320-4-sakari.ailus@linux.intel.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Sakari,

Thank you for the patch.

On Thu, Oct 08, 2020 at 11:47:47PM +0300, Sakari Ailus wrote:
> Check the mbus code provided by the user is one of those the driver
> supports. Ignore the code in set_fmt otherwise.

You're reading my mind :-)

The code shouldn't be ignored though, when an unsupported code is set,
it's best to use a fixed default code instead to make the driver
behaviour as stateless as possible.

> Fixes: c2a6a07afe4a ("media: intel-ipu3: cio2: add new MIPI-CSI2 driver")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/media/pci/intel/ipu3/ipu3-cio2.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
> index 9c7b527a8800..2ea6313e00b0 100644
> --- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
> +++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
> @@ -1270,10 +1270,17 @@ static int cio2_subdev_set_fmt(struct v4l2_subdev *sd,
>  	if (fmt->which == V4L2_SUBDEV_FORMAT_TRY) {
>  		*v4l2_subdev_get_try_format(sd, cfg, fmt->pad) = fmt->format;
>  	} else {
> +		unsigned int i;
> +
>  		/* It's the sink, allow changing frame size */
>  		q->subdev_fmt.width = fmt->format.width;
>  		q->subdev_fmt.height = fmt->format.height;
> -		q->subdev_fmt.code = fmt->format.code;
> +		for (i = 0; i < ARRAY_SIZE(formats); i++) {
> +			if (formats[i].mbus_code == fmt->format.code) {
> +				q->subdev_fmt.code = fmt->format.code;
> +				break;
> +			}
> +		}
>  		fmt->format = q->subdev_fmt;

This should equally apply to the TRY format, we should accept an
unsupported code. I'd rework the code as follows:

	v4l2_mbus_framefmt *format;

	if (fmt->which == V4L2_SUBDEV_FORMAT_TRY)
		format = v4l2_subdev_get_try_format(sd, cfg, fmt->pad);
	else
		format = &q->subdev_fmt;

(this can be done outside of the mutex-protected section) and then
operate on format unconditionally.

Note that we should also allow changing the field and colorspace
information.

-- 
Regards,

Laurent Pinchart
