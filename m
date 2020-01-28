Return-Path: <SRS0=rRrk=3R=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA4CC35246
	for <linux-media@archiver.kernel.org>; Tue, 28 Jan 2020 14:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37DF24685
	for <linux-media@archiver.kernel.org>; Tue, 28 Jan 2020 14:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220059;
	bh=jZNHsHOqCO64/b4cFrzFhkGrWSynCIXBkSudBt4Qs7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K8G2wW+K+9eB8aAs3id9cBH+R7vVRPeVg9tEuuWPLwfYkDo8obKLEU9zgc9SWo2hS
	 7eNkZHOmHTNpOol4rGQ94U9eMaaPqARe78uz/fSr05Aa59KpmvPBwdUUaxAZDWlAzI
	 2IrGgBFSBWpG7r2gXdlq2+TisrGB/M/6Ls0krRmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgA1OAs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:00:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59318 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgA1OAq (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 28 Jan 2020 09:00:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Tz48VZFw6Pyql4H3D79rMXp5boRr/1YzcV0w5QihF6k=; b=Mgx+5Is4LK6AQZN1NvMRds73I/
        olXZWwA+nV2dCq76W6DvszQM20mr/QeWB5OMlccpTB4drRHwddZy2Fzh1XsX13HF7xOJKReiJFoqB
        zwpBSf8vvu0lkQj6Ap3ZPY72BaGLHEk3lI3YBzhO2eF8okyDtpZoZrIQoTG5UOUmWqo/mER00yyTw
        UhmsOtJ3vNK9LMyRuUmk4L6gUJWY053m7aue6ZkELS0F6Jn0KA0YXCIRTbOZs2FpcBLdcn3G1pcg2
        mjH1DhMQ/8Zi3a1PX2ijXIitZilaux7DVWE/ebcTjsSzBTnbTVLhPl+yORMbCGHjE9llvH+tk1HT7
        2ewzq2Bw==;
Received: from [177.41.103.99] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwRQ6-0007iw-8u; Tue, 28 Jan 2020 14:00:46 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1iwRPq-001BPM-5A; Tue, 28 Jan 2020 15:00:30 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 27/27] docs: kvm: review-checklist.txt: rename to ReST
Date:   Tue, 28 Jan 2020 15:00:28 +0100
Message-Id: <c9e9bdbba907bde63f0bd611fc997b5e2829c2d8.1580219586.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1580219586.git.mchehab+huawei@kernel.org>
References: <cover.1580219586.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This file is already in ReST compatible format.
So, rename it and add to the kvm's index.rst.

While here, use the standard conversion for document titles.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/virt/kvm/index.rst                                | 2 ++
 .../virt/kvm/{review-checklist.txt => review-checklist.rst}     | 1 +
 2 files changed, 3 insertions(+)
 rename Documentation/virt/kvm/{review-checklist.txt => review-checklist.rst} (97%)

diff --git a/Documentation/virt/kvm/index.rst b/Documentation/virt/kvm/index.rst
index 7c1be8910837..774deaebf7fa 100644
--- a/Documentation/virt/kvm/index.rst
+++ b/Documentation/virt/kvm/index.rst
@@ -21,6 +21,8 @@ KVM
    timekeeping
    vcpu-requests
 
+   review-checklist
+
    arm/index
 
    devices/index
diff --git a/Documentation/virt/kvm/review-checklist.txt b/Documentation/virt/kvm/review-checklist.rst
similarity index 97%
rename from Documentation/virt/kvm/review-checklist.txt
rename to Documentation/virt/kvm/review-checklist.rst
index 499af499e296..d52e0bf96121 100644
--- a/Documentation/virt/kvm/review-checklist.txt
+++ b/Documentation/virt/kvm/review-checklist.rst
@@ -1,3 +1,4 @@
+================================
 Review checklist for kvm patches
 ================================
 
-- 
2.24.1

