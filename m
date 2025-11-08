Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646C519CD0A
	for <linux-media@vger.kernel.org>; Sat,  8 Nov 2025 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762618640; cv=none; b=JiA3FnRQWpgxn3jUdZ1cKGrpU1sLGxT7haCDGmHrZWNB3NpVREHVa0pxNc6+y7Wcnxx2IynMZY0xR0L+IdV7+YoSzZYfFmLxP4MROq/FdgUCta2ev5uIcKHmre+RpKl/DrFNm6vX2U7ppY84Xou+cxAkWWTZFzWH5hfluw7V/+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762618640; c=relaxed/simple;
	bh=/gcNQJp+b40JGumFW8fq0O797ND2AGDyJgezn6TKehs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cx2O7K5RCAswLmPWSRlDHHPLgMAlXBWN3/5e2yshHpqfupVoHfPCaF4B6m9boF+ifdpUH7Qq+pGBP0Lke6ohTXsFKHIMqlknDqnoomavHzR0ytznp5uUX1YeELsklIv7HLybBKMQu/XN0byODmEBnL0uYo4wq8ZY20RNmmhVC8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OlTYROIV; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OlTYROIV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762618639; x=1794154639;
  h=date:from:to:cc:subject:message-id;
  bh=/gcNQJp+b40JGumFW8fq0O797ND2AGDyJgezn6TKehs=;
  b=OlTYROIV3gWLyOQqzUxOfs/TtGxU6l1zN7+rOpQBJE+C8Nqw4jYtmwTy
   UtOPXqC+pycmZpngu+Vx/iGpxZpZNzh5BYpqjocG2pNenn8vadl/jQoeW
   2HveolZbSoI6gYWIgECxY4YuNu0Iyy7H33KNzzAV/A9Qn+ueM7R2DGlni
   4zA8I/tP4DqfA6fP4qn6sTZeOM4PsOJh+CnUnvE1suRH10UIVLBU9UCxc
   aNTPHswBfwcNHcs7h3UCfHQk5Xf8LxTvhn3Y/BI/OiJasm9WuXYsHJVlP
   V3JlOXcqgP0UjL97d9XIkrXxnXv59v3BFi5IPzoejDQ+zWBMXJb9CBpgV
   g==;
X-CSE-ConnectionGUID: f+b7oDcqQJS5Ssf6xMAzcA==
X-CSE-MsgGUID: ezgJD1KgSXmk2+E3FNHGWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="90209976"
X-IronPort-AV: E=Sophos;i="6.19,289,1754982000"; 
   d="scan'208";a="90209976"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 08:17:17 -0800
X-CSE-ConnectionGUID: mtT1lZgfTjW8XxQ11WRJZg==
X-CSE-MsgGUID: ixC6VWERQ62/UwdbwbgZFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,289,1754982000"; 
   d="scan'208";a="225555699"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 08 Nov 2025 08:17:16 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHlcn-0001Dv-1X;
	Sat, 08 Nov 2025 16:17:13 +0000
Date: Sun, 09 Nov 2025 00:16:33 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org
Subject: [linuxtv-media-pending:next] BUILD SUCCESS
 b4fbb13db86adb0bae1d7f968b61ea8dc9635e33
Message-ID: <202511090028.WDkjbWJx-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>

tree/branch: https://git.linuxtv.org/media-ci/media-pending.git next
branch HEAD: b4fbb13db86adb0bae1d7f968b61ea8dc9635e33  media: qcom: camss: Add support for MSM8939

elapsed time: 2937m

configs tested: 78
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.1.0
alpha                  allyesconfig    gcc-15.1.0
arc                     allnoconfig    gcc-15.1.0
arc         randconfig-001-20251107    gcc-8.5.0
arc         randconfig-002-20251107    gcc-9.5.0
arm                     allnoconfig    clang-22
arm         randconfig-001-20251107    clang-17
arm         randconfig-002-20251107    gcc-13.4.0
arm         randconfig-003-20251107    clang-22
arm         randconfig-004-20251107    gcc-8.5.0
arm64                   allnoconfig    gcc-15.1.0
arm64                  allyesconfig    clang-22
csky                   allmodconfig    gcc-15.1.0
csky                    allnoconfig    gcc-15.1.0
csky                   allyesconfig    gcc-15.1.0
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-22
hexagon                allyesconfig    clang-22
hexagon     randconfig-001-20251107    clang-22
hexagon     randconfig-002-20251107    clang-22
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                   allyesconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-22
loongarch              allyesconfig    clang-22
loongarch   randconfig-001-20251107    gcc-15.1.0
loongarch   randconfig-002-20251107    clang-19
m68k                   allmodconfig    gcc-15.1.0
m68k                    allnoconfig    gcc-15.1.0
m68k                   allyesconfig    gcc-15.1.0
microblaze             allmodconfig    gcc-15.1.0
microblaze              allnoconfig    gcc-15.1.0
microblaze             allyesconfig    gcc-15.1.0
mips                   allmodconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
mips                   allyesconfig    gcc-15.1.0
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
nios2                  allyesconfig    gcc-11.5.0
nios2       randconfig-001-20251107    gcc-11.5.0
nios2       randconfig-002-20251107    gcc-8.5.0
openrisc               allmodconfig    gcc-15.1.0
openrisc                allnoconfig    gcc-15.1.0
openrisc               allyesconfig    gcc-15.1.0
parisc                 allmodconfig    gcc-15.1.0
parisc                  allnoconfig    gcc-15.1.0
parisc                 allyesconfig    gcc-15.1.0
powerpc                allmodconfig    gcc-15.1.0
powerpc                 allnoconfig    gcc-15.1.0
powerpc                allyesconfig    clang-22
riscv                   allnoconfig    gcc-15.1.0
riscv       randconfig-001-20251107    clang-22
riscv       randconfig-002-20251107    gcc-13.4.0
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-22
s390                   allyesconfig    gcc-15.1.0
s390        randconfig-001-20251107    gcc-8.5.0
s390        randconfig-002-20251107    gcc-15.1.0
sh                     allmodconfig    gcc-15.1.0
sh                      allnoconfig    gcc-15.1.0
sh                     allyesconfig    gcc-15.1.0
sh          randconfig-001-20251107    gcc-13.4.0
sh          randconfig-002-20251107    gcc-11.5.0
sparc                  allmodconfig    gcc-15.1.0
sparc                   allnoconfig    gcc-15.1.0
sparc                  allyesconfig    gcc-15.1.0
sparc64                allmodconfig    clang-22
sparc64                allyesconfig    gcc-15.1.0
um                     allmodconfig    clang-19
um                      allnoconfig    clang-22
um                     allyesconfig    gcc-14
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.1.0
xtensa                 allyesconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
