Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1024F32A3D9
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848760; cv=none; b=uI24pburyQB98M0wxCM8siOQ5RvNL8uZ+dap31wGkH0SM2pgPNhxjHzy/OGEPOsbjfQO4TRqxWw+qvls/ONztjahlxNQR1KRcs+zcr2uRd2tA8AHDualK+wJWI9NI7JENfKyUo3jAk/v31wzai9VvuiJIJdWaYiU8RoqW8I2i7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848760; c=relaxed/simple;
	bh=LctZE7WWyD0ScAxlN3zs+VOlAcZS6SPJo85uGHj20/0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AmWDRFu3hn4Ws8jus32CI7mRH/t+rWTn8/SkaRlmORDvyTFkU4yf/O/9XFf4ondpPZ1xR8YD1xDqiHmUmLYJB4cHFMozAWZPiVpRybJchDrANXJ/os+VFLDWQmhqAceCmcJGGsNblhwUhdYZJaj5xsEY6n3dNGg34Ua1/yirY14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gILLAcFy; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gILLAcFy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762848759; x=1794384759;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=LctZE7WWyD0ScAxlN3zs+VOlAcZS6SPJo85uGHj20/0=;
  b=gILLAcFysvvTB1p1KTdTrm3Ty3uGLdDZhu5sR++MzVCpVMdhvN+/aCdR
   D4+ewDB8fonJ58G8Sw9cW+1Rp6Lmfl3kHCeo0HxOqVBPh0KEYww8+Sk16
   CVr5KH8/J1E8wPKj8xeCAmXo7dyQqHEJZwDABn1CWdrUTnWSdzq2vUHPd
   e0daqslzlATCV13r31A1PTUre9IZmRX4W3gN3xZTFpX/Gd+Bod6w5eka9
   t/HSrmTYmjFEKWy+GcweYsOR1QoJfZDiMWxIht3dJp1lb6ycvimVkDIM9
   M5o+mFM6Vpo0dORR4Gnurputi9yEU6Vudf12KLrRfox8OFYdho382ewsP
   w==;
X-CSE-ConnectionGUID: BO7OlDqfSu6QXjBygLCHlA==
X-CSE-MsgGUID: r8bgTi51Q+yVrGyYaWBmNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="52466268"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="52466268"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 00:12:37 -0800
X-CSE-ConnectionGUID: oes4RY8MRxyEru+W9+js4g==
X-CSE-MsgGUID: zCuMRSJnSf6w69TlOLI7VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="188538751"
Received: from ipu5-build.bj.intel.com (HELO [10.238.153.130]) ([10.238.153.130])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 00:12:30 -0800
Subject: Re: [PATCH v11 66/66] media: ipu6: Add support for raw CFA-agnostic
 formats
To: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org
Cc: hans@jjverkuil.nl, laurent.pinchart@ideasonboard.com,
 Prabhakar <prabhakar.csengg@gmail.com>, Kate Hsuan <hpa@redhat.com>,
 Alexander Shiyan <eagle.alexander923@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Tommaso Merciai <tomm.merciai@gmail.com>,
 Umang Jain <umang.jain@ideasonboard.com>,
 Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
 Sylvain Petinot <sylvain.petinot@foss.st.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Julien Massot <julien.massot@collabora.com>,
 Naushir Patuck <naush@raspberrypi.com>,
 "Yan, Dongcheng" <dongcheng.yan@intel.com>,
 "Cao, Bingbu" <bingbu.cao@intel.com>, "Qiu, Tian Shu"
 <tian.shu.qiu@intel.com>, "Wang, Hongju" <hongju.wang@intel.com>,
 Stefan Klug <stefan.klug@ideasonboard.com>,
 Mirela Rabulea <mirela.rabulea@nxp.com>, =?UTF-8?Q?Andr=c3=a9_Apitzsch?=
 <git@apitzsch.eu>, Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Mehdi Djait <mehdi.djait@linux.intel.com>,
 Ricardo Ribalda Delgado <ribalda@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
References: <20250825095107.1332313-1-sakari.ailus@linux.intel.com>
 <20250825095107.1332313-67-sakari.ailus@linux.intel.com>
From: Bingbu Cao <bingbu.cao@linux.intel.com>
Message-ID: <d6b30183-869d-8d01-aaba-6fa2257c2175@linux.intel.com>
Date: Tue, 11 Nov 2025 16:03:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250825095107.1332313-67-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Sakari,

Thanks for the patch.
Reviewed-by: Bingbu Cao <bingbu.cao@intel.com>

