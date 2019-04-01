Return-Path: <SRS0=Gl4L=SD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C50C43381
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 13:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11E720700
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 13:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfDANsx (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:48:53 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:57165 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726991AbfDANsw (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 1 Apr 2019 09:48:52 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id AxIphtcrNiLOmAxIuhcPEK; Mon, 01 Apr 2019 15:48:50 +0200
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.2] Various fixes
Message-ID: <dd916431-1424-c062-82d8-9d3d842dd572@xs4all.nl>
Date:   Mon, 1 Apr 2019 15:48:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNRjPR7j2bM0l0tykAvquAy7+nIu/H+yPce2/terrKGlnKFy5gN4DAo4vSZhZmeGqYrX3copfq7wgMQzWpZrF6DZ+plX6tkVxECx7/yX+EJgfKwhq9/q
 dM4rShN+08gG6HrbK/fXCtN2OPS6m69Cqf0GjOBNrnEugSddo34tXrSMGqNtzVq9p+wzho9t3p26t6c7JtY61xWm7BpegKKdvn0=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

Various fixes. The patch "Introduce helpers to fill pixel format structs"
is interesting and should simplify some of the driver code going forward.
Other patches add support for it to vimc. Other patches using it for e.g.
rockchip drivers are pending.

Regards,

	Hans


The following changes since commit 1c3ec30bb23023d738b538e64ac3028902d53692:

  media: index.rst: exclude Indexes section from latex/pdf output (2019-03-30 09:42:35 -0400)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.2b2

for you to fetch changes up to 1d93588c966b3f6fccb0e795f3288ee7f5124c86:

  media: stm32-dcmi: fix crash when subdev do not expose any formats (2019-04-01 13:19:59 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Colin Ian King (1):
      media: dvb: clean up redundant break statements

Eugen Hristev (2):
      media: atmel: atmel-isc: reworked driver and formats
      media: atmel: atmel-isc: removed ARGB32 added ABGR32 and XBGR32

Ezequiel Garcia (3):
      media: vb2: Minor function naming fix
      rockchip/vpu: Rename pixel format helpers
      media: Introduce helpers to fill pixel format structs

Fish Lin (1):
      v4l: add I / P frame min max QP definitions

Hans Verkuil (1):
      v4l2-ctrls.h: remove spurious text

Helen Fornazier (2):
      media: v4l2-common: add bayer formats in v4l2_format_info
      media: vimc: propagate pixel format in the stream

Hugues Fruchet (3):
      media: stm32-dcmi: fix error messages
      media: stm32-dcmi: do not emit error trace in case of few overrun
      media: stm32-dcmi: fix crash when subdev do not expose any formats

Sergei Shtylyov (1):
      dt-bindings: media: Renesas R-Car IMR bindings

Wolfram Sang (1):
      staging: media: imx: imx7-mipi-csis: simplify getting .driver_data

Yannick Fertre (1):
      media: platform: stm32: wait end of transmission

Yunfei Dong (1):
      media: mtk-vcodec: enlarge struct vdec_pic_info fields

 Documentation/devicetree/bindings/media/rcar_imr.txt  |  31 ++
 Documentation/media/uapi/v4l/ext-ctrls-codec.rst      |  24 ++
 drivers/media/common/videobuf2/videobuf2-v4l2.c       |   6 +-
 drivers/media/dvb-frontends/drxd_hard.c               |  30 +-
 drivers/media/platform/atmel/atmel-isc.c              | 899 +++++++++++++++++++++++++---------------------
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c    |  62 ++--
 drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h    |  16 +-
 drivers/media/platform/mtk-vcodec/vdec/vdec_h264_if.c |   4 +-
 drivers/media/platform/mtk-vcodec/vdec/vdec_vp8_if.c  |   4 +-
 drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c  |  11 +-
 drivers/media/platform/stm32/stm32-cec.c              |  11 +
 drivers/media/platform/stm32/stm32-dcmi.c             |  23 +-
 drivers/media/platform/vimc/vimc-capture.c            |  76 ++--
 drivers/media/platform/vimc/vimc-common.c             | 309 +++++++---------
 drivers/media/platform/vimc/vimc-common.h             |  58 ++-
 drivers/media/platform/vimc/vimc-debayer.c            |  81 +++--
 drivers/media/platform/vimc/vimc-scaler.c             |  63 ++--
 drivers/media/platform/vimc/vimc-sensor.c             |  51 +--
 drivers/media/platform/vimc/vimc-streamer.c           |   2 +
 drivers/media/platform/vimc/vimc-streamer.h           |   6 +
 drivers/media/v4l2-core/v4l2-common.c                 | 186 ++++++++++
 drivers/media/v4l2-core/v4l2-ctrls.c                  |   4 +
 drivers/staging/media/imx/imx7-mipi-csis.c            |   6 +-
 drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c |  12 +-
 include/media/v4l2-common.h                           |  33 ++
 include/media/v4l2-ctrls.h                            |   4 +-
 include/uapi/linux/v4l2-controls.h                    |   4 +
 27 files changed, 1173 insertions(+), 843 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/rcar_imr.txt
