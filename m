Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037D8C04FCE
	for <linux-media@archiver.kernel.org>; Wed, 20 Sep 2023 18:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjITSMz (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 20 Sep 2023 14:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjITSMy (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 20 Sep 2023 14:12:54 -0400
Received: from www.linuxtv.org (www.linuxtv.org [130.149.80.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FF7B9
        for <linux-media@vger.kernel.org>; Wed, 20 Sep 2023 11:12:48 -0700 (PDT)
Received: from builder.linuxtv.org ([140.211.167.10] helo=slave0)
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1qj1gt-009QIi-AQ; Wed, 20 Sep 2023 18:12:47 +0000
Received: from ip6-localhost ([::1] helo=localhost.localdomain)
        by slave0 with esmtp (Exim 4.96)
        (envelope-from <jenkins@linuxtv.org>)
        id 1qj1gp-00D3EJ-0r;
        Wed, 20 Sep 2023 18:12:44 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL for v6.6-rc3] media fixes (#94931)
Date:   Wed, 20 Sep 2023 18:12:44 +0000
Message-Id: <20230920181244.3110670-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230920200902.72ee092c@sal.lan>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/project/linux-media/patch/20230920200902.72ee092c@sal.lan/
Build log: https://builder.linuxtv.org/job/patchwork/341379/
Build time: 00:00:00
Link: https://lore.kernel.org/linux-media/20230920200902.72ee092c@sal.lan

gpg: Signature made Wed 20 Sep 2023 06:02:06 PM UTC
gpg:                using RSA key F909AE68FC11DF09C1755C00085F3EBD8EE4E115
gpg:                issuer "mchehab@kernel.org"
gpg: Good signature from "Mauro Carvalho Chehab <mchehab+huawei@kernel.org>" [ultimate]
gpg:                 aka "Mauro Carvalho Chehab <mchehab@kernel.org>" [ultimate]
gpg:                 aka "Mauro Carvalho Chehab <m.chehab@samsung.com>" [ultimate]
gpg:                 aka "Mauro Carvalho Chehab <mchehab@osg.samsung.com>" [ultimate]
gpg:                 aka "Mauro Carvalho Chehab <mchehab@s-opensource.com>" [ultimate]
gpg:                 aka "Mauro Carvalho Chehab <mchehab+samsung@kernel.org>" [ultimate]
gpg:                 aka "[jpeg image of size 3594]" [ultimate]


Build aborted due to a fatal error:
FAILED: patch patch patches/0001-media-pci-ivsc-Select-build-dependencies.patch doesn't apply:
Applying patch patches/0001-media-pci-ivsc-Select-build-dependencies.patch
patching file drivers/media/pci/intel/ivsc/Kconfig
Hunk #1 FAILED at 4.
1 out of 1 hunk FAILED -- rejects in file drivers/media/pci/intel/ivsc/Kconfig
Patch patches/0001-media-pci-ivsc-Select-build-dependencies.patch does not apply (enforce with -f)

