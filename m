Return-Path: <SRS0=19ZY=S3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DDFC10F03
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 12:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DD1205F4
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 12:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfDYMuN (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:50:13 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:36817 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727579AbfDYMuN (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Apr 2019 08:50:13 -0400
Received: from [IPv6:2001:420:44c1:2579:1962:5a24:e79b:27e1] ([IPv6:2001:420:44c1:2579:1962:5a24:e79b:27e1])
        by smtp-cloud9.xs4all.net with ESMTPA
        id JdpHhGeBQNExlJdpKhUXiL; Thu, 25 Apr 2019 14:50:11 +0200
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.2] rockchip fixes
Message-ID: <ae426ec5-e84f-2cd9-cd02-72d855bf8b08@xs4all.nl>
Date:   Thu, 25 Apr 2019 14:50:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfH+DniKehKx+h5Wl+wKNHhjps8Iyay1tUEeOWMzAcw9DzBcHLYih/gzw9Bsa4LX5gFq5YmL3/mT5F1vn8kFAswhSN3HkOTS1GHNf5QrCALR6NUf+7d9d
 VvwmbKRrpDtJInyIX5CgQuB1mUYsmjUtxwCozblzTZgAmcchfbPlnnhudXgPqjmD5qH/92MWQDHN9eeHLzJDmpH4BQMDiFWsihtqjDGU5vPFSGZkKc5gD7zP
 yXJOcUX3ml4Jcf8Dvs+SaWYW2kbSIcWVGl7ma1VCl6wG2YhfhOgQohWEsOC+6SjpvGqdifzEYSeVA9/kDj34Y8DPaGA9/fqqfvJ5fSATfgQ=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This pull request contains patches 1-10 of the "[PATCH v4 00/21] Add MPEG-2
decoding to Rockchip VPU" series.

These are all fixes and are independent of the mpeg-2 support.

Regards,

	Hans

The following changes since commit a4dfc8a24796ff312d1d307e11f26f8ca466e938:

  media: MAINTAINERS: Update AO CEC with ao-cec-g12a driver (2019-04-22 13:16:35 -0400)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.2j

for you to fetch changes up to 7634fd32f5d0e78e6e386f93cb35013b85b0b070:

  rockchip/vpu: Fix/re-order probe-error/remove path (2019-04-25 14:39:40 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Boris Brezillon (3):
      rockchip/vpu: Remove a useless test
      rockchip/vpu: Get vdev from the file arg in vidioc_querycap()
      rockchip/vpu: Initialize mdev->bus_info

Ezequiel Garcia (4):
      rockchip/vpu: Use pixel format helpers
      rockchip/vpu: Use v4l2_m2m_buf_copy_metadata
      rockchip/vpu: Cleanup macroblock alignment
      rockchip/vpu: Cleanup JPEG bounce buffer management

Jonas Karlman (3):
      rockchip/vpu: Do not request id 0 for our video device
      rockchip/vpu: Add missing dont_use_autosuspend() calls
      rockchip/vpu: Fix/re-order probe-error/remove path

 drivers/staging/media/rockchip/vpu/rk3288_vpu_hw.c          |   2 ++
 drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c |   4 +--
 drivers/staging/media/rockchip/vpu/rk3399_vpu_hw.c          |   2 ++
 drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c |   4 +--
 drivers/staging/media/rockchip/vpu/rockchip_vpu.h           |  12 +++----
 drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c       |  38 +++++++++++-----------
 drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c       | 137 +++++++++++-------------------------------------------------------------------
 drivers/staging/media/rockchip/vpu/rockchip_vpu_hw.h        |  28 ++++++++++++++++
 drivers/staging/media/rockchip/vpu/rockchip_vpu_jpeg.c      |  29 +++++++++++++++++
 9 files changed, 109 insertions(+), 147 deletions(-)
