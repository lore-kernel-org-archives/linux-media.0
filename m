Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AFF32B981
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511646; cv=none; b=CnOh+TQWAhBXji9i7SB5r35rSlYK7Va0Trc2//gY2ZM2un96GOHIugRH02QcFSeu3cRD55llY7wJMpo84d/8vW9Xde2MQszDpip/eA2SD0ss+0X0O6avmdvzBORylX1cZvL2erQGcYfAuEJxPAsWsNC2tmdHIzmqKonLe8VUT4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511646; c=relaxed/simple;
	bh=uiF6aR4qq1LbO/5kwekWOiEZkgE0EpDiFy5CVH6OISI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WEpkVEnlrrfoXprMtyXYePX5kFb0q9qU5FyeYKQ2OIkzqxfxn/49oKDqF38X/0SyiV6tB0LFAq2ZkeVYYHVnao9vJL+Okp8y5/VZKMDbiBaBN+4Q67xGJlIGTDJNsJFhONSELboLp39THdVhCVPHHpb3X4NsF26hOovxnNO5i8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GAiu+cKP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GAiu+cKP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762511642; x=1794047642;
  h=date:from:to:cc:subject:message-id;
  bh=uiF6aR4qq1LbO/5kwekWOiEZkgE0EpDiFy5CVH6OISI=;
  b=GAiu+cKPLxrKIYsbDOzLRxxQh+P9bfsVPUnK3ibPZAeDS4DZRKV2n7RJ
   Cz9RbcbdHeX588HH2+RO+cIMUk3cBerajFSQ+a/+EFgWeyBZ7qmLvHx65
   Oo7qfw909fDQx4Vulo57VgboNfMNf8hp5bd0nl8mhvO+fImWGag0dMvYx
   rU4HQSb8Y6WWjwMVwasyloXs3cDmYKwG9tVrgUmciInpWldgHFMJz7aWa
   mg66A2XumeLyAanxTO+a24Z8C/ZMOqbMbw8Wg/MeP0UaV/GhGS6b92Gio
   anQBowdSebSGVERjNaxvbIPY/gBc5W1Jn9S8R4o7/22OVHFvPNjlcYyl5
   w==;
X-CSE-ConnectionGUID: VzEQaylLROyI0lzYxXulYA==
X-CSE-MsgGUID: DmLo4SIkTWeZ+ZUcWMMDKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="75773196"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="75773196"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 02:34:02 -0800
X-CSE-ConnectionGUID: RPbHgub/RvKF9NIGlT7OIw==
X-CSE-MsgGUID: EdEOW3A6TEi2X+pLyYeN/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="192100873"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 07 Nov 2025 02:34:02 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHJn1-000Uzg-0I;
	Fri, 07 Nov 2025 10:33:56 +0000
Date: Fri, 07 Nov 2025 18:33:06 +0800
From: kernel test robot <lkp@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org
Subject: [sailus-media-tree:cleanup] BUILD SUCCESS
 113df97310ed20fd932dff92bed1d8507f82b20c
Message-ID: <202511071801.Ec9WJFz6-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>

tree/branch: git://linuxtv.org/sailus/media_tree.git cleanup
branch HEAD: 113df97310ed20fd932dff92bed1d8507f82b20c  media: i2c: imx214: Rearrange control initialization

elapsed time: 1597m

configs tested: 99
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251107    gcc-8.5.0
arc                   randconfig-002-20251107    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                       imx_v4_v5_defconfig    clang-22
arm                   randconfig-001-20251107    clang-17
arm                   randconfig-002-20251107    gcc-13.4.0
arm                   randconfig-003-20251107    clang-22
arm                   randconfig-004-20251107    gcc-8.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251107    gcc-8.5.0
arm64                 randconfig-002-20251107    clang-22
arm64                 randconfig-003-20251107    gcc-8.5.0
arm64                 randconfig-004-20251107    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251107    gcc-12.5.0
csky                  randconfig-002-20251107    gcc-13.4.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251107    clang-22
hexagon               randconfig-002-20251107    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251107    clang-20
i386        buildonly-randconfig-003-20251107    gcc-13
i386        buildonly-randconfig-004-20251107    gcc-14
i386                  randconfig-002-20251107    gcc-13
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251107    gcc-15.1.0
loongarch             randconfig-002-20251107    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                       rbtx49xx_defconfig    gcc-15.1.0
nios2                         10m50_defconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251107    gcc-11.5.0
nios2                 randconfig-002-20251107    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                       virt_defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251107    gcc-8.5.0
parisc                randconfig-002-20251107    gcc-12.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251107    clang-22
powerpc               randconfig-002-20251107    clang-22
powerpc64             randconfig-001-20251107    gcc-14.3.0
powerpc64             randconfig-002-20251107    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251106    clang-22
riscv                 randconfig-002-20251106    gcc-12.5.0
s390                              allnoconfig    clang-22
s390                          debug_defconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251106    gcc-8.5.0
s390                  randconfig-002-20251106    gcc-14.3.0
sh                                allnoconfig    gcc-15.1.0
sh                        apsh4ad0a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251106    gcc-11.5.0
sh                    randconfig-002-20251106    gcc-13.4.0
sh                   sh7770_generic_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251107    gcc-11.5.0
sparc                 randconfig-002-20251107    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251107    gcc-8.5.0
sparc64               randconfig-002-20251107    gcc-9.5.0
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251107    clang-22
um                    randconfig-002-20251107    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251107    gcc-14
x86_64      buildonly-randconfig-002-20251107    clang-20
x86_64      buildonly-randconfig-003-20251107    gcc-14
x86_64      buildonly-randconfig-004-20251107    clang-20
x86_64      buildonly-randconfig-005-20251107    gcc-14
x86_64      buildonly-randconfig-006-20251107    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251107    gcc-14
x86_64                randconfig-012-20251107    gcc-14
x86_64                randconfig-013-20251107    clang-20
x86_64                randconfig-014-20251107    clang-20
x86_64                randconfig-015-20251107    gcc-14
x86_64                randconfig-016-20251107    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251107    gcc-10.5.0
xtensa                randconfig-002-20251107    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
