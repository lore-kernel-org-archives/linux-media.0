Return-Path: <SRS0=i92q=25=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE245C282DD
	for <linux-media@archiver.kernel.org>; Wed,  8 Jan 2020 13:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C008620643
	for <linux-media@archiver.kernel.org>; Wed,  8 Jan 2020 13:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgAHNL0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:11:26 -0500
Received: from www.linuxtv.org ([130.149.80.248]:55496 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbgAHNL0 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 8 Jan 2020 08:11:26 -0500
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1ipB6Y-0009VS-RH; Wed, 08 Jan 2020 13:10:34 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1ipB8Q-00010t-Bz; Wed, 08 Jan 2020 13:12:30 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.6] v2: Various fixes
Date:   Wed,  8 Jan 2020 13:12:30 +0000
Message-Id: <20200108131230.3854-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <8dc5aad1-ae76-85f5-de05-8a7d2b340a3e@xs4all.nl>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/61063/
Build log: https://builder.linuxtv.org/job/patchwork/32763/
Build time: 00:12:20
Link: https://lore.kernel.org/linux-media/8dc5aad1-ae76-85f5-de05-8a7d2b340a3e@xs4all.nl

gpg: Signature made Wed 08 Jan 2020 12:46:41 PM UTC
gpg:                using RSA key AAA7FFBA4D2D77EF4CAEA1421326E0CD23ABDCE5
gpg: Good signature from "Hans Verkuil <hverkuil-cisco@xs4all.nl>" [unknown]
gpg:                 aka "Hans Verkuil <hverkuil@xs4all.nl>" [full]

Summary: 2 patches and/or PDF generation with issues, being 0 at build time

Error/warnings:


Error #256 when running ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0002-media-v4l2-Fix-fourcc-names-for-12b-and-14b-packed-b.patch:
$ ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0002-media-v4l2-Fix-fourcc-names-for-12b-and-14b-packed-b.patch
patches/0002-media-v4l2-Fix-fourcc-names-for-12b-and-14b-packed-b.patch:6: WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)

Error #256 when running ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0010-media-pci-bt8xx-convert-to-i2c_new_scanned_device.patch:
$ ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0010-media-pci-bt8xx-convert-to-i2c_new_scanned_device.patch
patches/0010-media-pci-bt8xx-convert-to-i2c_new_scanned_device.patch:35: WARNING: line over 80 characters

