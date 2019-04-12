Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1284C10F0E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 12:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADEB2186A
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 12:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfDLMHs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:07:48 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:33381 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727853AbfDLMHr (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 08:07:47 -0400
Received: from [IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68] ([IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68])
        by smtp-cloud7.xs4all.net with ESMTPA
        id Euy9h0pqoNG8zEuyAhCkar; Fri, 12 Apr 2019 14:07:46 +0200
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.2] cedrus: add H.264 support
Message-ID: <5356eed6-6bf0-49ab-32e1-7e632c3e4328@xs4all.nl>
Date:   Fri, 12 Apr 2019 14:07:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHUSggTkyhZfGWnxsLBxlON6JcUm2uDwi9YsuHe40u2cT4aErTTVK/F/oVadvI3RWwMKhOtpTA7KvhCo++/uQ6V7Zq4h5WBdZYGG8nfA88L76vin8UwY
 AwP8IP5xRB9O84cuLCLsliO4OoVBSIqkcHLeuftJ5/LKW/u7jkWJALl6OVkzdq8MegNy39CeHWmjPITwD0zzC/uJ6uJxCgB+tZiOKZBPXxnNLk97AWHjtrBk
 v2JxARt4jM6SJYRXG51uJEGjMfxD1NvifTFpbt7LnJ9TsN/8HKa1SZFclDSTf4renFEDVTBhZ59J1fkg3WC0uSgxppo/xVyajgkT6oc+tjjzhQc8aDF1R3H3
 tgHQJ4tF
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The following changes since commit 1c3ec30bb23023d738b538e64ac3028902d53692:

  media: index.rst: exclude Indexes section from latex/pdf output (2019-03-30 09:42:35 -0400)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-cedrus-h264

for you to fetch changes up to 496ab402ea2cb3b0ebba3d0e699e0454b611c820:

  media: cedrus: Add H264 decoding support (2019-04-12 13:32:21 +0200)

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
 Documentation/media/uapi/v4l/ext-ctrls-codec.rst   | 569 +++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/media/uapi/v4l/pixfmt-compressed.rst |  25 +++
 Documentation/media/uapi/v4l/vidioc-queryctrl.rst  |  30 +++
 Documentation/media/videodev2.h.rst.exceptions     |   5 +
 drivers/media/v4l2-core/v4l2-ctrls.c               |  42 ++++
 drivers/media/v4l2-core/v4l2-ioctl.c               |   1 +
 drivers/staging/media/sunxi/cedrus/Makefile        |   3 +-
 drivers/staging/media/sunxi/cedrus/cedrus.c        |  31 +++
 drivers/staging/media/sunxi/cedrus/cedrus.h        |  38 +++-
 drivers/staging/media/sunxi/cedrus/cedrus_dec.c    |  13 ++
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c   | 574 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c     |   4 +
 drivers/staging/media/sunxi/cedrus/cedrus_regs.h   |  91 +++++++++
 drivers/staging/media/sunxi/cedrus/cedrus_video.c  |   9 +
 include/media/h264-ctrls.h                         | 197 ++++++++++++++++++
 include/media/v4l2-ctrls.h                         |  13 +-
 17 files changed, 1651 insertions(+), 3 deletions(-)
 create mode 100644 drivers/staging/media/sunxi/cedrus/cedrus_h264.c
 create mode 100644 include/media/h264-ctrls.h
