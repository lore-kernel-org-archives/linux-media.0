Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C19C64E7B
	for <linux-media@archiver.kernel.org>; Tue,  1 Dec 2020 15:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 760FB20758
	for <linux-media@archiver.kernel.org>; Tue,  1 Dec 2020 15:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="YjjZst7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387835AbgLAPNd (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 1 Dec 2020 10:13:33 -0500
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:57033 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387592AbgLAPNc (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 1 Dec 2020 10:13:32 -0500
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud7.xs4all.net with ESMTPA
        id k7Kgk5s6pN7Xgk7KjkouZt; Tue, 01 Dec 2020 16:12:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1606835570; bh=Oj0Wobna6FnAkwBTdMk533P+PsB7edJw0k5UB5T/dCM=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=YjjZst7CH03/qX6BuTPMeosO4G4HiPSao9Yt5Kinw4Uaf5BgZ0mxc951og7wrt9Ny
         zizx+E322iHbHNcUYvTjzTWo+StZh409yei7IeTc7ogaxe3vnQcyutq5tOhwNvSsz3
         sTGK1gSNoxOAbvKM6TxuYbfSLfjBFK3Vizvka3W4oYeFJLTObgu6oEXIUFUAGYJkQb
         lEVu5B6hVNY4h6zf0C+W6fxAvY9OFQEddEix5cS39vUpH37oSptWP6D0RLRWk5yfZS
         GLC8XHn2Dv2P/+gk22RUMKM+qGgzQKhn/LmEdsw/29hTp1BBeGfPiSp+jJA2FFo/kA
         xXmoo8aW/fH/g==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT FIXES FOR v5.10] v2: Two pulse8-cec fixes
Message-ID: <52c0188e-fb21-0053-9c6c-4a50b990cb16@xs4all.nl>
Date:   Tue, 1 Dec 2020 16:12:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCI/A/VqzPlExy+JDeZ/A86dPm4O0KYqiDaP0kb32Zw78LWdqajrIOsJj+/8YzgOulRABtxenWgZXKc3Wb7RSIfxbHh1Fue7h157E2TWWFKet6jUwgMF
 cXJY45rVMXHGQiA9IosSu22DjoOi2f3IBa9MsG0cTLAHDn+Yn9Hjh2TfXb9nf57ISk6HNNi+CxHksEa+uMT70ZhkBtIGdfWWtUOaWFDZhLUvnTV2F1iLNt73
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The first patch fixes a kernel crash when disconnecting a Pulse-Eight
device, or simply connecting a Pulse-Eight device using a fw version >= 10.

The second patch adds support for such newer firmwares. Apparently the latest
batch of Pulse-Eight adapters us version 12, so they will currently all fail
hard.

Many thanks to Maxime for reporting this and helping to test the fixes.

Regards,

	Hans

Changes since v1:

- fix commit IDs (one character too long)
- drop comment after the stable Cc (apparently no longer supported)

No code changes, just in the commit log.

The following changes since commit 711561a41d1f70ad939c3ff3cf00e75fa8238337:

  media: lirc: fix lirc.h documentation generation (2020-11-26 14:29:37 +0100)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.10b

for you to fetch changes up to b57f7cf7876855d0cd5e654dc859b3dec7ea1f4f:

  pulse8-cec: add support for FW v10 and up (2020-12-01 16:08:50 +0100)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Hans Verkuil (2):
      pulse8-cec: fix duplicate free at disconnect or probe error
      pulse8-cec: add support for FW v10 and up

 drivers/media/cec/usb/pulse8/pulse8-cec.c | 52 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 18 deletions(-)
