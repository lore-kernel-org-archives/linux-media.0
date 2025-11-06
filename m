Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A31721D59C
	for <linux-media@vger.kernel.org>; Thu,  6 Nov 2025 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442918; cv=none; b=ikmI6C5QGwaFM58hfNWtFa0MVyF2QD3rDMMHV3+dchbj3sW0QFGbD5iJVPBjoyloPJdRRTEjsuzYn9F1sONzPuH68GjEEZ/EEPh60wNxXmUIyTVM7fOrq2qg0ziQaUmfW/IKjzJOpUx/THCVzqZ5LXG0zlafL399lc9bBBe/V/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442918; c=relaxed/simple;
	bh=z3rafII3GZVVdLj7QkBVWwycgU2qXok4k+OYmj6mPMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHaN8gr/B/OBIEGeoTmlJ8YhlwhmGTjbn/CRH6dd9QKAC1pdVXfzNKFSk2grEFRGVKvtBT++SBcs4DPz2F4QxR7/S2qG4Gu6RRZsKMHrPZv/3G233zbolw9Slfi3aCihTQyxsMLWs0A/VgH3gy7MqvEnomS0fOHpqFU9qMKi/DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YalrXv9h; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YalrXv9h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762442917; x=1793978917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z3rafII3GZVVdLj7QkBVWwycgU2qXok4k+OYmj6mPMw=;
  b=YalrXv9hkwzP/tZAREz/BhusOC0wsLhXX87bcQdMWdAZReAm+zReJqWE
   cXLUxQjqNtaAVwftrHE5/Nk5JbA3IAb1WhqwEPOo28vqKoChvMlYDJ3Nm
   PDge3kMjkD5vkXENd9EkqO+kF0L48MuzBfddsdel7OfVjyYGG5cqbrkZ5
   mZ9PVwai82shVaidv7mmH61rKbTBDGk84/gYv2PDaHGUsv8AbARw4YMhL
   i36Hu4cgILXKnU6HGrlqjQ0KgaDFWZ9uXaxCl+u0YsHoPAwBsgsWQnfbp
   kyi3cY3sid56aAzIoazzo+cvBooS3ljLMeVtPdtZOovVE1EfVTgBMpaPL
   g==;
X-CSE-ConnectionGUID: AvsfVXMgS4OJVQKPnEl9aA==
X-CSE-MsgGUID: l3Le9NgYTia2kFy+l+KsZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64676862"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64676862"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 07:28:36 -0800
X-CSE-ConnectionGUID: UrKIdx1QRKOAvO2AXqfifg==
X-CSE-MsgGUID: KcV2QMtNSQyD0ATWi5HhxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="188502162"
Received: from abityuts-desk.ger.corp.intel.com (HELO mdjait-mobl) ([10.245.244.232])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 07:28:35 -0800
Date: Thu, 6 Nov 2025 16:28:28 +0100
From: Mehdi Djait <mehdi.djait@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Bingbu Cao <bingbu.cao@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org
Subject: Re: [PATCH 16/25] media: i2c: ov01a10: Add cropping support / allow
 arbitrary sizes
Message-ID: <eswyokov4fzty53fkdyzmifhhuu2mkgsnc4nb5c6vbwpj4xosd@yipyaigpxa7p>
References: <20251014174033.20534-1-hansg@kernel.org>
 <20251014174033.20534-17-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014174033.20534-17-hansg@kernel.org>

Hi Hans,

Thank you for the patches!

On Tue, Oct 14, 2025 at 07:40:24PM +0200, Hans de Goede wrote:
> Remove the fixed mode list and add cropping support. The main reason for
> doing this is to allow libcamera to select 1292x812 instead of 1280x800
> so that after the extra border which the CPU debayer code needs libcamera
> can output 1280x720 instead of 1276x720.
> 
> This in turn allows google-meet to use 720p instead of it falling back
> to a pretty bad 360p.
> 
> This has been tested on a Dell XPS 9320, with both libcamera as well as
> with Intel's out-of-tree psys driver + proprietary userspace stack.
> 
> Libcamera asks for 1292x812 where as the Intel stack asks for 1280x800
> and neither stack explicitly sets the crop-window. Hence the need for
> ov01a10_set_format() to adjust the crop-window if necessary.
> 
> Note the differentiating between pattern_size and border_size is done in
> preparation for adding support for the monochrome OV01A1B model where
> coordinates still need to be aligned to a multiple of 2, but there will
> be no need for a border (border_size=0).
> 

Tested-by: Mehdi Djait <mehdi.djait@linux.intel.com> # Dell XPS 9315
Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>

> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2337593
> Signed-off-by: Hans de Goede <hansg@kernel.org>
> ---

[..]

> +static int ov01a10_set_mode(struct ov01a10 *ov01a10)
> +{
> +	struct v4l2_mbus_framefmt *fmt = ov01a10_get_active_format(ov01a10);
> +	int ret = 0;
> +
> +	cci_write(ov01a10->regmap, OV01A10_REG_X_ADDR_START, 0, &ret);
> +	cci_write(ov01a10->regmap, OV01A10_REG_Y_ADDR_START, 0, &ret);
> +	cci_write(ov01a10->regmap, OV01A10_REG_X_ADDR_END,
> +		  OV01A10_NATIVE_WIDTH - 1, &ret);
> +	cci_write(ov01a10->regmap, OV01A10_REG_Y_ADDR_END,
> +		  OV01A10_NATIVE_HEIGHT - 1, &ret);
> +	cci_write(ov01a10->regmap, OV01A10_REG_X_OUTPUT_SIZE,
> +		  fmt->width, &ret);
> +	cci_write(ov01a10->regmap, OV01A10_REG_Y_OUTPUT_SIZE,
> +		  fmt->height, &ret);
> +	/* HTS register is in units of 2 pixels */
> +	cci_write(ov01a10->regmap, OV01A10_REG_HTS,
> +		  OV01A10_HTS_DEF / 2, &ret);
> +	/* OV01A10_REG_VTS is set by vblank control */
> +	/* OV01A10_REG_X_WIN is set by hlip control */

nit: typo here hlip -> hflip

--
Kind Regards
Mehdi Djait
