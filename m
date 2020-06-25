Return-Path: <SRS0=o2oZ=AG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF59C433E0
	for <linux-media@archiver.kernel.org>; Thu, 25 Jun 2020 12:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F3ED206C3
	for <linux-media@archiver.kernel.org>; Thu, 25 Jun 2020 12:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404518AbgFYMSk (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:18:40 -0400
Received: from www.linuxtv.org ([130.149.80.248]:40960 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404343AbgFYMSk (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Jun 2020 08:18:40 -0400
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1joQlq-008k8r-FF; Thu, 25 Jun 2020 12:14:22 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1joQsC-0001uB-23; Thu, 25 Jun 2020 12:20:56 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.9] Minor fixes (#64886)
Date:   Thu, 25 Jun 2020 12:20:56 +0000
Message-Id: <20200625122056.7282-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200625115908.GA24947@gofer.mess.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/64886/
Build log: https://builder.linuxtv.org/job/patchwork/56942/
Build time: 00:10:44
Link: https://lore.kernel.org/linux-media/20200625115908.GA24947@gofer.mess.org

gpg: Signature made Thu 25 Jun 2020 11:43:01 AM UTC
gpg:                using RSA key A624251A26084A9ED9E4C8B6425F639D3960FA9E
gpg:                issuer "sean@mess.org"
gpg: Good signature from "Sean Young <sean@mess.org>" [full]

Summary: 2 patches and/or PDF generation with issues, being 0 at build time

Error/warnings:


Error #256 when running cat patches/0003-media-fintek-cir-remove-unused-function-fintek_clear.patch | formail -c | ./scripts/checkpatch.pl --terse --mailback --no-summary --strict:
$ cat patches/0003-media-fintek-cir-remove-unused-function-fintek_clear.patch | formail -c | ./scripts/checkpatch.pl --terse --mailback --no-summary --strict
-:9: WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)

