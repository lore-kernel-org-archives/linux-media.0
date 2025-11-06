Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EEA28A1E6
	for <linux-media@vger.kernel.org>; Thu,  6 Nov 2025 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443233; cv=none; b=RzUZ0hGkl38a4/A4raxOee9ohGdzkGZpNsuZrocqJoCh4+XqVZ5U9DqzkXPJRcf+JqVuF75QpIIQHlWKRchOHFVH3339U5cdm4B3bbCKyVU5EsNuhoD1JjR+goEqMj6JfPODtiFtDxHoUmf9ffqU/MoUeXX6kuskfuediFICDFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443233; c=relaxed/simple;
	bh=cd0Fm3P70XxetoCCKlCRtZMuLhFvrNbqcECFcF0KR48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mp5c9KhhZIzLRE60pqpnzrwea5wZmHgGT4AaTWI7yg3TP7xzPXcVEqZ6M8s7VB51Opqzu+20x88L86U1Em/r7BYPbb5MT/KlqfW70yjqKE2um2jnuxA+BJzfvIc90/w9Ah0bWP97eFhs0ZPYURbEMFWStQ5bzX4ygPBtkSlxEEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lDBLLSGp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lDBLLSGp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762443232; x=1793979232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cd0Fm3P70XxetoCCKlCRtZMuLhFvrNbqcECFcF0KR48=;
  b=lDBLLSGpA/g0jZXeofTVYph51Q+NJH6rKej+fZaay5XOjg+RDMlFspec
   h1TKcEqdozUwi3Tj/+PmK9XZ8DTwtARLijIB6PL5ZOrkLK80x1Hbz2xLH
   8vRcUu6SykCTRP+nrqvtaekP+X2ycNtGctIeV3HKAjv4Er3C65zvw64wz
   pvR4EZJ814vhqWyeLILTqUTub/T9LEztOUZtjUG+mCtpNMa6yWAYWRgeJ
   iDPnDndk2WnykpVTd4KpIPk4c1OAm6ju3zJsf78zAIbQVXGC+R3Vx3wCh
   Kei26C32dGFly64hRNuB4pEfQ6j0cxibYDyZuCBr1guct3kssXWRZQGTv
   A==;
X-CSE-ConnectionGUID: 8NT8RcWaSp+ubvLtWbe6CQ==
X-CSE-MsgGUID: c+NhNj0jTZGy+65ajIaH/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64619985"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64619985"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 07:33:51 -0800
X-CSE-ConnectionGUID: UprwXaaSTCajyV1fvSt2Hw==
X-CSE-MsgGUID: 1vFdDWYJQy2m36ayy/+l7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="192833898"
Received: from abityuts-desk.ger.corp.intel.com (HELO mdjait-mobl) ([10.245.244.232])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 07:33:50 -0800
Date: Thu, 6 Nov 2025 16:33:43 +0100
From: Mehdi Djait <mehdi.djait@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Bingbu Cao <bingbu.cao@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org
Subject: Re: [PATCH 21/25] media: i2c: ov01a10: Add ov01a10_sensor_cfg struct
Message-ID: <dhlugx6b32eb7bf6zeplrqednj5c3m5worxhi3ckvqwrncga3p@whmwypier2ev>
References: <20251014174033.20534-1-hansg@kernel.org>
 <20251014174033.20534-22-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014174033.20534-22-hansg@kernel.org>

Hi Hans,

Thank you for the patches!

On Tue, Oct 14, 2025 at 07:40:29PM +0200, Hans de Goede wrote:
> Add a struct with some sensor variant (ov01a10 / ov01a1b / ov01a1s)
> specific settings.
> 
> This is a preparation patch for adding support for the ov01a1s sensor
> which uses the same sensor with a different (RGBI) color-filter.
> 

Tested-by: Mehdi Djait <mehdi.djait@linux.intel.com> # Dell XPS 9315
Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>

> Signed-off-by: Hans de Goede <hansg@kernel.org>
