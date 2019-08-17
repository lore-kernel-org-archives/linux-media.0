Return-Path: <SRS0=Zkfq=WN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EABC3A59B
	for <linux-media@archiver.kernel.org>; Sat, 17 Aug 2019 09:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745922086C
	for <linux-media@archiver.kernel.org>; Sat, 17 Aug 2019 09:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfHQJs6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 17 Aug 2019 05:48:58 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:53355 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725840AbfHQJs6 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 17 Aug 2019 05:48:58 -0400
Received: from [192.168.2.10] ([46.9.232.237])
        by smtp-cloud8.xs4all.net with ESMTPA
        id yvKPh8Uj8DqPeyvKShf07s; Sat, 17 Aug 2019 11:48:56 +0200
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Hugues FRUCHET <hugues.fruchet@st.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.4] Various fixes and enhancements
Message-ID: <1e96f70a-4589-d905-1d0e-63a8d2ddbe43@xs4all.nl>
Date:   Sat, 17 Aug 2019 11:48:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJDXg29G9oQxdxhRi+xoJjiyhBYSM4+O6LhvmZHmtNkEKWwqcnurvLgb+iIj4UMPIpOLVdfzSQSjpnbv82LEYkAhGJStqY/9Y6LVqPhLuCevGohdK27L
 fxXpeauo+IYPTrZ4dY6y7jiSCg8kHKrvOQuUfwMWqEU0FBmhTs0pGpK+kCo/4F3zuqwWng/xkoITCm7zOcthQ7T5uxBX6ziqs+M=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The following changes since commit 31d5d15dfc3418a57cfab419a353d8dc5f5698b5:

  media: MAINTAINERS: Add entry for the ov5670 driver (2019-08-15 08:17:04 -0300)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.4m

for you to fetch changes up to cbc77b4a4f3125684f87e9a3ddfdc1a102e31e99:

  gspca: zero usb_buf on error (2019-08-17 11:34:22 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Ezequiel Garcia (2):
      media: Clarify how menus are hidden by SUBDRV_AUTOSELECT
      media: rockchip/rga: Update maintainership

Geert Uytterhoeven (1):
      media: Fix various misspellings of disconnected

Hans Verkuil (4):
      vidioc-queryctrl.rst: fix broken c:type references
      radio/si470x: kill urb on error
      hdpvr: add terminating 0 at end of string
      gspca: zero usb_buf on error

Hugues Fruchet (4):
      media: stm32-dcmi: improve sensor subdev naming
      media: stm32-dcmi: trace the supported fourcc/mbus_code
      media: stm32-dcmi: add media controller support
      media: stm32-dcmi: add support of several sub-devices

 Documentation/media/uapi/v4l/vidioc-queryctrl.rst |   4 +-
 MAINTAINERS                                       |   3 +-
 drivers/media/Kconfig                             |   5 +
 drivers/media/dvb-frontends/Kconfig               |   5 +-
 drivers/media/i2c/Kconfig                         |   5 +-
 drivers/media/platform/Kconfig                    |   2 +-
 drivers/media/platform/stm32/stm32-dcmi.c         | 317 ++++++++++++++++++++++++++++++++++++++++++--------
 drivers/media/radio/si470x/radio-si470x-usb.c     |   5 +-
 drivers/media/spi/Kconfig                         |   5 +-
 drivers/media/tuners/Kconfig                      |   6 +-
 drivers/media/usb/cx231xx/cx231xx-cards.c         |   4 +-
 drivers/media/usb/cx231xx/cx231xx-core.c          |   2 +-
 drivers/media/usb/cx231xx/cx231xx-video.c         |   2 +-
 drivers/media/usb/em28xx/em28xx-video.c           |   2 +-
 drivers/media/usb/em28xx/em28xx.h                 |   2 +-
 drivers/media/usb/gspca/konica.c                  |   5 +
 drivers/media/usb/gspca/nw80x.c                   |   5 +
 drivers/media/usb/gspca/ov519.c                   |  10 ++
 drivers/media/usb/gspca/ov534.c                   |   5 +
 drivers/media/usb/gspca/ov534_9.c                 |   1 +
 drivers/media/usb/gspca/se401.c                   |   5 +
 drivers/media/usb/gspca/sn9c20x.c                 |   5 +
 drivers/media/usb/gspca/sonixb.c                  |   5 +
 drivers/media/usb/gspca/sonixj.c                  |   5 +
 drivers/media/usb/gspca/spca1528.c                |   5 +
 drivers/media/usb/gspca/sq930x.c                  |   5 +
 drivers/media/usb/gspca/sunplus.c                 |   5 +
 drivers/media/usb/gspca/vc032x.c                  |   5 +
 drivers/media/usb/gspca/w996Xcf.c                 |   5 +
 drivers/media/usb/hdpvr/hdpvr-core.c              |   1 +
 drivers/media/usb/tm6000/tm6000-cards.c           |   2 +-
 31 files changed, 376 insertions(+), 67 deletions(-)
