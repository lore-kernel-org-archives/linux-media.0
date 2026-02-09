Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C77C309DDD;
	Mon,  9 Feb 2026 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625757; cv=none; b=berSTfRwHSW/z9UpoNHNb2fBMD2QGNChwPIzDV+tI5oDGLZ1HVwRM6ReMqcYRM+riRmtzLDkcQDX+Y3At/EbnOjoXyMPOCP9JSDI2T7DEa0Zuy1if5ImoQkMvFwOjkOUhdpHw2rYm0SyjEQLMEPqeNIntjXffCy5v1mqSmJR0jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625757; c=relaxed/simple;
	bh=dvzIHPQ7GaLSFpnJJaiAbUd8dzXpghvAu+vAhrDnzUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5SfHzPnfcLDw633DK7lJGYStMMEC2WM1CkZ3nMH8qL0yjYJpdf9fF70Se5ZUh83Ow4qZbKvTrB7epoHjCEeyZ1F/qAjHQ3mbCQtTgl/KtV8Jj9OJhqLzGQKZjKeaxI4cuG1J9wAsDj5ry7nfdiRcZ9v1voze7FN88N2zODH7Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QDhDG42F; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QDhDG42F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770625757; x=1802161757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dvzIHPQ7GaLSFpnJJaiAbUd8dzXpghvAu+vAhrDnzUg=;
  b=QDhDG42FflPwxdB95yGZ9Ul3ij/9nrO7HXF4TtGj8GHqlh1MtXuPEmWC
   b1HZzn+7VMuM5uu2Nuq11cWpmJcBfPm9BR7B4OK0oIppwn0JHYahhcF9H
   lAKvMF50ywfeN5Rr4AKA26pHmblkEIff8OdjHXrGPn7AMpfTrRiqSIrYG
   cn8IrvaEonw8k9pRLKYGbrEu457tV/yd1UQL0ITOQ01CyFnmv4eWPxCbE
   WkYpBG8WgKKyneRwmYhSaiSKLyq+FaE8AEpA3O1ggaG1ltIOxnN6SwS6T
   WMkAgQcbutxDlr+dQU5dmLAq+k7ATgUxSWRMEK+PwkNAltAhYCCZRHWYi
   g==;
X-CSE-ConnectionGUID: I6IrNhR4QXaqdejFbMBsMw==
X-CSE-MsgGUID: e4t3dRHhQfu8NAYpntCtYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83102995"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="83102995"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 00:29:16 -0800
X-CSE-ConnectionGUID: s/skDE+tS16gchFrwVq3qQ==
X-CSE-MsgGUID: SCgjC5HaQlm2ibKMwL+tZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="216488546"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.128])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 00:29:13 -0800
Date: Mon, 9 Feb 2026 10:29:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Taekyung Oh <ohxorud@ohxorud.com>
Cc: Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: media: atomisp: remove dead code in ov2722.h
Message-ID: <aYma13Z6IGID8o4J@smile.fi.intel.com>
References: <20260209045514.40352-1-ohxorud@ohxorud.com>
 <20260209045514.40352-3-ohxorud@ohxorud.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209045514.40352-3-ohxorud@ohxorud.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 09, 2026 at 04:55:57AM +0000, Taekyung Oh wrote:
> Remove unused code blocks enclosed in #if 0 to clean up the code.

This should be Acked by Hans, as he knows much more about the state of affairs
with this code. My memories tell me that this (in long-term) should go away.
Since the patch just (partially) removes the code, it's probably fine to have
it as it.

-- 
With Best Regards,
Andy Shevchenko


