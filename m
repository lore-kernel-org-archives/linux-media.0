Return-Path: <SRS0=bMJ1=W2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B51C3A5A8
	for <linux-media@archiver.kernel.org>; Fri, 30 Aug 2019 13:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80C223405
	for <linux-media@archiver.kernel.org>; Fri, 30 Aug 2019 13:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfH3NuV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 30 Aug 2019 09:50:21 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:48688 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbfH3NuV (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 30 Aug 2019 09:50:21 -0400
Received: from ramsan ([84.194.98.4])
        by andre.telenet-ops.be with bizsmtp
        id vRqJ2000S05gfCL01RqJ3t; Fri, 30 Aug 2019 15:50:19 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i3hIA-0003KX-Oy; Fri, 30 Aug 2019 15:50:18 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i3hGO-0003C6-Jy; Fri, 30 Aug 2019 15:48:28 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] media: i2c: Use div64_ul() for u64-by-unsigned-long divide
Date:   Fri, 30 Aug 2019 15:48:27 +0200
Message-Id: <20190830134827.12237-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

div_u64() does a 64-by-32 division, while the divisor max2175.xtal_freq
is unsigned long, thus 64-bit on 64-bit platforms.  Hence the proper
function to call is div64_ul().

Note that this change does not have any functional impact, as the
crystal frequency must be much lower than the 32-bit limit anyway.
On 32-bit platforms, the generated code is the same.  But at least on
arm64, this saves an AND-instruction to truncate xtal_freq to 32-bit.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/media/i2c/max2175.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/max2175.c b/drivers/media/i2c/max2175.c
index 19a3ceea3bc20f0f..506a30e69ced45c4 100644
--- a/drivers/media/i2c/max2175.c
+++ b/drivers/media/i2c/max2175.c
@@ -591,8 +591,8 @@ static int max2175_set_lo_freq(struct max2175 *ctx, u32 lo_freq)
 		lo_freq *= lo_mult;
 
 	int_desired = lo_freq / ctx->xtal_freq;
-	frac_desired = div_u64((u64)(lo_freq % ctx->xtal_freq) << 20,
-			       ctx->xtal_freq);
+	frac_desired = div64_ul((u64)(lo_freq % ctx->xtal_freq) << 20,
+				ctx->xtal_freq);
 
 	/* Check CSM is not busy */
 	ret = max2175_poll_csm_ready(ctx);
-- 
2.17.1