On 8/25/25 5:51 PM, Sakari Ailus wrote:
> Add support for CFA-agnostic mbus codes and V4L2 pixelformats.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c   | 3 +++
>  drivers/media/pci/intel/ipu6/ipu6-isys-subdev.c | 3 +++
>  drivers/media/pci/intel/ipu6/ipu6-isys-video.c  | 6 ++++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c b/drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c
> index b6421d6b978a..21a4f130bb34 100644
> --- a/drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c
> +++ b/drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c
> @@ -35,16 +35,19 @@ static const u32 csi2_supported_codes[] = {
>  	MEDIA_BUS_FMT_SGRBG10_1X10,
>  	MEDIA_BUS_FMT_SRGGB10_1X10,
>  	MEDIA_BUS_FMT_Y10_1X10,
> +	MEDIA_BUS_FMT_RAW_10,
>  	MEDIA_BUS_FMT_SBGGR12_1X12,
>  	MEDIA_BUS_FMT_SGBRG12_1X12,
>  	MEDIA_BUS_FMT_SGRBG12_1X12,
>  	MEDIA_BUS_FMT_SRGGB12_1X12,
>  	MEDIA_BUS_FMT_Y12_1X12,
> +	MEDIA_BUS_FMT_RAW_12,
>  	MEDIA_BUS_FMT_SBGGR8_1X8,
>  	MEDIA_BUS_FMT_SGBRG8_1X8,
>  	MEDIA_BUS_FMT_SGRBG8_1X8,
>  	MEDIA_BUS_FMT_SRGGB8_1X8,
>  	MEDIA_BUS_FMT_Y8_1X8,
> +	MEDIA_BUS_FMT_RAW_8,
>  	MEDIA_BUS_FMT_META_8,
>  	MEDIA_BUS_FMT_META_10,
>  	MEDIA_BUS_FMT_META_12,
> diff --git a/drivers/media/pci/intel/ipu6/ipu6-isys-subdev.c b/drivers/media/pci/intel/ipu6/ipu6-isys-subdev.c
> index 5db59cec821e..407db2ebe6ee 100644
> --- a/drivers/media/pci/intel/ipu6/ipu6-isys-subdev.c
> +++ b/drivers/media/pci/intel/ipu6/ipu6-isys-subdev.c
> @@ -32,6 +32,7 @@ unsigned int ipu6_isys_mbus_code_to_bpp(u32 code)
>  	case MEDIA_BUS_FMT_SGRBG12_1X12:
>  	case MEDIA_BUS_FMT_SRGGB12_1X12:
>  	case MEDIA_BUS_FMT_Y12_1X12:
> +	case MEDIA_BUS_FMT_RAW_12:
>  	case MEDIA_BUS_FMT_META_12:
>  		return 12;
>  	case MEDIA_BUS_FMT_SBGGR10_1X10:
> @@ -39,6 +40,7 @@ unsigned int ipu6_isys_mbus_code_to_bpp(u32 code)
>  	case MEDIA_BUS_FMT_SGRBG10_1X10:
>  	case MEDIA_BUS_FMT_SRGGB10_1X10:
>  	case MEDIA_BUS_FMT_Y10_1X10:
> +	case MEDIA_BUS_FMT_RAW_10:
>  	case MEDIA_BUS_FMT_META_10:
>  		return 10;
>  	case MEDIA_BUS_FMT_SBGGR8_1X8:
> @@ -46,6 +48,7 @@ unsigned int ipu6_isys_mbus_code_to_bpp(u32 code)
>  	case MEDIA_BUS_FMT_SGRBG8_1X8:
>  	case MEDIA_BUS_FMT_SRGGB8_1X8:
>  	case MEDIA_BUS_FMT_Y8_1X8:
> +	case MEDIA_BUS_FMT_RAW_8:
>  	case MEDIA_BUS_FMT_META_8:
>  		return 8;
>  	default:
> diff --git a/drivers/media/pci/intel/ipu6/ipu6-isys-video.c b/drivers/media/pci/intel/ipu6/ipu6-isys-video.c
> index 9a6b4736cd67..362608f89fc5 100644
> --- a/drivers/media/pci/intel/ipu6/ipu6-isys-video.c
> +++ b/drivers/media/pci/intel/ipu6/ipu6-isys-video.c
> @@ -91,6 +91,12 @@ const struct ipu6_isys_pixelformat ipu6_isys_pfmts[] = {
>  	  IPU6_FW_ISYS_FRAME_FORMAT_RAW10 },
>  	{ V4L2_PIX_FMT_Y12, 12, 12, MEDIA_BUS_FMT_Y12_1X12,
>  	  IPU6_FW_ISYS_FRAME_FORMAT_RAW12 },
> +	{ V4L2_PIX_FMT_RAW_8, 8, 8, MEDIA_BUS_FMT_RAW_8,
> +	  IPU6_FW_ISYS_FRAME_FORMAT_RAW8 },
> +	{ V4L2_PIX_FMT_RAW_CSI2_10, 10, 10, MEDIA_BUS_FMT_RAW_10,
> +	  IPU6_FW_ISYS_FRAME_FORMAT_RAW10 },
> +	{ V4L2_PIX_FMT_RAW_CSI2_12, 12, 12, MEDIA_BUS_FMT_RAW_12,
> +	  IPU6_FW_ISYS_FRAME_FORMAT_RAW12 },
>  	{ V4L2_META_FMT_GENERIC_8, 8, 8, MEDIA_BUS_FMT_META_8,
>  	  IPU6_FW_ISYS_FRAME_FORMAT_RAW8, true },
>  	{ V4L2_META_FMT_GENERIC_CSI2_10, 10, 10, MEDIA_BUS_FMT_META_10,
> 

-- 
Best regards,
Bingbu Cao
