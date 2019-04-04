Return-Path: <SRS0=KukI=SG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA726C4360F
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 13:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E16F20855
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 13:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfDDNjr (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:39:47 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:44498 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726790AbfDDNjq (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 4 Apr 2019 09:39:46 -0400
Received: from [IPv6:2001:420:44c1:2579:1ed:86b:7a55:d4f2] ([IPv6:2001:420:44c1:2579:1ed:86b:7a55:d4f2])
        by smtp-cloud8.xs4all.net with ESMTPA
        id C2ajh73tEUjKfC2amhK4cb; Thu, 04 Apr 2019 15:39:44 +0200
Subject: Re: [RFC 2/8] v4l2-async: Add
 v4l2_async_notifier_add_fwnode_remote_subdev
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org
Cc:     niklas.soderlund@ragnatech.se, laurent.pinchart@ideasonboard.com
References: <20190318191653.7197-1-sakari.ailus@linux.intel.com>
 <20190318191653.7197-3-sakari.ailus@linux.intel.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <facaf1aa-8b0a-843a-a772-3cf13e624dac@xs4all.nl>
Date:   Thu, 4 Apr 2019 15:39:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318191653.7197-3-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBjmyWqCH2TdyT6Q6hkS4/qxZUGgCu4R7BujsLnGS37lPu2fD32irlghJj5qARUr5JySulB+l3Yzo1mlPTFKD9x91mqy0GpWcJX2w4BC9Thvf1jpGY4n
 zp+MEz9QM9DiBPhLF6aheW75iD0BYnOaFnpiAeNZtgXfta+7hofTViVuTaTD92lIzimiN/t/1SCEXrOp9lnjbey2ZHqtp/5nnxIlVMV/9GHOlUb2NT817nqZ
 ALf79rKDDs4/ZN86+sQa2tb7vAAsNZaDaQ3bNt14mrG7yT+0sCMMPghgLTPlAgEGRAIH+SjU9EoSW/rLic0SlASpfm7FXe5wo/YfB+BoolgDtTVd7Taq+Y5K
 I+amPQWusRAqHiTdE0FNvVYkS4Wn7I9uTd9GZxcdt1lHjXPf4pKeua3d6wosuODQo1hS8n/f
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 3/18/19 8:16 PM, Sakari Ailus wrote:
> v4l2_async_notifier_add_fwnode_remote_subdev is a convenience function for
> parsing information on V4L2 fwnode subdevs.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/media/v4l2-core/v4l2-async.c | 23 +++++++++++++++++++++++
>  include/media/v4l2-async.h           | 24 ++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
> index 4cb49d5f8c03..9c1937d6ce17 100644
> --- a/drivers/media/v4l2-core/v4l2-async.c
> +++ b/drivers/media/v4l2-core/v4l2-async.c
> @@ -608,6 +608,29 @@ v4l2_async_notifier_add_fwnode_subdev(struct v4l2_async_notifier *notifier,
>  }
>  EXPORT_SYMBOL_GPL(v4l2_async_notifier_add_fwnode_subdev);
>  
> +int
> +v4l2_async_notifier_add_fwnode_remote_subdev(struct v4l2_async_notifier *notif,
> +					     struct fwnode_handle *endpoint,
> +					     struct v4l2_async_subdev *asd)
> +{
> +	struct fwnode_handle *remote_ep;
> +	int ret;
> +
> +	remote_ep = fwnode_graph_get_remote_endpoint(endpoint);
> +	if (!remote_ep)
> +		return -ENOTCONN;
> +
> +	asd->match_type = V4L2_ASYNC_MATCH_FWNODE;
> +	asd->match.fwnode = remote_ep;
> +
> +	ret = v4l2_async_notifier_add_subdev(notif, asd);
> +	if (ret)
> +		fwnode_handle_put(remote_ep);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(v4l2_async_notifier_add_fwnode_remote_subdev);
> +
>  struct v4l2_async_subdev *
>  v4l2_async_notifier_add_i2c_subdev(struct v4l2_async_notifier *notifier,
>  				   int adapter_id, unsigned short address,
> diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
> index 1497bda66c3b..215e73eddfc3 100644
> --- a/include/media/v4l2-async.h
> +++ b/include/media/v4l2-async.h
> @@ -184,6 +184,30 @@ v4l2_async_notifier_add_fwnode_subdev(struct v4l2_async_notifier *notifier,
>  				      unsigned int asd_struct_size);
>  
>  /**
> + * v4l2_async_notifier_add_fwnode_remote_subdev - Allocate and add a fwnode
> + *						  remote async subdev to the
> + *						  notifier's master asd_list.
> + *
> + * @notifier: pointer to &struct v4l2_async_notifier
> + * @endpoint: local endpoint the remote sub-device to be matched
> + * @asd_struct_size: size of the driver's async sub-device struct, including
> + *		     sizeof(struct v4l2_async_subdev). The &struct
> + *		     v4l2_async_subdev shall be the first member of
> + *		     the driver's async sub-device struct, i.e. both
> + *		     begin at the same memory address.

Huh? This argument is @asd, not a struct size. Also it's @notif, not
@notifier. It seems that this documentation isn't in sync with the actual
function.

	Hans

> + *
> + * Allocate a fwnode-matched asd of size asd_struct_size, and add it
> + * to the notifiers @asd_list.
> + *
> + * This is just like @v4l2_async_notifier_add_fwnode_subdev, but with the
> + * exception that the fwnode refers to a local endpoint, not the remote one.
> + */
> +int
> +v4l2_async_notifier_add_fwnode_remote_subdev(struct v4l2_async_notifier *notif,
> +					     struct fwnode_handle *endpoint,
> +					     struct v4l2_async_subdev *asd);
> +
> +/**
>   * v4l2_async_notifier_add_i2c_subdev - Allocate and add an i2c async
>   *				subdev to the notifier's master asd_list.
>   *
> 

