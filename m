Return-Path: <SRS0=EP8b=2D=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF00C34978
	for <linux-media@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B43A246AC
	for <linux-media@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfLMLbX (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 13 Dec 2019 06:31:23 -0500
Received: from www.linuxtv.org ([130.149.80.248]:58496 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfLMLbX (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 13 Dec 2019 06:31:23 -0500
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1ifj9x-00BftO-Fj; Fri, 13 Dec 2019 11:31:01 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1ifjBA-0000wN-6C; Fri, 13 Dec 2019 11:32:16 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.6] pulse8-cec driver fixes
Date:   Fri, 13 Dec 2019 11:32:16 +0000
Message-Id: <20191213113216.3574-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <7a0ba45d-6aa8-2bbb-e5df-7114d4b6a340@xs4all.nl>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/60701/
Build log: https://builder.linuxtv.org/job/patchwork/29011/
Build time: 00:09:52
Link: https://lore.kernel.org/linux-media/7a0ba45d-6aa8-2bbb-e5df-7114d4b6a340@xs4all.nl

gpg: Signature made Fri 13 Dec 2019 10:47:22 AM UTC
gpg:                using RSA key AAA7FFBA4D2D77EF4CAEA1421326E0CD23ABDCE5
gpg: Good signature from "Hans Verkuil <hverkuil-cisco@xs4all.nl>" [unknown]
gpg:                 aka "Hans Verkuil <hverkuil@xs4all.nl>" [full]

Summary: 2 patches and/or PDF generation with issues, being 0 at build time

Error/warnings:


Error #256 when running ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0001-pulse8-cec-improve-debugging.patch:
$ ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0001-pulse8-cec-improve-debugging.patch
patches/0001-pulse8-cec-improve-debugging.patch:87: WARNING: line over 80 characters
patches/0001-pulse8-cec-improve-debugging.patch:96: WARNING: line over 80 characters
patches/0001-pulse8-cec-improve-debugging.patch:107: WARNING: line over 80 characters

Error #256 when running ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0002-pulse8-cec-reorganize-function-order.patch:
$ ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0002-pulse8-cec-reorganize-function-order.patch
patches/0002-pulse8-cec-reorganize-function-order.patch:53: WARNING: line over 80 characters
patches/0002-pulse8-cec-reorganize-function-order.patch:70: WARNING: line over 80 characters

