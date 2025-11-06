Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D33834DCCE
	for <linux-media@vger.kernel.org>; Thu,  6 Nov 2025 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445852; cv=none; b=iRcGrOirejmCJpt30EyrqK6FPVG87bLxchOffnpPHZJod2/LKNrd20B40vwMCsoZJiXBkBusy4Yoa63geJLcDUuJCNqBGvO0dDU2rfqaHr97a1J1XNCuhMWokGs/Yrfd3TLYlbXYqDhsCUibA+vFC5vXJkSUrfMxKSAYx5ilIV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445852; c=relaxed/simple;
	bh=jPP5FcI4aZM/9sM238IOLgpV5FaR1m+9+gsQMNQmxp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZlZfdhwVkvUvlCCrC+Xgr6LO+MIHxG5Iguj7J6yS8TLP3Cr4Yvu+D5Z3xKWpF4AG/5V8k82K3XSD7rAr0pUTwc3iuG0Em3b/41tkzMFXxTuzqDSXNycyHUsx6vkKa7BXFP6bcAgA9SH+PWCi/LwzvE4GBZnxal1Bau6g0ozMAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V57OBp+i; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V57OBp+i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762445850; x=1793981850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jPP5FcI4aZM/9sM238IOLgpV5FaR1m+9+gsQMNQmxp0=;
  b=V57OBp+ibV00u1QYQGYnn9m/csS8OLhZBeq0VweYosPHpTZLEDHY0B+X
   074Ml69gCEP8m+GBaZ5X3RMSpEwdwuHukuOpszgKRaSJsxCQjTLxfTkmN
   qKIcgEuoi7ydwF+LTSu6rFgsujzoaQnQANWKyKEqpfMmKseyZBZmKU07b
   0cOWi/vgI0H9P14Mj5tHspeIH/WruXBi86R6lDnvkRFRMekpiyY20tHVM
   F0oMjmREpk9ZWjpchJ8YRxH1/lH+356iSTf9WW/HwM+XHdDnbDetWJuCF
   vs0SzqWPSlwDB0svRmg7sc8qjR6oHP5n9G9jGejE9fJ+eTcjuKhbwttx0
   Q==;
X-CSE-ConnectionGUID: WRfv4txxTTu0d37lNW+j+w==
X-CSE-MsgGUID: XmA3IctxTAmWCQ+ZySTGJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64495864"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64495864"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 08:17:30 -0800
X-CSE-ConnectionGUID: kTm9MCf6RhOv/EMmkq+ZaA==
X-CSE-MsgGUID: MKxrEEDpT02YA7MPJ9cquQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="225044131"
Received: from abityuts-desk.ger.corp.intel.com (HELO mdjait-mobl) ([10.245.244.232])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 08:17:28 -0800
Date: Thu, 6 Nov 2025 17:17:21 +0100
From: Mehdi Djait <mehdi.djait@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Bingbu Cao <bingbu.cao@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org
Subject: Re: [PATCH 24/25] media: i2c: ov01a10: Add ov01a1s support
Message-ID: <dowgswzazkmp32efd7ssos7hkigr6kipvqf7td7o7shzovyaca@vjozoktedctv>
References: <20251014174033.20534-1-hansg@kernel.org>
 <20251014174033.20534-25-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014174033.20534-25-hansg@kernel.org>

Hi Hans,

Thank you for the patches!

On Tue, Oct 14, 2025 at 07:40:32PM +0200, Hans de Goede wrote:
> The ov01a1s sensor is the exact same sensor as the ov01a10 with a different
> (RGBI) color-filter.
> 

Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>

> Signed-off-by: Hans de Goede <hansg@kernel.org>
