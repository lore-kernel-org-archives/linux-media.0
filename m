Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DFB1E51E0
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 09:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507083; cv=none; b=Vj2oekcRkEApkVT9MH2MSode+NpHs/kRxlpBbvlwuh2QfOOXfE6xrlBzwUp8RuKHDBjcpuTpCae31w/1R0TxHzr9mwdq4rrLhdlYgBL52zs4Dfps9D/LSVED8tiwS9wVpZVgGNp8mzZktiOClKXi35n2Mnjl2ulWffhSg9BcPPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507083; c=relaxed/simple;
	bh=Qz4zX/8crUeq6EwFctv/igfgaxk2y7x2TYFvtZQEtuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRffUlw7nYKxuIgAB1LCUq8HRF/bmvs0RBfXOuqkUIwd5PKBP8xf0FYlYupSSs3l5yh60KhwCwoJB+h5QNJvGyQxO74d2z0Gbbq2sGd74y7D5pH/MNMGcQpCnlpv1N+dmAIO9/I49L8VPQjJ3GFRYcJGNpEn5UHASj85WMWDnZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MDTdy3Nm; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDTdy3Nm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762507080; x=1794043080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qz4zX/8crUeq6EwFctv/igfgaxk2y7x2TYFvtZQEtuc=;
  b=MDTdy3NmItVRG1c450XCGbHrr+ulkcWQ0jfR7/iZHvfG5uU8FNagZXlO
   Q1PVFf+NqmOwHpfKEBjkaE3bxT38PtybAorMEdCVg2MsPpJtZTreSV3aw
   Cxd69u4MVJARA9bOGnUps+NYSK+ML22bl8sicyeMGLvt6Yt5TOvUqMZUq
   YMOdNslWXrgLoowzcGTz4boHwRWVvdUsiLstUJ36RK5Hp6T95myoRjak1
   XI3svLh36tAa8ywxyxOqxHC1LZ0cVYUC7mXn5znOgt/QF3B+T5KW4uF0v
   5bZrvQ22dIcxkc2XtuEznCc2fXkwtzF7TaNnID/7sOt2UWHbPx2M3eII5
   g==;
X-CSE-ConnectionGUID: erelWT9jT2m6zaleFRQ1nw==
X-CSE-MsgGUID: Lr/94GmySJuhArOOkqN6+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="68302742"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="68302742"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 01:17:59 -0800
X-CSE-ConnectionGUID: WQKFnYYRRZ2XQMDdwyZsfw==
X-CSE-MsgGUID: Mo02gvo6RQelMc86oNLYUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="187652646"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO mdjait-mobl) ([10.245.245.65])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 01:17:57 -0800
Date: Fri, 7 Nov 2025 10:17:50 +0100
From: Mehdi Djait <mehdi.djait@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Bingbu Cao <bingbu.cao@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org
Subject: Re: [PATCH 25/25] media: i2c: ov01a10: Register tweaks for ov01a1s
 model
Message-ID: <7fd4qbgendumnwahn7bqu7zyczvr6l3htbxxurq56cb6th7gyv@jncmh7kihgd6>
References: <20251014174033.20534-1-hansg@kernel.org>
 <20251014174033.20534-26-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014174033.20534-26-hansg@kernel.org>

Hi Hans,

Thank you for the patches!

On Tue, Oct 14, 2025 at 07:40:33PM +0200, Hans de Goede wrote:
> The out of tree drivers from:
> https://github.com/intel/ipu6-drivers/tree/master/drivers/media/i2c
> 
> Have a separate driver for the ov01a1s. This driver is 95% the same as
> the ov01a10 driver (same sensor, different color-filters) but there are
> a couple of registers for which the out of tree ov01a1s driver uses
> different values.
> 
> Add a per model reg_sequence to struct ov01a10_sensor_cfg and apply
> the register tweaks from the out of tree driver to the ov01a1s model.
> 
> Signed-off-by: Hans de Goede <hansg@kernel.org>
> ---
>  drivers/media/i2c/ov01a10.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov01a10.c b/drivers/media/i2c/ov01a10.c
> index 058ff311a289..08cab1e4be1d 100644
> --- a/drivers/media/i2c/ov01a10.c
> +++ b/drivers/media/i2c/ov01a10.c
> @@ -161,7 +161,6 @@ static const struct reg_sequence ov01a10_global_setting[] = {
>  	{0x3815, 0x01},
>  	{0x3816, 0x01},
>  	{0x3817, 0x01},
> -	{0x3822, 0x13},
>  	{0x3832, 0x28},
>  	{0x3833, 0x10},
>  	{0x3b00, 0x00},
> @@ -186,7 +185,6 @@ static const struct reg_sequence ov01a10_global_setting[] = {
>  	{0x4800, 0x64},
>  	{0x481f, 0x34},
>  	{0x4825, 0x33},
> -	{0x4837, 0x11},
>  	{0x4881, 0x40},
>  	{0x4883, 0x01},
>  	{0x4890, 0x00},
> @@ -203,6 +201,17 @@ static const struct reg_sequence ov01a10_global_setting[] = {
>  	{0x0325, 0xc2},
>  };
>  
> +static const struct reg_sequence ov01a10_regs[] = {
> +	{0x3822, 0x13},
> +	{0x4837, 0x11},
> +};
> +
> +static const struct reg_sequence ov01a1s_regs[] = {
> +	{0x3822, 0x03},
> +	{0x4837, 0x14},
> +	{0x373d, 0x24},
> +};

How about the 0x4800 register ?
we write 0x64 for the ov01a10 driver but the out-of-tree driver for
ov01a1s does not write that value

--
Kind Regards
Mehdi Djait
