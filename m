Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953A11946DF
	for <linux-media@vger.kernel.org>; Tue,  4 Nov 2025 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762269064; cv=none; b=fQdiAW8T4qQzOQJwZTlIwpDonkiRUKSlIjyp9ONd0USY7L9NyU94MOP+iRc1ZC8GkpjDrVkc/eqILdoCB/1Iu3Qm2M7YymxXCvhc+t9DQN3KfSG7GoDy2SFOvs/3siahq3RUUgJ25DeC5Hnk9eOTozisIxwM17Mj6fVlUrBIMMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762269064; c=relaxed/simple;
	bh=3fqZEaB4mb+GkWEyY8C/VfcBCrbLwS5C9rQsb8THtvs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FIbP+D/ASjmi1EgoZ/PrTvCEssZdA2Y6HlGn/owNgSSA/OQXxaxHSwhyDCz0ZVJLvcJowSvv0nkDPUPDS+CSsSoDBlFOJodO7Tz/5ftEM0FR2+mxQ04j0wvksb+Sn9gTKOLgmMQh8e3VticWTfHAqUqJNa/ahtEvoQDgVYlkMKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aYgIygnp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYgIygnp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762269062; x=1793805062;
  h=date:from:to:cc:subject:message-id;
  bh=3fqZEaB4mb+GkWEyY8C/VfcBCrbLwS5C9rQsb8THtvs=;
  b=aYgIygnpeP4D2s4UBAkoKLxMDS1OBmQNtzYB8kCNS61SSlna0Z8jjayn
   BK5C8WxjmxVxHCf3hY05t4ppS06O8aoh6tkOkuFZ/FOyEvi3xULfDtxqP
   lA24SiJPs8G8E84LpJXdBJgD3USUdUHRtvW+IcSb5Fwfj1a2eQSMo7eKo
   zMczLnM+9Yd+wPnMTmwuf47Oj06Wn7Sp1dkSep1wy4gSwKFGT7vmzvXEE
   3f/8NFi00jhlJYAC6MOH6OOSV7Ci4o3EblUOTfcu7DPVL8blUMiCN2nIK
   vSySjtF1I8tFidIQARbN2uVG/GyxCswKnogH8CxfI9s2M0LbSBuDJP4eR
   Q==;
X-CSE-ConnectionGUID: GtI11N/DSO6gE/jU7xLfxg==
X-CSE-MsgGUID: 95jPW0V9RuSBGrIUF3RCWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="75815563"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="75815563"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 07:11:02 -0800
X-CSE-ConnectionGUID: H8Y+TKbhRli5d3PsCRSNog==
X-CSE-MsgGUID: OzK7z/uVTFOTYy6F4MZXeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="217827859"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 04 Nov 2025 07:11:01 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGIgU-000RWw-36;
	Tue, 04 Nov 2025 15:10:59 +0000
Date: Tue, 04 Nov 2025 23:01:07 +0800
From: kernel test robot <lkp@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org
Subject: [sailus-media-tree:cleanup] BUILD SUCCESS
 719cde9fc071cfc633387510d0f84d9078bcb678
Message-ID: <202511042301.grNDIeUk-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>

tree/branch: git://linuxtv.org/sailus/media_tree.git cleanup
branch HEAD: 719cde9fc071cfc633387510d0f84d9078bcb678  media: imx-mipi-csis: Support active data lanes differing from maximum

elapsed time: 1475m

configs tested: 117
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                          axs101_defconfig    gcc-15.1.0
arc                   randconfig-001-20251104    gcc-12.5.0
arc                   randconfig-002-20251104    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                         lpc18xx_defconfig    clang-22
arm                   randconfig-001-20251104    gcc-14.3.0
arm                   randconfig-002-20251104    gcc-10.5.0
arm                   randconfig-003-20251104    clang-22
arm                   randconfig-004-20251104    gcc-8.5.0
arm                           spitz_defconfig    gcc-15.1.0
arm                         vf610m4_defconfig    gcc-15.1.0
arm                         wpcm450_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                  randconfig-001-20251104    gcc-10.5.0
csky                  randconfig-002-20251104    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251104    clang-22
hexagon               randconfig-002-20251104    clang-16
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251104    gcc-14
i386        buildonly-randconfig-002-20251104    clang-20
i386        buildonly-randconfig-003-20251104    gcc-12
i386        buildonly-randconfig-004-20251104    gcc-14
i386        buildonly-randconfig-005-20251104    gcc-12
i386        buildonly-randconfig-006-20251104    gcc-14
i386                  randconfig-001-20251104    gcc-12
i386                  randconfig-002-20251104    gcc-14
i386                  randconfig-003-20251104    clang-20
i386                  randconfig-004-20251104    gcc-14
i386                  randconfig-005-20251104    gcc-14
i386                  randconfig-006-20251104    gcc-14
i386                  randconfig-007-20251104    gcc-14
i386                  randconfig-011-20251104    gcc-13
i386                  randconfig-012-20251104    clang-20
i386                  randconfig-013-20251104    gcc-14
i386                  randconfig-014-20251104    clang-20
i386                  randconfig-015-20251104    gcc-14
i386                  randconfig-016-20251104    clang-20
i386                  randconfig-017-20251104    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251104    gcc-15.1.0
loongarch             randconfig-002-20251104    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251104    gcc-8.5.0
nios2                 randconfig-002-20251104    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20251104    gcc-8.5.0
parisc                randconfig-002-20251104    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                     mpc512x_defconfig    clang-22
powerpc               randconfig-001-20251104    gcc-15.1.0
powerpc               randconfig-002-20251104    clang-22
powerpc64             randconfig-001-20251104    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251104    gcc-8.5.0
riscv                 randconfig-002-20251104    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251104    clang-22
s390                  randconfig-002-20251104    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         ap325rxa_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251104    gcc-13.4.0
sh                    randconfig-002-20251104    gcc-11.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20251104    gcc-13.4.0
sparc                 randconfig-002-20251104    gcc-12.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251104    gcc-8.5.0
sparc64               randconfig-002-20251104    clang-22
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251104    clang-22
um                    randconfig-002-20251104    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251104    clang-20
x86_64      buildonly-randconfig-002-20251104    gcc-12
x86_64      buildonly-randconfig-003-20251104    gcc-14
x86_64      buildonly-randconfig-004-20251104    gcc-14
x86_64      buildonly-randconfig-005-20251104    gcc-12
x86_64      buildonly-randconfig-006-20251104    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251104    gcc-14
x86_64                randconfig-012-20251104    gcc-14
x86_64                randconfig-013-20251104    clang-20
x86_64                randconfig-014-20251104    clang-20
x86_64                randconfig-015-20251104    gcc-14
x86_64                randconfig-016-20251104    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251104    gcc-13.4.0
xtensa                randconfig-002-20251104    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
