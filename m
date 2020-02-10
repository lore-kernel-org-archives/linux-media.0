Return-Path: <SRS0=NCVB=36=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1183C35250
	for <linux-media@archiver.kernel.org>; Mon, 10 Feb 2020 06:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BDC2467D
	for <linux-media@archiver.kernel.org>; Mon, 10 Feb 2020 06:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581314593;
	bh=RQJBSrCBQoRjRPzNpPiEOUwoi4zmhWHM5Ddo22O4ojU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WkV5dCHRClSPIMwCbgbxmecE+78IVIVm+e3hyyNqj/M80Stk5v66KubdnoDotul1y
	 0oPqyZvF+q8XEy2tImzQyxcAxkwO0z+qCmaNwT5bqgwLuS5Ul6juWbWuwDQkceRMP5
	 Nx+cet8FP0K97u60dD84oc2SAbtK+FHxzkSpPJTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgBJGDM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 10 Feb 2020 01:03:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36292 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgBJGDM (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 10 Feb 2020 01:03:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/hfBTm+pwI/qMUzI6610HUXH01FV0FRb49kTIzGz0Ww=; b=YY9qMpTF6MirjG2R1XRdVVXM/9
        N2+i4gF3kDFNMMHfPjhir+tVy3kgLQ2Y+BluhTTxFRka0VQmvRE9kvlYdNwX60GvAGy/CrPTLRlt9
        G42D6+D8EE+h8b2yY9SuOheFq81KCSUVgwX6VnNm1a3DdIu35kocWvdgtUb3vivkZJ4fw+jsSuXj1
        6NVt2lsSLNxH3HZ0gS/XvEVQB8+So8pcGKeOFTN2xgRb8YwxL0qYpeXWbc160C13lCiJXmSsTkQcN
        v3PUJPxMfjgpG7WxZsBlHCZRnnX9V9gF2ckDxXPT83FRs5I92MJEEemVUZrZgkqSMvsH5AlSBMAJE
        6idRmYSg==;
Received: from [80.156.29.194] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j12A3-0006Tb-DC; Mon, 10 Feb 2020 06:03:11 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j12A1-00C2Ud-Nl; Mon, 10 Feb 2020 07:03:09 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 01/28] docs: kvm: add arm/pvtime.rst to index.rst
Date:   Mon, 10 Feb 2020 07:02:39 +0100
Message-Id: <cdea3a1899e21395073b8e4a02fb3db88dc63974.1581314316.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581314316.git.mchehab+huawei@kernel.org>
References: <cover.1581314316.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

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

