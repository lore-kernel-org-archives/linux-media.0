Return-Path: <SRS0=OtTt=3F=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F790C33CB1
	for <linux-media@archiver.kernel.org>; Thu, 16 Jan 2020 13:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3142075B
	for <linux-media@archiver.kernel.org>; Thu, 16 Jan 2020 13:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="sH9Nbjzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgAPNwm (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:52:42 -0500
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:46723 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726084AbgAPNwm (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 16 Jan 2020 08:52:42 -0500
Received: from [IPv6:2001:420:44c1:2577:1825:cb8:c622:6168]
 ([IPv6:2001:420:44c1:2577:1825:cb8:c622:6168])
        by smtp-cloud7.xs4all.net with ESMTPA
        id s5Zci8RyarNgys5ZgiDCVl; Thu, 16 Jan 2020 14:52:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1579182760; bh=RhdCPcmAHGoRU66eAS3Ugj7utaPaZC3vhEUuuimbs/o=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=sH9NbjzbjLs39ub7UXFOno1jePJzsu1fv+iJ5AA3uEfKwOQqQEyTKFZN7AGc0l5gJ
         QeV0KgOHMCRRAgiX6xogorHq2RlOrAgKhmbnlrcNDLy8TTeMLyPqdimhjYQ42idVJ5
         CnoHcQEZipVWLTBAjvuQD4tQ9TaOzMgaALcTVB2wvqLLZ1ERUsEs3gHtjM+wBfuHqE
         haoCUUP2CySgk1v2hNSynwASgvjv1BhvYes7/id7+jEADi+QwE23q9tEyVqUpCIFkp
         Be44YgaL9d96pPIEynhJ6IH7nKjBGhDp3MEGXduYC3ZNYQsRm5odleCZpnZoHzbXRD
         DR0cE6aeNjcXQ==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.6] Various fixes
Message-ID: <05d43c5d-f0ba-74df-3a95-e424c6b39a79@xs4all.nl>
Date:   Thu, 16 Jan 2020 14:52:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfB7HH/eBC0kNhwfg2qQ3VgTr2yRzmNIJ+enav79fyoB3LZR0Rn9BTY+VR94/hhQGaZzm6vnm3KlFlZ9LonsKgCe0LKs8TPCICi/HDpHZW9CC1aSxe+8S
 0NbGlSl1uBY5AHSqT5JPewyHXP+qs7aqQO1/GILzztNEG0F5bGP3Usp40jjJK9Ur1U7K2z578jEaROGfffy3+KSPe5jMw0cdMNGEbHJkZA3iZZaYB9HyWxIa
 Avv1OvwdfRgnjWwzeD3lvRJ4Z6SXwQ5n7cvBKIPgCV1vskOG5wPOvFyAhC0GdwSc
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The following changes since commit 2a0a0bc7020ef7e66c9569d8229d79fa72e3d659:

  media: MAINTAINERS: add entry for Rockchip ISP1 driver (2020-01-09 16:45:01 +0100)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.6m

for you to fetch changes up to 14c6e30267c855093778bcec15b53b4051823498:

  rcar-vin: Add support for V4L2_FIELD_SEQ_{TB,BT} (2020-01-16 14:50:13 +0100)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Dafna Hirschfeld (1):
      media: vimc: streamer: fix memory leak in vimc subdevs if kthread_run fails

Eugen Hristev (2):
      media: atmel: atmel-isc-base: expose white balance as v4l2 controls
      MAINTAINERS: add atmel-isc-media.h file to ATMEL ISC driver

Hans Verkuil (1):
      vidioc-queryctrl.rst: fix error code

Hirokazu Honda (1):
      media: hantro: Support H264 profile control

Jae Hyun Yoo (1):
      Documentation: dt-bindings: media: add AST2600 Video Engine support

Joel Stanley (3):
      media: aspeed: Rework memory mapping in probe
      media: aspeed: Use runtime configuration
      video: aspeed: Update copyright information

Johan Hovold (1):
      media: usbtv: fix control-message timeouts

Niklas Söderlund (3):
      adv7180: Add init_cfg pad operation
      rcar-vin: Move hardware buffer tracking to own struct
      rcar-vin: Add support for V4L2_FIELD_SEQ_{TB,BT}

Peter Ujfalusi (3):
      media: pxa_camera: Use dma_request_chan() instead dma_request_slave_channel()
      media: rcar_drif: Use dma_request_chan() instead dma_request_slave_channel()
      media: xilinx: Use dma_request_chan() instead dma_request_slave_channel()

 Documentation/devicetree/bindings/media/aspeed-video.txt |   5 +-
 Documentation/media/uapi/v4l/vidioc-queryctrl.rst        |   2 +-
 MAINTAINERS                                              |   1 +
 drivers/media/i2c/adv7180.c                              |  12 +++
 drivers/media/platform/aspeed-video.c                    |  73 +++++++++++------
 drivers/media/platform/atmel/atmel-isc-base.c            | 222 ++++++++++++++++++++++++++++++++++++++++++++-------
 drivers/media/platform/atmel/atmel-isc.h                 |  23 +++++-
 drivers/media/platform/pxa_camera.c                      |  20 ++---
 drivers/media/platform/rcar-vin/rcar-dma.c               |  91 ++++++++++++++++-----
 drivers/media/platform/rcar-vin/rcar-v4l2.c              |   5 ++
 drivers/media/platform/rcar-vin/rcar-vin.h               |  28 ++++++-
 drivers/media/platform/rcar_drif.c                       |   6 +-
 drivers/media/platform/vimc/vimc-streamer.c              |   9 ++-
 drivers/media/platform/xilinx/xilinx-dma.c               |  11 +--
 drivers/media/usb/usbtv/usbtv-core.c                     |   2 +-
 drivers/media/usb/usbtv/usbtv-video.c                    |   5 +-
 drivers/staging/media/hantro/hantro_drv.c                |  10 +++
 include/linux/atmel-isc-media.h                          |  58 ++++++++++++++
 include/uapi/linux/v4l2-controls.h                       |   6 ++
 19 files changed, 486 insertions(+), 103 deletions(-)
 create mode 100644 include/linux/atmel-isc-media.h
