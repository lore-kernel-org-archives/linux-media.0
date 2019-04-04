Return-Path: <SRS0=KukI=SG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2972AC4360F
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 23:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15532177E
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 23:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbfDDXEf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 4 Apr 2019 19:04:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:44913 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730539AbfDDXEf (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 4 Apr 2019 19:04:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 16:04:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,309,1549958400"; 
   d="scan'208";a="137699884"
Received: from jweber-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.42.228])
  by fmsmga008.fm.intel.com with ESMTP; 04 Apr 2019 16:04:23 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id B357D21E50; Fri,  5 Apr 2019 02:04:19 +0300 (EEST)
Date:   Fri, 5 Apr 2019 02:04:19 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, niklas.soderlund@ragnatech.se,
        laurent.pinchart@ideasonboard.com
Subject: Re: [RFC 2/8] v4l2-async: Add
 v4l2_async_notifier_add_fwnode_remote_subdev
Message-ID: <20190404230419.xqq4nhpkmaklfi2f@kekkonen.localdomain>
References: <20190318191653.7197-1-sakari.ailus@linux.intel.com>
 <20190318191653.7197-3-sakari.ailus@linux.intel.com>
 <facaf1aa-8b0a-843a-a772-3cf13e624dac@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <facaf1aa-8b0a-843a-a772-3cf13e624dac@xs4all.nl>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, Apr 04, 2019 at 03:39:41PM +0200, Hans Verkuil wrote:
> On 3/18/19 8:16 PM, Sakari Ailus wrote:
> > v4l2_async_notifier_add_fwnode_remote_subdev is a convenience function for
> > parsing information on V4L2 fwnode subdevs.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/media/v4l2-core/v4l2-async.c | 23 +++++++++++++++++++++++
> >  include/media/v4l2-async.h           | 24 ++++++++++++++++++++++++
> >  2 files changed, 47 insertions(+)
> > 
> > diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
> > index 4cb49d5f8c03..9c1937d6ce17 100644
> > --- a/drivers/media/v4l2-core/v4l2-async.c
> > +++ b/drivers/media/v4l2-core/v4l2-async.c
> > @@ -608,6 +608,29 @@ v4l2_async_notifier_add_fwnode_subdev(struct v4l2_async_notifier *notifier,
> >  }
> >  EXPORT_SYMBOL_GPL(v4l2_async_notifier_add_fwnode_subdev);
> >  
> > +int
> > +v4l2_async_notifier_add_fwnode_remote_subdev(struct v4l2_async_notifier *notif,
> > +					     struct fwnode_handle *endpoint,
> > +					     struct v4l2_async_subdev *asd)
> > +{
> > +	struct fwnode_handle *remote_ep;
> > +	int ret;
> > +
> > +	remote_ep = fwnode_graph_get_remote_endpoint(endpoint);
> > +	if (!remote_ep)
> > +		return -ENOTCONN;
> > +
> > +	asd->match_type = V4L2_ASYNC_MATCH_FWNODE;
> > +	asd->match.fwnode = remote_ep;
> > +
> > +	ret = v4l2_async_notifier_add_subdev(notif, asd);
> > +	if (ret)
> > +		fwnode_handle_put(remote_ep);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(v4l2_async_notifier_add_fwnode_remote_subdev);
> > +
> >  struct v4l2_async_subdev *
> >  v4l2_async_notifier_add_i2c_subdev(struct v4l2_async_notifier *notifier,
> >  				   int adapter_id, unsigned short address,
> > diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
> > index 1497bda66c3b..215e73eddfc3 100644
> > --- a/include/media/v4l2-async.h
> > +++ b/include/media/v4l2-async.h
> > @@ -184,6 +184,30 @@ v4l2_async_notifier_add_fwnode_subdev(struct v4l2_async_notifier *notifier,
> >  				      unsigned int asd_struct_size);
> >  
> >  /**
> > + * v4l2_async_notifier_add_fwnode_remote_subdev - Allocate and add a fwnode
> > + *						  remote async subdev to the
> > + *						  notifier's master asd_list.
> > + *
> > + * @notifier: pointer to &struct v4l2_async_notifier
> > + * @endpoint: local endpoint the remote sub-device to be matched
> > + * @asd_struct_size: size of the driver's async sub-device struct, including
> > + *		     sizeof(struct v4l2_async_subdev). The &struct
> > + *		     v4l2_async_subdev shall be the first member of
> > + *		     the driver's async sub-device struct, i.e. both
> > + *		     begin at the same memory address.
> 
> Huh? This argument is @asd, not a struct size. Also it's @notif, not
> @notifier. It seems that this documentation isn't in sync with the actual
> function.

Yes, I'll address this in the next version.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
