Return-Path: <SRS0=rHfj=S2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156FEC10F11
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 15:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F0320878
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 15:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbfDXPJC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:09:02 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:33669 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730163AbfDXPJC (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 24 Apr 2019 11:09:02 -0400
Received: from [IPv6:2001:420:44c1:2579:8575:c0e0:a08:6676] ([IPv6:2001:420:44c1:2579:8575:c0e0:a08:6676])
        by smtp-cloud9.xs4all.net with ESMTPA
        id JJW4hAntkNExlJJW8hRar3; Wed, 24 Apr 2019 17:09:00 +0200
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.2] cedrus: add H.264 support
Message-ID: <58cf0c7b-9b2f-3311-c14b-ada98d570e90@xs4all.nl>
Date:   Wed, 24 Apr 2019 17:08:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKK+F/sWy8+p/u5ry07WpSNayfwwabcq9lEd/oP/1GvUbTSRvzhdEAqhQwNzLpBPXX+HJRfQOAMNeCjj6t7RcH/9G4PrlItPk+lt2mUuxAt0MrYLnZX8
 S+6vR0o2jTICIJ0jfu2K43NeiI0ggKzFqLW+TkRSE/67irjK1MmTMD3ySZq7bIMDegJdcAlOm86HPxycLBJwnQtB8iQbWG+8RkhaxNq/qvqLIQBIy0sKRfv5
 r0HZYSvJUGFfsXYQNJC6oMVT0AEFEZZ3c/W48top2paqh46wE6jiKwomPwTQZUaZlhuzgcRmgr7Rvhc9yeaMdwn2gfP/svcgw0/qLzpRyUc7p1VrBbl+grzn
 LZWDKFexj+4JnaCu/ytL+Uu3AO8nrw==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Changes since the previous pull request: rebased and some sparse warnings fixed.

Regards,

	Hans

The following changes since commit a4dfc8a24796ff312d1d307e11f26f8ca466e938:

  media: MAINTAINERS: Update AO CEC with ao-cec-g12a driver (2019-04-22 13:16:35 -0400)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-cedrus-h264b

for you to fetch changes up to 5fd433dbb1bc5ca18ae2913b7e9fbdba2631ca8d:

  media: cedrus: Add H264 decoding support (2019-04-24 16:50:45 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Maxime Ripard (3):
      media: pixfmt: Add H264 Slice format
      media: pixfmt: Add H264_SLICE_RAW format documentation
      media: cedrus: Add H264 decoding support

Pawel Osciak (1):
      media: uapi: Add H264 low-level decoder API compound controls.

 Documentation/media/uapi/v4l/biblio.rst            |   9 +
 Documentation/media/uapi/v4l/ext-ctrls-codec.rst   | 569 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/media/uapi/v4l/pixfmt-compressed.rst |  25 +++
 Documentation/media/uapi/v4l/vidioc-queryctrl.rst  |  30 +++
 Documentation/media/videodev2.h.rst.exceptions     |   5 +
 drivers/media/v4l2-core/v4l2-ctrls.c               |  42 +++++
 drivers/media/v4l2-core/v4l2-ioctl.c               |   1 +
 drivers/staging/media/sunxi/cedrus/Makefile        |   3 +-
 drivers/staging/media/sunxi/cedrus/cedrus.c        |  31 ++++
 drivers/staging/media/sunxi/cedrus/cedrus.h        |  38 +++-
 drivers/staging/media/sunxi/cedrus/cedrus_dec.c    |  13 ++
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c   | 576 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c     |   4 +
 drivers/staging/media/sunxi/cedrus/cedrus_regs.h   |  91 +++++++++
 drivers/staging/media/sunxi/cedrus/cedrus_video.c  |   9 +
 include/media/h264-ctrls.h                         | 197 ++++++++++++++++++++
 include/media/v4l2-ctrls.h                         |  13 +-
 17 files changed, 1653 insertions(+), 3 deletions(-)
 create mode 100644 drivers/staging/media/sunxi/cedrus/cedrus_h264.c
 create mode 100644 include/media/h264-ctrls.h
