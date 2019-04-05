Return-Path: <SRS0=Dnes=SH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC14C4360F
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 00:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBDB20663
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 00:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfDEAWR (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:22:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:60500 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbfDEAWR (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 4 Apr 2019 20:22:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 17:22:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,310,1549958400"; 
   d="scan'208";a="140118933"
Received: from jweber-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.42.228])
  by orsmga003.jf.intel.com with ESMTP; 04 Apr 2019 17:22:14 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id 85E3221E50; Fri,  5 Apr 2019 03:22:10 +0300 (EEST)
Date:   Fri, 5 Apr 2019 03:22:10 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, niklas.soderlund@ragnatech.se,
        laurent.pinchart@ideasonboard.com
Subject: Re: [RFC 4/8] omap3isp: Rework OF endpoint parsing
Message-ID: <20190405002209.erqxg3yfkuc4vv7t@kekkonen.localdomain>
References: <20190318191653.7197-1-sakari.ailus@linux.intel.com>
 <20190318191653.7197-5-sakari.ailus@linux.intel.com>
 <47cf12e5-25a1-b315-d834-e940d953aadf@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47cf12e5-25a1-b315-d834-e940d953aadf@xs4all.nl>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Hans,

Thank you for reviewing this.

On Thu, Apr 04, 2019 at 03:43:51PM +0200, Hans Verkuil wrote:
> On 3/18/19 8:16 PM, Sakari Ailus wrote:
...
> > +static int isp_parse_of_endpoints(struct isp_device *isp)
> > +{
> > +	struct fwnode_handle *ep;
> > +	struct isp_async_subdev *isd;
> > +	struct isp_bus_cfg *buscfg;
> > +	unsigned int i;
> > +
> > +	ep = fwnode_graph_get_endpoint_by_id(
> > +		dev_fwnode(isp->dev), ISP_OF_PHY_PARALLEL, 0,
> > +		FWNODE_GRAPH_ENDPOINT_NEXT);
> > +
> > +	if (ep) {
> > +		struct v4l2_fwnode_endpoint vep = {
> > +			.bus_type = V4L2_MBUS_PARALLEL
> > +		};
> > +		int ret;
> > +
> > +		dev_dbg(isp->dev, "parsing parallel interface\n");
> > +
> > +		ret = v4l2_fwnode_endpoint_parse(ep, &vep);
> > +		if (!ret)
> > +			ret = isp_alloc_isd(&isd, &buscfg);
> > +
> > +		if (!ret) {
> > +			isp_parse_of_parallel_endpoint(isp->dev, &vep, buscfg);
> > +			ret = v4l2_async_notifier_add_fwnode_remote_subdev(
> > +				&isp->notifier, ep, &isd->asd);
> > +		}
> > +
> > +		if (ret) {
> > +			kfree(isd);
> > +			fwnode_handle_put(ep);
> > +		}
> 
> If ret == 0, then who calls 'fwnode_handle_put(ep);'?
> 
> Am I missing something?

Good question. The reference is released when the notifier is eventually
cleaned up. That's not very intuitive. I'll see if I could address that in
the next version.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
