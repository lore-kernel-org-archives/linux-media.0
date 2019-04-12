Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE63C282CE
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 15:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4D820693
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 15:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfDLPvn (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:51:43 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47031 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfDLPvn (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 11:51:43 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hEySr-0000EY-95; Fri, 12 Apr 2019 17:51:41 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     kernel@pengutronix.de
Subject: [PATCH 03/13] media: coda: add coda_frame_type_char helper
Date:   Fri, 12 Apr 2019 17:51:25 +0200
Message-Id: <20190412155135.13907-3-p.zabel@pengutronix.de>
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

Add a function to translate from V4L2 buffer flags to 'I'/'P'/'B'
characters for debug output.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/platform/coda/coda-bit.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/coda/coda-bit.c b/drivers/media/platform/coda/coda-bit.c
index eaa86737fa04..a0dbee2262e9 100644
--- a/drivers/media/platform/coda/coda-bit.c
+++ b/drivers/media/platform/coda/coda-bit.c
@@ -1456,6 +1456,13 @@ static int coda_prepare_encode(struct coda_ctx *ctx)
 	return 0;
 }
 
+static char coda_frame_type_char(u32 flags)
+{
+	return (flags & V4L2_BUF_FLAG_KEYFRAME) ? 'I' :
+	       (flags & V4L2_BUF_FLAG_PFRAME) ? 'P' :
+	       (flags & V4L2_BUF_FLAG_BFRAME) ? 'B' : '?';
+}
+
 static void coda_finish_encode(struct coda_ctx *ctx)
 {
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
@@ -1512,8 +1519,7 @@ static void coda_finish_encode(struct coda_ctx *ctx)
 		ctx->gopcounter = ctx->params.gop_size - 1;
 
 	coda_dbg(1, ctx, "job finished: encoded %c frame (%d)\n",
-		 (dst_buf->flags & V4L2_BUF_FLAG_KEYFRAME) ? 'I' : 'P',
-		 dst_buf->sequence);
+		 coda_frame_type_char(dst_buf->flags), dst_buf->sequence);
 }
 
 static void coda_seq_end_work(struct work_struct *work)
@@ -2241,8 +2247,7 @@ static void coda_finish_decode(struct coda_ctx *ctx)
 			coda_m2m_buf_done(ctx, dst_buf, VB2_BUF_STATE_DONE);
 
 		coda_dbg(1, ctx, "job finished: decoded %c frame (%u/%u)\n",
-			 (dst_buf->flags & V4L2_BUF_FLAG_KEYFRAME) ? 'I' :
-			 ((dst_buf->flags & V4L2_BUF_FLAG_PFRAME) ? 'P' : 'B'),
+			 coda_frame_type_char(dst_buf->flags),
 			 dst_buf->sequence, ctx->qsequence);
 	} else {
 		coda_dbg(1, ctx, "job finished: no frame decoded (%u/%u)\n",
-- 
2.20.1

