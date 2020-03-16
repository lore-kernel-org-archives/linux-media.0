Return-Path: <SRS0=JFiv=5B=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5831BC18E5B
	for <linux-media@archiver.kernel.org>; Mon, 16 Mar 2020 15:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CEA2051A
	for <linux-media@archiver.kernel.org>; Mon, 16 Mar 2020 15:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbgCPP0t (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:26:49 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48135 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731658AbgCPP0o (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 16 Mar 2020 11:26:44 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1jDrdZ-0000lG-Iz; Mon, 16 Mar 2020 16:26:41 +0100
Received: from mtr by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1jDrdY-000557-JM; Mon, 16 Mar 2020 16:26:40 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        Michael Tretter <m.tretter@pengutronix.de>
Subject: [PATCH v2 06/18] media: allegro: fix calculation of CPB size
Date:   Mon, 16 Mar 2020 16:26:26 +0100
Message-Id: <20200316152638.19457-7-m.tretter@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316152638.19457-1-m.tretter@pengutronix.de>
References: <20200316152638.19457-1-m.tretter@pengutronix.de>
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

The cpb_size is given in kilobytes, but the bitrate is given in bits per
second. Therefore, the calculation of the initial removal delay and the
cpb size for the firmware were wrong.

Convert the bitrate to kilobytes before calculating the cpb size in 90
kHz units for sending it to the firmware. Also reuse the result for the
initial removal delay, to make it obvious that we are setting the
initial removal delay to the maximum value.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
Changelog:

v1 -> v2:
- Add separate function for calculating CPB for mcu
---
 .../staging/media/allegro-dvt/allegro-core.c  | 25 +++++++++++++++----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/allegro-dvt/allegro-core.c b/drivers/staging/media/allegro-dvt/allegro-core.c
index cbe79bc216fd..87592419ec84 100644
--- a/drivers/staging/media/allegro-dvt/allegro-core.c
+++ b/drivers/staging/media/allegro-dvt/allegro-core.c
@@ -5,6 +5,7 @@
  * Allegro DVT video encoder driver
  */
 
+#include <linux/bits.h>
 #include <linux/firmware.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -1053,6 +1054,22 @@ v4l2_bitrate_mode_to_mcu_mode(enum v4l2_mpeg_video_bitrate_mode mode)
 	}
 }
 
+static u32 v4l2_cpb_size_to_mcu(unsigned int cpb_size, unsigned int bitrate)
+{
+	unsigned int cpb_size_kbit;
+	unsigned int bitrate_kbps;
+
+	/*
+	 * The mcu expects the CPB size in units of a 90 kHz clock, but the
+	 * channel follows the V4L2_CID_MPEG_VIDEO_H264_CPB_SIZE and stores
+	 * the CPB size in kilobytes.
+	 */
+	cpb_size_kbit = cpb_size * BITS_PER_BYTE;
+	bitrate_kbps = bitrate / 1000;
+
+	return (cpb_size_kbit * 90000) / bitrate_kbps;
+}
+
 static int allegro_mcu_send_create_channel(struct allegro_dev *dev,
 					   struct allegro_channel *channel)
 {
@@ -1094,12 +1111,10 @@ static int allegro_mcu_send_create_channel(struct allegro_dev *dev,
 
 	msg.rate_control_mode =
 		v4l2_bitrate_mode_to_mcu_mode(channel->bitrate_mode);
+	msg.cpb_size = v4l2_cpb_size_to_mcu(channel->cpb_size,
+					    channel->bitrate_peak);
 	/* Shall be ]0;cpb_size in 90 kHz units]. Use maximum value. */
-	msg.initial_rem_delay =
-		((channel->cpb_size * 1000) / channel->bitrate_peak) * 90000;
-	/* Encoder expects cpb_size in units of a 90 kHz clock. */
-	msg.cpb_size =
-		((channel->cpb_size * 1000) / channel->bitrate_peak) * 90000;
+	msg.initial_rem_delay = msg.cpb_size;
 	msg.framerate = 25;
 	msg.clk_ratio = 1000;
 	msg.target_bitrate = channel->bitrate;
-- 
2.20.1

