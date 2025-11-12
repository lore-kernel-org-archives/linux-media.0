Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2DB2D73BB
	for <linux-media@vger.kernel.org>; Wed, 12 Nov 2025 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973673; cv=none; b=FIXdzy3jNnGMiEHhAWf3dYU9JwpPnfKriDMrKXw5koh8/pr55/ilg3lAqXgqITYtzWZJTa1jtAmE2gY72g/Vd8lwuWGHnsQJ/WUy2WDKmvGJZ72s8djuhY+kH84SpB3RVbjpMsU9DuNHKBA5kr1JHJ/ttbpEJdVKJzZgf8ix184=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973673; c=relaxed/simple;
	bh=9qt+Mdo2/eT4a+BCpEb2Sez8ZadfAs6gXCoOzzYyUrc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PrLmSo253jTITeK9ozMUOcRqgi/gwzKYbQgYMIJPTW3V/ILZTbBAHHAS0mZCx2JpRapGR59AeRNhwG1ZmDBsdZzKqAfrvNdD0WM0vjB3TtC5ffio0pQn3KrcFVF25FcGTRO33FAnWuu0W2sl+nWOopy3N3wc2pEh7P8AvxTtOu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8WtMRpf; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8WtMRpf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762973671; x=1794509671;
  h=date:from:to:cc:subject:message-id;
  bh=9qt+Mdo2/eT4a+BCpEb2Sez8ZadfAs6gXCoOzzYyUrc=;
  b=i8WtMRpfNHySSFvUSz4tko7UfN3wzU9q54/uHE0VUPf3Ycfrc+N2mM7q
   ycakzxgRlbyjIIuzO5pktr9fph5jpGpYvDVegHc0WN+jc9Xna85fGTxUs
   8XjBYqUJQwPNCWX0t7HlWeCo/ZQF8DahkIqEWCXDdXwtWcFK62GcYV93I
   dIjI5lP2EIs2sx8odestESYBHIQL1tv4iGU8AdA/gzfmYPpDlM3PwKuOQ
   Jt3Zmf7bUDUABXTickFK2BqgvhWUfhOvIBmxCkATV45AzNc3i3OR37TDO
   JehQn+i3tgCVEE9LWX4T0/wl68e84PBHuTV9Js3hYxrTH/8/KMq9PArDM
   Q==;
X-CSE-ConnectionGUID: DcBFuVzGScOq1kXF7Y0Kpg==
X-CSE-MsgGUID: IaHiOnWKSM6bjyrCwsuHOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="90517202"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="90517202"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 10:54:30 -0800
X-CSE-ConnectionGUID: YsoPisCmSryxIYdK2BU3MQ==
X-CSE-MsgGUID: tYiakpMHQyyXenHtC/jp3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="190030744"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 12 Nov 2025 10:54:30 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJFz9-0004Xr-2K;
	Wed, 12 Nov 2025 18:54:27 +0000
Date: Thu, 13 Nov 2025 02:53:51 +0800
From: kernel test robot <lkp@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org
Subject: [sailus-media-tree:cleanup] BUILD SUCCESS
 6cf6c758446bfc5b6ee45dabc645bc03e0e0d39c
Message-ID: <202511130245.jxRPe4lW-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>

tree/branch: git://linuxtv.org/sailus/media_tree.git cleanup
branch HEAD: 6cf6c758446bfc5b6ee45dabc645bc03e0e0d39c  media: i2c: add Sony IMX111 CMOS camera sensor driver

elapsed time: 1676m

configs tested: 109
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251112    gcc-8.5.0
arc                   randconfig-002-20251112    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                                 defconfig    clang-22
arm                            hisi_defconfig    gcc-15.1.0
arm                        neponset_defconfig    gcc-15.1.0
arm                   randconfig-001-20251112    gcc-8.5.0
arm                   randconfig-002-20251112    clang-22
arm                   randconfig-003-20251112    clang-22
arm                   randconfig-004-20251112    gcc-14.3.0
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251112    clang-22
arm64                 randconfig-002-20251112    gcc-10.5.0
arm64                 randconfig-003-20251112    gcc-8.5.0
arm64                 randconfig-004-20251112    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251112    gcc-13.4.0
csky                  randconfig-002-20251112    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251112    clang-16
hexagon               randconfig-002-20251112    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251112    clang-20
i386        buildonly-randconfig-002-20251112    gcc-14
i386        buildonly-randconfig-003-20251112    clang-20
i386        buildonly-randconfig-004-20251112    clang-20
i386        buildonly-randconfig-005-20251112    gcc-13
i386        buildonly-randconfig-006-20251112    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251112    gcc-14
i386                  randconfig-002-20251112    gcc-14
i386                  randconfig-003-20251112    gcc-14
i386                  randconfig-004-20251112    clang-20
i386                  randconfig-005-20251112    clang-20
i386                  randconfig-006-20251112    clang-20
i386                  randconfig-007-20251112    gcc-13
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251112    gcc-15.1.0
loongarch             randconfig-002-20251112    gcc-13.4.0
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm47xx_defconfig    clang-18
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251112    gcc-11.5.0
nios2                 randconfig-002-20251112    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251112    gcc-9.5.0
parisc                randconfig-002-20251112    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251112    clang-22
powerpc               randconfig-002-20251112    clang-22
powerpc64             randconfig-001-20251112    clang-22
powerpc64             randconfig-002-20251112    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251113    gcc-8.5.0
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20251113    clang-22
s390                  randconfig-002-20251113    clang-17
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                        edosk7760_defconfig    gcc-15.1.0
sh                          polaris_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251112    gcc-8.5.0
sparc                 randconfig-002-20251112    gcc-14.3.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251112    gcc-8.5.0
sparc64               randconfig-002-20251112    clang-20
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251112    gcc-14
um                    randconfig-002-20251112    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           alldefconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251112    clang-20
x86_64      buildonly-randconfig-002-20251112    clang-20
x86_64      buildonly-randconfig-003-20251112    clang-20
x86_64      buildonly-randconfig-004-20251112    clang-20
x86_64      buildonly-randconfig-005-20251112    gcc-14
x86_64      buildonly-randconfig-006-20251112    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251112    gcc-14
x86_64                randconfig-003-20251112    gcc-12
x86_64                randconfig-004-20251112    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251112    gcc-12.5.0
xtensa                randconfig-002-20251112    gcc-8.5.0
xtensa                         virt_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
