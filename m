Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B1EC4743C
	for <linux-media@archiver.kernel.org>; Mon, 14 Jun 2021 11:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7149161185
	for <linux-media@archiver.kernel.org>; Mon, 14 Jun 2021 11:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbhFNLpU (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 14 Jun 2021 07:45:20 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58306 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbhFNLnA (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 14 Jun 2021 07:43:00 -0400
Received: from deskari.lan (91-158-153-130.elisa-laajakaista.fi [91.158.153.130])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 99F055EBD;
        Mon, 14 Jun 2021 13:24:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1623669855;
        bh=ZyDKJbUYIT7yKuRpPQZHChapZwTvI3GG5M1BFZwl8sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CffR4STJ3ITxCjIK3UYiGPzqje5Zztu4g0GGnZ0MotwRpqz6ClxRfZwGgm6/PKllh
         +yKWAVuFULdoWezesw/CSjHRMRm55QAf9c5Af/8CLneyhkXJcIz0NtfpLLYOzhGj1U
         ZQ+pYlz25W3MLchzaw2Ui8bJHKoYzh8s8o+vj7fI=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     linux-media@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v4 31/35] media: ti-vpe: cal: fix queuing of the initial buffer
Date:   Mon, 14 Jun 2021 14:23:41 +0300
Message-Id: <20210614112345.2032435-32-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614112345.2032435-1-tomi.valkeinen@ideasonboard.com>
References: <20210614112345.2032435-1-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

When starting streaming the driver currently programs the buffer
address to the CAL base-address register and assigns the buffer pointer
to ctx->dma.pending. This is not correct, as the buffer is not
"pending", but active, and causes the first buffer to be needlessly
written twice.

Fix this by assigning the buffer pointer to ctx->dma.active.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/ti-vpe/cal-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti-vpe/cal-video.c b/drivers/media/platform/ti-vpe/cal-video.c
index b53191425cc4..6364ccb45073 100644
--- a/drivers/media/platform/ti-vpe/cal-video.c
+++ b/drivers/media/platform/ti-vpe/cal-video.c
@@ -731,7 +731,7 @@ static int cal_start_streaming(struct vb2_queue *vq, unsigned int count)
 
 	spin_lock_irq(&ctx->dma.lock);
 	buf = list_first_entry(&ctx->dma.queue, struct cal_buffer, list);
-	ctx->dma.pending = buf;
+	ctx->dma.active = buf;
 	list_del(&buf->list);
 	spin_unlock_irq(&ctx->dma.lock);
 
-- 
2.25.1

