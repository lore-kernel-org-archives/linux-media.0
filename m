Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MWeI9TFR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4389CCD
	for <linux-media@vger.kernel.org>; Tue, 12 Dec 2023 03:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702381063; x=1733917063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pTJEj6y6GGaeVqb8N6HtmVwkB1PE+e6odFHNMQ3bh0s=;
  b=MWeI9TFRhnUFvfUgG98W3VJ4EJV42I1ytOwhk3dcbsaxdXGV3Ta6fM6w
   p1YwDnkfwSTWUPO5k2E4gDJyw4vdTyYLaI36xlnXGboMkeLe6UM9MvqrW
   bJsBI0KpWK18fNwCzYe4V+QNGHsFgl5/wyHi2Zh9VHE/ZSErYTVkg9wpg
   tCQpl02P6DFRU/EVqv2UmVMs0q57zhFXxxow22z00/YLtSywXXRP6kWPD
   LqfWa2oODA3q3VP5FCx141tmS1pEqM4SDP60innAk95PhwAebRig1vkjF
   nb4PVgCKaNQg6hL4EufQvvlIbvKjljAPtELUqByE6p14A12m+om6wJOD9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1632916"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="1632916"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 03:37:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="896890652"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="896890652"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 03:37:40 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id E2A5911F7E4;
	Tue, 12 Dec 2023 13:37:37 +0200 (EET)
Date: Tue, 12 Dec 2023 11:37:37 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Gerald Loacker <gerald.loacker@wolfvision.net>,
	linux-media@vger.kernel.org
Subject: Re: [PATCH 2/3] media: i2c: imx415: Add more clock configurations
Message-ID: <ZXhGAR2fhEOjHXcJ@kekkonen.localdomain>
References: <20231205090557.298680-1-alexander.stein@ew.tq-group.com>
 <20231205090557.298680-3-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205090557.298680-3-alexander.stein@ew.tq-group.com>

Hi Alexander,

On Tue, Dec 05, 2023 at 10:05:56AM +0100, Alexander Stein wrote:
> Complete the list from "INCK Setting" section in IMX415-AAQR-C
> (Rev. E19504, 2019/05/21)
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Could you address these smatch warnings, and run

	./scripts/checkpatch.pl --strict --max-line-length=80

on the patches?

drivers/media/i2c/imx415.c:402:30: warning: decimal constant 2376000000 is      
between LONG_MAX and ULONG_MAX. For C99 that means long long, C90 compilers are 
very likely to produce unsigned long (and a                                     
warning) here                                                                   
drivers/media/i2c/imx415.c:417:30: warning: decimal constant 2376000000 is      
between LONG_MAX and ULONG_MAX. For C99 that means long long, C90 compilers are 
very likely to produce unsigned long (and a                                     
warning) here                                                                   
drivers/media/i2c/imx415.c:432:30: warning: decimal constant 2376000000 is      
between LONG_MAX and ULONG_MAX. For C99 that means long long, C90 compilers are 
very likely to produce unsigned long (and a                                     
warning) here                                                                   

-- 
Sakari Ailus
