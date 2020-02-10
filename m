Return-Path: <SRS0=NCVB=36=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7E4C3B186
	for <linux-media@archiver.kernel.org>; Mon, 10 Feb 2020 06:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E1921927
	for <linux-media@archiver.kernel.org>; Mon, 10 Feb 2020 06:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581314643;
	bh=P4LnyLZ65S8o8II+eEhSbCd4kvDsh7wLEYquFYAmk84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0q+HloVxXdQXbGfh4aJ9/dqVksuyH4Muc8Cqq7ZZ0aGbiXJqJdQ4lULavO/f/Asu5
	 OVavQXvzjkQChJ1gzkD4GKUZNXi5rTNkMyePMdsI000QmGyY5WwyoWIw940p5BdjBO
	 JRmNGj+KLlWQx7d36GLD/f3uBHLYpJUYM55Zmf/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgBJGEC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 10 Feb 2020 01:04:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36326 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbgBJGDM (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 10 Feb 2020 01:03:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CzvFNiYCk6rJkYqH7EYJZ58H6P3c8r/RaU40sj/CJoI=; b=jiQdTZs1FzJ+u4sw9+hMXi1vts
        3xjm7DpEsDfx6YZ2JxgW4RwkKuLDQPo9nw9lHJLuq/ods7m1Rox/qZkbvlVGUAR2scP/EcWNQMc2L
        +KgY/oDtPSyg0NvSN4Rfgay8B9ikbgajAtyxGgEYQAbQHu7vzD4XAtUQJId7odLXlaoUc8R5XASVI
        ouVT8ydpv1Y93WdffHOTMkrzshHn7XLlKc4eSJBSR2KpgP9QDcYFddobNHi3UEm6lba05Xst1ARiy
        rPSfdKqcqpXLBt6gkOQbEnXxkHwpvcKRwDVgg+fquhw3auEVuU7ZGboRdwhHZ5VWH+fM8s9q6tO5q
        mzcVBOCg==;
Received: from [80.156.29.194] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j12A4-0006Tt-39; Mon, 10 Feb 2020 06:03:12 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j12A2-00C2W5-Dk; Mon, 10 Feb 2020 07:03:10 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 19/28] docs: kvm: arm/psci.txt: convert to ReST
Date:   Mon, 10 Feb 2020 07:02:57 +0100
Message-Id: <fc2e287a392fefca192045854d91051bea297c1f.1581314317.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581314316.git.mchehab+huawei@kernel.org>
References: <cover.1581314316.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

- Add a title for the document;
- Adjust whitespaces for it to be properly formatted after
  parsed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/virt/kvm/arm/index.rst          |  1 +
 .../virt/kvm/arm/{psci.txt => psci.rst}       | 46 +++++++++++++------
 2 files changed, 32 insertions(+), 15 deletions(-)
 rename Documentation/virt/kvm/arm/{psci.txt => psci.rst} (60%)

diff --git a/Documentation/virt/kvm/arm/index.rst b/Documentation/virt/kvm/arm/index.rst
index 134fa5fa77e5..3e2b2aba90fc 100644
--- a/Documentation/virt/kvm/arm/index.rst
+++ b/Documentation/virt/kvm/arm/index.rst
@@ -8,4 +8,5 @@ ARM
    :maxdepth: 2
 
    hyp-abi
+   psci
    pvtime
diff --git a/Documentation/virt/kvm/arm/psci.txt b/Documentation/virt/kvm/arm/psci.rst
similarity index 60%
rename from Documentation/virt/kvm/arm/psci.txt
rename to Documentation/virt/kvm/arm/psci.rst
index 559586fc9d37..d52c2e83b5b8 100644
--- a/Documentation/virt/kvm/arm/psci.txt
+++ b/Documentation/virt/kvm/arm/psci.rst
@@ -1,3 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================================
+Power State Coordination Interface (PSCI)
+=========================================
+
 KVM implements the PSCI (Power State Coordination Interface)
 specification in order to provide services such as CPU on/off, reset
 and power-off to the guest.
@@ -30,32 +36,42 @@ The following register is defined:
   - Affects the whole VM (even if the register view is per-vcpu)
 
 * KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1:
-  Holds the state of the firmware support to mitigate CVE-2017-5715, as
-  offered by KVM to the guest via a HVC call. The workaround is described
-  under SMCCC_ARCH_WORKAROUND_1 in [1].
+    Holds the state of the firmware support to mitigate CVE-2017-5715, as
+    offered by KVM to the guest via a HVC call. The workaround is described
+    under SMCCC_ARCH_WORKAROUND_1 in [1].
+
   Accepted values are:
-    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL: KVM does not offer
+
+    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL:
+      KVM does not offer
       firmware support for the workaround. The mitigation status for the
       guest is unknown.
-    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL: The workaround HVC call is
+    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL:
+      The workaround HVC call is
       available to the guest and required for the mitigation.
-    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_REQUIRED: The workaround HVC call
+    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_REQUIRED:
+      The workaround HVC call
       is available to the guest, but it is not needed on this VCPU.
 
 * KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2:
-  Holds the state of the firmware support to mitigate CVE-2018-3639, as
-  offered by KVM to the guest via a HVC call. The workaround is described
-  under SMCCC_ARCH_WORKAROUND_2 in [1].
+    Holds the state of the firmware support to mitigate CVE-2018-3639, as
+    offered by KVM to the guest via a HVC call. The workaround is described
+    under SMCCC_ARCH_WORKAROUND_2 in [1]_.
+
   Accepted values are:
-    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL: A workaround is not
+
+    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL:
+      A workaround is not
       available. KVM does not offer firmware support for the workaround.
-    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNKNOWN: The workaround state is
+    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNKNOWN:
+      The workaround state is
       unknown. KVM does not offer firmware support for the workaround.
-    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL: The workaround is available,
+    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL:
+      The workaround is available,
       and can be disabled by a vCPU. If
       KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED is set, it is active for
       this vCPU.
-    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED: The workaround is
-      always active on this vCPU or it is not needed.
+    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED:
+      The workaround is always active on this vCPU or it is not needed.
 
-[1] https://developer.arm.com/-/media/developer/pdf/ARM_DEN_0070A_Firmware_interfaces_for_mitigating_CVE-2017-5715.pdf
+.. [1] https://developer.arm.com/-/media/developer/pdf/ARM_DEN_0070A_Firmware_interfaces_for_mitigating_CVE-2017-5715.pdf
-- 
2.24.1

