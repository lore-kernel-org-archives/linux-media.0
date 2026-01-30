Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62452F7AB8
	for <linux-media@vger.kernel.org>; Fri, 30 Jan 2026 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769759566; cv=none; b=FxIReHq2HCrkUi/7nLHKdtIfrxOgHZioRQ8d6e0D0/jvyJ7di0omb1S40A976tuRFHrsygrtmmeb/OA3k40Tznr9GiWxgScxOQT6TrXtINgDajQXWmW/+Extqz7FkpTwKR3TfHdtZ8ZWw3TqvLD0OY6PLBgW57KsUczgEGLxsoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769759566; c=relaxed/simple;
	bh=aX2gGtLk0RdmVui+gtEWlxTOSd9DpW+YmCX91ZUxfTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZ9loBi+QhjMUTfhhNKfgBxuiz8DI3NmlyFsASgSGXzyOI6IIP/wkVcMxPPrApw0HGwL1V5dG986PAE3BWmO7l8R0o7GKz2+Zjw8VreirIu4vedycUUMwKdAbqZUWgNkYjLyUxz6OZdJJKWnks+k2q9t/7lniD2Ks1UIxTToZJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hfSd0wEN; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hfSd0wEN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769759564; x=1801295564;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aX2gGtLk0RdmVui+gtEWlxTOSd9DpW+YmCX91ZUxfTk=;
  b=hfSd0wENHLunpw8oiFSY1SNmvPWg1yKK3ivDj+IoPyEwl+kcqEB2YC+a
   2X0G2JGf2zoaAbHb8nzaXS8kDGW/Ujm2wivA+8PArxLJP0XMfb7i4aFrl
   ZGjHvwTHMG9ql9p0gz6zI6d8/FTredf7a2DlqxjGQm2NyQ/Il/zRil4Bu
   L/4Yn7CLmMNUp5LOIq2ALcZM0TBqkiiJoAJpQze+S2VvHgo5nqEh+i2mJ
   6P4c9OqP2Kpb2EIqWPsAZSfpirONfWZDwo9BbGqyTTeaS4LCOs2fEvffI
   IDUJZvNpsKn5P8UPyrO4RTO/kKN3M9IfFtzshRQ5bDXJ5YFywIeM0+Jad
   A==;
X-CSE-ConnectionGUID: CyjBO/o3QSOj2Neue1VCOw==
X-CSE-MsgGUID: gP8SMNvKT9KWe5m6Ass6EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="96472143"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="96472143"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 23:52:44 -0800
X-CSE-ConnectionGUID: 4lPDyHmuRlCDGd/lYki7Jg==
X-CSE-MsgGUID: gAwQQt+aTxyOY6vj7lBOxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="239522017"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 29 Jan 2026 23:52:40 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vljIz-00000000cLg-3aEb;
	Fri, 30 Jan 2026 07:52:37 +0000
Date: Fri, 30 Jan 2026 15:51:45 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Geyko <ageyko0@gmail.com>, linux-staging@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, mripard@kernel.org, paulk@sys-base.io,
	mchehab@kernel.org, wens@kernel.org, jernej.skrabec@gmail.com,
	samuel@sholland.org, gregkh@linuxfoundation.org,
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, Andrew Geyko <ageyko0@gmail.com>
Subject: Re: [PATCH] cedrus: Convert bitfield macros to FIELD_PREP for clarity
Message-ID: <202601301548.SMgNvRPx-lkp@intel.com>
References: <20260129164341.104155-1-ageyko0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129164341.104155-1-ageyko0@gmail.com>

Hi Andrew,

kernel test robot noticed the following build errors:

[auto build test ERROR on sunxi/sunxi/for-next]
[also build test ERROR on linus/master v6.19-rc7 next-20260129]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrew-Geyko/cedrus-Convert-bitfield-macros-to-FIELD_PREP-for-clarity/20260130-004554
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git sunxi/for-next
patch link:    https://lore.kernel.org/r/20260129164341.104155-1-ageyko0%40gmail.com
patch subject: [PATCH] cedrus: Convert bitfield macros to FIELD_PREP for clarity
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20260130/202601301548.SMgNvRPx-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260130/202601301548.SMgNvRPx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601301548.SMgNvRPx-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/staging/media/sunxi/cedrus/cedrus_h265.c:17:
   drivers/staging/media/sunxi/cedrus/cedrus_h265.c: In function 'cedrus_h265_skip_bits':
>> drivers/staging/media/sunxi/cedrus/cedrus_regs.h:434:40: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
     434 | #define VE_DEC_H265_TRIGGER_FLUSH_BITS FIELD_PREP(VE_DEC_H265_TRIGGER_CMD_MASK, 0x3)
         |                                        ^~~~~~~~~~
   drivers/staging/media/sunxi/cedrus/cedrus_h265.c:248:30: note: in expansion of macro 'VE_DEC_H265_TRIGGER_FLUSH_BITS'
     248 |                              VE_DEC_H265_TRIGGER_FLUSH_BITS |
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/FIELD_PREP +434 drivers/staging/media/sunxi/cedrus/cedrus_regs.h

   425	
   426	#define VE_DEC_H265_TRIGGER_TYPE_N_BITS(x)	(((x) & 0x3f) << 8)
   427	#define VE_DEC_H265_TRIGGER_STCD_MASK  GENMASK(5, 4)
   428	#define VE_DEC_H265_TRIGGER_CMD_MASK   GENMASK(3, 0)
   429	#define VE_DEC_H265_TRIGGER_STCD_HEVC  FIELD_PREP(VE_DEC_H265_TRIGGER_STCD_MASK, 0x0)
   430	#define VE_DEC_H265_TRIGGER_STCD_AVS   FIELD_PREP(VE_DEC_H265_TRIGGER_STCD_MASK, 0x1)
   431	#define VE_DEC_H265_TRIGGER_STCD_VC1   FIELD_PREP(VE_DEC_H265_TRIGGER_STCD_MASK, 0x2)
   432	#define VE_DEC_H265_TRIGGER_SHOW_BITS  FIELD_PREP(VE_DEC_H265_TRIGGER_CMD_MASK, 0x1)
   433	#define VE_DEC_H265_TRIGGER_GET_BITS   FIELD_PREP(VE_DEC_H265_TRIGGER_CMD_MASK, 0x2)
 > 434	#define VE_DEC_H265_TRIGGER_FLUSH_BITS FIELD_PREP(VE_DEC_H265_TRIGGER_CMD_MASK, 0x3)
   435	#define VE_DEC_H265_TRIGGER_GET_VLCSE  FIELD_PREP(VE_DEC_H265_TRIGGER_CMD_MASK, 0x4)
   436	#define VE_DEC_H265_TRIGGER_GET_VLCUE  FIELD_PREP(VE_DEC_H265_TRIGGER_CMD_MASK, 0x5)
   437	#define VE_DEC_H265_TRIGGER_BYTE_ALIGN FIELD_PREP(VE_DEC_H265_TRIGGER_CMD_MASK, 0x6)
   438	#define VE_DEC_H265_TRIGGER_INIT_SWDEC FIELD_PREP(VE_DEC_H265_TRIGGER_CMD_MASK, 0x7)
   439	#define VE_DEC_H265_TRIGGER_DEC_SLICE  FIELD_PREP(VE_DEC_H265_TRIGGER_CMD_MASK, 0x8)
   440	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
