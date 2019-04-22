Return-Path: <SRS0=+FiN=SY=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F55FC10F11
	for <linux-media@archiver.kernel.org>; Mon, 22 Apr 2019 19:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166D721738
	for <linux-media@archiver.kernel.org>; Mon, 22 Apr 2019 19:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbfDVTvz (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:51:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:19689 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731278AbfDVTvw (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 22 Apr 2019 15:51:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Apr 2019 12:51:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,383,1549958400"; 
   d="scan'208";a="339788177"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 22 Apr 2019 12:51:50 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hIeyk-000CZy-5i; Tue, 23 Apr 2019 03:51:50 +0800
Date:   Tue, 23 Apr 2019 03:51:11 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org
Subject: [ragnatech:media-tree] BUILD SUCCESS
 a4dfc8a24796ff312d1d307e11f26f8ca466e938
Message-ID: <5cbe1b2f.U3jB5ga+iqMHpAws%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

tree/branch: git://git.ragnatech.se/linux  media-tree
branch HEAD: a4dfc8a24796ff312d1d307e11f26f8ca466e938  media: MAINTAINERS: Update AO CEC with ao-cec-g12a driver

elapsed time: 133m

configs tested: 164

The following configs have been built successfully.
More configs may be tested in the coming days.

i386                   randconfig-x010-201916
i386                   randconfig-x018-201916
i386                   randconfig-x017-201916
i386                   randconfig-x013-201916
i386                   randconfig-x011-201916
i386                   randconfig-x014-201916
i386                   randconfig-x019-201916
i386                   randconfig-x015-201916
i386                   randconfig-x016-201916
i386                   randconfig-x012-201916
i386                     randconfig-n2-201916
i386                     randconfig-n3-201916
i386                     randconfig-n0-201916
i386                     randconfig-n1-201916
x86_64                 randconfig-x004-201916
x86_64                 randconfig-x001-201916
x86_64                 randconfig-x000-201916
x86_64                 randconfig-x003-201916
x86_64                 randconfig-x008-201916
x86_64                 randconfig-x007-201916
x86_64                 randconfig-x002-201916
x86_64                 randconfig-x006-201916
x86_64                 randconfig-x009-201916
x86_64                 randconfig-x005-201916
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                     randconfig-i0-201916
i386                     randconfig-i1-201916
i386                     randconfig-i2-201916
i386                     randconfig-i3-201916
riscv                             allnoconfig
riscv                               defconfig
x86_64                 randconfig-x015-201916
x86_64                 randconfig-x016-201916
x86_64                 randconfig-x017-201916
x86_64                 randconfig-x012-201916
x86_64                 randconfig-x013-201916
x86_64                 randconfig-x018-201916
x86_64                 randconfig-x010-201916
x86_64                 randconfig-x014-201916
x86_64                 randconfig-x019-201916
x86_64                 randconfig-x011-201916
i386                     randconfig-a1-201916
i386                     randconfig-a2-201916
i386                     randconfig-a0-201916
i386                     randconfig-a3-201916
x86_64                 randconfig-k2-04220059
x86_64                 randconfig-k0-04220059
i386                   randconfig-k3-04220059
i386                   randconfig-k1-04220059
x86_64                 randconfig-k3-04220059
x86_64                 randconfig-k1-04220059
i386                   randconfig-k2-04220059
i386                   randconfig-k0-04220059
arm                              allmodconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
riscv                              tinyconfig
i386                               tinyconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                           allmodconfig
i386                             alldefconfig
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
nds32                             allnoconfig
nds32                               defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                              fedora-25
i386                     randconfig-m0-201916
x86_64                   randconfig-m2-201916
i386                     randconfig-m3-201916
i386                     randconfig-m2-201916
x86_64                   randconfig-m1-201916
x86_64                   randconfig-m0-201916
x86_64                   randconfig-m3-201916
i386                     randconfig-m1-201916
x86_64                 randconfig-l0-04221612
x86_64                 randconfig-l1-04221612
x86_64                 randconfig-l2-04221612
x86_64                 randconfig-l3-04221612
i386                   randconfig-l0-04221612
i386                   randconfig-l1-04221612
i386                   randconfig-l2-04221612
i386                   randconfig-l3-04221612
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
um                                  defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                           allyesconfig
i386                             allmodconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-x077-201916
i386                   randconfig-x074-201916
i386                   randconfig-x070-201916
i386                   randconfig-x072-201916
i386                   randconfig-x075-201916
i386                   randconfig-x071-201916
i386                   randconfig-x079-201916
i386                   randconfig-x078-201916
i386                   randconfig-x073-201916
i386                   randconfig-x076-201916
i386                              allnoconfig
i386                                defconfig
i386                   randconfig-x002-201916
i386                   randconfig-x001-201916
i386                   randconfig-x005-201916
i386                   randconfig-x007-201916
i386                   randconfig-x000-201916
i386                   randconfig-x004-201916
i386                   randconfig-x008-201916
i386                   randconfig-x009-201916
i386                   randconfig-x006-201916
i386                   randconfig-x003-201916
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
