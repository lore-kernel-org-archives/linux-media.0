Return-Path: <SRS0=0Sen=32=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF52C352A4
	for <linux-media@archiver.kernel.org>; Thu,  6 Feb 2020 14:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E680520838
	for <linux-media@archiver.kernel.org>; Thu,  6 Feb 2020 14:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581000665;
	bh=AFD65OKSV1+A0vldGPtU8+SJqCThPuv3WOKajnC2d8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lA8JLZ2HsDRiOmX6B3tgxwCZKv81sCqvGFH+ZTGjKwyhRzKBcXrE22Hl0Za462+Wi
	 wZW1S+b0jYrun8u2LCiIwJwHZ7jDU2dl7gi21yA8pnNC2xGz9C885ea0wNZk7fnRWE
	 RLoSA/ngFVnQ8yZwgXKvtAFi7x08Mlq4rcv1v/Qc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgBFOvD (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 6 Feb 2020 09:51:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55632 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbgBFOuj (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 6 Feb 2020 09:50:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=0NdNmLSXcScD8m9tuo9ayLdWPmuOQKKz8+PbS3hVgr4=; b=GvaxT7oS2UDy8pRTsZR0XupZpU
        GYZILZM0AUq3Itj+oIPimlvsH+W4Gi26DMWye6aoRVvJDyMoDoNBsPyVu9NkhEzfxJszdSO/XrqQf
        zYZP/FaN+8SCEbFjhM8H8Fl5kuMu2DB271xvlHVblf+9zGeUbyTpmnhh+jId5HrWFIlu893KVQEHu
        24eLlZm1d5nD/cQu0/KkpRjHRq6y54ctiGF6gcMVWitPWMdJtXZvH/2sAlsry+PHlYNNupbBem7fx
        Xn08kQ+ASIwKyBkX64dCYU8nPHfrooNex3S4sJoq7NkuTnYGzKGNJ+9NgrNB0D9peiLNT24kmE0Ri
        cOR21JZA==;
Received: from [179.95.15.160] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iziUJ-0004Iu-62; Thu, 06 Feb 2020 14:50:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1iziU6-002nKv-HY; Thu, 06 Feb 2020 15:50:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 10/27] docs: kvm: convert devices/mpic.txt to ReST
Date:   Thu,  6 Feb 2020 15:50:07 +0100
Message-Id: <3d9f3e53bec7f4c59cc3ea932428721d982fd5af.1581000481.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581000481.git.mchehab+huawei@kernel.org>
References: <cover.1581000481.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This document is almost in ReST format. The only thing
needed is to mark a list as such and to add an extra
whitespace.

Yet, let's also use the standard document title markup,
as it makes easier if anyone wants later to add sessions
to it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/virt/kvm/devices/index.rst              |  1 +
 Documentation/virt/kvm/devices/{mpic.txt => mpic.rst} | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)
 rename Documentation/virt/kvm/devices/{mpic.txt => mpic.rst} (91%)

diff --git a/Documentation/virt/kvm/devices/index.rst b/Documentation/virt/kvm/devices/index.rst
index 7eabce80c61e..9e5586e371de 100644
--- a/Documentation/virt/kvm/devices/index.rst
+++ b/Documentation/virt/kvm/devices/index.rst
@@ -10,3 +10,4 @@ Devices
    arm-vgic-its
    arm-vgic
    arm-vgic-v3
+   mpic
diff --git a/Documentation/virt/kvm/devices/mpic.txt b/Documentation/virt/kvm/devices/mpic.rst
similarity index 91%
rename from Documentation/virt/kvm/devices/mpic.txt
rename to Documentation/virt/kvm/devices/mpic.rst
index 8257397adc3c..55cefe030d41 100644
--- a/Documentation/virt/kvm/devices/mpic.txt
+++ b/Documentation/virt/kvm/devices/mpic.rst
@@ -1,9 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================
 MPIC interrupt controller
 =========================
 
 Device types supported:
-  KVM_DEV_TYPE_FSL_MPIC_20     Freescale MPIC v2.0
-  KVM_DEV_TYPE_FSL_MPIC_42     Freescale MPIC v4.2
+
+  - KVM_DEV_TYPE_FSL_MPIC_20     Freescale MPIC v2.0
+  - KVM_DEV_TYPE_FSL_MPIC_42     Freescale MPIC v4.2
 
 Only one MPIC instance, of any type, may be instantiated.  The created
 MPIC will act as the system interrupt controller, connecting to each
@@ -11,7 +15,8 @@ vcpu's interrupt inputs.
 
 Groups:
   KVM_DEV_MPIC_GRP_MISC
-  Attributes:
+   Attributes:
+
     KVM_DEV_MPIC_BASE_ADDR (rw, 64-bit)
       Base address of the 256 KiB MPIC register space.  Must be
       naturally aligned.  A value of zero disables the mapping.
-- 
2.24.1

