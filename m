Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E033C4338F
	for <linux-media@archiver.kernel.org>; Tue, 10 Aug 2021 13:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73B3A61008
	for <linux-media@archiver.kernel.org>; Tue, 10 Aug 2021 13:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241885AbhHJNss (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 10 Aug 2021 09:48:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:63845 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240232AbhHJNss (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 10 Aug 2021 09:48:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="300492031"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="300492031"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 06:48:26 -0700
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="503131908"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 06:48:22 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 53DC220364;
        Tue, 10 Aug 2021 16:48:20 +0300 (EEST)
Date:   Tue, 10 Aug 2021 16:48:20 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     paul.kocialkowski@bootlin.com, ezequiel@collabora.com,
        hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
        yong.zhi@intel.com, bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        kevin.lhopital@bootlin.com, yang.lee@linux.alibaba.com,
        andy.shevchenko@gmail.com, laurent.pinchart@ideasonboard.com,
        kieran.bingham@ideasonboard.com
Subject: Re: [PATCH v2 06/12] media: i2c: Switch control to
 V4L2_CID_ANALOGUE_GAIN
Message-ID: <20210810134820.GD3@paasikivi.fi.intel.com>
References: <20210809225845.916430-1-djrscally@gmail.com>
 <20210809225845.916430-7-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809225845.916430-7-djrscally@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Aug 09, 2021 at 11:58:39PM +0100, Daniel Scally wrote:
> @@ -2143,7 +2143,7 @@ static int ov8865_exposure_configure(struct ov8865_sensor *sensor, u32 exposure)
>  
>  /* Gain */
>  
> -static int ov8865_gain_configure(struct ov8865_sensor *sensor, u32 gain)
> +static int ov8865_analog_gain_configure(struct ov8865_sensor *sensor, u32 gain)
>  {
>  	int ret;
>  
> @@ -2453,8 +2453,8 @@ static int ov8865_s_ctrl(struct v4l2_ctrl *ctrl)
>  		if (ret)
>  			return ret;
>  		break;
> -	case V4L2_CID_GAIN:
> -		ret = ov8865_gain_configure(sensor, ctrl->val);
> +	case V4L2_CID_ANALOGUE_GAIN:
> +		ret = ov8865_analog_gain_configure(sensor, ctrl->val);
>  		if (ret)
>  			return ret;
>  		break;
> @@ -2499,7 +2499,7 @@ static int ov8865_ctrls_init(struct ov8865_sensor *sensor)
>  
>  	/* Gain */
>  
> -	v4l2_ctrl_new_std(handler, ops, V4L2_CID_GAIN, 128, 8191, 128, 128);
> +	v4l2_ctrl_new_std(handler, ops, V4L2_CID_ANALOGUE_GAIN, 128, 8191, 128, 128);

Over 80, please wrap.

-- 
Sakari Ailus
