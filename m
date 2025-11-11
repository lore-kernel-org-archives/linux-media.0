Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091241EEE6
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848640; cv=none; b=SZte0A3NYg5xNBE6LqCXejxZOkFNvWDoa9cVK06UdN7ETqGsz4w6eBiOgLBciwbNixcm8r5b1X4c9aC/41T7c7mXQUpKneOgu68i3MGSWGrTzSxCzWPIoF/oF27L3exmL92UuN4+pgqHhc3WEDZuMw2cu+enE1YJ+PRDmYZIBaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848640; c=relaxed/simple;
	bh=qz0jAIjeW4fkA7pK9LadI3BxNgTZufvPUhuxnlKV50Y=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RE2DesmCTWCWn3ka/3zeBpSz1WZyWJNWj/m6B9Txom2d1nDTZ6zo9rMXxkdxBAz8pPm4vc9V5DzLTG3wEbnc+mBIzdg0Q2xkOPrxvQbvtnZIWR/ELuPusAsA8Qal8CZKlSaDiT0+qde0z7iaC5sBpt2Gs8pN5iti5lZZe7asaW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VuHGMCA1; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VuHGMCA1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762848638; x=1794384638;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=qz0jAIjeW4fkA7pK9LadI3BxNgTZufvPUhuxnlKV50Y=;
  b=VuHGMCA1+IjmqdMAToYK1T0iyAohR4fTwhhu5L0gPhumX1JKAh06USCO
   6fZ5ZInrNAbEJNa96pn44pci7aacIB2owKF0EhOlyt+KzpXdjT7YyF7Lt
   9EyF4lnvmInByxJgeF1dhF1oxSOE3VfVBWgDsP95LoL6DQx/QP1ZFYAGO
   WxCwiOlYueblWoDrGKlLWDi4jf25Yko454iHbMLAIcpn0tp5no8//DIJc
   Qbh2SyJqYXfTTfQQjg4yrbTP3Ei4deFDm4+S8Hkmp6CGzGaylXcQsVKFR
   TxwjMJ1HjFE/8lZEz/4NblpFN/l1ewJviycX0FeiEY2Yh7ldkVjYwThOW
   g==;
X-CSE-ConnectionGUID: VQRa8qeXSNuKVZQ9dWkcjw==
X-CSE-MsgGUID: FcpnfFe9RTCHJIYbTD7umA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="67512655"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="67512655"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 00:10:37 -0800
X-CSE-ConnectionGUID: WwqgW24SQrWTBSp89/MutQ==
X-CSE-MsgGUID: XbKblEENQdOV+dC0dEvIoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="194094407"
Received: from ipu5-build.bj.intel.com (HELO [10.238.153.130]) ([10.238.153.130])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 00:10:31 -0800
Subject: Re: [PATCH v11 65/66] media: ipu6: Add support for luma-only formats
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
 <20250825095107.1332313-66-sakari.ailus@linux.intel.com>
From: Bingbu Cao <bingbu.cao@linux.intel.com>
Message-ID: <7e8d109c-c1f7-10da-d1a4-1a2f19702cb5@linux.intel.com>
Date: Tue, 11 Nov 2025 16:01:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250825095107.1332313-66-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Sakari,

Thanks for the patch.
Reviewed-by: Bingbu Cao <bingbu.cao@intel.com>

On 8/25/25 5:51 PM, Sakari Ailus wrote:
> Add support for luma-only formats.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c   | 3 +++
>  drivers/media/pci/intel/ipu6/ipu6-isys-subdev.c | 7 +++++++
>  drivers/media/pci/intel/ipu6/ipu6-isys-video.c  | 6 ++++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c b/drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c
> index d1fece6210ab..b6421d6b978a 100644
> --- a/drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c
> +++ b/drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c
> @@ -34,14 +34,17 @@ static const u32 csi2_supported_codes[] = {
>  	MEDIA_BUS_FMT_SGBRG10_1X10,
>  	MEDIA_BUS_FMT_SGRBG10_1X10,
>  	MEDIA_BUS_FMT_SRGGB10_1X10,
> +	MEDIA_BUS_FMT_Y10_1X10,
>  	MEDIA_BUS_FMT_SBGGR12_1X12,
>  	MEDIA_BUS_FMT_SGBRG12_1X12,
>  	MEDIA_BUS_FMT_SGRBG12_1X12,
>  	MEDIA_BUS_FMT_SRGGB12_1X12,
> +	MEDIA_BUS_FMT_Y12_1X12,
>  	MEDIA_BUS_FMT_SBGGR8_1X8,
>  	MEDIA_BUS_FMT_SGBRG8_1X8,
>  	MEDIA_BUS_FMT_SGRBG8_1X8,
>  	MEDIA_BUS_FMT_SRGGB8_1X8,
> +	MEDIA_BUS_FMT_Y8_1X8,
>  	MEDIA_BUS_FMT_META_8,
>  	MEDIA_BUS_FMT_META_10,
>  	MEDIA_BUS_FMT_META_12,
> diff --git a/drivers/media/pci/intel/ipu6/ipu6-isys-subdev.c b/drivers/media/pci/intel/ipu6/ipu6-isys-subdev.c
> index 463a0adf9e13..5db59cec821e 100644
> --- a/drivers/media/pci/intel/ipu6/ipu6-isys-subdev.c
> +++ b/drivers/media/pci/intel/ipu6/ipu6-isys-subdev.c
> @@ -31,18 +31,21 @@ unsigned int ipu6_isys_mbus_code_to_bpp(u32 code)
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
> @@ -65,21 +68,25 @@ unsigned int ipu6_isys_mbus_code_to_mipi(u32 code)
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
> diff --git a/drivers/media/pci/intel/ipu6/ipu6-isys-video.c b/drivers/media/pci/intel/ipu6/ipu6-isys-video.c
> index e1306b9510e7..9a6b4736cd67 100644
> --- a/drivers/media/pci/intel/ipu6/ipu6-isys-video.c
> +++ b/drivers/media/pci/intel/ipu6/ipu6-isys-video.c
> @@ -85,6 +85,12 @@ const struct ipu6_isys_pixelformat ipu6_isys_pfmts[] = {
>  	  IPU6_FW_ISYS_FRAME_FORMAT_RGB565 },
>  	{ V4L2_PIX_FMT_BGR24, 24, 24, MEDIA_BUS_FMT_RGB888_1X24,
>  	  IPU6_FW_ISYS_FRAME_FORMAT_RGBA888 },
> +	{ V4L2_PIX_FMT_GREY, 8, 8, MEDIA_BUS_FMT_Y8_1X8,
> +	  IPU6_FW_ISYS_FRAME_FORMAT_RAW8 },
> +	{ V4L2_PIX_FMT_Y10, 10, 10, MEDIA_BUS_FMT_Y10_1X10,
> +	  IPU6_FW_ISYS_FRAME_FORMAT_RAW10 },
> +	{ V4L2_PIX_FMT_Y12, 12, 12, MEDIA_BUS_FMT_Y12_1X12,
> +	  IPU6_FW_ISYS_FRAME_FORMAT_RAW12 },
>  	{ V4L2_META_FMT_GENERIC_8, 8, 8, MEDIA_BUS_FMT_META_8,
>  	  IPU6_FW_ISYS_FRAME_FORMAT_RAW8, true },
>  	{ V4L2_META_FMT_GENERIC_CSI2_10, 10, 10, MEDIA_BUS_FMT_META_10,
> 

-- 
Best regards,
Bingbu Cao
