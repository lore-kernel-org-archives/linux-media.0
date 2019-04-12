Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C079C282DA
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 15:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4AC2083E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 15:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfDLPvt (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:51:49 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42737 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfDLPvn (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 11:51:43 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hEySr-0000EY-9O; Fri, 12 Apr 2019 17:51:41 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     kernel@pengutronix.de
Subject: [PATCH 04/13] media: coda: improve decoder job finished debug message
Date:   Fri, 12 Apr 2019 17:51:26 +0200
Message-Id: <20190412155135.13907-4-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412155135.13907-1-p.zabel@pengutronix.de>
References: <20190412155135.13907-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Print a single line containing the following information:
 - which frame was decoded, including its type,
 - if no frame was decoded, the reason (code) why
 - which decoded frame was returned, copied out by either rotator or VODA,
 - if no frame was returned, the reason (code) why, and
 - the output queue sequence number, which is only useful in case
   each queued coded buffer corresponds to exactly one frame.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/platform/coda/coda-bit.c | 34 ++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/coda/coda-bit.c b/drivers/media/platform/coda/coda-bit.c
index a0dbee2262e9..228743b82ace 100644
--- a/drivers/media/platform/coda/coda-bit.c
+++ b/drivers/media/platform/coda/coda-bit.c
@@ -2246,12 +2246,36 @@ static void coda_finish_decode(struct coda_ctx *ctx)
 		else
 			coda_m2m_buf_done(ctx, dst_buf, VB2_BUF_STATE_DONE);
 
-		coda_dbg(1, ctx, "job finished: decoded %c frame (%u/%u)\n",
-			 coda_frame_type_char(dst_buf->flags),
-			 dst_buf->sequence, ctx->qsequence);
+		if (decoded_idx >= 0 &&
+		    decoded_idx < ctx->num_internal_frames) {
+			coda_dbg(1, ctx, "job finished: decoded %c frame %u, returned %c frame %u (%u/%u)%s\n",
+				 coda_frame_type_char(ctx->frame_types[decoded_idx]),
+				 ctx->frame_metas[decoded_idx].sequence,
+				 coda_frame_type_char(dst_buf->flags),
+				 ctx->frame_metas[ctx->display_idx].sequence,
+				 dst_buf->sequence, ctx->qsequence,
+				 (dst_buf->flags & V4L2_BUF_FLAG_LAST) ?
+				 " (last)" : "");
+		} else {
+			coda_dbg(1, ctx, "job finished: no frame decoded (%d), returned %c frame %u (%u/%u)%s\n",
+				 decoded_idx,
+				 coda_frame_type_char(dst_buf->flags),
+				 ctx->frame_metas[ctx->display_idx].sequence,
+				 dst_buf->sequence, ctx->qsequence,
+				 (dst_buf->flags & V4L2_BUF_FLAG_LAST) ?
+				 " (last)" : "");
+		}
 	} else {
-		coda_dbg(1, ctx, "job finished: no frame decoded (%u/%u)\n",
-			 ctx->osequence, ctx->qsequence);
+		if (decoded_idx >= 0 &&
+		    decoded_idx < ctx->num_internal_frames) {
+			coda_dbg(1, ctx, "job finished: decoded %c frame %u, no frame returned (%d)\n",
+				 coda_frame_type_char(ctx->frame_types[decoded_idx]),
+				 ctx->frame_metas[decoded_idx].sequence,
+				 ctx->display_idx);
+		} else {
+			coda_dbg(1, ctx, "job finished: no frame decoded (%d) or returned (%d)\n",
+				 decoded_idx, ctx->display_idx);
+		}
 	}
 
 	/* The rotator will copy the current display frame next time */
-- 
2.20.1

