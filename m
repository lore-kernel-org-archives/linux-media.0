Return-Path: <SRS0=4cU9=WR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6299C3A59E
	for <linux-media@archiver.kernel.org>; Wed, 21 Aug 2019 18:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9495321655
	for <linux-media@archiver.kernel.org>; Wed, 21 Aug 2019 18:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfHUSWX (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:22:23 -0400
Received: from www.linuxtv.org ([130.149.80.248]:42876 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbfHUSWX (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 21 Aug 2019 14:22:23 -0400
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtp (Exim 4.84_2)
        (envelope-from <jenkins@linuxtv.org>)
        id 1i0VFT-0001EF-Cm; Wed, 21 Aug 2019 18:22:19 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1i0VFX-0004FW-6d; Wed, 21 Aug 2019 18:22:23 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.4] More DVB/RC changes
Date:   Wed, 21 Aug 2019 18:22:23 +0000
Message-Id: <20190821182223.16293-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821130434.gh4drkm6tiawzbpg@gofer.mess.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/58337/
Build log: https://builder.linuxtv.org/job/patchwork/12670/
Build time: 00:10:31
Link: https://lore.kernel.org/linux-media/20190821130434.gh4drkm6tiawzbpg@gofer.mess.org

gpg: Signature made Wed 21 Aug 2019 12:58:58 PM UTC
gpg:                using RSA key A624251A26084A9ED9E4C8B6425F639D3960FA9E
gpg:                issuer "sean@mess.org"
gpg: Good signature from "Sean Young <sean@mess.org>" [unknown]
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: A624 251A 2608 4A9E D9E4  C8B6 425F 639D 3960 FA9E

Summary: 2 patches and/or PDF generation with issues, being 0 at build time

Error/warnings:

patches/0008-dt-bindings-media-Add-YAML-schemas-for-the-generic-R.patch:143: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

Error #256 when running ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0008-dt-bindings-media-Add-YAML-schemas-for-the-generic-R.patch
patches/0009-dt-bindings-media-Convert-Allwinner-A10-IR-to-a-sche.patch:23: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
patches/0009-dt-bindings-media-Convert-Allwinner-A10-IR-to-a-sche.patch:112: WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.txt

Error #256 when running ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0009-dt-bindings-media-Convert-Allwinner-A10-IR-to-a-sche.patch

