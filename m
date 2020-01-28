Return-Path: <SRS0=rRrk=3R=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E63C33CB2
	for <linux-media@archiver.kernel.org>; Tue, 28 Jan 2020 14:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C85920716
	for <linux-media@archiver.kernel.org>; Tue, 28 Jan 2020 14:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580223002;
	bh=4KbYRGFqJZ7ieywXsFZMMJVdhzIfilUrd/qsaKkEEAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Uosh70p8ONcpioOvASYAj1yVIQAnJ/kyvGjxS+9OXN1NkooK28wXmuJxDBXh+wjVO
	 th3bs0od+KU6Sbo38x1I8NY3MQ0UgUs7J/zlW4wJyYtW75VuatTNFXjIkO6mzDUrr0
	 WpoUXu+/5mtfm96aKBFuQmyQeQvGHkvtf9JA5ARA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgA1OuA (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:50:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59280 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbgA1OAq (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 28 Jan 2020 09:00:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=H1nRRjrZGeu/PASJbR2ix7tpTPDW4y35R3IZ+NkvAB8=; b=lMc7rGguapyL8NhwV4j/uuQM0t
        p89ipN0XtzsMKNDMc6Z3dY/mtPjxFkftxHz6vUbbP533m3dHPnHQdovrJaJLx9dCWjp9r45i6kvY7
        tZToXlLBQCryC+Ep5swpooGbhL3PxErelLu6IEtwzpi6eZHaXbvIPa31JzJis2VyMaCmV9FK6x/S3
        LyNfBzf0ADrJqMJKZpSirulPsW7yhva9CI0PWyXZCCrpUnucYRuPqwfYoJzvLBeNUH32zJDsqZ7L4
        BxYRgk8hqxva4jKxliivBVc58ac+A+i4Pyf6nsZgcvgeZkjwc/qVyU/niE0n7jdDnXU3FWyHeHxRi
        x39Dh7Tw==;
Received: from [177.41.103.99] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwRQ5-0007ie-UC; Tue, 28 Jan 2020 14:00:45 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1iwRPp-001BNz-Gu; Tue, 28 Jan 2020 15:00:29 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 10/27] docs: kvm: convert devices/mpic.txt to ReST
Date:   Tue, 28 Jan 2020 15:00:11 +0100
Message-Id: <11aa35fac07b299da862706325b194164548549b.1580219586.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1580219586.git.mchehab+huawei@kernel.org>
References: <cover.1580219586.git.mchehab+huawei@kernel.org>
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

