Return-Path: <SRS0=WufJ=6T=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0004BC47247
	for <linux-media@archiver.kernel.org>; Tue,  5 May 2020 08:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D76AE206B9
	for <linux-media@archiver.kernel.org>; Tue,  5 May 2020 08:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgEEIkc (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 5 May 2020 04:40:32 -0400
Received: from www.linuxtv.org ([130.149.80.248]:56304 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgEEIkc (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 5 May 2020 04:40:32 -0400
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1jVt4h-00CTH9-Ue; Tue, 05 May 2020 08:37:11 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1jVt9m-0000kD-H0; Tue, 05 May 2020 08:42:26 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.8] Add Tegra210 Video input driver (#63596)
Date:   Tue,  5 May 2020 08:42:26 +0000
Message-Id: <20200505084226.2820-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <c95abf33-bfd4-489f-2c20-536e76b848ce@xs4all.nl>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/63596/
Build log: https://builder.linuxtv.org/job/patchwork/49600/
Build time: 00:02:11
Link: https://lore.kernel.org/linux-media/c95abf33-bfd4-489f-2c20-536e76b848ce@xs4all.nl

gpg: Signature made Tue 05 May 2020 08:31:46 AM UTC
gpg:                using RSA key AAA7FFBA4D2D77EF4CAEA1421326E0CD23ABDCE5
gpg: Good signature from "Hans Verkuil <hverkuil-cisco@xs4all.nl>" [unknown]
gpg:                 aka "Hans Verkuil <hverkuil@xs4all.nl>" [full]

Summary: 2 patches and/or PDF generation with issues, being 0 at build time

Error/warnings:


Error #256 when running cat patches/0001-media-tegra-Add-Tegra210-Video-input-driver.patch | formail -c | ./scripts/checkpatch.pl --terse --mailback --no-summary --strict:
$ cat patches/0001-media-tegra-Add-Tegra210-Video-input-driver.patch | formail -c | ./scripts/checkpatch.pl --terse --mailback --no-summary --strict
-:76: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
-:650: WARNING: DT compatible string "nvidia,tegra210-csi" appears un-documented -- check ./Documentation/devicetree/bindings/
-:3260: WARNING: DT compatible string "nvidia,tegra210-csi" appears un-documented -- check ./Documentation/devicetree/bindings/

