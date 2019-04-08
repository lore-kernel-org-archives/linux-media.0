Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11C7C10F13
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 12:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7AC214D8
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 12:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfDHMdK (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:33:10 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49113 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfDHMdJ (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 08:33:09 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hDTSW-00005P-Bv; Mon, 08 Apr 2019 14:33:08 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     kernel@pengutronix.de
Subject: [PATCH 04/10] media: coda: add min number of buffers controls
Date:   Mon,  8 Apr 2019 14:32:50 +0200
Message-Id: <20190408123256.22868-4-p.zabel@pengutronix.de>
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

Add min number of buffers for capture (decoder) and output (encoder)
controls, which are required by the stateful video decoder / encoder
interface specification.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/platform/coda/coda-common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index de608de62908..f1d3fb17784a 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -2061,11 +2061,17 @@ static int coda_ctrls_setup(struct coda_ctx *ctx)
 	v4l2_ctrl_new_std(&ctx->ctrls, &coda_ctrl_ops,
 		V4L2_CID_VFLIP, 0, 1, 1, 0);
 	if (ctx->inst_type == CODA_INST_ENCODER) {
+		v4l2_ctrl_new_std(&ctx->ctrls, &coda_ctrl_ops,
+				  V4L2_CID_MIN_BUFFERS_FOR_OUTPUT,
+				  1, 1, 1, 1);
 		if (ctx->cvd->dst_formats[0] == V4L2_PIX_FMT_JPEG)
 			coda_jpeg_encode_ctrls(ctx);
 		else
 			coda_encode_ctrls(ctx);
 	} else {
+		v4l2_ctrl_new_std(&ctx->ctrls, &coda_ctrl_ops,
+				  V4L2_CID_MIN_BUFFERS_FOR_CAPTURE,
+				  1, 1, 1, 1);
 		if (ctx->cvd->src_formats[0] == V4L2_PIX_FMT_H264)
 			coda_decode_ctrls(ctx);
 	}
-- 
2.20.1

