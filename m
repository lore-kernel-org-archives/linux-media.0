Return-Path: <SRS0=MIHa=26=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A576DC33CA1
	for <linux-media@archiver.kernel.org>; Thu,  9 Jan 2020 10:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8614220673
	for <linux-media@archiver.kernel.org>; Thu,  9 Jan 2020 10:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgAIKhp (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:37:45 -0500
Received: from www.linuxtv.org ([130.149.80.248]:60496 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729151AbgAIKhm (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 9 Jan 2020 05:37:42 -0500
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1ipVBJ-001Myk-BV; Thu, 09 Jan 2020 10:36:49 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1ipVDB-0003Pi-Lj; Thu, 09 Jan 2020 10:38:45 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.6] RC & DVB (c)
Date:   Thu,  9 Jan 2020 10:38:45 +0000
Message-Id: <20200109103845.13081-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109102647.GA27599@gofer.mess.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/61105/
Build log: https://builder.linuxtv.org/job/patchwork/32892/
Build time: 00:08:35
Link: https://lore.kernel.org/linux-media/20200109102647.GA27599@gofer.mess.org

gpg: Signature made Wed 08 Jan 2020 07:53:13 PM UTC
gpg:                using RSA key A624251A26084A9ED9E4C8B6425F639D3960FA9E
gpg:                issuer "sean@mess.org"
gpg: Good signature from "Sean Young <sean@mess.org>" [full]

Summary: 2 patches and/or PDF generation with issues, being 0 at build time

Error/warnings:


Error #256 when running ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0006-media-pci-cx23885-cx23885-dvb-convert-to-use-i2c_new.patch:
$ ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0006-media-pci-cx23885-cx23885-dvb-convert-to-use-i2c_new.patch
patches/0006-media-pci-cx23885-cx23885-dvb-convert-to-use-i2c_new.patch:37: WARNING: line over 80 characters
patches/0006-media-pci-cx23885-cx23885-dvb-convert-to-use-i2c_new.patch:48: WARNING: line over 80 characters
patches/0006-media-pci-cx23885-cx23885-dvb-convert-to-use-i2c_new.patch:60: WARNING: line over 80 characters
patches/0006-media-pci-cx23885-cx23885-dvb-convert-to-use-i2c_new.patch:106: WARNING: line over 80 characters
patches/0006-media-pci-cx23885-cx23885-dvb-convert-to-use-i2c_new.patch:129: WARNING: line over 80 characters
patches/0006-media-pci-cx23885-cx23885-dvb-convert-to-use-i2c_new.patch:208: WARNING: line over 80 characters
patches/0006-media-pci-cx23885-cx23885-dvb-convert-to-use-i2c_new.patch:230: WARNING: line over 80 characters
patches/0006-media-pci-cx23885-cx23885-dvb-convert-to-use-i2c_new.patch:241: WARNING: line over 80 characters
patches/0006-media-pci-cx23885-cx23885-dvb-convert-to-use-i2c_new.patch:252: WARNING: line over 80 characters
patches/0006-media-pci-cx23885-cx23885-dvb-convert-to-use-i2c_new.patch:263: WARNING: line over 80 characters
patches/0006-media-pci-cx23885-cx23885-dvb-convert-to-use-i2c_new.patch:274: WARNING: line over 80 characters
patches/0006-media-pci-cx23885-cx23885-dvb-convert-to-use-i2c_new.patch:285: WARNING: line over 80 characters
patches/0006-media-pci-cx23885-cx23885-dvb-convert-to-use-i2c_new.patch:296: WARNING: line over 80 characters
patches/0006-media-pci-cx23885-cx23885-dvb-convert-to-use-i2c_new.patch:307: WARNING: line over 80 characters
patches/0006-media-pci-cx23885-cx23885-dvb-convert-to-use-i2c_new.patch:318: WARNING: line over 80 characters

Error #256 when running ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0007-media-pci-saa7164-saa7164-dvb-convert-to-use-i2c_new.patch:
$ ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0007-media-pci-saa7164-saa7164-dvb-convert-to-use-i2c_new.patch
patches/0007-media-pci-saa7164-saa7164-dvb-convert-to-use-i2c_new.patch:38: WARNING: line over 80 characters
patches/0007-media-pci-saa7164-saa7164-dvb-convert-to-use-i2c_new.patch:50: WARNING: line over 80 characters
patches/0007-media-pci-saa7164-saa7164-dvb-convert-to-use-i2c_new.patch:62: WARNING: line over 80 characters
patches/0007-media-pci-saa7164-saa7164-dvb-convert-to-use-i2c_new.patch:74: WARNING: line over 80 characters

