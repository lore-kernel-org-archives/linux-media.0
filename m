Return-Path: <SRS0=rRrk=3R=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E3EC2D0DB
	for <linux-media@archiver.kernel.org>; Tue, 28 Jan 2020 14:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF982467E
	for <linux-media@archiver.kernel.org>; Tue, 28 Jan 2020 14:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580223098;
	bh=RQJBSrCBQoRjRPzNpPiEOUwoi4zmhWHM5Ddo22O4ojU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mF6+kt0rkqqGicTW65EByuYIu6FPpptUfOzAo7WZ5Rq7OUZ+yQTIJ+8SBOMG3MEtV
	 IOIGWPublJ8GY7hOIMS9wjj6KGzmXQ/SQfVmm6+AjyFrE72Axfm+t0jy26hkwWusw8
	 KIuSJ+VB+QyRdmqPldJfMjB6HreZAbRS0K8SpW3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgA1Ovg (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:51:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58454 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgA1N6o (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 28 Jan 2020 08:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/hfBTm+pwI/qMUzI6610HUXH01FV0FRb49kTIzGz0Ww=; b=t9ykKbpknrNnDM3UctKfI8f4Y7
        4PkIUnKL+6+v2tP0G+057NZ6Y2DzDsc+qu4gH+GDr3WyjLtwaKdFYUGU2PMjUkesdUlxy6JJED1+6
        UWn3pF3fth6sR8cpJNwoKYrpewCCjQNLqnDoemlKL6VfFHt3sfCt/9sj6LujaIm4sg0Ax2dMdaOF8
        muO8pzKpt9LNPt00uVMMRLbSnQzgwQgtIw/UvukvLZJ+6WpqTL+ksP6C/D1F1nITgSGRhznrjys+s
        jBkPf+50m9rMJCJ5dSfuRBVuioGIx3wzOotXI814povNgISLktSrvM090/naE8+JDdfS3KAj4UyY2
        ABVNuEcQ==;
Received: from [177.41.103.99] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwRO7-0006Hx-1I; Tue, 28 Jan 2020 13:58:43 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1iwRNq-001BJE-2o; Tue, 28 Jan 2020 14:58:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 01/27] docs: kvm: add arm/pvtime.rst to index.rst
Date:   Tue, 28 Jan 2020 14:57:57 +0100
Message-Id:
 <8efe846ddd76d97a62a150a997619e5d7d992774.1580219586.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1580219586.git.mchehab+huawei@kernel.org>
References: <cover.1580219586.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org
Message-ID: <20200128135757.J5i7tAhClNE_sORRnD7gDOgJWDkG689BZFWir9UQdBY@z>

Add this file to a new kvm/arm index.rst, in order for it to
be shown as part of the virt book.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/virt/kvm/arm/index.rst | 10 ++++++++++
 Documentation/virt/kvm/index.rst     |  2 ++
 2 files changed, 12 insertions(+)
 create mode 100644 Documentation/virt/kvm/arm/index.rst

diff --git a/Documentation/virt/kvm/arm/index.rst b/Documentation/virt/kvm/arm/index.rst
new file mode 100644
index 000000000000..e039d9b1e076
--- /dev/null
+++ b/Documentation/virt/kvm/arm/index.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===
+ARM
+===
+
+.. toctree::
+   :maxdepth: 2
+
+   pvtime
diff --git a/Documentation/virt/kvm/index.rst b/Documentation/virt/kvm/index.rst
index ada224a511fe..488c6370a447 100644
--- a/Documentation/virt/kvm/index.rst
+++ b/Documentation/virt/kvm/index.rst
@@ -10,3 +10,5 @@ KVM
    amd-memory-encryption
    cpuid
    vcpu-requests
+
+   arm/index
-- 
2.24.1

