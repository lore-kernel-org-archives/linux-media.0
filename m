Return-Path: <SRS0=7IOK=UF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136ACC04AB5
	for <linux-media@archiver.kernel.org>; Thu,  6 Jun 2019 16:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DF120645
	for <linux-media@archiver.kernel.org>; Thu,  6 Jun 2019 16:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfFFQ0b (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 6 Jun 2019 12:26:31 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:52893 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727840AbfFFQ0b (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 6 Jun 2019 12:26:31 -0400
Received: from [192.168.2.10] ([46.9.252.75])
        by smtp-cloud7.xs4all.net with ESMTPA
        id YvDdh2Nle3qlsYvDgho3dr; Thu, 06 Jun 2019 18:26:29 +0200
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.3] add meson decoder driver
Message-ID: <89dbffab-7d15-555b-9401-37243b0c9feb@xs4all.nl>
Date:   Thu, 6 Jun 2019 18:26:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBYrwH9L7Tt3t6Sx5C2ykIvEgdmvBHmwKZI2lDPavUNN16/U4J6Dn4hJXm4G2yBRPFDkHrAP71YsNxAGokkzJhk8eZfpr/bO1hLIrC/KEfHC2jw/AjBH
 HsKtnYpqlvMI2BswTi0Gc4PqLUb7ezqIAOPv24XhnkB4lYp93WA1rObxUT+KisI8F9g2PACXuGcm4p7oktZR2ylHvU00tm/B9II=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The following changes since commit edadd68031e5b7c1ba0c413a9549dce62a02844c:

  media: MAINTAINERS: update email address (2019-06-05 15:58:40 -0400)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.3o

for you to fetch changes up to ddfad6971e54f423ea78548e3dbf741a54968193:

  MAINTAINERS: Add meson video decoder (2019-06-06 18:16:40 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Maxime Jourdan (3):
      dt-bindings: media: add Amlogic Video Decoder Bindings
      media: meson: add v4l2 m2m video decoder driver
      MAINTAINERS: Add meson video decoder

 Documentation/devicetree/bindings/media/amlogic,vdec.txt |   71 +++
 MAINTAINERS                                              |    8 +
 drivers/staging/media/Kconfig                            |    2 +
 drivers/staging/media/Makefile                           |    1 +
 drivers/staging/media/meson/vdec/Kconfig                 |   11 +
 drivers/staging/media/meson/vdec/Makefile                |    8 +
 drivers/staging/media/meson/vdec/TODO                    |    8 +
 drivers/staging/media/meson/vdec/codec_mpeg12.c          |  210 ++++++++
 drivers/staging/media/meson/vdec/codec_mpeg12.h          |   14 +
 drivers/staging/media/meson/vdec/dos_regs.h              |   98 ++++
 drivers/staging/media/meson/vdec/esparser.c              |  324 +++++++++++++
 drivers/staging/media/meson/vdec/esparser.h              |   32 ++
 drivers/staging/media/meson/vdec/vdec.c                  | 1098 ++++++++++++++++++++++++++++++++++++++++++
 drivers/staging/media/meson/vdec/vdec.h                  |  267 ++++++++++
 drivers/staging/media/meson/vdec/vdec_1.c                |  230 +++++++++
 drivers/staging/media/meson/vdec/vdec_1.h                |   14 +
 drivers/staging/media/meson/vdec/vdec_helpers.c          |  449 +++++++++++++++++
 drivers/staging/media/meson/vdec/vdec_helpers.h          |   83 ++++
 drivers/staging/media/meson/vdec/vdec_platform.c         |  101 ++++
 drivers/staging/media/meson/vdec/vdec_platform.h         |   30 ++
 20 files changed, 3059 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/amlogic,vdec.txt
 create mode 100644 drivers/staging/media/meson/vdec/Kconfig
 create mode 100644 drivers/staging/media/meson/vdec/Makefile
 create mode 100644 drivers/staging/media/meson/vdec/TODO
 create mode 100644 drivers/staging/media/meson/vdec/codec_mpeg12.c
 create mode 100644 drivers/staging/media/meson/vdec/codec_mpeg12.h
 create mode 100644 drivers/staging/media/meson/vdec/dos_regs.h
 create mode 100644 drivers/staging/media/meson/vdec/esparser.c
 create mode 100644 drivers/staging/media/meson/vdec/esparser.h
 create mode 100644 drivers/staging/media/meson/vdec/vdec.c
 create mode 100644 drivers/staging/media/meson/vdec/vdec.h
 create mode 100644 drivers/staging/media/meson/vdec/vdec_1.c
 create mode 100644 drivers/staging/media/meson/vdec/vdec_1.h
 create mode 100644 drivers/staging/media/meson/vdec/vdec_helpers.c
 create mode 100644 drivers/staging/media/meson/vdec/vdec_helpers.h
 create mode 100644 drivers/staging/media/meson/vdec/vdec_platform.c
 create mode 100644 drivers/staging/media/meson/vdec/vdec_platform.h
