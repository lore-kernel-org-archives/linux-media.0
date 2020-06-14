Return-Path: <SRS0=EymB=74=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879A9C433E1
	for <linux-media@archiver.kernel.org>; Mon, 15 Jun 2020 00:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 684F320768
	for <linux-media@archiver.kernel.org>; Mon, 15 Jun 2020 00:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aJJdnp5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgFOACM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 14 Jun 2020 20:02:12 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33330 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgFOACM (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 14 Jun 2020 20:02:12 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 756A72177;
        Mon, 15 Jun 2020 02:00:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1592179259;
        bh=673avfbG4inNOKyZaO3o+5Q0cohR8zNYatasjGUVqHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJJdnp5aWfztmNkjEMcc9KIr0jBmh8seQaqd4dc9qPTzlMGN+zVWg/S/WNq0CyAn3
         Sa94x3Cw63r0t9XS0NxIdgNEHibAH5oYQiwQc9tRCmbcnbJ3tsykmV9GRijaCzUgu0
         dUI3zTB5SzRyPAVyzmXcg5sUQA5kC8NoF9NP9Iw8=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Benoit Parrot <bparrot@ti.com>
Subject: [PATCH v1 101/107] media: ti-vpe: cal: Remove DMA queue empty check at start streaming time
Date:   Mon, 15 Jun 2020 02:59:38 +0300
Message-Id: <20200614235944.17716-102-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200614235944.17716-1-laurent.pinchart@ideasonboard.com>
References: <20200614235944.17716-1-laurent.pinchart@ideasonboard.com>
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

