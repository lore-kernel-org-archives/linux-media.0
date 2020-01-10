Return-Path: <SRS0=fbk1=27=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA51AC282DD
	for <linux-media@archiver.kernel.org>; Fri, 10 Jan 2020 14:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF3520721
	for <linux-media@archiver.kernel.org>; Fri, 10 Jan 2020 14:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="FaEiKMEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgAJOxG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:53:06 -0500
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:48735 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728115AbgAJOxG (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 10 Jan 2020 09:53:06 -0500
Received: from [IPv6:2001:420:44c1:2577:c967:e1d3:183a:b8ef]
 ([IPv6:2001:420:44c1:2577:c967:e1d3:183a:b8ef])
        by smtp-cloud8.xs4all.net with ESMTPA
        id pveminik6pLtbpvepiRAHY; Fri, 10 Jan 2020 15:53:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1578667983; bh=RtZJqp4wiNMY/XmExSKDRVmvbGdzTourhfS9Sc8yZvk=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=FaEiKMEzn9zRkGrk8gf1iLARxGc6zov4HKPgcEawypO8oEXD+2q0imvW09OMpM7Wl
         s1RyOdAtpTW7qyzOsTQFFh44ZMV3tUtHxRjmyasPbWD96hPUOcd1n53jvhqY6UkmvU
         jnvjS/JPD78NL63bkk9KjrvfqImnZ+cZWPFOmMsdtQ8R6IRtgVym7FFAorj97tJ+/f
         zRbd4n5/L7ylv1wGvrYK/4PId+ATATcut6M0rrAbyayJQ2Br/IHnUrXMtCB4HszSxc
         gFDHpi8YCGMC4A7Dw/9KmzkKQ5c7oOPwHkuo/fy0lyP4tXZQPb+OH+3MKR+I8t+tKE
         C3rya7CgLjn1Q==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.6] Various fixes
Message-ID: <cc217178-64e4-19ca-f8f8-06edf053a14a@xs4all.nl>
Date:   Fri, 10 Jan 2020 15:53:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNiwPYRXLE0PhXjaibDABgX2P++iePbj55nQlXQ06F5Z2sQade7k+vc3RsYLeAvDSblwApn75IFq2fBLBYtUxaK/16UTJ4pg2FW/58MGMWnZxdDA909G
 Nal3pQst26EB8tPt2h0zyXcBMu+fytg/lFEvcXvPaw4xbE6NMsZORH+Zq0ccZs7bmbC5vkvihrikLBSIUzHgodTM1VM9M19M73qAHg2Jfv+weQsoW2lA16ZI
 qR1TgCQ2dRZiS5h+Du4sv+U5l9KmupLqUk9bOi8oo/E+OClNEvHMToLXs1EPsAku
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The following changes since commit 2a0a0bc7020ef7e66c9569d8229d79fa72e3d659:

  media: MAINTAINERS: add entry for Rockchip ISP1 driver (2020-01-09 16:45:01 +0100)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.6k

for you to fetch changes up to 3351d701efd90aa963cb7e22e4c2ad0b1fa09e7d:

  media: stm32-dcmi: Use dma_request_chan() instead dma_request_slave_channel() (2020-01-10 15:27:49 +0100)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Aditya Pakki (1):
      media: media/saa7146: fix incorrect assertion in saa7146_buffer_finish

Julia Lawall (3):
      anysee: constify copied structure
      media: isif: constify copied structure
      media: cx231xx: constify copied structure

Krzysztof Kozlowski (1):
      media: Fix Kconfig indentation

Niklas Söderlund (3):
      rcar-vin: Use correct pixel format when aligning format
      rcar-vin: Handle special pixel formats in a switch
      rcar-vin: Limit NV12 availability to supported VIN channels only

Peter Ujfalusi (1):
      media: stm32-dcmi: Use dma_request_chan() instead dma_request_slave_channel()

Wolfram Sang (1):
      media: v4l2-core: v4l2-i2c: convert to new API with ERRPTR

 drivers/media/Kconfig                       |  6 +++---
 drivers/media/common/saa7146/saa7146_fops.c |  2 --
 drivers/media/platform/Kconfig              | 74 ++++++++++++++++++++++++++++++++---------------------------------
 drivers/media/platform/davinci/isif.c       |  2 +-
 drivers/media/platform/exynos4-is/Kconfig   |  2 +-
 drivers/media/platform/rcar-vin/rcar-v4l2.c | 23 ++++++++++++++------
 drivers/media/platform/stm32/stm32-dcmi.c   | 11 ++++++----
 drivers/media/radio/si470x/Kconfig          |  4 ++--
 drivers/media/usb/cx231xx/cx231xx-dvb.c     |  2 +-
 drivers/media/usb/dvb-usb-v2/anysee.c       |  4 ++--
 drivers/media/v4l2-core/v4l2-i2c.c          | 10 ++++-----
 11 files changed, 76 insertions(+), 64 deletions(-)
