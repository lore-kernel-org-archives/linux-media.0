Return-Path: <SRS0=aj5L=6W=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833FDC54E49
	for <linux-media@archiver.kernel.org>; Fri,  8 May 2020 09:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B82A20870
	for <linux-media@archiver.kernel.org>; Fri,  8 May 2020 09:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgEHJ7Y (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 8 May 2020 05:59:24 -0400
Received: from www.linuxtv.org ([130.149.80.248]:44234 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgEHJ7Y (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 8 May 2020 05:59:24 -0400
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1jWzjc-00H91e-CC; Fri, 08 May 2020 09:56:00 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1jWzom-0006o8-1b; Fri, 08 May 2020 10:01:20 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.8] Small fixes (#63674)
Date:   Fri,  8 May 2020 10:01:19 +0000
Message-Id: <20200508100119.26127-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508094758.GC1214@gofer.mess.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/63674/
Build log: https://builder.linuxtv.org/job/patchwork/50037/
Build time: 00:11:00
Link: https://lore.kernel.org/linux-media/20200508094758.GC1214@gofer.mess.org

gpg: Signature made Fri 08 May 2020 08:29:18 AM UTC
gpg:                using RSA key A624251A26084A9ED9E4C8B6425F639D3960FA9E
gpg:                issuer "sean@mess.org"
gpg: Good signature from "Sean Young <sean@mess.org>" [full]

Summary: 2 patches and/or PDF generation with issues, being 0 at build time

Error/warnings:


Error #256 when running cat patches/0005-media-usb-ttusb-dec-reduce-the-number-of-memory-read.patch | formail -c | ./scripts/checkpatch.pl --terse --mailback --no-summary --strict:
$ cat patches/0005-media-usb-ttusb-dec-reduce-the-number-of-memory-read.patch | formail -c | ./scripts/checkpatch.pl --terse --mailback --no-summary --strict
-:39: WARNING: line over 80 characters
-:42: WARNING: line over 80 characters

