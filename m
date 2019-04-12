Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A82C10F0E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 15:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A96120693
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 15:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfDLPvw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:51:52 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35845 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfDLPvn (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 11:51:43 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hEySr-0000EY-LF; Fri, 12 Apr 2019 17:51:41 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     kernel@pengutronix.de
Subject: [PATCH 12/13] media: coda: use v4l2_m2m_buf_copy_metadata
Date:   Fri, 12 Apr 2019 17:51:34 +0200
Message-Id: <20190412155135.13907-12-p.zabel@pengutronix.de>
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

Use v4l2_m2m2_buf_copy_metadata to let BIT encoder contexts copy buffer
field, timestamp, timestamp flags, and optionally timecode.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/platform/coda/coda-bit.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/media/platform/coda/coda-bit.c b/drivers/media/platform/coda/coda-bit.c
index 2b73e023b191..d10b113610eb 100644
--- a/drivers/media/platform/coda/coda-bit.c
+++ b/drivers/media/platform/coda/coda-bit.c
@@ -1506,12 +1506,7 @@ static void coda_finish_encode(struct coda_ctx *ctx)
 		dst_buf->flags &= ~V4L2_BUF_FLAG_KEYFRAME;
 	}
 
-	dst_buf->vb2_buf.timestamp = src_buf->vb2_buf.timestamp;
-	dst_buf->field = src_buf->field;
-	dst_buf->flags &= ~V4L2_BUF_FLAG_TSTAMP_SRC_MASK;
-	dst_buf->flags |=
-		src_buf->flags & V4L2_BUF_FLAG_TSTAMP_SRC_MASK;
-	dst_buf->timecode = src_buf->timecode;
+	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, false);
 
 	v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_DONE);
 
-- 
2.20.1

