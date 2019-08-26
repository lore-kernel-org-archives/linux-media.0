Return-Path: <SRS0=igqM=WW=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A0CC3A59F
	for <linux-media@archiver.kernel.org>; Mon, 26 Aug 2019 16:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E8C206BA
	for <linux-media@archiver.kernel.org>; Mon, 26 Aug 2019 16:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566837935;
	bh=57OR/lLT7te4caEP+GgHIwdqSMq7DhXkDKdlrsRF7gg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=NzNqZ41Wd2WivSgO79tMjxzENUgJG5qlElUWbqZ3h/hks97YW7qtMe5mb9sdADV3a
	 sYD+CDGtEtcPuZFQm/0Mg/2Q0N2TS1jQ+GyX6f/ry2cQuEkiacsBncZs/oSng/q3py
	 m7ZqAXyykiq2I1Hzleo35Au5FF0dLHeQ1SSl8tjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733059AbfHZQpe (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 26 Aug 2019 12:45:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39506 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733066AbfHZQpe (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 26 Aug 2019 12:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PlMC/LTyTtcuu5LOWMZIJEE3Vv3BYEQR/0v7QjlNLhQ=; b=t/meXgVJQ6V0NzBmq16OCXXgm
        8bkDEDunfqQTkYKcK2QtXQn54/EuVhNqMVKdkp+4TNZ1H8GPGAcugAyNoJulvuX7gl6HdwXz0YVQ4
        vnFqK7v0b3/FO0S8OnSLtNz8P9BqQfN7FiiUy/QyXr+2gUbcmM6YH8yUYdD6WkvGm8P5YG0pk3ctV
        erydmqXs4MBVoq/COO0FjFJXIeKu9XkwfgUKpvntM9r08M2o29xQivbbHuksHq+AG9I4acyJQnMWF
        349iub5Bq8ezD7iqiuL1TcEpVNb2sKckgeDWAZVvZmOVLeEmC5MzqR8OSEJ1LIvz3JYJ/vTbdTjTI
        FZp2fIKqQ==;
Received: from 177.17.135.157.dynamic.adsl.gvt.net.br ([177.17.135.157] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2I7Z-0004tY-6Z; Mon, 26 Aug 2019 16:45:33 +0000
Date:   Mon, 26 Aug 2019 13:45:29 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>
Subject: [GIT PULL] media patches
Message-ID: <20190826134529.5db7716b@coco.lan>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The following changes since commit 01faced6f65d0224bf6ce1262a4137771e28519f:

  media: dt-bindings: media: Convert Allwinner A10 IR to a schema (2019-08-21 18:39:55 -0300)

are available in the Git repository at:

  git://linuxtv.org/mchehab/experimental.git tags/patches/v5.3-1

for you to fetch changes up to 03905f3929e5c8241aa0188eda41dcb37ffd64c5:

  media: don't do a 31 bit shift on a signed int (2019-08-26 06:49:18 -0300)

----------------------------------------------------------------

Media patches solving some issues detected by cppcheck.

----------------------------------------------------------------
Mauro Carvalho Chehab (6):
      media: remove include stdarg.h from some drivers
      media: vicodec: make life easier for static analyzers
      media: aspeed-video: address a protential usage of an unit var
      media: ov9650: add a sanity check
      media: use the BIT() macro
      media: don't do a 31 bit shift on a signed int

 drivers/media/dvb-frontends/cx24123.c             |   2 +-
 drivers/media/i2c/ov9650.c                        |   5 +
 drivers/media/pci/bt8xx/bttv-input.c              |   4 +-
 drivers/media/pci/cobalt/cobalt-driver.h          |  63 +--
 drivers/media/pci/cx18/cx18-ioctl.c               |   2 +-
 drivers/media/pci/cx18/cx18-mailbox.c             |   2 +-
 drivers/media/pci/ivtv/ivtv-driver.c              |   2 +-
 drivers/media/pci/ivtv/ivtv-ioctl.c               |   4 +-
 drivers/media/pci/ivtv/ivtv-irq.h                 |  28 +-
 drivers/media/pci/ivtv/ivtv-mailbox.c             |   2 -
 drivers/media/pci/mantis/mantis_reg.h             | 152 +++---
 drivers/media/pci/solo6x10/solo6x10-gpio.c        |   6 +-
 drivers/media/pci/solo6x10/solo6x10-regs.h        | 286 +++++------
 drivers/media/pci/ttpci/av7110_hw.c               |   1 -
 drivers/media/platform/am437x/am437x-vpfe_regs.h  |  26 +-
 drivers/media/platform/aspeed-video.c             |   5 +-
 drivers/media/platform/davinci/dm644x_ccdc_regs.h |  20 +-
 drivers/media/platform/exynos4-is/fimc-lite-reg.h |  80 +--
 drivers/media/platform/exynos4-is/fimc-reg.h      | 138 ++---
 drivers/media/platform/exynos4-is/mipi-csis.c     |   6 +-
 drivers/media/platform/fsl-viu.c                  |   2 +-
 drivers/media/platform/mx2_emmaprp.c              |   2 +-
 drivers/media/platform/omap3isp/ispreg.h          | 584 +++++++++++-----------
 drivers/media/platform/pxa_camera.c               |   4 +-
 drivers/media/platform/qcom/venus/core.c          |   2 +-
 drivers/media/platform/s3c-camif/camif-regs.h     | 118 ++---
 drivers/media/platform/s5p-jpeg/jpeg-regs.h       |  10 +-
 drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c   |   4 +-
 drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c   |   2 +-
 drivers/media/platform/tegra-cec/tegra_cec.h      |  82 +--
 drivers/media/platform/ti-vpe/vpe_regs.h          |  94 ++--
 drivers/media/platform/vicodec/vicodec-core.c     |  11 +-
 drivers/media/platform/vsp1/vsp1_regs.h           | 224 ++++-----
 drivers/media/platform/xilinx/xilinx-vip.h        |  29 +-
 drivers/media/radio/radio-gemtek.c                |   2 +-
 drivers/media/radio/radio-trust.c                 |   1 -
 drivers/media/radio/wl128x/fmdrv_common.h         |  88 ++--
 drivers/media/usb/dvb-usb-v2/gl861.c              |   2 +-
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c           |  14 +-
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c          |   4 +-
 drivers/media/v4l2-core/v4l2-ioctl.c              |   2 +-
 drivers/staging/media/ipu3/ipu3-tables.h          |   4 +-
 42 files changed, 1068 insertions(+), 1051 deletions(-)

