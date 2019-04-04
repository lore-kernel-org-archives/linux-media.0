Return-Path: <SRS0=KukI=SG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A76C4360F
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 21:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6481F20882
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 21:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbfDDVvB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:51:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:58954 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729827AbfDDVvB (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 4 Apr 2019 17:51:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 14:51:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,309,1549958400"; 
   d="scan'208";a="131563057"
Received: from jweber-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.42.228])
  by orsmga008.jf.intel.com with ESMTP; 04 Apr 2019 14:50:59 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id 3A48021E50; Fri,  5 Apr 2019 00:50:55 +0300 (EEST)
Date:   Fri, 5 Apr 2019 00:50:54 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, niklas.soderlund@ragnatech.se,
        laurent.pinchart@ideasonboard.com
Subject: Re: [RFC 1/8] v4l2-async: Use endpoint node, not device node, for
 fwnode match
Message-ID: <20190404215054.rg2wtfvyetnubjto@kekkonen.localdomain>
References: <20190318191653.7197-1-sakari.ailus@linux.intel.com>
 <20190318191653.7197-2-sakari.ailus@linux.intel.com>
 <198618d5-f32b-a4d2-c048-a7d8371289ee@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <198618d5-f32b-a4d2-c048-a7d8371289ee@xs4all.nl>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Hans,

Thank you for the review.

On Thu, Apr 04, 2019 at 03:37:44PM +0200, Hans Verkuil wrote:
...
> > diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
> > index 6216b7ac6875..bb4c9cb9f2ad 100644
> > --- a/drivers/media/platform/davinci/vpif_capture.c
> > +++ b/drivers/media/platform/davinci/vpif_capture.c
> > @@ -1541,7 +1541,6 @@ vpif_capture_get_pdata(struct platform_device *pdev)
> >  
> >  	for (i = 0; i < VPIF_CAPTURE_NUM_CHANNELS; i++) {
> >  		struct v4l2_fwnode_endpoint bus_cfg = { .bus_type = 0 };
> > -		struct device_node *rem;
> >  		unsigned int flags;
> >  		int err;
> >  
> > @@ -1550,14 +1549,6 @@ vpif_capture_get_pdata(struct platform_device *pdev)
> >  		if (!endpoint)
> >  			break;
> >  
> > -		rem = of_graph_get_remote_port_parent(endpoint);
> > -		if (!rem) {
> > -			dev_dbg(&pdev->dev, "Remote device at %pOF not found\n",
> > -				endpoint);
> > -			of_node_put(endpoint);
> > -			goto done;
> > -		}
> > -
> >  		sdinfo = &pdata->subdev_info[i];
> >  		chan = &pdata->chan_config[i];
> >  		chan->inputs = devm_kcalloc(&pdev->dev,
> > @@ -1565,7 +1556,6 @@ vpif_capture_get_pdata(struct platform_device *pdev)
> >  					    sizeof(*chan->inputs),
> >  					    GFP_KERNEL);
> >  		if (!chan->inputs) {
> > -			of_node_put(rem);
> >  			of_node_put(endpoint);
> >  			goto err_cleanup;
> >  		}
> > @@ -1577,10 +1567,8 @@ vpif_capture_get_pdata(struct platform_device *pdev)
> >  
> >  		err = v4l2_fwnode_endpoint_parse(of_fwnode_handle(endpoint),
> >  						 &bus_cfg);
> > -		of_node_put(endpoint);
> 
> I don't think you can delete this line, seems to be an accidental deletion.

Right. of_graph_get_next_endpoint() will put the endpoint node on the next
iteration, so if the loop is executed again, the endpoint node musn't be
put here. I think I'll properly address this in a separate patch (before
this one).

> 
> >  		if (err) {
> >  			dev_err(&pdev->dev, "Could not parse the endpoint\n");
> > -			of_node_put(rem);
> >  			goto done;
> >  		}
> >  
> > @@ -1599,7 +1587,7 @@ vpif_capture_get_pdata(struct platform_device *pdev)
> >  		sdinfo->name = rem->full_name;
> >  
> >  		pdata->asd[i] = v4l2_async_notifier_add_fwnode_subdev(
> > -			&vpif_obj.notifier, of_fwnode_handle(rem),
> > +			&vpif_obj.notifier, of_fwnode_handle(endpoint),
> >  			sizeof(struct v4l2_async_subdev));
> >  		if (IS_ERR(pdata->asd[i])) {
> >  			of_node_put(rem);

...

> > diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
> > index 15b0c44a76e7..4cb49d5f8c03 100644
> > --- a/drivers/media/v4l2-core/v4l2-async.c
> > +++ b/drivers/media/v4l2-core/v4l2-async.c
> > @@ -670,8 +670,12 @@ int v4l2_async_register_subdev(struct v4l2_subdev *sd)
> >  	 * (struct v4l2_subdev.dev), and async sub-device does not
> >  	 * exist independently of the device at any point of time.
> >  	 */
> > -	if (!sd->fwnode && sd->dev)
> > -		sd->fwnode = dev_fwnode(sd->dev);
> > +	if (!sd->fwnode && sd->dev) {
> > +		sd->fwnode = fwnode_graph_get_next_endpoint(
> > +			dev_fwnode(sd->dev), NULL);
> 
> Doesn't this take a reference? As opposed to the assignment below?
> 
> Shouldn't you call 'fwnode_handle_put(sd->fwnode);'?

Yes. I'll fix this for the next version.

> 
> > +		if (!sd->fwnode)
> > +			sd->fwnode = dev_fwnode(sd->dev);
> > +	}
> >  
> >  	mutex_lock(&list_lock);
> >  

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
