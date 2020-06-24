Return-Path: <SRS0=XVSF=AF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D98C433E0
	for <linux-media@archiver.kernel.org>; Wed, 24 Jun 2020 15:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D01F12078A
	for <linux-media@archiver.kernel.org>; Wed, 24 Jun 2020 15:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ojt9YBlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404288AbgFXPYJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:24:09 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:45629 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404017AbgFXPYJ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 24 Jun 2020 11:24:09 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id o7FrjhzhINb6lo7Fujtq9Y; Wed, 24 Jun 2020 17:24:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1593012247; bh=oX56VdwsuVUDjJYCaaf5bwSx7iEk4wXXmhKFL3v7zPU=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=ojt9YBlVYXJjWTU4KGDYuPrKSzmss2Hq2+E6Rh2zeJzgP55goofJ5EOS0Ulw9O0YH
         ruRtT7sI09TYRKQYr8Le16F4/pYZKJNGXV+SLG8idPJ9ORf8tTXD6jgZkw2iEKijGb
         LKyG6SLavPmC2+/jHVgAGlnwQmIe8RiMB3R3sTAQoYz0cgvmpQ5hrQMwh1S1jwr3tY
         RokgWdoFFPcdjzs9J1qdQH30ugDi0kvW0elDitQ7eNb4jvKsPA/KYlq+0ZNELzkH6Z
         f+GyPzCW64vads8bmNCCbjsqWEuTI3YKcuMiB6MIPbsjDm6sG4YqN3GMZDRtAwHJtI
         QMmEGeAEwCpKQ==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Jeff Chase <jnchase@google.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.9] Add Chrontel ch7322 CEC adapter driver
Message-ID: <eecb9151-2e7d-7d90-010d-dab6fc42307f@xs4all.nl>
Date:   Wed, 24 Jun 2020 17:24:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLqjTzPBFpcYjo5WalErVAZ+PsKiZU1m9BJBn2WDFjbbn+XOYGbptuEsMZEfCoRkXPyFXfqrPaYQP9sRKt94f6yqIIusKr0hsbRVXR3/LnySmjJbni7q
 9zDd5Zlhtg6atTCaeFcxHK/qfhMz+iQ/iin6LspIj4w6ZDaJXJJ3THUby+wAetEU9HZ0NKkeej058lfrYiMIyziJt4LBWD33m8w=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The following changes since commit e30cc79cc80fd919b697a15c5000d9f57487de8e:

  media: media-request: Fix crash if memory allocation fails (2020-06-23 15:19:37 +0200)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-ch7322

for you to fetch changes up to b2f2b3c3bdbfd19cf7a8aa4d6717aeb46a43872e:

  media: cec: i2c: ch7322: Add ch7322 CEC controller driver (2020-06-24 17:00:09 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Jeff Chase (3):
      dt-bindings: Add ch7322 media i2c device
      media: cec: add adap_controls_phys_addr option
      media: cec: i2c: ch7322: Add ch7322 CEC controller driver

 Documentation/devicetree/bindings/media/i2c/chrontel,ch7322.yaml |  67 +++++
 MAINTAINERS                                                      |   8 +
 drivers/media/cec/Kconfig                                        |   1 +
 drivers/media/cec/Makefile                                       |   2 +-
 drivers/media/cec/core/cec-notifier.c                            |  11 +-
 drivers/media/cec/i2c/Kconfig                                    |  14 +
 drivers/media/cec/i2c/Makefile                                   |   5 +
 drivers/media/cec/i2c/ch7322.c                                   | 604 ++++++++++++++++++++++++++++++++++++++++++++
 include/media/cec.h                                              |   6 +
 9 files changed, 713 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/chrontel,ch7322.yaml
 create mode 100644 drivers/media/cec/i2c/Kconfig
 create mode 100644 drivers/media/cec/i2c/Makefile
 create mode 100644 drivers/media/cec/i2c/ch7322.c
