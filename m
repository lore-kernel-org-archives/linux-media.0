Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFCE21D3F8
	for <linux-media@vger.kernel.org>; Thu,  6 Nov 2025 15:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444486; cv=none; b=ZkIZ8R+D5ZMzP19ifqmtwv/l9nNnX8LiiLj/q2BjI7Qdqdegj7NenBhDnkc7A/2MproMVhwwRrp1/RM2RRa4aE9hrJayaSROgUl/sZYKf2TVMcFXHRifT9suFWjuXGoNr6hs75vJqjXs0ri2M+D1xodUo/8x+STw4HMPUBFq7HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444486; c=relaxed/simple;
	bh=lxQUdZbZwLaw2xc2v8uDCXIVeOWzrpSpsHc771cymvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYnp2wz5MGTG8TZDiUCxlOAeKbpcOGC/Mz7jBDh7Nij77zFvHgtHDkJHKci2oVOqYuPRRmWbEYUF+X3yFfwhcEUSaXqJDfVaZWCsxdpfS7wMYEJoIvqf6CRGScQxBDAnl8TqMoJrHi6N3QjLf/lS1UfTelUT1+l6NREMB+8kyS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iZvLT/KP; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZvLT/KP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762444485; x=1793980485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lxQUdZbZwLaw2xc2v8uDCXIVeOWzrpSpsHc771cymvc=;
  b=iZvLT/KPstOhDF28VwFnO5lJIsIB+1kfMu2Q6xYn48qm2XHcRDUGdwey
   luZG/e098n2+haZ8qpQq4UchhfbO12Ext4AWdi9829OeA9JwhKGpY++9S
   Dxx56+fbRtDVg27QgcVZ/Oy3oxrTzKaIrD20WP3LTiIhIISE+6nMEkKms
   D+esvH8z8KAzJr0SM04SOL0Ug6Q4Zy0FaZtWrZdvplajfR8wRxk2E2ZZt
   0sVPY8SDbpY103UQhwL8qnI6VLiG8mKTAbXCqaE6oKvps+3zf3eQjt62m
   X4V2O3ptRpnj8lzQdSp7e3Eo1sQURi7faXGPZ+VWxd5DOr9LZHWSy/kr/
   g==;
X-CSE-ConnectionGUID: DyD9ay6iQxuoXTI8CAAnzQ==
X-CSE-MsgGUID: YwdvG+q8SmasRfyEV6xOpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68423124"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68423124"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 07:54:44 -0800
X-CSE-ConnectionGUID: rotSijAgRAawyuCBgeex0g==
X-CSE-MsgGUID: CMH2uCd6TGG88SbP9cTpXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="188074177"
Received: from abityuts-desk.ger.corp.intel.com (HELO mdjait-mobl) ([10.245.244.232])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 07:54:42 -0800
Date: Thu, 6 Nov 2025 16:54:35 +0100
From: Mehdi Djait <mehdi.djait@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Bingbu Cao <bingbu.cao@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org
Subject: Re: [PATCH 22/25] media: i2c: ov01a10: Optimize setting h/vflip
 values
Message-ID: <zniomy6xe6blff456jiavzsodfk6jz2owyip2z5abpfj7wlhld@uagt7rls7nae>
References: <20251014174033.20534-1-hansg@kernel.org>
 <20251014174033.20534-23-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014174033.20534-23-hansg@kernel.org>

Hi Hans,

Thank you for the patches!

On Tue, Oct 14, 2025 at 07:40:30PM +0200, Hans de Goede wrote:
> Since ov01a10_global_setting[] sets the initial format1 register value,
> there is no need to do a read-write-modify when setting the flip controls.
> 
> Only write format1 when setting the flip-controls and remove the now
> unnecessary format1 register init from ov01a10_global_setting[].
> 

Tested-by: Mehdi Djait <mehdi.djait@linux.intel.com> # Dell XPS 9315
Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>

> Signed-off-by: Hans de Goede <hansg@kernel.org>
