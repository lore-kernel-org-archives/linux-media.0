Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2053D3074AA
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762860747; cv=none; b=EvRmIOo8dlkbr9JoSKlybA89/8tYp8dHBA/JNA+M5X+J9m5QgZRT3diaaVgm86u93juLC61vbudgJdRMuaYAKmzmo/8Le6x8hxH9Gh8Rh6AE/t+jfVpU+RvsymC4jQ0karhP+Dnp4QhnOnME9MlCvRFI001ywMZ3siSDyhtNEX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762860747; c=relaxed/simple;
	bh=1MiRAmTtb4XNmBa1pjHOOuEUotiTVicqhvCkgBqf7is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUGoe1C2DAP/cq3k6kgxXBiroDxnT+tg0i61WWE9nB/x5Gk8vMhwqY0ruaZUarRJHrobIJXXfL5g6fOEHnBUi+APx1rkMmd06gAqyvnGsZHvHp5rxNMpEwQTPMtrxURw1Zda2AMoZ2GW+Ueyipy254fnf3aJ8KjauoKn2zuRrZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=AS1o2c0u; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="AS1o2c0u"
Received: from ideasonboard.com (mob-5-90-142-135.net.vodafone.it [5.90.142.135])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7088050A;
	Tue, 11 Nov 2025 12:30:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762860622;
	bh=1MiRAmTtb4XNmBa1pjHOOuEUotiTVicqhvCkgBqf7is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AS1o2c0ul7NLlXxoVOEmEtUQN7OX48AyiUQyi4khy47QBYc3dancSriMaJlMRgkHl
	 i4GQYsGxqi5emHutkWRyrw5Vo9MmnSRm7LkEqD0l7HpYhDyhRRJirnSad9oGgjlrGC
	 0BFGctihGC2kZeWg0MEjSqPQ+G9kY8pGxAVpz1/w=
Date: Tue, 11 Nov 2025 12:32:16 +0100
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, hans@jjverkuil.nl, 
	laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH 1/1] media: v4l2-ctrls: Set error
 v4l2_ctrl_new_fwnode_properties consistently
Message-ID: <7ic266r6xq7exbvayosprrypyxliwmeh6aitubvcblgh6tu2l3@u4tvkkg5ig3i>
References: <20251111112057.95655-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251111112057.95655-1-sakari.ailus@linux.intel.com>

Hi Sakari

On Tue, Nov 11, 2025 at 01:20:57PM +0200, Sakari Ailus wrote:
> The vast majority of the callers of v4l2_ctrl_new_fwnode_properties() do
> check the returned error code but the function does not set the control
> handler's error on failure. This will make error handling more complicated
> and prone for bugs.
>
> Always assign the control handler's error field on error in
> v4l2_ctrl_new_fwnode_properties().
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

I think it makes sense indeed
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

Thanks
  j

> ---
>  drivers/media/v4l2-core/v4l2-ctrls-core.c | 3 ++-
>  include/media/v4l2-ctrls.h                | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
> index 209bc05883bb..1d4b5859f0e2 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
> @@ -2780,7 +2780,8 @@ int v4l2_ctrl_new_fwnode_properties(struct v4l2_ctrl_handler *hdl,
>  			orientation_ctrl = V4L2_CAMERA_ORIENTATION_EXTERNAL;
>  			break;
>  		default:
> -			return -EINVAL;
> +			hdl->error = -EINVAL;
> +			return hdl->error;
>  		}
>  		if (!v4l2_ctrl_new_std_menu(hdl, ctrl_ops,
>  					    V4L2_CID_CAMERA_ORIENTATION,
> diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
> index 31fc1bee3797..327976b14d50 100644
> --- a/include/media/v4l2-ctrls.h
> +++ b/include/media/v4l2-ctrls.h
> @@ -1581,6 +1581,9 @@ int v4l2_ctrl_subdev_log_status(struct v4l2_subdev *sd);
>   * not overwritten. Callers should register the controls they want to handle
>   * themselves before calling this function.
>   *
> + * This function will set the control handler's error field on failure, just as
> + * other functions adding controls to the handler.
> + *
>   * Return: 0 on success, a negative error code on failure.
>   */
>  int v4l2_ctrl_new_fwnode_properties(struct v4l2_ctrl_handler *hdl,
> --
> 2.47.3
>
>
