Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64702315D43
	for <linux-media@vger.kernel.org>; Wed, 11 Feb 2026 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770800371; cv=none; b=uxyeyhIdTNZSZop3YwFkzuqxVVVYnlVKqDvH4ZDLwu8eyKLkjjJTqCYBFVZz837Bc4VnRM5B6IEjK6yz1g19FIHEP6B92RyRfK0KclvrK7t4EqaqlKo/LjHu3UwA4WJkb3T+aNFikdHeLnHH1V2ZUg9MWGcuqFpt5qg+Ml7aUq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770800371; c=relaxed/simple;
	bh=DfFVq71FEOUGBeTctt3BnYnzZLVcjBzQqGE8eGSnI28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUn0WAWQhWABNl9s7VsY/NsiDLxUMfuKTxWoFZk0AuwnRDWbvvnhHT2CoVLD/t6YR5Y4WSKpuL/es6E0UTBXEXmPYYE5PKIuIAA+DH7w9ugTP1EKuBSVb6xIisjJ9CDN6Kk9VXQB7D8/RNVYhVOQrf+Qq3sx4s8V3QXSMj7veck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=INM27KAH; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="INM27KAH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770800371; x=1802336371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DfFVq71FEOUGBeTctt3BnYnzZLVcjBzQqGE8eGSnI28=;
  b=INM27KAHd/j7Ly8PGOJ2Yj1W76kwpDM7CpECysTSEVYKU/cdxNKDory3
   x89wdo1BqRpjFYu7nOGxfO8Mn1V6X5FDkbBMZPyPx0s5DcQxyCqUaRXsr
   YTawREDx1mFs58/lcqgNR0ViteK0o28hvoyTSZMe4wDE4yLyVHMtHc68V
   +g5jC3/6FMBcDDyTs7mECu5SNmWPmLvW1MmHLKBClQdgZGIFV8QlRIZEY
   jpmIpIVPULs25v8B+45X2zzzFGHj5eif1HtqraL35zeUqSHtXN9Tr4BU/
   a36Qqlj5YwohwruF/40X8EDuOKKtjUwkFgOEHweM1sFwJFl61+oDLLEjR
   A==;
X-CSE-ConnectionGUID: ezhh0RljQDGGru1UhX2dkg==
X-CSE-MsgGUID: z/qu2ZTVRSC/klrrPhy6lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="72016838"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="72016838"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 00:59:27 -0800
X-CSE-ConnectionGUID: p+yfe89HQbKKM0vM4S1wbw==
X-CSE-MsgGUID: WiSaUrb3Q6CNZk76afPCpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211297044"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.220])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 00:59:24 -0800
Date: Wed, 11 Feb 2026 10:59:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, soufianeda@tutanota.com,
	linux-staging@lists.linux.dev, Andy Shevchenko <andy@kernel.org>,
	linux-media@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] staging: atomisp: fix heap buffer overflow in
 framebuffer conversion
Message-ID: <aYxE6iMhwwqiLZpD@smile.fi.intel.com>
References: <20260210-atomisp-fix-v1-1-024429cbff31@tutanota.com>
 <aYt-vrc7h7CJOmSu@stanley.mountain>
 <aYw5q_gsHOmKAIhK@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYw5q_gsHOmKAIhK@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 11, 2026 at 10:11:23AM +0200, Sakari Ailus wrote:
> On Tue, Feb 10, 2026 at 09:53:50PM +0300, Dan Carpenter wrote:

...

> Beyond that, even I have to admit I have little idea what this
> IOCTL is supposed to be doing. Possibly feed in a raw frame for processing?
> But that's not supposed to be implemented like this... The TODO file
> contains an entry that says "Remove/disable private IOCTLs" -- we should
> move to use parameter buffers instead.
> 
> I'm not sure anyone depends on these IOCTLs at the moment, but definitely
> some obviously are associated with some risk.
> 
> The world looked different when this code was written.
> 
> I'd disable all private IOCTLs in the driver, with the possible exception
> of ATOMISP_IOC_S_ISP_PARM, which is close to the parameter buffer approach
> already.

I agree with a caveat (see below).

> Also cc LMML, Greg and Andy.

Perhaps also ask Hans or other people from libcamera? What does that use when
it comes to AtomISP?

-- 
With Best Regards,
Andy Shevchenko


