Return-Path: <SRS0=EymB=74=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843B5C433DF
	for <linux-media@archiver.kernel.org>; Mon, 15 Jun 2020 00:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EDE020747
	for <linux-media@archiver.kernel.org>; Mon, 15 Jun 2020 00:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dQ7BrAwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbgFOAA6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 14 Jun 2020 20:00:58 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33330 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbgFOAA5 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 14 Jun 2020 20:00:57 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C45CD1226;
        Mon, 15 Jun 2020 02:00:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1592179228;
        bh=IjMV1GzEJNzo+TvxQbg/rVOpGtEomXq94dH326EqaZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dQ7BrAwjIZmyKDxWKgcvAcgPizs25FpoJvFKNK1pi2CIcZF6N+ZmEqgt/KlZz98th
         roXbEMaLRZKGt1cYcCtRBribiwDI+pCb3Nkpg0beM+ydkEVp5+fpmZVWpParImQnhZ
         O2TOY/iOveSjJcuzHWPLCh07KKb5i2qrlemiYq3g=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Benoit Parrot <bparrot@ti.com>
Subject: [PATCH v1 039/107] media: ti-vpe: cal: Get struct device without going through v4l2_device
Date:   Mon, 15 Jun 2020 02:58:36 +0300
Message-Id: <20200614235944.17716-40-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200614235944.17716-1-laurent.pinchart@ideasonboard.com>
References: <20200614235944.17716-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Instead of retrieving the struct device for the platform device from the
v4l2_device, get it from the platform device directly. This prepares for
cleanups related to v4l2_device handling.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/ti-vpe/cal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index fdc8248ef44a..10baca7cfcee 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -1862,7 +1862,7 @@ static int cal_complete_ctx(struct cal_ctx *ctx)
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	q->lock = &ctx->mutex;
 	q->min_buffers_needed = 3;
-	q->dev = ctx->v4l2_dev.dev;
+	q->dev = &ctx->cal->pdev->dev;
 
 	ret = vb2_queue_init(q);
 	if (ret)
-- 
Regards,

Laurent Pinchart

