Return-Path: <SRS0=0Sen=32=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785E9C33CAC
	for <linux-media@archiver.kernel.org>; Thu,  6 Feb 2020 14:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F3C20838
	for <linux-media@archiver.kernel.org>; Thu,  6 Feb 2020 14:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581000656;
	bh=vQJLLZn3vi8CC0s8MsnvWwQMGx7seGAxYjef4Wj5uNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pm3DwJJO68yOYCJK4lDuoeIyIVz6qozV1+T43Y4R+jviT9t0YMnIUPnB+RzbzFsDG
	 UF110WPYwx7JxTuq1nBydietBOS9VkmWR2YCVSZdIo0UBscav+gr9qULfhtnn1t7cM
	 mh3/CZRd/Bzn5dnZBsKYdpScCLIkTeYoR8TI7K2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgBFOux (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 6 Feb 2020 09:50:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55642 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbgBFOuk (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 6 Feb 2020 09:50:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mGZFeY/9WqxIo7KFW0Czxynn3cnW2ZRXL0gMI5TxJeM=; b=ZEPLmzRDQuPnqfrdm2+b+KqART
        Z9CQ3Dl2aK3Y1R3Fxg6L81v8QJjd/HbbX1FWvPqb/IzAigNxME4zLqB9PtYOiHd2NXIn7pSeJMId8
        M///V+ud9vEu4EHwJoGr+ti15DqKHkOPmqF+iSw+7RtNhirYQcaedM8kM6ubTCYrzh+H05dMfkZl2
        vCBkOeYd8eSHTaOPw7ChHkpPVRopvDT1W70LkXhQpZRby5nLoslJxXbIj1pz6IzIudnGeC8aOvvna
        DCKvMp0gRnDTaiQFHiMcJlbr7HuizwKpPamV4yxTW93sZPpjwwFIT+kD4nWAzOtOBHG4JdifENw9+
        8mAmyhkg==;
Received: from [179.95.15.160] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iziUI-0004Ir-UK; Thu, 06 Feb 2020 14:50:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1iziU6-002nL3-JU; Thu, 06 Feb 2020 15:50:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 12/27] docs: kvm: convert devices/vcpu.txt to ReST
Date:   Thu,  6 Feb 2020 15:50:09 +0100
Message-Id: <011ccabd61ce299e638a9545adf7f59eead15131.1581000481.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581000481.git.mchehab+huawei@kernel.org>
References: <cover.1581000481.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

- Use title markups;
- adjust indentation and add blank lines as needed;
- adjust tables to match ReST accepted formats;
- use :field: markups;
- mark code blocks as such.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/virt/kvm/devices/index.rst |   1 +
 Documentation/virt/kvm/devices/vcpu.rst  | 114 +++++++++++++++++++++++
 Documentation/virt/kvm/devices/vcpu.txt  |  76 ---------------
 3 files changed, 115 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/virt/kvm/devices/vcpu.rst
 delete mode 100644 Documentation/virt/kvm/devices/vcpu.txt

diff --git a/Documentation/virt/kvm/devices/index.rst b/Documentation/virt/kvm/devices/index.rst
index e6caccc36623..5a61838f0e61 100644
--- a/Documentation/virt/kvm/devices/index.rst
+++ b/Documentation/virt/kvm/devices/index.rst
@@ -12,3 +12,4 @@ Devices
    arm-vgic-v3
    mpic
    s390_flic
+   vcpu
diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
new file mode 100644
index 000000000000..e4e41b7fcac3
--- /dev/null
+++ b/Documentation/virt/kvm/devices/vcpu.rst
@@ -0,0 +1,114 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+Generic vcpu interface
+======================
+
+The virtual cpu "device" also accepts the ioctls KVM_SET_DEVICE_ATTR,
+KVM_GET_DEVICE_ATTR, and KVM_HAS_DEVICE_ATTR. The interface uses the same struct
+kvm_device_attr as other devices, but targets VCPU-wide settings and controls.
+
+The groups and attributes per virtual cpu, if any, are architecture specific.
+
+1. GROUP: KVM_ARM_VCPU_PMU_V3_CTRL
+==================================
+
+:Architectures: ARM64
+
+1.1. ATTRIBUTE: KVM_ARM_VCPU_PMU_V3_IRQ
+---------------------------------------
+
+:Parameters: in kvm_device_attr.addr the address for PMU overflow interrupt is a
+	     pointer to an int
+
+Returns:
+
+	 =======  ========================================================
+	 -EBUSY   The PMU overflow interrupt is already set
+	 -ENXIO   The overflow interrupt not set when attempting to get it
+	 -ENODEV  PMUv3 not supported
+	 -EINVAL  Invalid PMU overflow interrupt number supplied or
+		  trying to set the IRQ number without using an in-kernel
+		  irqchip.
+	 =======  ========================================================
+
+A value describing the PMUv3 (Performance Monitor Unit v3) overflow interrupt
+number for this vcpu. This interrupt could be a PPI or SPI, but the interrupt
+type must be same for each vcpu. As a PPI, the interrupt number is the same for
+all vcpus, while as an SPI it must be a separate number per vcpu.
+
+1.2 ATTRIBUTE: KVM_ARM_VCPU_PMU_V3_INIT
+---------------------------------------
+
+:Parameters: no additional parameter in kvm_device_attr.addr
+
+Returns:
+
+	 =======  ======================================================
+	 -ENODEV  PMUv3 not supported or GIC not initialized
+	 -ENXIO   PMUv3 not properly configured or in-kernel irqchip not
+		  configured as required prior to calling this attribute
+	 -EBUSY   PMUv3 already initialized
+	 =======  ======================================================
+
+Request the initialization of the PMUv3.  If using the PMUv3 with an in-kernel
+virtual GIC implementation, this must be done after initializing the in-kernel
+irqchip.
+
+
+2. GROUP: KVM_ARM_VCPU_TIMER_CTRL
+=================================
+
+:Architectures: ARM,ARM64
+
+2.1. ATTRIBUTES: KVM_ARM_VCPU_TIMER_IRQ_VTIMER, KVM_ARM_VCPU_TIMER_IRQ_PTIMER
+-----------------------------------------------------------------------------
+
+:Parameters: in kvm_device_attr.addr the address for the timer interrupt is a
+	     pointer to an int
+
+Returns:
+
+	 =======  =================================
+	 -EINVAL  Invalid timer interrupt number
+	 -EBUSY   One or more VCPUs has already run
+	 =======  =================================
+
+A value describing the architected timer interrupt number when connected to an
+in-kernel virtual GIC.  These must be a PPI (16 <= intid < 32).  Setting the
+attribute overrides the default values (see below).
+
+=============================  ==========================================
+KVM_ARM_VCPU_TIMER_IRQ_VTIMER  The EL1 virtual timer intid (default: 27)
+KVM_ARM_VCPU_TIMER_IRQ_PTIMER  The EL1 physical timer intid (default: 30)
+=============================  ==========================================
+
+Setting the same PPI for different timers will prevent the VCPUs from running.
+Setting the interrupt number on a VCPU configures all VCPUs created at that
+time to use the number provided for a given timer, overwriting any previously
+configured values on other VCPUs.  Userspace should configure the interrupt
+numbers on at least one VCPU after creating all VCPUs and before running any
+VCPUs.
+
+3. GROUP: KVM_ARM_VCPU_PVTIME_CTRL
+==================================
+
+:Architectures: ARM64
+
+3.1 ATTRIBUTE: KVM_ARM_VCPU_PVTIME_IPA
+--------------------------------------
+
+:Parameters: 64-bit base address
+
+Returns:
+
+	 =======  ======================================
+	 -ENXIO   Stolen time not implemented
+	 -EEXIST  Base address already set for this VCPU
+	 -EINVAL  Base address not 64 byte aligned
+	 =======  ======================================
+
+Specifies the base address of the stolen time structure for this VCPU. The
+base address must be 64 byte aligned and exist within a valid guest memory
+region. See Documentation/virt/kvm/arm/pvtime.txt for more information
+including the layout of the stolen time structure.
diff --git a/Documentation/virt/kvm/devices/vcpu.txt b/Documentation/virt/kvm/devices/vcpu.txt
deleted file mode 100644
index 6f3bd64a05b0..000000000000
--- a/Documentation/virt/kvm/devices/vcpu.txt
+++ /dev/null
@@ -1,76 +0,0 @@
-Generic vcpu interface
-====================================
-
-The virtual cpu "device" also accepts the ioctls KVM_SET_DEVICE_ATTR,
-KVM_GET_DEVICE_ATTR, and KVM_HAS_DEVICE_ATTR. The interface uses the same struct
-kvm_device_attr as other devices, but targets VCPU-wide settings and controls.
-
-The groups and attributes per virtual cpu, if any, are architecture specific.
-
-1. GROUP: KVM_ARM_VCPU_PMU_V3_CTRL
-Architectures: ARM64
-
-1.1. ATTRIBUTE: KVM_ARM_VCPU_PMU_V3_IRQ
-Parameters: in kvm_device_attr.addr the address for PMU overflow interrupt is a
-            pointer to an int
-Returns: -EBUSY: The PMU overflow interrupt is already set
-         -ENXIO: The overflow interrupt not set when attempting to get it
-         -ENODEV: PMUv3 not supported
-         -EINVAL: Invalid PMU overflow interrupt number supplied or
-                  trying to set the IRQ number without using an in-kernel
-                  irqchip.
-
-A value describing the PMUv3 (Performance Monitor Unit v3) overflow interrupt
-number for this vcpu. This interrupt could be a PPI or SPI, but the interrupt
-type must be same for each vcpu. As a PPI, the interrupt number is the same for
-all vcpus, while as an SPI it must be a separate number per vcpu.
-
-1.2 ATTRIBUTE: KVM_ARM_VCPU_PMU_V3_INIT
-Parameters: no additional parameter in kvm_device_attr.addr
-Returns: -ENODEV: PMUv3 not supported or GIC not initialized
-         -ENXIO: PMUv3 not properly configured or in-kernel irqchip not
-                 configured as required prior to calling this attribute
-         -EBUSY: PMUv3 already initialized
-
-Request the initialization of the PMUv3.  If using the PMUv3 with an in-kernel
-virtual GIC implementation, this must be done after initializing the in-kernel
-irqchip.
-
-
-2. GROUP: KVM_ARM_VCPU_TIMER_CTRL
-Architectures: ARM,ARM64
-
-2.1. ATTRIBUTE: KVM_ARM_VCPU_TIMER_IRQ_VTIMER
-2.2. ATTRIBUTE: KVM_ARM_VCPU_TIMER_IRQ_PTIMER
-Parameters: in kvm_device_attr.addr the address for the timer interrupt is a
-            pointer to an int
-Returns: -EINVAL: Invalid timer interrupt number
-         -EBUSY:  One or more VCPUs has already run
-
-A value describing the architected timer interrupt number when connected to an
-in-kernel virtual GIC.  These must be a PPI (16 <= intid < 32).  Setting the
-attribute overrides the default values (see below).
-
-KVM_ARM_VCPU_TIMER_IRQ_VTIMER: The EL1 virtual timer intid (default: 27)
-KVM_ARM_VCPU_TIMER_IRQ_PTIMER: The EL1 physical timer intid (default: 30)
-
-Setting the same PPI for different timers will prevent the VCPUs from running.
-Setting the interrupt number on a VCPU configures all VCPUs created at that
-time to use the number provided for a given timer, overwriting any previously
-configured values on other VCPUs.  Userspace should configure the interrupt
-numbers on at least one VCPU after creating all VCPUs and before running any
-VCPUs.
-
-3. GROUP: KVM_ARM_VCPU_PVTIME_CTRL
-Architectures: ARM64
-
-3.1 ATTRIBUTE: KVM_ARM_VCPU_PVTIME_IPA
-Parameters: 64-bit base address
-Returns: -ENXIO:  Stolen time not implemented
-         -EEXIST: Base address already set for this VCPU
-         -EINVAL: Base address not 64 byte aligned
-
-Specifies the base address of the stolen time structure for this VCPU. The
-base address must be 64 byte aligned and exist within a valid guest memory
-region. See Documentation/virt/kvm/arm/pvtime.txt for more information
-including the layout of the stolen time structure.
-- 
2.24.1

