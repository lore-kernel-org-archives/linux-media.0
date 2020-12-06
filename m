Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01042C433FE
	for <linux-media@archiver.kernel.org>; Sun,  6 Dec 2020 23:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB239208E4
	for <linux-media@archiver.kernel.org>; Sun,  6 Dec 2020 23:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgLFX5k (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 6 Dec 2020 18:57:40 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:60444 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbgLFX5k (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sun, 6 Dec 2020 18:57:40 -0500
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F29E41895;
        Mon,  7 Dec 2020 00:54:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1607298848;
        bh=6p6bHzeFwKIVdDFMLZpNXKtMULAyn2veORJvtdVE5pY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FUyeVxErcUbzCC686YtMz3619FKItW/nanLodKJLlgY3ZRwdWchubu+D/Jst4YM/F
         9OjgNMJl7utl/jID8/UtRw+zR2IeuJ5z1vexCDva8xjVz5F5P/NX7h6hLxzCcfE75v
         yjPdbzd7gVUxWJ4ADs+zGlUr5AESN8pWJqPy2Y6I=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Benoit Parrot <bparrot@ti.com>
Subject: [PATCH v3 18/24] media: ti-vpe: cal: Remove DMA queue empty check at start streaming time
Date:   Mon,  7 Dec 2020 01:53:47 +0200
Message-Id: <20201206235353.26968-19-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201206235353.26968-1-laurent.pinchart@ideasonboard.com>
References: <20201206235353.26968-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index ad1e85189831..bfc3ba4a96af 100644
--- a/drivers/media/platform/ti-vpe/cal-video.c
+++ b/drivers/media/platform/ti-vpe/cal-video.c
@@ -511,12 +511,6 @@ static int cal_start_streaming(struct vb2_queue *vq, unsigned int count)
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

