Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FFEC10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 12:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF83217F4
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 12:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731866AbfDJM0W (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:26:22 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:44234 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731865AbfDJM0V (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 08:26:21 -0400
Received: from [IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f] ([IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f])
        by smtp-cloud7.xs4all.net with ESMTPA
        id ECJ0hkZvrNG8zECJ1h0oUo; Wed, 10 Apr 2019 14:26:20 +0200
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.2] Various fixes
Message-ID: <f951ef37-5729-8d14-7f63-4748a410ebb1@xs4all.nl>
Date:   Wed, 10 Apr 2019 14:26:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfG3iNu+laD7CPFLqUp0F2TuOZQsvKULZghewPLT5NYf55LV3Y5PavgBbASKXGYfN2195Yn1rwPqzu4JLVyDW4R258t/tsV1GnxC2lCvR9+l186D2ATzK
 jGWDeLR1t+e5VB9McfNmFktH5GeWHP1gx+x4xAnmEBRWEO5sKVurtlQobTLtlz0qQrdW1mWOCyfdxNF5iZDxfbpjIR1+TXxjnHMWiWknPBfL30ZJYyqn628I
 ZH8hjDjyIzopPSE//+O4HLGIv+0T6M8fZwBKfGpAs14=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The following changes since commit 1c3ec30bb23023d738b538e64ac3028902d53692:

  media: index.rst: exclude Indexes section from latex/pdf output (2019-03-30 09:42:35 -0400)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.2d2

for you to fetch changes up to 94448dbf89f7c05bd1ff7d9990491065f8aeb976:

  vb2: add waiting_in_dqbuf flag (2019-04-10 12:51:16 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Alexander Potapenko (1):
      media: vivid: use vfree() instead of kfree() for dev->bitmap_cap

Dan Carpenter (1):
      media: pvrusb2: Prevent a buffer overflow

Hans Verkuil (2):
      videobuf2-v4l2.c: move up STATE_DEQUEUED check
      vb2: add waiting_in_dqbuf flag

Jernej Skrabec (1):
      media: cedrus: Fix initialization order

Maoguang Meng (1):
      media: mtk-vcodec: fix vp9 content playback error with show exist frame

 drivers/media/common/videobuf2/videobuf2-core.c      | 22 ++++++++++++++++++++++
 drivers/media/common/videobuf2/videobuf2-v4l2.c      | 11 ++++++-----
 drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c | 16 +++++++---------
 drivers/media/platform/vivid/vivid-vid-cap.c         |  2 +-
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c              |  2 ++
 drivers/media/usb/pvrusb2/pvrusb2-hdw.h              |  1 +
 drivers/staging/media/sunxi/cedrus/cedrus.c          | 24 ++++++++++++------------
 include/media/videobuf2-core.h                       |  1 +
 8 files changed, 52 insertions(+), 27 deletions(-)
