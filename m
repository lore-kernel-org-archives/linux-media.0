Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8CA176FB1
	for <linux-media@vger.kernel.org>; Wed, 11 Feb 2026 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770810003; cv=none; b=aSc67NpimqSqZt62k4L+Ln85zlCpskIRYyHiMyaD9p1C1/blOjdzu8Oqn9i6y8xOru3d149A4gf2qTSNdwC7rKpmZr18QlpqfiSpvfJzY7Igk3IV16gdIiAI+gNAPCbpTVAt5ktgQw9ue2oMoON0I+Hi2oJh2UDfan+hrXaNg+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770810003; c=relaxed/simple;
	bh=ymna7XG/mgt9cPVj/mzXlWKIFK61h3fsbBYtrQuxwI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHYK4oeaLHbcqu5BgCeKOjjz2ZPUaTYjt5YC0Jk2nWz7UiG3D0dyuw1ru1E9TtjrRACHwa1uhk3kMQ/pbJ6Ae5FU9RbXXZ7AJZgRfVpHsuxu0xWkj8wjqahppSJ3ZZx8zJH5BOodbQhyfS9Emz18wv7COaugYqLa8oNzaxN5Z9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dkPCBULo; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dkPCBULo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770810001; x=1802346001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ymna7XG/mgt9cPVj/mzXlWKIFK61h3fsbBYtrQuxwI8=;
  b=dkPCBULodJHDFdrrCX/KNSkHqAbaNkkSzbSIkCLFtgtd19HtrJR13qXW
   bjyvGq9cc+gUpQcSbCMwFAskpqYSFTKh4aQY4zO9PYxLQ8QBK9BrahpJR
   488DUgFwBi4KlIC+05syipFWZKgcZzWtTf9jwADEvp/VDNJqDpdORn0LJ
   zhsWjKe3is2MeTXW4mlXLcqFPPbaOzd+6EFI2W+qNbtTX4uocArcqDEMk
   rLpi8/LUDe0f8C6LNQKPmRcIbQV35eyacuibvwJm4SdsFcaPMr0ipxaME
   tn6R8b8mcHG2glxI2OPFZg3syDhTuGXkbdPJnTLo1lH5WDBFRXeasQgTF
   Q==;
X-CSE-ConnectionGUID: GG8sY8YvQ/KL5z7RTV5rrg==
X-CSE-MsgGUID: eax1MuWjSrWyDW1WtCCIUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="59523598"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="59523598"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 03:40:00 -0800
X-CSE-ConnectionGUID: cI6Q/kuaRxSx7rwSrOdaQw==
X-CSE-MsgGUID: FZdzEVvoRuSNYZaQ2r0OxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211169810"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.220])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 03:39:58 -0800
Date: Wed, 11 Feb 2026 13:39:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: johannes.goede@oss.qualcomm.com
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, soufianeda@tutanota.com,
	linux-staging@lists.linux.dev, Andy Shevchenko <andy@kernel.org>,
	linux-media@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] staging: atomisp: fix heap buffer overflow in
 framebuffer conversion
Message-ID: <aYxqjBSI-t8Jk9UF@smile.fi.intel.com>
References: <20260210-atomisp-fix-v1-1-024429cbff31@tutanota.com>
 <aYt-vrc7h7CJOmSu@stanley.mountain>
 <aYw5q_gsHOmKAIhK@kekkonen.localdomain>
 <8efb3705-42f3-40c5-9631-d72eb2dda74a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8efb3705-42f3-40c5-9631-d72eb2dda74a@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 11, 2026 at 12:28:35PM +0100, johannes.goede@oss.qualcomm.com wrote:
> On 11-Feb-26 09:11, Sakari Ailus wrote:

...

> This will cause a bunch of code to turn into dead code, but I would
> like to keep that code around since when we add support for
> a parameter buffer queue that code can serve as an example how to send
> parameters to the ISP.

But it's forever in the Git index, we can remove it, so it's just matter
of convenience to keep it in a working copy (tree). That being said,
I would rather drop the dead code to avoid a stream of not-so-useful
white space, style, and similar cleanups.

-- 
With Best Regards,
Andy Shevchenko


