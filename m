Return-Path: <SRS0=4kUN=CX=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC08C43461
	for <linux-media@archiver.kernel.org>; Mon, 14 Sep 2020 13:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C435206DB
	for <linux-media@archiver.kernel.org>; Mon, 14 Sep 2020 13:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600089989;
	bh=dXrEI8jV4unTdYHFAX+Gpr/qoPq01Has+DYPOYKtm2w=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=cKlFpFpv180AXh8B70hi2mNRlD2HJcvaQeO7x+ABB2mGWPfwb7F8vKTHcJwtk7vVO
	 DEqHNAQcOq/5Uw9IoQJvSApBSulWd5I8SUdD7blAERfJtM5ECA2AkDF3pR8Yxaq1VQ
	 NVJ1Kg80dn2ptpG0E3bd6xOi4+5RKX+4bxTra1HI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgINN0S (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 14 Sep 2020 09:26:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgINNXT (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 14 Sep 2020 09:23:19 -0400
Received: from mail.kernel.org (unknown [95.90.213.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E30E206DB;
        Mon, 14 Sep 2020 13:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600089794;
        bh=dXrEI8jV4unTdYHFAX+Gpr/qoPq01Has+DYPOYKtm2w=;
        h=From:To:Cc:Subject:Date:From;
        b=1PxDyUkrzS6ZADUEulO7FrbACopN2SNXZFxv7PItrTzycvktYk59+s6rxe4ETwJ7P
         2gQkNbljnk6tkVEFQECgw1W/hyfI8t5qp62AnNmGCf095def+zw4mzTDCLSXLqnH2q
         8vxTbHk/z3P+tl6/Trfuc/2NinF1gWmYPENj2auc=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kHoRs-003DeD-0P; Mon, 14 Sep 2020 15:23:12 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH] media: vidtv: adjust signal strength range
Date:   Mon, 14 Sep 2020 15:23:10 +0200
Message-Id: <c824a8b556280747c2a278864920baf8f78089ab.1600089788.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On real devices, signal strength is always a negative
number when represented in dBm. A more interesting
range is to use dBmV (which is what Kaffeine does,
for example). The conversion from the two units are
simple:

	dBmV = dBm - 108

Usually, signal strength ranges up to 100dBmV. Adjust the
maximum value to be around 74 dBmV, when there's no
frequency shift, which represents a good signal.

With that, Kaffeine displays it a lot better.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/test-drivers/vidtv/vidtv_demod.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_demod.c b/drivers/media/test-drivers/vidtv/vidtv_demod.c
index c54c88cac84f..c825842758f0 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_demod.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_demod.c
@@ -181,12 +181,18 @@ static void vidtv_demod_update_stats(struct dvb_frontend *fe)
 	c->block_count.stat[0].scale = scale;
 
 	/*
-	 * Add a 0.5% of randomness at the signal streangth and CNR,
+	 * Add a 0.5% of randomness at the signal strength and CNR,
 	 * and make them different, as we want to have something closer
 	 * to a real case scenario.
+	 *
+	 * Also, usually, signal strength is a negative number in dBm.
 	 */
-	c->strength.stat[0].svalue = state->tuner_cnr + prandom_u32_max(state->tuner_cnr / 50);
-	c->cnr.stat[0].svalue = state->tuner_cnr - prandom_u32_max(state->tuner_cnr / 50);
+	c->strength.stat[0].svalue = state->tuner_cnr;
+	c->strength.stat[0].svalue -= prandom_u32_max(state->tuner_cnr / 50);
+	c->strength.stat[0].svalue -= 68000; /* Adjust to a better range */
+
+	c->cnr.stat[0].svalue = state->tuner_cnr;
+	c->cnr.stat[0].svalue -= prandom_u32_max(state->tuner_cnr / 50);
 
 }
 
-- 
2.26.2

