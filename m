Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFD6C56201
	for <linux-media@archiver.kernel.org>; Thu, 12 Nov 2020 11:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 527D82223F
	for <linux-media@archiver.kernel.org>; Thu, 12 Nov 2020 11:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgKLL5e (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 12 Nov 2020 06:57:34 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60924 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgKLL51 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 12 Nov 2020 06:57:27 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id D20BB1F462E9
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 0/5] Stateless H.264 de-staging
Date:   Thu, 12 Nov 2020 08:57:09 -0300
Message-Id: <20201112115714.48081-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Now that H.264 stateless controls are solid, we can get it
out of staging.

Following some guidelines from Hans, this series creates a
new stateless control class for the stable codec controls to land.

This is compile-tested for now, and I'm sending it just to
check if the approach looks good, or otherwise get feedback.

I'll be porting GStreamer v4l2codecs to the new interface
and running some tests soon.

As far as I'm aware, Ffmpeg/libavcodec support is ready and
waiting for stable uAPIs, so we can expect that to be added
shortly after we land this.

Thanks,
Ezequiel

Ezequiel Garcia (4):
  media: cedrus: h264: Support profile control
  media: Rename stateful codec control macros
  media: Clean stateless control includes
  media: uapi: move H264 stateless controls out of staging

Jonas Karlman (1):
  media: rkvdec: h264: Support profile and level controls

 .../userspace-api/media/v4l/common.rst        |   1 +
 .../userspace-api/media/v4l/dev-mem2mem.rst   |   2 +-
 .../media/v4l/ext-ctrls-codec-stateless.rst   | 674 ++++++++++++++++
 .../media/v4l/ext-ctrls-codec.rst             | 696 +----------------
 .../media/v4l/extended-controls.rst           |   8 +-
 .../media/v4l/pixfmt-compressed.rst           |  14 +-
 .../media/v4l/vidioc-g-ext-ctrls.rst          |   6 +-
 drivers/media/common/cx2341x.c                |   4 +-
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c  |   2 +-
 drivers/media/platform/s5p-mfc/s5p_mfc_enc.c  |   2 +-
 drivers/media/v4l2-core/v4l2-ctrls.c          |  40 +-
 drivers/staging/media/hantro/hantro_drv.c     |  26 +-
 drivers/staging/media/hantro/hantro_h264.c    |   8 +-
 drivers/staging/media/hantro/hantro_hw.h      |   4 +-
 drivers/staging/media/rkvdec/rkvdec-h264.c    |   8 +-
 drivers/staging/media/rkvdec/rkvdec.c         |  39 +-
 drivers/staging/media/sunxi/cedrus/cedrus.c   |  36 +-
 .../staging/media/sunxi/cedrus/cedrus_dec.c   |  12 +-
 include/media/fwht-ctrls.h                    |   2 +-
 include/media/h264-ctrls.h                    | 406 ----------
 include/media/hevc-ctrls.h                    |  10 +-
 include/media/mpeg2-ctrls.h                   |   4 +-
 include/media/v4l2-ctrls.h                    |   1 -
 include/media/v4l2-h264.h                     |   2 +-
 include/media/vp8-ctrls.h                     |   2 +-
 include/uapi/linux/v4l2-controls.h            | 731 +++++++++++++-----
 include/uapi/linux/videodev2.h                |   8 +
 27 files changed, 1368 insertions(+), 1380 deletions(-)
 create mode 100644 Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
 delete mode 100644 include/media/h264-ctrls.h

-- 
2.27.0

