Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE30C433FE
	for <linux-media@archiver.kernel.org>; Mon,  7 Dec 2020 12:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66F4323372
	for <linux-media@archiver.kernel.org>; Mon,  7 Dec 2020 12:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgLGMKN (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 7 Dec 2020 07:10:13 -0500
Received: from www.linuxtv.org ([130.149.80.248]:49104 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbgLGMKM (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 7 Dec 2020 07:10:12 -0500
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1kmFKd-0094JH-0c; Mon, 07 Dec 2020 12:09:31 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1kmFNo-0006tC-D6; Mon, 07 Dec 2020 12:12:48 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL for 5.11] Some fixes to the recently merged stuff (#69768)
Date:   Mon,  7 Dec 2020 12:12:48 +0000
Message-Id: <20201207121248.26252-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201204120857.GJ4351@valkosipuli.retiisi.org.uk>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/project/linux-media/patch/20201204120857.GJ4351@valkosipuli.retiisi.org.uk/
Build log: https://builder.linuxtv.org/job/patchwork/80283/
Build time: 00:02:25
Link: https://lore.kernel.org/linux-media/20201204120857.GJ4351@valkosipuli.retiisi.org.uk

gpg: Signature made Fri 04 Dec 2020 11:52:40 AM UTC
gpg:                using DSA key 53AC58A5F5948636C04A1BF8141DFA54A1EC8DEA
gpg:                issuer "sakari.ailus@linux.intel.com"
gpg: Can't check signature: No public key

Summary: got 1/3 patches with issues, being 0 at build time

Error/warnings:

patches/0002-media-ccs-avoid-printing-an-uninitialized-variable.patch:

   checkpatch.pl:
	$ cat patches/0002-media-ccs-avoid-printing-an-uninitialized-variable.patch | formail -c | ./scripts/checkpatch.pl --terse --mailback --no-summary --strict
	-:6: WARNING: 'intialization' may be misspelled - perhaps 'initialization'?

