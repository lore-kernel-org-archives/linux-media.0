Return-Path: <SRS0=iZD8=AR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53090C433DF
	for <linux-media@archiver.kernel.org>; Mon,  6 Jul 2020 18:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36BF3207BB
	for <linux-media@archiver.kernel.org>; Mon,  6 Jul 2020 18:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="v7sin85r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbgGFSjQ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:39:16 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45198 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730040AbgGFSjP (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 6 Jul 2020 14:39:15 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CC80E25D3;
        Mon,  6 Jul 2020 20:38:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594060714;
        bh=fOIJ4Ff6gMAfOdhq5J67E4+fsb5Ps19k26BSCyjUdm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v7sin85ryvV+Nv7+UZgCYi0NDZkTC5Zxaqf4q5B1u2O8InmxiYcweIPRlx7iGkrwa
         Td0H1wbdJe1E+PNR9bzwBDZN/VnMuR3/Z2QfB3z7U8s9b9XKDjMo9UTwq3W8bny2fU
         ghOvZASc5jQwHXncOei73D/jDI+NS6xlAfFNCTsQ=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Benoit Parrot <bparrot@ti.com>
Subject: [PATCH v2 102/108] media: ti-vpe: cal: Remove DMA queue empty check at start streaming time
Date:   Mon,  6 Jul 2020 21:37:03 +0300
Message-Id: <20200706183709.12238-103-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200706183709.12238-1-laurent.pinchart@ideasonboard.com>
References: <20200706183709.12238-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The vb2 queue ensures that the start streaming operation will only be
called with a minimal number of buffers queued to the driver. There's
thus no need to manually check if the DMA queue is empty. Remove the
check.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/media/platform/ti-vpe/cal-video.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal-video.c b/drivers/media/platform/ti-vpe/cal-video.c
index 6d6ea02bf0b2..d10c8c16abd3 100644
--- a/drivers/media/platform/ti-vpe/cal-video.c
+++ b/drivers/media/platform/ti-vpe/cal-video.c
@@ -512,12 +512,6 @@ static int cal_start_streaming(struct vb2_queue *vq, unsigned int count)
 	int ret;
 
 	spin_lock_irq(&ctx->slock);
-	if (list_empty(&dma_q->active)) {
-		spin_unlock_irq(&ctx->slock);
-		ctx_dbg(3, ctx, "buffer queue is empty\n");
-		return -EIO;
-	}
-
 	buf = list_entry(dma_q->active.next, struct cal_buffer, list);
 	ctx->cur_frm = buf;
 	ctx->next_frm = buf;
-- 
Regards,

Laurent Pinchart

