Return-Path: <SRS0=djxu=SF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EF1C4360F
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 07:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE12F2084C
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 07:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfDCHcW (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:32:22 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:58998 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbfDCHcW (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 3 Apr 2019 03:32:22 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud7.xs4all.net with ESMTPA
        id BaNbhpWXRNG8zBaNfhO6ii; Wed, 03 Apr 2019 09:32:19 +0200
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.2] Media Device Allocator API
Message-ID: <30de419f-5dac-71a1-9255-d334d6025a0d@xs4all.nl>
Date:   Wed, 3 Apr 2019 09:32:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOV4/Z9kEsFYYIEAC7nOZxHQP3tqzxaiPJ2n0iojSW+lAM4h8iGDoT68vJIoEipfE07h645D8ZCKEGc9ZMmuJJN1fRguwCbYDbBLKD8xGgYr+XGuu3D/
 jORiNWQDJ+4FYFfPvz9r2ElMNTh3C3+i6z6uA6SVWMizOLABg4VSB/dJV03wrSGzE1cHVtywsL2kC0wFI4eoD4UF+mUMnj0spcB+l78Ngg+dXmIvd/PXO8ee
 QATOJS/Fcs6mMGT+xM7zSMFE2ztCSTyeuNWQB6I/uhg=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

After five (!) years of work, this is finally ready to go in.

Thank you Shuah for your perseverance!

Regards,

	Hans

The following changes since commit 1c3ec30bb23023d738b538e64ac3028902d53692:

  media: index.rst: exclude Indexes section from latex/pdf output (2019-03-30 09:42:35 -0400)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.2c3

for you to fetch changes up to 5ea25de43fd59a319136cf5b2e547ca315cfb212:

  au0828: stop video streaming only when last user stops (2019-04-03 09:01:15 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Hans Verkuil (1):
      au0828: stop video streaming only when last user stops

Shuah Khan (8):
      media: Media Device Allocator API
      media: change au0828 to use Media Device Allocator API
      media: media.h: Enable ALSA MEDIA_INTF_T* interface types
      sound/usb: Use Media Controller API to share media resources
      au0828: fix enable and disable source audio and video inconsistencies
      selftests: media_dev_allocator api test
      au0828: Fix NULL pointer dereference in au0828_analog_stream_enable()
      media: Clear devnode->media_dev holding media_devnode_lock

 Documentation/media/kapi/mc-core.rst                       |  41 ++++++
 drivers/media/Makefile                                     |   6 +
 drivers/media/media-dev-allocator.c                        | 135 +++++++++++++++++
 drivers/media/media-devnode.c                              |   3 +-
 drivers/media/usb/au0828/Kconfig                           |   2 +
 drivers/media/usb/au0828/au0828-core.c                     | 196 ++++++++++++++++++------
 drivers/media/usb/au0828/au0828-video.c                    |  16 +-
 drivers/media/usb/au0828/au0828.h                          |   6 +-
 include/media/media-dev-allocator.h                        |  63 ++++++++
 include/uapi/linux/media.h                                 |  25 ++--
 sound/usb/Kconfig                                          |   4 +
 sound/usb/Makefile                                         |   2 +
 sound/usb/card.c                                           |  14 ++
 sound/usb/card.h                                           |   3 +
 sound/usb/media.c                                          | 327 +++++++++++++++++++++++++++++++++++++++++
 sound/usb/media.h                                          |  74 ++++++++++
 sound/usb/mixer.h                                          |   3 +
 sound/usb/pcm.c                                            |  29 +++-
 sound/usb/quirks-table.h                                   |   1 +
 sound/usb/stream.c                                         |   2 +
 sound/usb/usbaudio.h                                       |   6 +
 tools/testing/selftests/media_tests/media_dev_allocator.sh |  85 +++++++++++
 22 files changed, 976 insertions(+), 67 deletions(-)
 create mode 100644 drivers/media/media-dev-allocator.c
 create mode 100644 include/media/media-dev-allocator.h
 create mode 100644 sound/usb/media.c
 create mode 100644 sound/usb/media.h
 create mode 100755 tools/testing/selftests/media_tests/media_dev_allocator.sh
