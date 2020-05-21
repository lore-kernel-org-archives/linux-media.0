Return-Path: <SRS0=xnAv=7D=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9E0C433E0
	for <linux-media@archiver.kernel.org>; Thu, 21 May 2020 10:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 503102072C
	for <linux-media@archiver.kernel.org>; Thu, 21 May 2020 10:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgEUKd2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 21 May 2020 06:33:28 -0400
Received: from www.linuxtv.org ([130.149.80.248]:46406 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgEUKd2 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 21 May 2020 06:33:28 -0400
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1jbiST-00GWes-5n; Thu, 21 May 2020 10:29:49 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1jbiXw-0007OO-FB; Thu, 21 May 2020 10:35:28 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.8] Small DVB fixes (#63968)
Date:   Thu, 21 May 2020 10:35:28 +0000
Message-Id: <20200521103528.28375-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521102652.GA30462@gofer.mess.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/63968/
Build log: https://builder.linuxtv.org/job/patchwork/51907/
Build time: 00:05:14
Link: https://lore.kernel.org/linux-media/20200521102652.GA30462@gofer.mess.org

gpg: Signature made Thu 21 May 2020 09:24:52 AM UTC
gpg:                using RSA key A624251A26084A9ED9E4C8B6425F639D3960FA9E
gpg:                issuer "sean@mess.org"
gpg: Good signature from "Sean Young <sean@mess.org>" [full]

Summary: 2 patches and/or PDF generation with issues, being 0 at build time

Error/warnings:


Error #256 when running cat patches/0002-media-dvb-usb-Add-Cinergy-S2-PCIe-Dual-Port-support.patch | formail -c | ./scripts/checkpatch.pl --terse --mailback --no-summary --strict:
$ cat patches/0002-media-dvb-usb-Add-Cinergy-S2-PCIe-Dual-Port-support.patch | formail -c | ./scripts/checkpatch.pl --terse --mailback --no-summary --strict
-:10: WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)

