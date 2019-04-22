Return-Path: <SRS0=+FiN=SY=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACE9C282E1
	for <linux-media@archiver.kernel.org>; Mon, 22 Apr 2019 08:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F54213A2
	for <linux-media@archiver.kernel.org>; Mon, 22 Apr 2019 08:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfDVIIY (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:08:24 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46396 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDVIIY (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 22 Apr 2019 04:08:24 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id AE16626070C;
        Mon, 22 Apr 2019 09:08:21 +0100 (BST)
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>, linux-media@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>, kernel@collabora.com,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v3 00/15] Add MPEG-2 decoding to Rockchip VPU
Date:   Mon, 22 Apr 2019 10:08:03 +0200
Message-Id: <20190422080818.29130-1-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This series introduces the decoding infrastructure that will be
used to add support for other codecs such as VP8, VP9 and H.264.

As explained in the cover letter for the v1 patchset,
the driver is now exposing two video device nodes.
The VPU encoder is exposed on /dev/video0, and the VPU decoder
is exposed on /dev/video1. Both devices are tied to the same
memory-to-memory queue, and same media device /dev/media0.

Therefore there are two media graphs:

┌────────────────────────────────┐
│ rockchip,rk3399-vpu-enc-source │
│          /dev/video0           │
└────────────────────────────────┘
  ┃
  ┃
  ▼
┌────────────────────────────────┐
│  rockchip,rk3399-vpu-enc-proc  │
└────────────────────────────────┘
  ┃
  ┃
  ▼
┌────────────────────────────────┐
│  rockchip,rk3399-vpu-enc-sink  │
│          /dev/video0           │
└────────────────────────────────┘

┌────────────────────────────────┐
│ rockchip,rk3399-vpu-dec-source │
│          /dev/video1           │
└────────────────────────────────┘
  ┃
  ┃
  ▼
┌────────────────────────────────┐
│  rockchip,rk3399-vpu-dec-proc  │
└────────────────────────────────┘
  ┃
  ┃
  ▼
┌────────────────────────────────┐
│  rockchip,rk3399-vpu-dec-sink  │
│          /dev/video1           │
└────────────────────────────────┘

Of course, this work has been possible thanks to Jonas Karlman, who did
the initial MPEG-2 decoding work and also got mpv+ffmpeg working using
the Request API.

Regards,

Boris

v3:
  * Share more code between the encoder/decoder logic (VB2/V4L2
    interface implementation)
  * Add a patch to support MPEG2 decoding on RK3288 (Jonas)
  * Several fixes/improvements all over the place (see changelog
    in each patch for more details)

v2:
  * Fixed some minor issues brought up by v4l2-compliance.
  * Fixed bytesused wrongly assigned 0 on the MPEG-2 decoder.
  * Addressed comments from Hans and Tomasz on the pixel format
    helpers.

Boris Brezillon (5):
  rockchip/vpu: Rename rockchip_vpu_common.h into rockchip_vpu_v4l2.h
  rockchip/vpu: Remove a useless test
  rockchip/vpu: Move encoder logic to a common place
  rockchip/vpu: Provide a helper to reset both src and dst formats
  rockchip/vpu: Prepare things to support decoders

Ezequiel Garcia (9):
  rockchip/vpu: Use pixel format helpers
  rockchip/vpu: Use v4l2_m2m_buf_copy_metadata
  rockchip/vpu: Cleanup macroblock alignment
  rockchip/vpu: Cleanup JPEG bounce buffer management
  rockchip/vpu: Open-code media controller register
  rockchip/vpu: Support the Request API
  rockchip/vpu: Add decoder boilerplate
  rockchip/vpu: Add support for non-standard controls
  rockchip/vpu: Add support for MPEG-2 decoding

Jonas Karlman (1):
  rockchip/vpu: Add support for MPEG-2 decoding on RK3288

 drivers/staging/media/rockchip/vpu/Makefile   |   7 +-
 .../media/rockchip/vpu/rk3288_vpu_hw.c        |  61 +-
 .../rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c     |   6 +-
 .../rockchip/vpu/rk3288_vpu_hw_mpeg2_dec.c    | 257 +++++++
 .../media/rockchip/vpu/rk3288_vpu_regs.h      |   1 +
 .../media/rockchip/vpu/rk3399_vpu_hw.c        |  61 +-
 .../rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c     |  12 +-
 .../rockchip/vpu/rk3399_vpu_hw_mpeg2_dec.c    | 273 +++++++
 .../staging/media/rockchip/vpu/rockchip_vpu.h | 115 ++-
 .../media/rockchip/vpu/rockchip_vpu_common.h  |  30 +-
 .../media/rockchip/vpu/rockchip_vpu_drv.c     | 456 ++++++++++--
 .../media/rockchip/vpu/rockchip_vpu_enc.c     | 670 ------------------
 .../media/rockchip/vpu/rockchip_vpu_hw.h      |  44 ++
 .../media/rockchip/vpu/rockchip_vpu_jpeg.c    |  29 +
 .../media/rockchip/vpu/rockchip_vpu_mpeg2.c   |  61 ++
 .../media/rockchip/vpu/rockchip_vpu_v4l2.c    | 668 +++++++++++++++++
 .../media/rockchip/vpu/rockchip_vpu_v4l2.h    |  26 +
 17 files changed, 2016 insertions(+), 761 deletions(-)
 create mode 100644 drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_mpeg2_dec.c
 create mode 100644 drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_mpeg2_dec.c
 delete mode 100644 drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c
 create mode 100644 drivers/staging/media/rockchip/vpu/rockchip_vpu_mpeg2.c
 create mode 100644 drivers/staging/media/rockchip/vpu/rockchip_vpu_v4l2.c
 create mode 100644 drivers/staging/media/rockchip/vpu/rockchip_vpu_v4l2.h

-- 
2.20.1

