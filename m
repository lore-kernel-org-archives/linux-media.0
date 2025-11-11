Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E856A23183A
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762851328; cv=none; b=DWsjnz8+s4vWk5eL2sGDLIMfswYFJDXeHmy7hfhH81LTaZbZ7/7/xC5W9/nkq/X8kF8B+Hw066tMGzj4jfIyqyZbCxpydXKuyrIcol9FVMlDN/4iSpyY9NJa/KPJa2DSRo+FDNWJUN+dq2zI7dHJPdfdKNfBZZxgw1yB+I5FlVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762851328; c=relaxed/simple;
	bh=EG56e5gtJIoW9d9/7S20iEdh9HJqkXltPCJ+tYnVg/4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=By+XpC0ZDwA6K4LgrZFUbZsX/vdG9Sm8pLA/eFbzkhpQRkByKfdMDQmzrMXRuwtVqyimWI5/jHOPCMGx6OmrnDSdl4qfVm0Sjsc8Rks7ZJOwjy7Us2/U1QxVyvxneiXGA7aAZOmsrNpkSenIR8ZSCn2DTwx8/R8yB+68rhIR+6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j6vHIGeV; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j6vHIGeV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762851327; x=1794387327;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=EG56e5gtJIoW9d9/7S20iEdh9HJqkXltPCJ+tYnVg/4=;
  b=j6vHIGeVU07VF+mLZlohfOtYnbxWyIOmO/mqhRO9zQB+giqyOC016w1M
   H12YpQ7NOWJMKsD1AxCdG6tCNiVD+e84Ruzq+/Jg7TMN5Iu7SIjQLd1mY
   92/5BNNp6bnOfHc2ifg6UbwxfJkBgdy0M7DQz6T0DCxVhxxUoUbPqheHo
   cL2c5DwPMYN6GHBaJxygRi/pJkY46tt9NwUq72dAG0tc48pZXMWJc68tt
   xFqxe9JWEGnbvKaar4Cp2dMSc5i3kaWKZ3sGahgSqB2Sff5wmSq48lkV1
   8Y+VOF571efSzEm8KP88RY4GDIsJO8/yMokWlJUlVV3MrLvKwwGGbpWFb
   A==;
X-CSE-ConnectionGUID: +K93ELlaSyi22I1Do+Cj+w==
X-CSE-MsgGUID: i4LxKTV4SIW1FgbfraS2tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="75593916"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="75593916"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 00:55:26 -0800
X-CSE-ConnectionGUID: g+bUTiJ6TgOBJaBXkCLNzA==
X-CSE-MsgGUID: gx9RhGswQxqH9LPKVEr1ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="188234685"
Received: from ipu5-build.bj.intel.com (HELO [10.238.153.130]) ([10.238.153.130])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 00:55:25 -0800
Subject: Re: [PATCH] media: ipu6: isys: Add support for monochrome media bus
 formats
To: Hans de Goede <hansg@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>
Cc: linux-media@vger.kernel.org
References: <20251020153741.55404-1-hansg@kernel.org>
From: Bingbu Cao <bingbu.cao@linux.intel.com>
Message-ID: <8a2f06b1-57dd-8a17-e884-b495d05f14d8@linux.intel.com>
Date: Tue, 11 Nov 2025 16:46:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251020153741.55404-1-hansg@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hans,

Thanks for the patch.
Reviewed-by: Bingbu Cao <bingbu.cao@intel.com>

