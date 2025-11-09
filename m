Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226B2171C9
	for <linux-media@vger.kernel.org>; Sun,  9 Nov 2025 21:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762724932; cv=none; b=rTVxZIPvoWK0HNDdNoMTg3TXIbh/nLCsfN1jfC8Xz5LX4sROcDM52HwzeU2Yq19AhpJ+Oft5KB5sFBByqI+VIPb0mFJYTfJ4bJ3LzM4Zw0VLAS+GnOCrb3LW0lsfAZkRq2xTWwb9wlVsxAEfljjsVsrkWadfaXNzh2X8AKvkiZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762724932; c=relaxed/simple;
	bh=Q2KbBtdvFBz63OxXv1wztUo9rT/L1z8KKdXs98sTjzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgbMKLKouuJ3FBry8ehwnB3SV6hpezvUn2ZS1f/YzTtnJHmRPNlLq+SiSnxn5dFit/StsLy7sYXFX14cOm1CkA0vJd/BFuJD39gfjZnubZ6nrJoVEFxvtnayykIn+SZtPGEb8q0HfU75L2N/5h0UvkMidkzdVcM3O04T7lDA1sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ag2QPTyW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ag2QPTyW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762724931; x=1794260931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q2KbBtdvFBz63OxXv1wztUo9rT/L1z8KKdXs98sTjzo=;
  b=Ag2QPTyWEUdn56jVr9gCO43OYvPN9nD1wEm7d+Ism6Wi8bpg8gvnakos
   BbcI8Bek7QgSRpH85LLZASJVPWsRkwPLYaviRCASRnDEa58/GVUEASn0k
   ZAtZq0e+bV5ovJFW0ldJ08ATtd0Yr1wGy67AL6NruARajUCKK/YOGb0Lo
   /dTFe3JJavIkyauqW7fZY5eNc+DBEGyCRUnhQO5kLtw/1xccwyvnHBJid
   ymW/1ygyY9yDvyRwiWAfRidN6GEUgAWGGVQyPw4iYG8nZNcbm5ssiYzug
   GoBjPlq9HiUx7MqmiLKvRISskv2Efr389JmgTFThY8PlPDSamhzT+uSjq
   w==;
X-CSE-ConnectionGUID: Jry6BA/YT5SXtgfTlHfyyw==
X-CSE-MsgGUID: rKwpqh/7Sk+5OjLfrrfywg==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="68630232"
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="68630232"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 13:48:50 -0800
X-CSE-ConnectionGUID: yZi8cpxlTAmH/01aimhL0A==
X-CSE-MsgGUID: 016R6T/9TRG4taXsPRCqpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="188775217"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 09 Nov 2025 13:48:47 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIDHB-0002Qd-2b;
	Sun, 09 Nov 2025 21:48:45 +0000
Date: Mon, 10 Nov 2025 05:48:29 +0800
From: kernel test robot <lkp@intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-media@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Martin Kepplinger <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v1 3/6] media: imx-mipi-csis: Implement the
 .set_routing() operation
Message-ID: <202511100531.4skNcchV-lkp@intel.com>
References: <20251107015813.5834-4-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107015813.5834-4-laurent.pinchart@ideasonboard.com>

Hi Laurent,

kernel test robot noticed the following build errors:

[auto build test ERROR on dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa]

url:    https://github.com/intel-lab-lkp/linux/commits/Laurent-Pinchart/media-imx-mipi-csis-Add-VC-related-register-fields/20251107-100134
base:   dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
patch link:    https://lore.kernel.org/r/20251107015813.5834-4-laurent.pinchart%40ideasonboard.com
patch subject: [PATCH v1 3/6] media: imx-mipi-csis: Implement the .set_routing() operation
config: arm-randconfig-003-20251110 (https://download.01.org/0day-ci/archive/20251110/202511100531.4skNcchV-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251110/202511100531.4skNcchV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511100531.4skNcchV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/media/platform/nxp/imx-mipi-csis.c:1164:32: error: initializer element is not a compile-time constant
                   .code = mipi_csis_formats[0].code,
                           ~~~~~~~~~~~~~~~~~~~~~^~~~
   1 error generated.


vim +1164 drivers/media/platform/nxp/imx-mipi-csis.c

  1156	
  1157	static int __mipi_csis_set_routing(struct v4l2_subdev *sd,
  1158					   struct v4l2_subdev_state *state,
  1159					   struct v4l2_subdev_krouting *routing)
  1160	{
  1161		static const struct v4l2_mbus_framefmt format = {
  1162			.width = MIPI_CSIS_DEF_PIX_WIDTH,
  1163			.height = MIPI_CSIS_DEF_PIX_HEIGHT,
> 1164			.code = mipi_csis_formats[0].code,
  1165			.field = V4L2_FIELD_NONE,
  1166			.colorspace = V4L2_XFER_FUNC_709,
  1167			.ycbcr_enc = V4L2_YCBCR_ENC_601,
  1168			.quantization = V4L2_QUANTIZATION_LIM_RANGE,
  1169			.xfer_func = V4L2_XFER_FUNC_SRGB,
  1170		};
  1171		int ret;
  1172	
  1173		ret = v4l2_subdev_routing_validate(sd, routing,
  1174						   V4L2_SUBDEV_ROUTING_NO_1_TO_N);
  1175		if (ret)
  1176			return ret;
  1177	
  1178		/* Only a single route is supported for now. */
  1179		if (routing->num_routes != 1 ||
  1180		    !(routing->routes[0].flags & V4L2_SUBDEV_ROUTE_FL_ACTIVE))
  1181			return -EINVAL;
  1182	
  1183		ret = v4l2_subdev_set_routing_with_fmt(sd, state, routing, &format);
  1184		if (ret)
  1185			return ret;
  1186	
  1187		return 0;
  1188	}
  1189	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
