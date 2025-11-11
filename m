Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6278F35950;
	Tue, 11 Nov 2025 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853126; cv=none; b=r9ABK7mtuZ+MAqU6JISN8bOLD5YIbVhdym3YTsE384yZe7EloJOQhK1R0jQv26faZRLbSpblgBYA+I4o2/haZB2jI1s4seRUuzY2l/qiR/HVod+rVEHsRDKpDa4w3DdbSUvWbWRQ37R0bH2xxs07Yuc4HjooK+lw4/m0BQHYuBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853126; c=relaxed/simple;
	bh=dWqAEzq8BQlwywuFknlCoPyBuGFhE/dM7bk78th5Ht4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIgXR1bITnjtxlYvyIGq8Y7PDE9xoh3/r2obn6AW11rD18YpF64T6bghByJgy+1qC/s3rwKYAq299Tb4heUU76HoZoDsFWV4FKbBcgCbBJ3A9qR6gVs86UtKLpzhtMd+ksxy1MlWZyZ1C31u/sgExwHLcz9GfSWN1Vl2BPwZ9/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VENJyNCw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VENJyNCw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762853125; x=1794389125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dWqAEzq8BQlwywuFknlCoPyBuGFhE/dM7bk78th5Ht4=;
  b=VENJyNCwdJFd4oAhw4bLdzUY0Z5hfPXS9uKt93wu/R3tpztMcltiToNN
   RBsf0cbjlDQnnPYlKx8c3bLRlRgF1MGROvHIdjMsJsgZOARmCg+g3lpNy
   wZfI92CV2fzNKms5gjHJV3UUNgFutCrEeF+5utlnRhrV/DwhNmEirzCJI
   Kmzmo1V63QWQRiyBQEhGZl7/xFCF6FQJbDoWHAIN5C5Pbt+EaUFbfme9w
   o3jgv/QgZitM8ueGdbo8O5mTIISukWdcu8Hh0IqA7vM68KMGy4n+dZhJm
   ltDnz3nC8CCy+IFxZy/DYGlrokbIXIcg53l08Yc+jKRc04euzMibmDV89
   g==;
X-CSE-ConnectionGUID: xDDUNZF+RPKMujWeC88PyQ==
X-CSE-MsgGUID: sJEIey7mTgKrdf3EkuMwKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="65068238"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="65068238"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 01:25:24 -0800
X-CSE-ConnectionGUID: /xSN7E4ARAG4M2GZRzgB3w==
X-CSE-MsgGUID: Xqisr/pSSXu/n7wAyFPjoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="189655324"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.96])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 01:25:21 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 0D8CF11F983;
	Tue, 11 Nov 2025 11:25:19 +0200 (EET)
Date: Tue, 11 Nov 2025 11:25:18 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: Bryan O'Donoghue <bod@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Hans de Goede <hansg@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] media: i2c: add Samsung S5KJN1 image sensor
 device driver
Message-ID: <aRMA_kd87a7rL-v0@kekkonen.localdomain>
References: <20251023025356.2421327-1-vladimir.zapolskiy@linaro.org>
 <zGlVBFnnqOaXjobqCKcCVXYYwfZwwxelX8G9ocxVagSkLPFzqtDmjtLwg0mzjc4dcn845hPm_6UPjBNb6Eza2Q==@protonmail.internalid>
 <20251023025356.2421327-3-vladimir.zapolskiy@linaro.org>
 <aa8d9d2a-a778-49b9-ad66-05bf31065856@kernel.org>
 <ff531ac2-26e0-48a4-a0f8-9e5c09dde05f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff531ac2-26e0-48a4-a0f8-9e5c09dde05f@linaro.org>

Hi Vladimir,

On Sat, Nov 08, 2025 at 01:00:33PM +0200, Vladimir Zapolskiy wrote:
> On 11/4/25 17:53, Bryan O'Donoghue wrote:
> > On 23/10/2025 03:53, Vladimir Zapolskiy wrote:
> > > +static int s5kjn1_check_hwcfg(struct s5kjn1 *s5kjn1)
> > > +{
> > > +	struct fwnode_handle *fwnode = dev_fwnode(s5kjn1->dev), *ep;
> > > +	struct v4l2_fwnode_endpoint bus_cfg = {
> > > +		.bus_type = V4L2_MBUS_CSI2_DPHY,
> > > +	};
> > > +	unsigned long freq_bitmap;
> > > +	int ret;
> > > +
> > > +	if (!fwnode)
> > > +		return -ENODEV;
> > > +
> > > +	ep = fwnode_graph_get_next_endpoint(fwnode, NULL);
> > > +	if (!ep)
> > > +		return -EINVAL;
> > > +
> > > +	ret = v4l2_fwnode_endpoint_alloc_parse(ep, &bus_cfg);
> > > +	fwnode_handle_put(ep);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (bus_cfg.bus.mipi_csi2.num_data_lanes &&
> > 
> > Is !bus_cfg.bus.mipi_csi2.num_data_lanes a valid case ?
> > 
> 
> Yes, it is a valid case, because a number of data lanes is unchangeable
> and the property can be omitted like in many other similar cases.

In that case make 4 lanes the default.

-- 
Regards,

Sakari Ailus
