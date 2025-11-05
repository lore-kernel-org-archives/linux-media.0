Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB79330B03
	for <linux-media@vger.kernel.org>; Wed,  5 Nov 2025 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353544; cv=none; b=IJHoq6iM671j3AzRH0hAvPiGfuyQWXAeQORRwgOcwrb44L+3wfPzqA0c42hfA/kFA1pfpAd8k3giulU1h4T7ZcHYLoeNafwuETPDKlQzBrEeReStKN6rSI1b+ucutA2ax7dR6N6C4yvc09rcb14LyCo51+6MPtSOPrPP6WBDALM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353544; c=relaxed/simple;
	bh=kz+amfQJzWqXmh8qF8sY02iN5OVxKhBFXxVGMTdYZdo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Pn4eD6dmu4j844QlAfJ3CAg8nud9zs0SdDLFicFQ8EMGePl9g+QA8zjgZHA4K9uKVoGhfRFMApi3bG0bahLVLxIPv160beV+UAwTDNeOoNR/JYVtf0ybxMDcjhMu6f9xWNYfuil5PMvXcyEwkZmdzMa/CEtU8N0x/tQtcl5Vi5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JQUIk28E; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQUIk28E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762353543; x=1793889543;
  h=date:from:to:cc:subject:message-id;
  bh=kz+amfQJzWqXmh8qF8sY02iN5OVxKhBFXxVGMTdYZdo=;
  b=JQUIk28E6XXNj/mN6oYhtyenNosllFeClssCszbBccICbmvybLI7jLyq
   HjMF1sTy/F9pUellMQ841Wp1xXFC27w6ufxZ9Qd/qPyTBrUVFnaM467Er
   ZRHS7iUuBChLI1gdfo4gb6Jpu5DHx8C227PiIjI/FpqmpCHmnepzhBIZG
   Mrbj8tdmBHbYuNBUy1dB6HvAk5SXGqmyOAnJBAjcgROtK3ABQDK7YTvTS
   IVNmJ/7oRvC4vrhHZgJ1GHfHywLGKVw0VJ5RzZnHr+krTLBAOtwpNoaSY
   N36k3DszhYyf9pQ/dYnOXE6qO1JXDM1UzXo+8BWc5LLSF9VRRuq7IIfv4
   g==;
X-CSE-ConnectionGUID: f7qAmnhHT0qfr8CAN4w05w==
X-CSE-MsgGUID: L0/38OeaRASpjVKh1Lklgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="67084766"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="67084766"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 06:39:02 -0800
X-CSE-ConnectionGUID: fcD0QYWQSmuVISAZmNZEgg==
X-CSE-MsgGUID: iEx07YVHRd6vlj2j3tOcAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="192638939"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 05 Nov 2025 06:39:01 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGef4-000ShK-1e;
	Wed, 05 Nov 2025 14:38:58 +0000
Date: Wed, 05 Nov 2025 22:35:48 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org
Subject: [linuxtv-media-pending:next] BUILD SUCCESS
 1a31cb2782104969e48c7ce7e4fc06e403fcb5cf
Message-ID: <202511052242.S6TiAi5D-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>

tree/branch: https://git.linuxtv.org/media-ci/media-pending.git next
branch HEAD: 1a31cb2782104969e48c7ce7e4fc06e403fcb5cf  media: dvb-usb: pctv452e: move snd/rcv len check before kmalloc

elapsed time: 1477m

configs tested: 119
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              alldefconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                        nsim_700_defconfig    gcc-15.1.0
arc                   randconfig-001-20251105    gcc-8.5.0
arc                   randconfig-002-20251105    gcc-13.4.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20251105    clang-22
arm                   randconfig-002-20251105    clang-22
arm                   randconfig-003-20251105    clang-22
arm                   randconfig-004-20251105    gcc-12.5.0
arm                           stm32_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    clang-22
arm64                 randconfig-001-20251105    clang-17
arm64                 randconfig-002-20251105    gcc-13.4.0
arm64                 randconfig-003-20251105    gcc-8.5.0
arm64                 randconfig-004-20251105    clang-17
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                  randconfig-001-20251105    gcc-15.1.0
csky                  randconfig-002-20251105    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251105    clang-22
hexagon               randconfig-002-20251105    clang-20
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251105    gcc-14
i386        buildonly-randconfig-002-20251105    gcc-14
i386        buildonly-randconfig-003-20251105    clang-20
i386        buildonly-randconfig-004-20251105    gcc-14
i386        buildonly-randconfig-005-20251105    gcc-14
i386        buildonly-randconfig-006-20251105    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251105    clang-18
loongarch             randconfig-002-20251105    clang-20
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                         3c120_defconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251105    gcc-9.5.0
nios2                 randconfig-002-20251105    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20251105    gcc-12.5.0
parisc                randconfig-002-20251105    gcc-10.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                        cell_defconfig    gcc-15.1.0
powerpc                   currituck_defconfig    clang-22
powerpc               randconfig-001-20251105    gcc-14.3.0
powerpc               randconfig-002-20251105    gcc-12.5.0
powerpc64             randconfig-001-20251105    clang-22
powerpc64             randconfig-002-20251105    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv             nommu_k210_sdcard_defconfig    gcc-15.1.0
riscv                 randconfig-001-20251105    gcc-8.5.0
riscv                 randconfig-002-20251105    clang-18
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251105    gcc-8.5.0
s390                  randconfig-002-20251105    gcc-14.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251105    gcc-10.5.0
sh                    randconfig-002-20251105    gcc-11.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20251105    gcc-12.5.0
sparc                 randconfig-002-20251105    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251105    clang-22
sparc64               randconfig-002-20251105    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251105    clang-22
um                    randconfig-002-20251105    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251105    clang-20
x86_64      buildonly-randconfig-002-20251105    gcc-13
x86_64      buildonly-randconfig-003-20251105    gcc-14
x86_64      buildonly-randconfig-004-20251105    gcc-13
x86_64      buildonly-randconfig-005-20251105    gcc-14
x86_64      buildonly-randconfig-006-20251105    gcc-13
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251105    clang-20
x86_64                randconfig-012-20251105    clang-20
x86_64                randconfig-013-20251105    clang-20
x86_64                randconfig-014-20251105    gcc-14
x86_64                randconfig-015-20251105    clang-20
x86_64                randconfig-016-20251105    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                generic_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251105    gcc-11.5.0
xtensa                randconfig-002-20251105    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