On 10/20/25 11:37 PM, Hans de Goede wrote:
> Add support for monochrome media bus formats, for use with monochrome/IR
> camera sensors.
> 
> This has been tested on a Dell XPS 13 9320 with OV1A1B IR sensor.
> 
> Signed-off-by: Hans de Goede <hansg@kernel.org>
> ---
>  drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c |  4 +++
>  .../media/pci/intel/ipu6/ipu6-isys-subdev.c   | 34 ++++++++++++++-----
>  .../media/pci/intel/ipu6/ipu6-isys-video.c    | 14 ++++++++
>  3 files changed, 43 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c b/drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c
> index d1fece6210ab..daec6b865bda 100644
> --- a/drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c
> +++ b/drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c
> @@ -42,6 +42,10 @@ static const u32 csi2_supported_codes[] = {
>  	MEDIA_BUS_FMT_SGBRG8_1X8,
>  	MEDIA_BUS_FMT_SGRBG8_1X8,
>  	MEDIA_BUS_FMT_SRGGB8_1X8,
> +	MEDIA_BUS_FMT_Y8_1X8,
> +	MEDIA_BUS_FMT_Y10_1X10,
> +	MEDIA_BUS_FMT_Y12_1X12,
> +	MEDIA_BUS_FMT_Y16_1X16,
>  	MEDIA_BUS_FMT_META_8,
>  	MEDIA_BUS_FMT_META_10,
>  	MEDIA_BUS_FMT_META_12,
> diff --git a/drivers/media/pci/intel/ipu6/ipu6-isys-subdev.c b/drivers/media/pci/intel/ipu6/ipu6-isys-subdev.c
> index 463a0adf9e13..869e7d4ba572 100644
> --- a/drivers/media/pci/intel/ipu6/ipu6-isys-subdev.c
> +++ b/drivers/media/pci/intel/ipu6/ipu6-isys-subdev.c
> @@ -25,24 +25,28 @@ unsigned int ipu6_isys_mbus_code_to_bpp(u32 code)
>  	case MEDIA_BUS_FMT_RGB565_1X16:
>  	case MEDIA_BUS_FMT_UYVY8_1X16:
>  	case MEDIA_BUS_FMT_YUYV8_1X16:
> +	case MEDIA_BUS_FMT_Y16_1X16:
>  	case MEDIA_BUS_FMT_META_16:
>  		return 16;
>  	case MEDIA_BUS_FMT_SBGGR12_1X12:
>  	case MEDIA_BUS_FMT_SGBRG12_1X12:
>  	case MEDIA_BUS_FMT_SGRBG12_1X12:
>  	case MEDIA_BUS_FMT_SRGGB12_1X12:
> +	case MEDIA_BUS_FMT_Y12_1X12:
>  	case MEDIA_BUS_FMT_META_12:
>  		return 12;
>  	case MEDIA_BUS_FMT_SBGGR10_1X10:
>  	case MEDIA_BUS_FMT_SGBRG10_1X10:
>  	case MEDIA_BUS_FMT_SGRBG10_1X10:
>  	case MEDIA_BUS_FMT_SRGGB10_1X10:
> +	case MEDIA_BUS_FMT_Y10_1X10:
>  	case MEDIA_BUS_FMT_META_10:
>  		return 10;
>  	case MEDIA_BUS_FMT_SBGGR8_1X8:
>  	case MEDIA_BUS_FMT_SGBRG8_1X8:
>  	case MEDIA_BUS_FMT_SGRBG8_1X8:
>  	case MEDIA_BUS_FMT_SRGGB8_1X8:
> +	case MEDIA_BUS_FMT_Y8_1X8:
>  	case MEDIA_BUS_FMT_META_8:
>  		return 8;
>  	default:
> @@ -65,21 +69,25 @@ unsigned int ipu6_isys_mbus_code_to_mipi(u32 code)
>  	case MEDIA_BUS_FMT_SGBRG16_1X16:
>  	case MEDIA_BUS_FMT_SGRBG16_1X16:
>  	case MEDIA_BUS_FMT_SRGGB16_1X16:
> +	case MEDIA_BUS_FMT_Y16_1X16:
>  		return MIPI_CSI2_DT_RAW16;
>  	case MEDIA_BUS_FMT_SBGGR12_1X12:
>  	case MEDIA_BUS_FMT_SGBRG12_1X12:
>  	case MEDIA_BUS_FMT_SGRBG12_1X12:
>  	case MEDIA_BUS_FMT_SRGGB12_1X12:
> +	case MEDIA_BUS_FMT_Y12_1X12:
>  		return MIPI_CSI2_DT_RAW12;
>  	case MEDIA_BUS_FMT_SBGGR10_1X10:
>  	case MEDIA_BUS_FMT_SGBRG10_1X10:
>  	case MEDIA_BUS_FMT_SGRBG10_1X10:
>  	case MEDIA_BUS_FMT_SRGGB10_1X10:
> +	case MEDIA_BUS_FMT_Y10_1X10:
>  		return MIPI_CSI2_DT_RAW10;
>  	case MEDIA_BUS_FMT_SBGGR8_1X8:
>  	case MEDIA_BUS_FMT_SGBRG8_1X8:
>  	case MEDIA_BUS_FMT_SGRBG8_1X8:
>  	case MEDIA_BUS_FMT_SRGGB8_1X8:
> +	case MEDIA_BUS_FMT_Y8_1X8:
>  		return MIPI_CSI2_DT_RAW8;
>  	case MEDIA_BUS_FMT_META_8:
>  	case MEDIA_BUS_FMT_META_10:
> @@ -96,15 +104,23 @@ unsigned int ipu6_isys_mbus_code_to_mipi(u32 code)
>  
>  bool ipu6_isys_is_bayer_format(u32 code)
>  {
> -	switch (ipu6_isys_mbus_code_to_mipi(code)) {
> -	case MIPI_CSI2_DT_RAW8:
> -	case MIPI_CSI2_DT_RAW10:
> -	case MIPI_CSI2_DT_RAW12:
> -	case MIPI_CSI2_DT_RAW14:
> -	case MIPI_CSI2_DT_RAW16:
> -	case MIPI_CSI2_DT_RAW20:
> -	case MIPI_CSI2_DT_RAW24:
> -	case MIPI_CSI2_DT_RAW28:
> +	switch (code) {
> +	case MEDIA_BUS_FMT_SBGGR8_1X8:
> +	case MEDIA_BUS_FMT_SGBRG8_1X8:
> +	case MEDIA_BUS_FMT_SGRBG8_1X8:
> +	case MEDIA_BUS_FMT_SRGGB8_1X8:
> +	case MEDIA_BUS_FMT_SBGGR10_1X10:
> +	case MEDIA_BUS_FMT_SGBRG10_1X10:
> +	case MEDIA_BUS_FMT_SGRBG10_1X10:
> +	case MEDIA_BUS_FMT_SRGGB10_1X10:
> +	case MEDIA_BUS_FMT_SBGGR12_1X12:
> +	case MEDIA_BUS_FMT_SGBRG12_1X12:
> +	case MEDIA_BUS_FMT_SGRBG12_1X12:
> +	case MEDIA_BUS_FMT_SRGGB12_1X12:
> +	case MEDIA_BUS_FMT_SRGGB16_1X16:
> +	case MEDIA_BUS_FMT_SGRBG16_1X16:
> +	case MEDIA_BUS_FMT_SGBRG16_1X16:
> +	case MEDIA_BUS_FMT_SBGGR16_1X16:
>  		return true;
>  	default:
>  		return false;
> diff --git a/drivers/media/pci/intel/ipu6/ipu6-isys-video.c b/drivers/media/pci/intel/ipu6/ipu6-isys-video.c
> index f3f3bc0615e5..dec8f5ffcfa5 100644
> --- a/drivers/media/pci/intel/ipu6/ipu6-isys-video.c
> +++ b/drivers/media/pci/intel/ipu6/ipu6-isys-video.c
> @@ -77,6 +77,20 @@ const struct ipu6_isys_pixelformat ipu6_isys_pfmts[] = {
>  	  IPU6_FW_ISYS_FRAME_FORMAT_RAW10 },
>  	{ V4L2_PIX_FMT_SRGGB10P, 10, 10, MEDIA_BUS_FMT_SRGGB10_1X10,
>  	  IPU6_FW_ISYS_FRAME_FORMAT_RAW10 },
> +
> +	{ V4L2_PIX_FMT_GREY, 8, 8, MEDIA_BUS_FMT_Y8_1X8,
> +	  IPU6_FW_ISYS_FRAME_FORMAT_RAW8 },
> +	{ V4L2_PIX_FMT_Y10, 16, 10, MEDIA_BUS_FMT_Y10_1X10,
> +	  IPU6_FW_ISYS_FRAME_FORMAT_RAW16 },
> +	{ V4L2_PIX_FMT_Y12, 16, 12, MEDIA_BUS_FMT_Y12_1X12,
> +	  IPU6_FW_ISYS_FRAME_FORMAT_RAW16 },
> +	{ V4L2_PIX_FMT_Y16, 16, 16, MEDIA_BUS_FMT_Y16_1X16,
> +	  IPU6_FW_ISYS_FRAME_FORMAT_RAW16 },
> +	{ V4L2_PIX_FMT_Y10P, 10, 10, MEDIA_BUS_FMT_Y10_1X10,
> +	  IPU6_FW_ISYS_FRAME_FORMAT_RAW10 },
> +	{ V4L2_PIX_FMT_Y12P, 12, 12, MEDIA_BUS_FMT_Y12_1X12,
> +	  IPU6_FW_ISYS_FRAME_FORMAT_RAW12 },
> +
>  	{ V4L2_PIX_FMT_UYVY, 16, 16, MEDIA_BUS_FMT_UYVY8_1X16,
>  	  IPU6_FW_ISYS_FRAME_FORMAT_UYVY},
>  	{ V4L2_PIX_FMT_YUYV, 16, 16, MEDIA_BUS_FMT_YUYV8_1X16,
> 

-- 
Best regards,
Bingbu Cao
