Return-Path: <SRS0=oTdG=5K=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090F7C54FD0
	for <linux-media@archiver.kernel.org>; Wed, 25 Mar 2020 14:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C8E2076A
	for <linux-media@archiver.kernel.org>; Wed, 25 Mar 2020 14:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgCYOK1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:10:27 -0400
Received: from www.linuxtv.org ([130.149.80.248]:58374 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727316AbgCYOK1 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 25 Mar 2020 10:10:27 -0400
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1jH6hU-00A07j-WD; Wed, 25 Mar 2020 14:08:09 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1jH6lH-00059u-LL; Wed, 25 Mar 2020 14:12:03 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.7] ti-vpe/cal and imx7-mipi-csis cleanups/fixes (#62535)
Date:   Wed, 25 Mar 2020 14:12:03 +0000
Message-Id: <20200325141203.19789-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <64c740ae-3ebd-cec3-14f4-e65f2cb53af3@xs4all.nl>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/62535/
Build log: https://builder.linuxtv.org/job/patchwork/43853/
Build time: 00:11:53
Link: https://lore.kernel.org/linux-media/64c740ae-3ebd-cec3-14f4-e65f2cb53af3@xs4all.nl

gpg: Signature made Wed 25 Mar 2020 01:50:37 PM UTC
gpg:                using RSA key AAA7FFBA4D2D77EF4CAEA1421326E0CD23ABDCE5
gpg: Good signature from "Hans Verkuil <hverkuil-cisco@xs4all.nl>" [unknown]
gpg:                 aka "Hans Verkuil <hverkuil@xs4all.nl>" [full]

Summary: 3 patches and/or PDF generation with issues, being 0 at build time

Error/warnings:


Error #256 when running ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0020-media-ti-vpe-cal-catch-error-irqs-and-print-errors.patch:
$ ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0020-media-ti-vpe-cal-catch-error-irqs-and-print-errors.patch
patches/0020-media-ti-vpe-cal-catch-error-irqs-and-print-errors.patch:79: WARNING: line over 80 characters
patches/0020-media-ti-vpe-cal-catch-error-irqs-and-print-errors.patch:82: WARNING: line over 80 characters

Error #256 when running ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0026-media-ti-vpe-cal-cleanup-CIO-power-enable-disable.patch:
$ ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0026-media-ti-vpe-cal-cleanup-CIO-power-enable-disable.patch
patches/0026-media-ti-vpe-cal-cleanup-CIO-power-enable-disable.patch:40: WARNING: line over 80 characters
patches/0026-media-ti-vpe-cal-cleanup-CIO-power-enable-disable.patch:41: WARNING: line over 80 characters

Error #256 when running ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0029-media-ti-vpe-cal-set-DMA-max-seg-size.patch:
$ ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0029-media-ti-vpe-cal-set-DMA-max-seg-size.patch
patches/0029-media-ti-vpe-cal-set-DMA-max-seg-size.patch:9: WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)

