Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D98BC282DE
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 12:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E393214D8
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 12:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfDHMdK (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:33:10 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36247 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfDHMdJ (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 08:33:09 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hDTSW-00005P-Dc; Mon, 08 Apr 2019 14:33:08 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     kernel@pengutronix.de
Subject: [PATCH 05/10] media: coda: disable encoder command on decoder and vice versa
Date:   Mon,  8 Apr 2019 14:32:51 +0200
Message-Id: <20190408123256.22868-5-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408123256.22868-1-p.zabel@pengutronix.de>
References: <20190408123256.22868-1-p.zabel@pengutronix.de>
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

Return -ENOTTY when userspace tries to call VIDIOC_(TRY_)ENCODER_CMD on
a decoder instance or VIDIOC_(TRY_)DECODER_CMD on an encoder instance.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/platform/coda/coda-common.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index f1d3fb17784a..c0421f06ca48 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -1000,6 +1000,11 @@ static int coda_s_selection(struct file *file, void *fh,
 static int coda_try_encoder_cmd(struct file *file, void *fh,
 				struct v4l2_encoder_cmd *ec)
 {
+	struct coda_ctx *ctx = fh_to_ctx(fh);
+
+	if (ctx->inst_type != CODA_INST_ENCODER)
+		return -ENOTTY;
+
 	if (ec->cmd != V4L2_ENC_CMD_STOP)
 		return -EINVAL;
 
@@ -1020,10 +1025,6 @@ static int coda_encoder_cmd(struct file *file, void *fh,
 	if (ret < 0)
 		return ret;
 
-	/* Ignore encoder stop command silently in decoder context */
-	if (ctx->inst_type != CODA_INST_ENCODER)
-		return 0;
-
 	/* Set the stream-end flag on this context */
 	ctx->bit_stream_param |= CODA_BIT_STREAM_END_FLAG;
 
@@ -1041,6 +1042,11 @@ static int coda_encoder_cmd(struct file *file, void *fh,
 static int coda_try_decoder_cmd(struct file *file, void *fh,
 				struct v4l2_decoder_cmd *dc)
 {
+	struct coda_ctx *ctx = fh_to_ctx(fh);
+
+	if (ctx->inst_type != CODA_INST_DECODER)
+		return -ENOTTY;
+
 	if (dc->cmd != V4L2_DEC_CMD_STOP)
 		return -EINVAL;
 
@@ -1063,10 +1069,6 @@ static int coda_decoder_cmd(struct file *file, void *fh,
 	if (ret < 0)
 		return ret;
 
-	/* Ignore decoder stop command silently in encoder context */
-	if (ctx->inst_type != CODA_INST_DECODER)
-		return 0;
-
 	/* Set the stream-end flag on this context */
 	coda_bit_stream_end_flag(ctx);
 	ctx->hold = false;
-- 
2.20.1

