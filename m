Return-Path: <SRS0=iZ/e=73=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D527CC433E0
	for <linux-media@archiver.kernel.org>; Sun, 14 Jun 2020 21:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD82A2071A
	for <linux-media@archiver.kernel.org>; Sun, 14 Jun 2020 21:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgFNVwi (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 14 Jun 2020 17:52:38 -0400
Received: from www.linuxtv.org ([130.149.80.248]:49552 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727910AbgFNVwi (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sun, 14 Jun 2020 17:52:38 -0400
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1jkaUR-00CgYJ-O6; Sun, 14 Jun 2020 21:48:31 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1jkaaW-00065k-WF; Sun, 14 Jun 2020 21:54:49 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.9] RC & DVB fixes (#64523)
Date:   Sun, 14 Jun 2020 21:54:48 +0000
Message-Id: <20200614215448.23375-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200614213012.GA2231@gofer.mess.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/64523/
Build log: https://builder.linuxtv.org/job/patchwork/55420/
Build time: 00:14:39
Link: https://lore.kernel.org/linux-media/20200614213012.GA2231@gofer.mess.org

gpg: Signature made Sun 14 Jun 2020 09:01:57 PM UTC
gpg:                using RSA key A624251A26084A9ED9E4C8B6425F639D3960FA9E
gpg:                issuer "sean@mess.org"
gpg: Good signature from "Sean Young <sean@mess.org>" [full]

Summary: 4 patches and/or PDF generation with issues, being 0 at build time

Error/warnings:


Error #256 when running cat patches/0001-media-rc-add-support-for-Infrared-Toy-and-IR-Droid-d.patch | formail -c | ./scripts/checkpatch.pl --terse --mailback --no-summary --strict:
$ cat patches/0001-media-rc-add-support-for-Infrared-Toy-and-IR-Droid-d.patch | formail -c | ./scripts/checkpatch.pl --terse --mailback --no-summary --strict
-:50: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

Error #256 when running cat patches/0004-media-cxusb-analog-fix-V4L2-dependency.patch | formail -c | ./scripts/checkpatch.pl --terse --mailback --no-summary --strict:
$ cat patches/0004-media-cxusb-analog-fix-V4L2-dependency.patch | formail -c | ./scripts/checkpatch.pl --terse --mailback --no-summary --strict
-:11: WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)

Error #256 when running cat patches/0005-media-dvbsky-MyGica-T230-receivers-also-do-DVB-C-and.patch | formail -c | ./scripts/checkpatch.pl --terse --mailback --no-summary --strict:
$ cat patches/0005-media-dvbsky-MyGica-T230-receivers-also-do-DVB-C-and.patch | formail -c | ./scripts/checkpatch.pl --terse --mailback --no-summary --strict
-:31: WARNING: line over 80 characters
-:35: WARNING: line over 80 characters

