Return-Path: <SRS0=rRrk=3R=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675E8C2D0DB
	for <linux-media@archiver.kernel.org>; Tue, 28 Jan 2020 14:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBC924683
	for <linux-media@archiver.kernel.org>; Tue, 28 Jan 2020 14:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580223075;
	bh=4KbYRGFqJZ7ieywXsFZMMJVdhzIfilUrd/qsaKkEEAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r1DciBp8XlzVJCAkfZddw2BWtDcldDCarzhXL+z0jy2m632FQx401H6lVyz25ytKg
	 dIzkDzfJrfRyb0+DV/MNVTeXx/zpxqP5+zWK5jOskM7Nt+kMh0t0WFUtkSI9zK2MUv
	 8M4+jHn3G4AcmTMz+rlxeN7LnBYxwWG90+k3IAss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgA1OvF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:51:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgA1N6p (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 28 Jan 2020 08:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=H1nRRjrZGeu/PASJbR2ix7tpTPDW4y35R3IZ+NkvAB8=; b=mowTCdEj5jn6n0WdWu24FS5gWR
        tk6/R/aWJakV/jNP9qJvHApl230fONfFeYnOwNoDQdEuyocJFXCPK5BytQh1FFh7kZO8034fMeIci
        f4WpVR9kgHWbvJYJ1qb56kWcOxDVtWXwaxxd+cclM1YHPKYPfP8bx48z1ycGbUyHXPowa8ljKjaBx
        zhS+kq06tV6JO3Z2jpvpKT/N8WKcG3V+m4na9at8Ccmd0HVeVXvXFAZDQ4dgw6jNwcapUzXp1NC/C
        pntY4Pd/pdx97gdEWjhBUYIP8pzmzA694N1mt+cgiA77I0Xt7SEkwvhqHWc7V3GsiZSa1BoY7zb1U
        e2OP5I6Q==;
Received: from [177.41.103.99] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwRO6-0006Ht-Nw; Tue, 28 Jan 2020 13:58:42 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1iwRNq-001BJp-Dc; Tue, 28 Jan 2020 14:58:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 10/27] docs: kvm: convert devices/mpic.txt to ReST
Date:   Tue, 28 Jan 2020 14:58:06 +0100
Message-Id:
 <11aa35fac07b299da862706325b194164548549b.1580219586.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1580219586.git.mchehab+huawei@kernel.org>
References: <cover.1580219586.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org
Message-ID: <20200128135806.9fBIF_zcMPkRvzZ0gkgMc_X4CtpCv6Caqf7pfQ3iqt0@z>

This document is almost in ReST format. The only thing
needed is to mark a list as such and to add an extra
whitespace.

Yet, let's also use the standard document title markup,
as it makes easier if anyone wants later to add sessions
to it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/virt/kvm/devices/index.rst              | 1 +
 Documentation/virt/kvm/devices/{mpic.txt => mpic.rst} | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)
 rename Documentation/virt/kvm/devices/{mpic.txt => mpic.rst} (92%)

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
similarity index 92%
rename from Documentation/virt/kvm/devices/mpic.txt
rename to Documentation/virt/kvm/devices/mpic.rst
index 8257397adc3c..571b2bc72b5e 100644
--- a/Documentation/virt/kvm/devices/mpic.txt
+++ b/Documentation/virt/kvm/devices/mpic.rst
@@ -1,9 +1,11 @@
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
@@ -11,7 +13,8 @@ vcpu's interrupt inputs.
 
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

