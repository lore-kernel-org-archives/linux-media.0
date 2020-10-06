Return-Path: <SRS0=ILh3=DN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F820C4727E
	for <linux-media@archiver.kernel.org>; Tue,  6 Oct 2020 10:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B182078E
	for <linux-media@archiver.kernel.org>; Tue,  6 Oct 2020 10:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgJFKoO (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 6 Oct 2020 06:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFKoN (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 6 Oct 2020 06:44:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B96C061755
        for <linux-media@vger.kernel.org>; Tue,  6 Oct 2020 03:44:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 49BFA29B122
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>, cphealy@gmail.com,
        Benjamin.Bara@skidata.com, l.stach@pengutronix.de,
        Ezequiel Garcia <ezequiel@collabora.com>, kernel@collabora.com
Subject: [PATCH 2/6] coda: Simplify H.264 small buffer padding logic
Date:   Tue,  6 Oct 2020 07:44:10 -0300
Message-Id: <20201006104414.67984-3-ezequiel@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201006104414.67984-1-ezequiel@collabora.com>
References: <20201006104414.67984-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The H.264 small buffer padding is done under
the (ctx->qsequence == 0 && payload < 512) condition.

Given this is the exact same condition immediately
above, we can move it right there, making the code
slightly clearer.

This change shouldn't affect functionality as it's just
cosmetics.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/media/platform/coda/coda-bit.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/coda/coda-bit.c b/drivers/media/platform/coda/coda-bit.c
index aa0a47c34413..659fcf77b0ed 100644
--- a/drivers/media/platform/coda/coda-bit.c
+++ b/drivers/media/platform/coda/coda-bit.c
@@ -293,12 +293,11 @@ static bool coda_bitstream_try_queue(struct coda_ctx *ctx,
 			coda_dbg(1, ctx,
 				 "could not parse header, sequence initialization might fail\n");
 		}
-	}
 
-	/* Add padding before the first buffer, if it is too small */
-	if (ctx->qsequence == 0 && payload < 512 &&
-	    ctx->codec->src_fourcc == V4L2_PIX_FMT_H264)
-		coda_h264_bitstream_pad(ctx, 512 - payload);
+		/* Add padding before the first buffer, if it is too small */
+		if (ctx->codec->src_fourcc == V4L2_PIX_FMT_H264)
+			coda_h264_bitstream_pad(ctx, 512 - payload);
+	}
 
 	ret = coda_bitstream_queue(ctx, vaddr, payload);
 	if (ret < 0) {
-- 
2.27.0

