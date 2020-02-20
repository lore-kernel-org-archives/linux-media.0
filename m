Return-Path: <SRS0=i8LN=4I=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A9CC11D0C
	for <linux-media@archiver.kernel.org>; Thu, 20 Feb 2020 18:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE162467D
	for <linux-media@archiver.kernel.org>; Thu, 20 Feb 2020 18:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgBTS4Q (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:56:16 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49750 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgBTS4Q (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 20 Feb 2020 13:56:16 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id 3291729257A
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     dafna.hirschfeld@collabora.com, helen.koike@collabora.com,
        ezequiel@collabora.com, hverkuil@xs4all.nl, kernel@collabora.com,
        dafna3@gmail.com, sakari.ailus@linux.intel.com,
        linux-rockchip@lists.infradead.org, mchehab@kernel.org
Subject: [PATCH] media: staging: rkisp1: capture: remove support to userptr memory
Date:   Thu, 20 Feb 2020 19:56:03 +0100
Message-Id: <20200220185603.26968-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The dma_contig memory operations which is used by the capture
should not support userptr. Therefore remove it.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/staging/media/rkisp1/rkisp1-capture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/rkisp1/rkisp1-capture.c b/drivers/staging/media/rkisp1/rkisp1-capture.c
index 5f97af5cd95f..a006cd03228d 100644
--- a/drivers/staging/media/rkisp1/rkisp1-capture.c
+++ b/drivers/staging/media/rkisp1/rkisp1-capture.c
@@ -1349,7 +1349,7 @@ static int rkisp1_register_capture(struct rkisp1_capture *cap)
 
 	q = &node->buf_queue;
 	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
-	q->io_modes = VB2_MMAP | VB2_DMABUF | VB2_USERPTR;
+	q->io_modes = VB2_MMAP | VB2_DMABUF;
 	q->drv_priv = cap;
 	q->ops = &rkisp1_vb2_ops;
 	q->mem_ops = &vb2_dma_contig_memops;
-- 
2.17.1

