Return-Path: <SRS0=oIBZ=4N=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B907C35DEA
	for <linux-media@archiver.kernel.org>; Tue, 25 Feb 2020 01:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28214222C2
	for <linux-media@archiver.kernel.org>; Tue, 25 Feb 2020 01:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgBYBZF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 24 Feb 2020 20:25:05 -0500
Received: from www.linuxtv.org ([130.149.80.248]:56772 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbgBYBZF (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 24 Feb 2020 20:25:05 -0500
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1j6OwS-009UOZ-7J; Tue, 25 Feb 2020 01:23:20 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1j6OzU-00009g-Pq; Tue, 25 Feb 2020 01:26:28 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.7] RC & DVB (#61801)
Date:   Tue, 25 Feb 2020 01:26:28 +0000
Message-Id: <20200225012628.555-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225010451.GA22451@gofer.mess.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/61801/
Build log: https://builder.linuxtv.org/job/patchwork/39602/
Build time: 00:16:19
Link: https://lore.kernel.org/linux-media/20200225010451.GA22451@gofer.mess.org

gpg: Signature made Tue 25 Feb 2020 12:20:59 AM UTC
gpg:                using RSA key A624251A26084A9ED9E4C8B6425F639D3960FA9E
gpg:                issuer "sean@mess.org"
gpg: Good signature from "Sean Young <sean@mess.org>" [full]

Summary: 1 patches and/or PDF generation with issues, being 0 at build time

Error/warnings:


Error #256 when running ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0003-media-rc-iguanair-Replace-zero-length-array-with-fle.patch:
$ ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0003-media-rc-iguanair-Replace-zero-length-array-with-fle.patch
patches/0003-media-rc-iguanair-Replace-zero-length-array-with-fle.patch:43: CHECK: Prefer kernel type 'u8' over 'uint8_t'

