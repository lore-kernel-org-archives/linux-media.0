Return-Path: <SRS0=MHKF=4F=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006A7C34027
	for <linux-media@archiver.kernel.org>; Mon, 17 Feb 2020 15:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CF320801
	for <linux-media@archiver.kernel.org>; Mon, 17 Feb 2020 15:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgBQPOF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:14:05 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60829 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgBQPOE (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 17 Feb 2020 10:14:04 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1j3i5x-0005WA-8Z; Mon, 17 Feb 2020 16:14:01 +0100
Received: from mtr by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1j3i5w-0001aA-A1; Mon, 17 Feb 2020 16:14:00 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        Michael Tretter <m.tretter@pengutronix.de>
Subject: [PATCH 07/18] media: allegro: fix reset if WAKEUP has not been set properly
Date:   Mon, 17 Feb 2020 16:13:47 +0100
Message-Id: <20200217151358.5695-8-m.tretter@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200217151358.5695-1-m.tretter@pengutronix.de>
References: <20200217151358.5695-1-m.tretter@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The Zynq UltraScale+ Devices Register Reference states that the WAKEUP
bit "should be set to 0 after the MCU sleep status bit gets back to 0."
If this is not done, the mcu is not going to sleep on reset and fail the
reset.

Set WAKEUP to 0 before triggering a reset to make sure that the reset is
successful.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
 drivers/staging/media/allegro-dvt/allegro-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/media/allegro-dvt/allegro-core.c b/drivers/staging/media/allegro-dvt/allegro-core.c
index 383a5fe07d64..3366e3605cf5 100644
--- a/drivers/staging/media/allegro-dvt/allegro-core.c
+++ b/drivers/staging/media/allegro-dvt/allegro-core.c
@@ -1975,6 +1975,14 @@ static int allegro_mcu_reset(struct allegro_dev *dev)
 {
 	int err;
 
+	/*
+	 * Ensure that the AL5_MCU_WAKEUP bit is set to 0 otherwise the mcu
+	 * does not go to sleep after the reset.
+	 */
+	err = regmap_write(dev->regmap, AL5_MCU_WAKEUP, 0);
+	if (err)
+		return err;
+
 	err = regmap_write(dev->regmap,
 			   AL5_MCU_RESET_MODE, AL5_MCU_RESET_MODE_SLEEP);
 	if (err < 0)
-- 
2.20.1

