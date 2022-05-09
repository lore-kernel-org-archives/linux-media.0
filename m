Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D2DC43217
	for <linux-media@archiver.kernel.org>; Mon,  9 May 2022 09:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiEIJvj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 9 May 2022 05:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237099AbiEIJUe (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 9 May 2022 05:20:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D3F14915A
        for <linux-media@vger.kernel.org>; Mon,  9 May 2022 02:16:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40A0FB80D3A
        for <linux-media@vger.kernel.org>; Mon,  9 May 2022 09:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DE7C385AB;
        Mon,  9 May 2022 09:15:55 +0000 (UTC)
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH 0/7] Various smatch fixes
Date:   Mon,  9 May 2022 11:15:46 +0200
Message-Id: <20220509091553.2637089-1-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The daily build produces a number of smatch warnings.

This series fixes those warnings.

Regards,

	Hans

Hans Verkuil (7):
  v4l2-subdev.c: kvmalloc_array -> kvcalloc
  v4l2-ctls-core.c: kvmalloc_array -> kvcalloc
  videobuf2-dma-sg.c: kvmalloc_array -> kvcalloc
  cx25821: request_irq -> devm_request_irq
  ccs-core.c: fix failure to call clk_disable_unprepare
  s5k6a3: add missing clk_disable_unprepare
  uvc_v4l2.c: avoid using iterator used outside loop

 drivers/media/common/videobuf2/videobuf2-dma-sg.c |  3 +--
 drivers/media/i2c/ccs/ccs-core.c                  |  7 +++++--
 drivers/media/i2c/s5k6a3.c                        |  4 +++-
 drivers/media/pci/cx25821/cx25821-alsa.c          |  4 ++--
 drivers/media/usb/uvc/uvc_v4l2.c                  | 13 +++++++++----
 drivers/media/v4l2-core/v4l2-ctrls-core.c         |  5 ++---
 drivers/media/v4l2-core/v4l2-subdev.c             |  5 ++---
 7 files changed, 24 insertions(+), 17 deletions(-)

-- 
2.34.1

