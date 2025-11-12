Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E792874F1;
	Wed, 12 Nov 2025 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936851; cv=none; b=kSZ1nVVSaEFtTeMStfMmjb1MbaJb/z6BIiLsHHRdgQG90Tel77dB8qCllkXFCWFkgSSdkAsl9de26+DL+WzuHQVYnaYxqNR/sD4I6G0eqN2s/hvxZN915/zaUl2RWsSooP65PLNrqvj9ZjocXxyrCMVfmSsdqim9QfzBYbDAe7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936851; c=relaxed/simple;
	bh=lcwxQu/soNAypJWH0CYGVdZaDZ7OuY35lRb3v2Avqvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4Ad8uhKekz5Jt01Bb+I4+sTPTGHYawx2baFuaqwC1zU9UQLdcepc3HF/ID1GEDB0ybmPxNiLxD8Z0hAlkjTTxiJCltuEnHVpiVGA48A0I+kxyGLDqhdliUl5kD3cw042gVrU3SuekU641gznoJFKl2RQoR8EqIWxY8fYbi+qqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PWf9MxE4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PWf9MxE4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762936850; x=1794472850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lcwxQu/soNAypJWH0CYGVdZaDZ7OuY35lRb3v2Avqvg=;
  b=PWf9MxE4ecVK5wmGC6J6Ip80rcn0ShqohvP25Fbe6r5+c2TtsLTlRpcG
   JE5jI630qdjX9Ebv7e3iYQyrvQ8mpnrF9mYBXuttlKAZ6nYzX3ndu2LtT
   Gdy6lNZJs/psCsecXm3l6ssH0JVgoRzHet6JV18+Cq+BjxEaeu688l9fb
   dXVzRbCPSOSNg81NwIq/wvgRvimlP2oSIuJPRLiZsDqvdDk1nmgIKUypJ
   OIZuCbqjSKeh322WKEo4xTL4bTbxQfzgwsCauEpFcHepxCxHyaAjBrzA0
   3vXEzgUZRgYyJbeOQfAUWroPy/7YQeShJFwA7nhe2QbGTm7Fx4brtapwf
   g==;
X-CSE-ConnectionGUID: LHDDXmWJRAy7IjLeX/e4ew==
X-CSE-MsgGUID: RBbppXTaT6CpLMJkXehXaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="65032298"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="65032298"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 00:40:49 -0800
X-CSE-ConnectionGUID: N2bA1VYgQg2EALNKEfWvpw==
X-CSE-MsgGUID: TV49G5t0RLaSKNHCJZ0mkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="189130986"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.214])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 00:40:47 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id B81B9121DDD;
	Wed, 12 Nov 2025 10:40:44 +0200 (EET)
Date: Wed, 12 Nov 2025 10:40:44 +0200
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
Message-ID: <aRRIDCJqjdI-zu1f@kekkonen.localdomain>
References: <20251023025356.2421327-1-vladimir.zapolskiy@linaro.org>
 <zGlVBFnnqOaXjobqCKcCVXYYwfZwwxelX8G9ocxVagSkLPFzqtDmjtLwg0mzjc4dcn845hPm_6UPjBNb6Eza2Q==@protonmail.internalid>
 <20251023025356.2421327-3-vladimir.zapolskiy@linaro.org>
 <aa8d9d2a-a778-49b9-ad66-05bf31065856@kernel.org>
 <ff531ac2-26e0-48a4-a0f8-9e5c09dde05f@linaro.org>
 <aRMA_kd87a7rL-v0@kekkonen.localdomain>
 <d118401c-a238-4d76-ad85-7ff7449d606f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d118401c-a238-4d76-ad85-7ff7449d606f@linaro.org>

On Wed, Nov 12, 2025 at 04:39:49AM +0200, Vladimir Zapolskiy wrote:
> Hi Sakari,
> 
> On 11/11/25 11:25, Sakari Ailus wrote:
> > Hi Vladimir,
> > 
> > On Sat, Nov 08, 2025 at 01:00:33PM +0200, Vladimir Zapolskiy wrote:
> > > On 11/4/25 17:53, Bryan O'Donoghue wrote:
> > > > On 23/10/2025 03:53, Vladimir Zapolskiy wrote:
> > > > > +static int s5kjn1_check_hwcfg(struct s5kjn1 *s5kjn1)
> > > > > +{
> > > > > +	struct fwnode_handle *fwnode = dev_fwnode(s5kjn1->dev), *ep;
> > > > > +	struct v4l2_fwnode_endpoint bus_cfg = {
> > > > > +		.bus_type = V4L2_MBUS_CSI2_DPHY,
> > > > > +	};
> > > > > +	unsigned long freq_bitmap;
> > > > > +	int ret;
> > > > > +
> > > > > +	if (!fwnode)
> > > > > +		return -ENODEV;
> > > > > +
> > > > > +	ep = fwnode_graph_get_next_endpoint(fwnode, NULL);
> > > > > +	if (!ep)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	ret = v4l2_fwnode_endpoint_alloc_parse(ep, &bus_cfg);
> > > > > +	fwnode_handle_put(ep);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	if (bus_cfg.bus.mipi_csi2.num_data_lanes &&
> > > > 
> > > > Is !bus_cfg.bus.mipi_csi2.num_data_lanes a valid case ?
> > > > 
> > > 
> > > Yes, it is a valid case, because a number of data lanes is unchangeable
> > > and the property can be omitted like in many other similar cases.
> > 
> > In that case make 4 lanes the default.
> 
> 4 lanes configuration is the only supported lane configuration mode
> in the driver, so I believe there is nothing else to change. Perhaps
> the confusion came from misreading the given dt binding documentation.

Right now you're not setting any default for the number of lanes for
v4l2_fwnode_endpoint_alloc_parse(). Please add that in bus_cfg.

-- 
Sakari Ailus
