Return-Path: <SRS0=S52y=5E=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13DFC4332D
	for <linux-media@archiver.kernel.org>; Thu, 19 Mar 2020 13:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C538720787
	for <linux-media@archiver.kernel.org>; Thu, 19 Mar 2020 13:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgCSNdL (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:33:11 -0400
Received: from www.linuxtv.org ([130.149.80.248]:51726 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727310AbgCSNdK (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 19 Mar 2020 09:33:10 -0400
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1jEvGE-002cvB-No; Thu, 19 Mar 2020 13:30:58 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1jEvJs-0004eQ-5E; Thu, 19 Mar 2020 13:34:44 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.7] Various allegro fixes (#62382)
Date:   Thu, 19 Mar 2020 13:34:44 +0000
Message-Id: <20200319133444.17837-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <95ec6bae-4c7e-c9ee-6633-17357fa0e42a@xs4all.nl>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/62382/
Build log: https://builder.linuxtv.org/job/patchwork/42985/
Build time: 00:14:33
Link: https://lore.kernel.org/linux-media/95ec6bae-4c7e-c9ee-6633-17357fa0e42a@xs4all.nl

gpg: Signature made Thu 19 Mar 2020 01:16:46 PM UTC
gpg:                using RSA key AAA7FFBA4D2D77EF4CAEA1421326E0CD23ABDCE5
gpg: Good signature from "Hans Verkuil <hverkuil-cisco@xs4all.nl>" [unknown]
gpg:                 aka "Hans Verkuil <hverkuil@xs4all.nl>" [full]

Summary: 2 patches and/or PDF generation with issues, being 0 at build time

Error/warnings:


Error #256 when running ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0015-media-allegro-handle-dependency-of-bitrate-and-bitra.patch:
$ ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0015-media-allegro-handle-dependency-of-bitrate-and-bitra.patch
patches/0015-media-allegro-handle-dependency-of-bitrate-and-bitra.patch:83: WARNING: line over 80 characters

Error #256 when running ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0018-media-allegro-move-mail-definitions-to-separate-file.patch:
$ ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0018-media-allegro-move-mail-definitions-to-separate-file.patch
patches/0018-media-allegro-move-mail-definitions-to-separate-file.patch:328: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

