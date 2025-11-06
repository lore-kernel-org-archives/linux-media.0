Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE134FF55
	for <linux-media@vger.kernel.org>; Thu,  6 Nov 2025 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445809; cv=none; b=hWjelkirWXBN682u8mmeq0SUE1wpWCWw4PnYOddGt5yd2I7iMJQg6LOwoq0ckwN7XBe/LMjNyG+rmfCpu4DL8AoUzjReZeVwATFmllmM0utNtQ2JfWpuz/s7XwkcfMvEvkysnCwEhloBdmKTxjMkeuHZltxujIUfavOEd9tCnzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445809; c=relaxed/simple;
	bh=dioPofanP7H7hwzvFJWPHwj4gHyxX2pVOJHZrSIfIu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaSCliN6oZNJnG8wUg1rQCQGkrfUANwgea8NhmCKjfB5QkSXM0NMB3oJF+n/pIsdA3694ebTyMUki9MdsFw6nXytTVmNPL6tvse+YqTkmSCe2OnHY3bONJtDMI5haKH/ySa52047CbuX8Gak8EWrt+zvQ/zOCGEy5vmxVsqREMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ByKOsttU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ByKOsttU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762445808; x=1793981808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dioPofanP7H7hwzvFJWPHwj4gHyxX2pVOJHZrSIfIu0=;
  b=ByKOsttU1M0kr95JXCVrnCRBTAFlDeEB8QHdc9c0qVIOyuU1Enn56Abb
   pLa/vMYL9WTu2GMval8FCv4e1HbDqX/eYeAuFWYIfZ3K9Nwqsr5OuZU7U
   7rWUwucM+1YHRAd06BqM0Nwzn3kz+XU+mwyVjRApgiYKjJDSey8AZBWal
   JocQYfsTtHYgZHt3LosONeAlZNSHqkzqhzZoSuHUq6YhfqcJRZ1wOXltT
   9LwS5OnUuhvHggr3JZs/yvmOlq0Eg/L9fKujlgHR+jlGYPd9xWIqpg2AS
   P5+hxeKrPeQAjddHj3CXZm2Hz6N8eSiw/Y76p59QAxVXobALPzyMmNXjv
   A==;
X-CSE-ConnectionGUID: sxZAmHN3TXO4US0aOSqcQA==
X-CSE-MsgGUID: SWHl+tTAS7GsFcMahKXdvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="63793962"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="63793962"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 08:16:47 -0800
X-CSE-ConnectionGUID: rMfSUbHJSv+erdW+R7V3pw==
X-CSE-MsgGUID: LuJueuudRNKJisGPFPgcVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="218456011"
Received: from abityuts-desk.ger.corp.intel.com (HELO mdjait-mobl) ([10.245.244.232])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 08:16:46 -0800
Date: Thu, 6 Nov 2025 17:16:37 +0100
From: Mehdi Djait <mehdi.djait@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Bingbu Cao <bingbu.cao@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org
Subject: Re: [PATCH 23/25] media: i2c: ov01a10: Add ov01a1b support
Message-ID: <ptahcygyk77neqbonl23ks6icrprdgvslzunnokyg3rystajwg@jqvnxlyagal3>
References: <20251014174033.20534-1-hansg@kernel.org>
 <20251014174033.20534-24-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014174033.20534-24-hansg@kernel.org>

Hi Hans,

Thank you for the patches!

On Tue, Oct 14, 2025 at 07:40:31PM +0200, Hans de Goede wrote:
> Add support for the ov01a1b model which is the exact same sensor as
> the ov01a10 without a color-filter.
> 
> Note since there is no color-filter there is also no need to shift
> the crop-window when flipping, so the crop window set by userspace may
> cover the full sensor (border_size=0).
> 

Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>

> Signed-off-by: Hans de Goede <hansg@kernel.org>
