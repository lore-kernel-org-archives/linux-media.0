Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68632C43381
	for <linux-media@archiver.kernel.org>; Wed,  6 Jan 2021 10:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 263A32310F
	for <linux-media@archiver.kernel.org>; Wed,  6 Jan 2021 10:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbhAFKn6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 6 Jan 2021 05:43:58 -0500
Received: from gofer.mess.org ([88.97.38.141]:52467 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbhAFKn5 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 6 Jan 2021 05:43:57 -0500
Received: by gofer.mess.org (Postfix, from userid 1000)
        id CE41DC6385; Wed,  6 Jan 2021 10:43:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1609929794; bh=NKYGIPCJVnLRmaqnjq9gKa5xG/lDCTajTqlkIwJgtPQ=;
        h=Date:From:To:Subject:From;
        b=RY6PMn15OEPvhAll0aR5Qeue6sbI+OeRjNSS2n6hgGgK7xsTH+/yKHdVRF1yJbkFj
         q6ySbvRcW3P4jyI1u8PQzcjczvIc+3peKXUMDNjYMJEYLVozcSHNd24jimUwmut3g3
         TkGaBQwtpNEy65wQM2lGnxquXHWrik4ZlIvRNH/HQcMc2Moamt84pPVi7miq/tU2mO
         QYxE+8LAivSXoJUS60fxqIuxmd+mZ6TypF+SenDfjrwrvb9LMI7qYqy4tEXdO5BBm+
         gOP8zUyKUdsayU+ZwTOvFNGe3uIjQpZjbGI7O2DL1DJ8zX9BwyrKb+OGlyG2henSP7
         Ap+x2dsovdldQ==
Date:   Wed, 6 Jan 2021 10:43:14 +0000
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Subject: [GIT FIXES FOR v5.11] rc nsec to usec fix #2
Message-ID: <20210106104314.GA879@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

Here is a fix for the nsec to usec change in rc-core, this time based of
the signed tag.

Thanks,

Sean

The following changes since commit 896111dc4bcf887b835b3ef54f48b450d4692a1d:

  media: rc: ensure that uevent can be read directly after rc device register (2021-01-04 11:00:25 +0100)

are available in the Git repository at:

  git://linuxtv.org/syoung/media_tree.git tags/v5.11f

for you to fetch changes up to 38ba369ca12bad5ed0a01d6a966f865219857415:

  media: rc: fix timeout handling after switch to microsecond durations (2021-01-05 10:03:01 +0000)

----------------------------------------------------------------
v5.11f

----------------------------------------------------------------
Matthias Reichl (1):
      media: rc: fix timeout handling after switch to microsecond durations

 drivers/media/rc/ir-mce_kbd-decoder.c | 2 +-
 drivers/media/rc/rc-main.c            | 4 ++--
 drivers/media/rc/serial_ir.c          | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
