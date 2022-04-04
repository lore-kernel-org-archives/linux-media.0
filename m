Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6768C4167B
	for <linux-media@archiver.kernel.org>; Mon,  4 Apr 2022 21:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379121AbiDDVSs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379147AbiDDQhq (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 4 Apr 2022 12:37:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5890AE094
        for <linux-media@vger.kernel.org>; Mon,  4 Apr 2022 09:35:49 -0700 (PDT)
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbPgB-0004CX-MA; Mon, 04 Apr 2022 18:35:47 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>, kernel@pengutronix.de
Subject: [PATCH 1/7] media: coda: set output buffer bytesused to appease v4l2-compliance
Date:   Mon,  4 Apr 2022 18:35:27 +0200
Message-Id: <20220404163533.707508-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::39
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The V4L2 specification states:

 "If the application sets this to 0 for an output stream, then bytesused
  will be set to the size of the buffer (see the length field of this
  struct) by the driver."

Since we set allow_zero_bytesused, we have to handle this ourselves.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/platform/chips-media/coda-bit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/chips-media/coda-bit.c b/drivers/media/platform/chips-media/coda-bit.c
index c484c008ab02..705a179ea8f0 100644
--- a/drivers/media/platform/chips-media/coda-bit.c
+++ b/drivers/media/platform/chips-media/coda-bit.c
@@ -381,6 +381,9 @@ void coda_fill_bitstream(struct coda_ctx *ctx, struct list_head *buffer_list)
 		/* Dump empty buffers */
 		if (!vb2_get_plane_payload(&src_buf->vb2_buf, 0)) {
 			src_buf = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
+			vb2_set_plane_payload(&src_buf->vb2_buf, 0,
+					      vb2_plane_size(&src_buf->vb2_buf,
+							     0));
 			v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_DONE);
 			continue;
 		}
-- 
2.30.2

