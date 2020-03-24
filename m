Return-Path: <SRS0=HLWw=5J=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B535C2BAEE
	for <linux-media@archiver.kernel.org>; Tue, 24 Mar 2020 13:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A48E208D6
	for <linux-media@archiver.kernel.org>; Tue, 24 Mar 2020 13:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgCXNOt (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:14:49 -0400
Received: from www.linuxtv.org ([130.149.80.248]:45156 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbgCXNOr (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 24 Mar 2020 09:14:47 -0400
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1jGjM6-008dpr-64; Tue, 24 Mar 2020 13:12:30 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1jGjPr-0001FZ-Ee; Tue, 24 Mar 2020 13:16:23 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.7] Various fixes, add i.MX8MQ hantro support (#62458)
Date:   Tue, 24 Mar 2020 13:16:23 +0000
Message-Id: <20200324131623.4764-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <270c0340-e052-7466-4a7b-2155a643d35f@xs4all.nl>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/62458/
Build log: https://builder.linuxtv.org/job/patchwork/43704/
Build time: 00:06:13
Link: https://lore.kernel.org/linux-media/270c0340-e052-7466-4a7b-2155a643d35f@xs4all.nl

gpg: Signature made Tue 24 Mar 2020 01:02:38 PM UTC
gpg:                using RSA key AAA7FFBA4D2D77EF4CAEA1421326E0CD23ABDCE5
gpg: Good signature from "Hans Verkuil <hverkuil-cisco@xs4all.nl>" [unknown]
gpg:                 aka "Hans Verkuil <hverkuil@xs4all.nl>" [full]

Summary: 4 patches and/or PDF generation with issues, being 0 at build time

Error/warnings:


Error #256 when running ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0003-vivid-fix-incorrect-PA-assignment-to-HDMI-outputs.patch:
$ ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0003-vivid-fix-incorrect-PA-assignment-to-HDMI-outputs.patch
patches/0003-vivid-fix-incorrect-PA-assignment-to-HDMI-outputs.patch:28: WARNING: line over 80 characters

Error #256 when running ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0004-media-dt-bindings-Document-i.MX8MQ-VPU-bindings.patch:
$ ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0004-media-dt-bindings-Document-i.MX8MQ-VPU-bindings.patch
patches/0004-media-dt-bindings-Document-i.MX8MQ-VPU-bindings.patch:17: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

Error #256 when running ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0005-media-hantro-add-initial-i.MX8MQ-support.patch:
$ ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0005-media-hantro-add-initial-i.MX8MQ-support.patch
patches/0005-media-hantro-add-initial-i.MX8MQ-support.patch:45: WARNING: please write a paragraph that describes the config symbol fully
patches/0005-media-hantro-add-initial-i.MX8MQ-support.patch:97: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

Error #256 when running ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0007-media-i2c-video-i2c-fix-build-errors-due-to-imply-hw.patch:
$ ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0007-media-i2c-video-i2c-fix-build-errors-due-to-imply-hw.patch
patches/0007-media-i2c-video-i2c-fix-build-errors-due-to-imply-hw.patch:12: WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)

