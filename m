Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F1F29E116
	for <linux-media@vger.kernel.org>; Thu, 13 Nov 2025 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763045568; cv=none; b=M1I5Z5Y6Yts8HRGtXvFnd19DOAmglmWf/hQo4JiWdwWW87m7Os0socTXHhlCk82ZuSQ4bu72OFNGUyx/TPCwlJk6Ms8BPMN1+9GN99qGFIy4+6n+ChVKlq83dOmvjDjqrNqU3xrxpXyGxPA99+Bq/rluqmXyqH+s9hEU8YISqEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763045568; c=relaxed/simple;
	bh=N/1SlR78eU55vHGcDw0ENlh2XZ1xdL2itJ4pywjTBnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8jfnv6Z92jtm+zoXjvpzX3+8BtlQbbeB30i/t+yuJFD1Hj6YCf193NyXUK7afBNk/pIgGhT15bZI1BUzcI21jAlu8c/pSTymNmqPGUEtnyF80B3Dyf9REZkHkC4zgd/XUgyKdXYpiwY6xULm0iz4VsD4ilv6XTnFAQlK670+ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJdd1e7e; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJdd1e7e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763045563; x=1794581563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=N/1SlR78eU55vHGcDw0ENlh2XZ1xdL2itJ4pywjTBnY=;
  b=HJdd1e7e0GN7B8aIhbh4+pZG9xeAFfCHyEi/Cuz6ff/dq5bK1vaV5K/i
   yfbYb9LMryeFkxyROLMi/YCHlgR7qrhQToMtMMmUp0ZblAY8IbqNBSscm
   LhbNBCmI1RYm5TVmj45kvHWO5A8/XOMaI6VlpOme6W7W6gv22xGU831vd
   XbvAxiUYivXGicc7IeW3D/fuaR9jEcx1xCfyUIYqtwo8bONJx8P6knns7
   xqTz6L8aA09B4ECUHuHAGld7H2xfZ4wD6e+uHtMvCLOShYQOCvylqsPme
   BI0g2+Y97vrxUn9bX69G5OLzjFmnZQQG18XQGnEMhtp3bZwSxwPVg6rfd
   A==;
X-CSE-ConnectionGUID: 7LeXHVKqSteQdYeVkaZiDw==
X-CSE-MsgGUID: C5omVrWmS2WOPwAIxoqVpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="75805368"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="75805368"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 06:52:43 -0800
X-CSE-ConnectionGUID: 1qNwQ+B0RXmMyGZpcBRsfg==
X-CSE-MsgGUID: yKcNISvGR1CjikNC2XFjzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="189356754"
Received: from rvuia-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.89])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 06:52:41 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 12C50121DDC;
	Thu, 13 Nov 2025 16:52:39 +0200 (EET)
Date: Thu, 13 Nov 2025 16:52:39 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Michael Riesch <michael.riesch@collabora.com>
Cc: linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com,
	jacopo.mondi@ideasonboard.com,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH 1/1] media: v4l2-fwnode: Allow passing NULL fwnode to
 endpoint parsers
Message-ID: <aRXwtyuOz76OUDD4@kekkonen.localdomain>
References: <20251112100333.97288-1-sakari.ailus@linux.intel.com>
 <54404cd0-2aae-489a-bb7d-771058b35aa5@collabora.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54404cd0-2aae-489a-bb7d-771058b35aa5@collabora.com>

Hi Michael,

On Thu, Nov 13, 2025 at 02:56:19PM +0100, Michael Riesch wrote:
> Hi Sakari,
> 
> Thanks for the patch!
> 
> On 11/12/25 11:03, Sakari Ailus wrote:
> > v4l2_fwnode_endpoint_parse() and v4l2_fwnode_endpoint_alloc_parse() take
> > a fwnode as the first argument and leave it up to the caller to check a
> > valid fwnode has been obtained through various means. Instead, add a check
> > here so the callers won't need to do that anymore.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> Reviewed-by: Michael Riesch <michael.riesch@collabora.com>

Thank you.

> 
> LGTM, just one question...
> 
> > ---
> >  drivers/media/v4l2-core/v4l2-fwnode.c | 3 +++
> >  include/media/v4l2-fwnode.h           | 4 ++--
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
> > index cb153ce42c45..22ec702a4567 100644
> > --- a/drivers/media/v4l2-core/v4l2-fwnode.c
> > +++ b/drivers/media/v4l2-core/v4l2-fwnode.c
> > @@ -465,6 +465,9 @@ static int __v4l2_fwnode_endpoint_parse(struct fwnode_handle *fwnode,
> >  	enum v4l2_mbus_type mbus_type;
> >  	int rval;
> >  
> > +	if (!fwnode)
> > +		return -EINVAL;
> > +
> >  	pr_debug("===== begin parsing endpoint %pfw\n", fwnode);
> >  
> >  	fwnode_property_read_u32(fwnode, "bus-type", &bus_type);
> > diff --git a/include/media/v4l2-fwnode.h b/include/media/v4l2-fwnode.h
> > index f7c57c776589..299b60ce960b 100644
> > --- a/include/media/v4l2-fwnode.h
> > +++ b/include/media/v4l2-fwnode.h
> > @@ -182,7 +182,7 @@ enum v4l2_fwnode_bus_type {
> >  
> >  /**
> >   * v4l2_fwnode_endpoint_parse() - parse all fwnode node properties
> > - * @fwnode: pointer to the endpoint's fwnode handle
> > + * @fwnode: pointer to the endpoint's fwnode handle (may be NULL)
> 
> ... isn't that addition a bit misleading? It says it may be NULL, but it
> returns an error in this case?
> 
> Checking for pointer == NULL in public functions is excellent practice,
> but I wouldn't say this needs to be emphasized in the argument
> documentation. But that's just my €0.02, I am fine either way.

Such wording is used elsewhere to signal NULL for something is acceptable.
Obviously this leads to parsing failure in this case. I'll add an explicit
note on this for -EINVAL code, how about that?

-- 
Kind regards,

Sakari Ailus
