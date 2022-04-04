Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701EAC4332F
	for <linux-media@archiver.kernel.org>; Mon,  4 Apr 2022 21:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379113AbiDDVSq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379159AbiDDQhv (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 4 Apr 2022 12:37:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E711AF00
        for <linux-media@vger.kernel.org>; Mon,  4 Apr 2022 09:35:55 -0700 (PDT)
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbPgH-0004CX-SM; Mon, 04 Apr 2022 18:35:53 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>, kernel@pengutronix.de
Subject: [PATCH 6/7] media: coda: enable capture G_PARM for stateful encoder
Date:   Mon,  4 Apr 2022 18:35:32 +0200
Message-Id: <20220404163533.707508-6-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404163533.707508-1-p.zabel@pengutronix.de>
References: <20220404163533.707508-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::39
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Allow to call G_PARM with type == V4L2_BUF_TYPE_VIDEO_CAPTURE,
to fix the following v4l2-compliance test failure:

		fail: v4l2-test-formats.cpp(1344): ret && node->has_frmintervals
	test VIDIOC_G/S_PARM: FAIL

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/platform/chips-media/coda-common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/platform/chips-media/coda-common.c b/drivers/media/platform/chips-media/coda-common.c
index c068c16d1eb4..33fcd8c7d72b 100644
--- a/drivers/media/platform/chips-media/coda-common.c
+++ b/drivers/media/platform/chips-media/coda-common.c
@@ -1341,9 +1341,6 @@ static int coda_g_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
 	struct coda_ctx *ctx = fh_to_ctx(fh);
 	struct v4l2_fract *tpf;
 
-	if (a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
-		return -EINVAL;
-
 	a->parm.output.capability = V4L2_CAP_TIMEPERFRAME;
 	tpf = &a->parm.output.timeperframe;
 	tpf->denominator = ctx->params.framerate & CODA_FRATE_RES_MASK;
-- 
2.30.2

