Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B76C43381
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 18:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429FF20823
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 18:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfC1SiH (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:38:07 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:59975 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726047AbfC1SiH (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 14:38:07 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 9ZuchJoKSUjKf9Zufhtn4J; Thu, 28 Mar 2019 19:38:05 +0100
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.2] Fixes, fixes and more fixes
Message-ID: <28d8bc7d-910f-9aa7-88ba-1c0d630578b4@xs4all.nl>
Date:   Thu, 28 Mar 2019 19:38:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHJx4vC+uyNEoC5d/ZVuEoxvSV8MJtuJkUfNXYAEguIYveugL7nFfCzYqnFvir9LHeK8QSQE2yo+sKSpVD5rCGcIjT3Shpyw5r949Dx2oa7WdlkO2soz
 Kv/L5wleHqeE7lRDBI6DrpKBiPfuBAKSjrb8IF+nn734g0A7MHgPvqO9JthKpBibbHIceZ3QkyV0+g==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The following changes since commit 149e31e90b505ae0cc909bd0d92b2ba4826574d6:

  media: v4l: rcar_fdp1: Fix indentation oddities (2019-03-25 14:14:56 -0400)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.2a-new

for you to fetch changes up to 0bc6225ce93d79a051ea7c926bac35eb942b29a2:

  media: wl128x: Fix some error handling in fmc_prepare() (2019-03-28 16:35:53 +0100)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Alexandre Courbot (2):
      media: mtk-vcodec: fix access to incorrect planes member
      media: mtk-vcodec: remove ready_to_display

Arnd Bergmann (3):
      staging: media: davinci_vpfe: fix large stack usage with clang
      staging: media: imx7-mipi-csis: fix debugfs compilation
      media: davinci-isif: avoid uninitialized variable use

Dan Carpenter (3):
      media: v4l2-ctrl: potential shift wrapping bugs
      wl128x: prevent two potential buffer overflows
      media: wl128x: Fix some error handling in fmc_prepare()

Ezequiel Garcia (1):
      gspca: Kill URBs on USB device disconnect

Kangjie Lu (2):
      media: video-mux: fix null pointer dereferences
      media: usbvision: fix a potential NULL pointer dereference

Koen Vandeputte (1):
      media: i2c: tda1997x: select V4L2_FWNODE

Lucas Leonardo Ciancaglini (1):
      media: staging/imx: Fix inconsistent long line breaks

YueHaibing (1):
      media: tw5864: Fix possible NULL pointer dereference in tw5864_handle_frame

 drivers/media/i2c/Kconfig                          |  3 ++-
 drivers/media/pci/tw5864/tw5864-video.c            |  4 ++--
 drivers/media/platform/davinci/isif.c              |  9 ---------
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c |  9 ++-------
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.h |  2 --
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c | 10 +++++-----
 drivers/media/platform/video-mux.c                 |  5 +++++
 drivers/media/radio/wl128x/fmdrv_common.c          |  9 ++++++---
 drivers/media/usb/gspca/gspca.c                    |  4 +++-
 drivers/media/usb/usbvision/usbvision-core.c       |  3 +++
 drivers/media/v4l2-core/v4l2-ctrls.c               |  4 ++--
 drivers/staging/media/davinci_vpfe/dm365_isif.c    | 20 +++++++++-----------
 drivers/staging/media/imx/imx-media-dev.c          | 17 +++++++++--------
 drivers/staging/media/imx/imx7-mipi-csis.c         | 16 ++--------------
 14 files changed, 50 insertions(+), 65 deletions(-)
