Return-Path: <SRS0=NCVB=36=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D209C35250
	for <linux-media@archiver.kernel.org>; Mon, 10 Feb 2020 06:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AF82465B
	for <linux-media@archiver.kernel.org>; Mon, 10 Feb 2020 06:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581314641;
	bh=kza+nIaub/EO+u1abwbBpyZvce4UHjBfCCjb8bXTkqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sxtUVIuPsh3pKSB5KOrBhnNnWZN4wo/jQDgsZah+zSOV7NPvN3nI+3bJcj/UTGc6x
	 T8aBVTbJSUI+zWme2XvE72N7CoJ5RWiN3leG3yTc/dKTTJ6vj4Zc+XB+5VUyeGVL+Q
	 Yca1O+AdGBZkhszjF1Ty24lNrucAKc+IE2GE9nhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgBJGDp (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 10 Feb 2020 01:03:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36330 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbgBJGDM (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 10 Feb 2020 01:03:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=p2YhU3jfC3+pZD58yyGjx9QrnEOyUsPJA0xSIIWllRk=; b=c9V4kU8saJN9Y9mvu0C3MA0dxc
        2rNYXuRxjKsOO1gQZkbQyxByF2w2v6RHgT15ytnblAeVKkxTVLq62d49oRnZuR0PrGF8St9nlp+g8
        bsAmfV0ch6BoCJVR6v+G7YPb6f6IWoKonrdKBGfbGrUpAOC4tvhjHjVEDKkwQhCciBlrgprgKp432
        J07yMjFfnEWRAC4/SMnjBSHeqmTTvIN4hJeQ2JTNP+LeFzWs9JGrjW0H41dBcXhAo7W+sy38LO6kX
        ojRYybOh2CCo52dlXCWD9zySo1lpkMhLvZYFv2aX9WVf0JBTNLJeiPEumzHtcP6mq3/wufxissrCS
        hzjIDpeA==;
Received: from [80.156.29.194] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j12A4-0006Ts-2b; Mon, 10 Feb 2020 06:03:12 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j12A2-00C2W0-Cs; Mon, 10 Feb 2020 07:03:10 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 18/28] docs: kvm: convert arm/hyp-abi.txt to ReST
Date:   Mon, 10 Feb 2020 07:02:56 +0100
Message-Id: <f0ecf7be020cb410ee29f506d440b32e549d569a.1581314317.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581314316.git.mchehab+huawei@kernel.org>
References: <cover.1581314316.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

- Add proper markups for titles;
- Adjust whitespaces and blank lines to match ReST
  needs;
- Mark literal blocks as such.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../virt/kvm/arm/{hyp-abi.txt => hyp-abi.rst} | 28 +++++++++++++------
 Documentation/virt/kvm/arm/index.rst          |  1 +
 2 files changed, 20 insertions(+), 9 deletions(-)
 rename Documentation/virt/kvm/arm/{hyp-abi.txt => hyp-abi.rst} (79%)

diff --git a/Documentation/virt/kvm/arm/hyp-abi.txt b/Documentation/virt/kvm/arm/hyp-abi.rst
similarity index 79%
rename from Documentation/virt/kvm/arm/hyp-abi.txt
rename to Documentation/virt/kvm/arm/hyp-abi.rst
index a20a0bee268d..d1fc27d848e9 100644
--- a/Documentation/virt/kvm/arm/hyp-abi.txt
+++ b/Documentation/virt/kvm/arm/hyp-abi.rst
@@ -1,4 +1,8 @@
-* Internal ABI between the kernel and HYP
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================================
+Internal ABI between the kernel and HYP
+=======================================
 
 This file documents the interaction between the Linux kernel and the
 hypervisor layer when running Linux as a hypervisor (for example
@@ -19,25 +23,31 @@ and only act on individual CPUs.
 Unless specified otherwise, any built-in hypervisor must implement
 these functions (see arch/arm{,64}/include/asm/virt.h):
 
-* r0/x0 = HVC_SET_VECTORS
-  r1/x1 = vectors
+* ::
+
+    r0/x0 = HVC_SET_VECTORS
+    r1/x1 = vectors
 
   Set HVBAR/VBAR_EL2 to 'vectors' to enable a hypervisor. 'vectors'
   must be a physical address, and respect the alignment requirements
   of the architecture. Only implemented by the initial stubs, not by
   Linux hypervisors.
 
-* r0/x0 = HVC_RESET_VECTORS
+* ::
+
+    r0/x0 = HVC_RESET_VECTORS
 
   Turn HYP/EL2 MMU off, and reset HVBAR/VBAR_EL2 to the initials
   stubs' exception vector value. This effectively disables an existing
   hypervisor.
 
-* r0/x0 = HVC_SOFT_RESTART
-  r1/x1 = restart address
-  x2 = x0's value when entering the next payload (arm64)
-  x3 = x1's value when entering the next payload (arm64)
-  x4 = x2's value when entering the next payload (arm64)
+* ::
+
+    r0/x0 = HVC_SOFT_RESTART
+    r1/x1 = restart address
+    x2 = x0's value when entering the next payload (arm64)
+    x3 = x1's value when entering the next payload (arm64)
+    x4 = x2's value when entering the next payload (arm64)
 
   Mask all exceptions, disable the MMU, move the arguments into place
   (arm64 only), and jump to the restart address while at HYP/EL2. This
diff --git a/Documentation/virt/kvm/arm/index.rst b/Documentation/virt/kvm/arm/index.rst
index e039d9b1e076..134fa5fa77e5 100644
--- a/Documentation/virt/kvm/arm/index.rst
+++ b/Documentation/virt/kvm/arm/index.rst
@@ -7,4 +7,5 @@ ARM
 .. toctree::
    :maxdepth: 2
 
+   hyp-abi
    pvtime
-- 
2.24.1

