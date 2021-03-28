Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACF0C433C1
	for <linux-media@archiver.kernel.org>; Sun, 28 Mar 2021 01:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B96661964
	for <linux-media@archiver.kernel.org>; Sun, 28 Mar 2021 01:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhC1Bdh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 27 Mar 2021 21:33:37 -0400
Received: from www.linuxtv.org ([130.149.80.248]:51580 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230318AbhC1Bdh (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sat, 27 Mar 2021 21:33:37 -0400
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1lQKJ5-00195n-UN; Sun, 28 Mar 2021 01:33:35 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1lQKMv-0000vr-Ul; Sun, 28 Mar 2021 01:37:35 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.13] Miscellaneous changes (#72687)
Date:   Sun, 28 Mar 2021 01:37:33 +0000
Message-Id: <20210328013733.3542-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <YF/Zr/HtUaKH3EKA@pendragon.ideasonboard.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/project/linux-media/patch/YF/Zr/HtUaKH3EKA@pendragon.ideasonboard.com/
Build log: https://builder.linuxtv.org/job/patchwork/96182/
Build time: 00:06:26
Link: https://lore.kernel.org/linux-media/YF/Zr/HtUaKH3EKA@pendragon.ideasonboard.com

gpg: Signature made Sun 28 Mar 2021 12:58:59 AM UTC
gpg:                using RSA key CB9D6877529820CD53099B1B65F89C37BC54210D
gpg:                issuer "laurent.pinchart@ideasonboard.com"
gpg: Can't check signature: No public key

Summary: got 1/13 patches with issues, being 0 at build time, plus one error when buinding PDF document

Error/warnings:

patches/0011-media-dt-bindings-media-renesas-drif-Convert-to-json.patch:

   checkpatch.pl:
	$ cat patches/0011-media-dt-bindings-media-renesas-drif-Convert-to-json.patch | formail -c | ./scripts/checkpatch.pl --terse --mailback --no-summary --strict
	-:27: WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
	-:206: WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst


Error #512 when building PDF docs

