Return-Path: <SRS0=rHfj=S2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A457CC10F11
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 12:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF2121773
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 12:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfDXMRW (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:17:22 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:44893 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727230AbfDXMRW (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 24 Apr 2019 08:17:22 -0400
Received: from [IPv6:2001:420:44c1:2579:8575:c0e0:a08:6676] ([IPv6:2001:420:44c1:2579:8575:c0e0:a08:6676])
        by smtp-cloud9.xs4all.net with ESMTPA
        id JGpwh9oNONExlJGpzhQw0r; Wed, 24 Apr 2019 14:17:20 +0200
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, Eugen.Hristev@microchip.com
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.2] Various fixes, mostly atmel and coda.
Message-ID: <34b79578-80dc-84ad-7668-0992738b53b8@xs4all.nl>
Date:   Wed, 24 Apr 2019 14:17:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNDdJJyb4czZb3UoFms2S/rBpEsBFoQL3dyPshzXlONhzB2Y3Yp2mnKDUSOSBtdDvoTThPLdfwYxVcmiBpc4ErMeUMozxpPqLhIVx7/pI3be0hES5msY
 U5j+B9JNI5OpI1yVdOH+JrHdZPGXC15dwKG+wRcrJoajBM0OCn6fitVhDbDnma+hvpQn7IVetgtjvNFX/j25XgGbV9v7bWhvI5DkjOBJi8reEunyI4ZyhQ1P
 ol+Txe9QLA1XGIyMt4QyOkwnemhnmhq3txK+bh4/xK0vv6dW5KjHg1CnUno3uNJTLyqjPiRA8qtCcR3IqGN+y9LbT6+rmcYq0i6appkZ9/EqCwiyo7PfGP6R
 GN7jlq6j
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The following changes since commit a4dfc8a24796ff312d1d307e11f26f8ca466e938:

  media: MAINTAINERS: Update AO CEC with ao-cec-g12a driver (2019-04-22 13:16:35 -0400)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.2g2

for you to fetch changes up to 36e3425f9d53697ffbc13328dc8a6076f62efd9b:

  tegra-cec: fix cec_notifier_parse_hdmi_phandle return check (2019-04-24 13:12:33 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Dan Carpenter (2):
      media: omap_vout: potential buffer overflow in vidioc_dqbuf()
      media: davinci/vpbe: array underflow in vpbe_enum_outputs()

Eugen Hristev (7):
      media: atmel: atmel-isc: limit incoming pixels per frame
      media: atmel: atmel-isc: fix INIT_WORK misplacement
      media: atmel: atmel-isc: fix asd memory allocation
      media: atmel: atmel-isc: reworked white balance feature
      media: v4l2-ctrl: fix flags for DO_WHITE_BALANCE
      media: atmel: atmel-isc: add support for DO_WHITE_BALANCE
      media: atmel: atmel-isc: make try_fmt error less verbose

Hans Verkuil (2):
      field-order.rst: clarify FIELD_ANY and FIELD_NONE
      tegra-cec: fix cec_notifier_parse_hdmi_phandle return check

Niklas Söderlund (2):
      rcar-csi2: restart CSI-2 link if error is detected
      rcar-csi2: Propagate the FLD signal for NTSC and PAL

Philipp Zabel (13):
      media: coda: move register debugging to coda_debug level 3
      media: coda: move job ready message to coda_debug level 2
      media: coda: add coda_frame_type_char helper
      media: coda: improve decoder job finished debug message
      media: coda: demote s_ctrl debug messages to level 2
      media: coda: add menu strings to s_ctrl debug output
      media: coda: update profile and level controls after sequence initialization
      media: coda: add decoder MPEG-4 profile and level controls
      media: v4l2-ctrl: add MPEG-2 profile and level controls
      media: coda: add decoder MPEG-2 profile and level controls
      media: coda: add lockdep asserts
      media: coda: use v4l2_m2m_buf_copy_metadata
      media: coda: fix unset field and fail on invalid field in buf_prepare

Rui Miguel Silva (1):
      media: staging/imx: add media device to capture register

Stanimir Varbanov (1):
      media/doc: Allow sizeimage to be set by v4l clients

 Documentation/media/uapi/v4l/ext-ctrls-codec.rst    |  56 ++++++++++
 Documentation/media/uapi/v4l/field-order.rst        |  16 ++-
 Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst |  13 ++-
 Documentation/media/uapi/v4l/pixfmt-v4l2.rst        |  11 +-
 drivers/media/platform/atmel/atmel-isc-regs.h       |  25 ++++-
 drivers/media/platform/atmel/atmel-isc.c            | 309 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 drivers/media/platform/coda/Makefile                |   2 +-
 drivers/media/platform/coda/coda-bit.c              |  69 ++++++++++---
 drivers/media/platform/coda/coda-common.c           | 139 +++++++++++++++++++------
 drivers/media/platform/coda/coda-mpeg2.c            |  44 ++++++++
 drivers/media/platform/coda/coda-mpeg4.c            |  48 +++++++++
 drivers/media/platform/coda/coda.h                  |  14 +++
 drivers/media/platform/coda/coda_regs.h             |   2 +-
 drivers/media/platform/davinci/vpbe.c               |   2 +-
 drivers/media/platform/omap/omap_vout.c             |  15 ++-
 drivers/media/platform/rcar-vin/rcar-csi2.c         |  68 ++++++++++++-
 drivers/media/platform/tegra-cec/tegra_cec.c        |   4 +-
 drivers/media/v4l2-core/v4l2-ctrls.c                |  24 +++++
 drivers/staging/media/imx/imx-ic-prpencvf.c         |   2 +-
 drivers/staging/media/imx/imx-media-capture.c       |   6 +-
 drivers/staging/media/imx/imx-media-csi.c           |   2 +-
 drivers/staging/media/imx/imx-media.h               |   3 +-
 drivers/staging/media/imx/imx7-media-csi.c          |   2 +-
 include/media/davinci/vpbe.h                        |   2 +-
 include/uapi/linux/v4l2-controls.h                  |  18 ++++
 25 files changed, 779 insertions(+), 117 deletions(-)
 create mode 100644 drivers/media/platform/coda/coda-mpeg2.c
 create mode 100644 drivers/media/platform/coda/coda-mpeg4.c
