Return-Path: <SRS0=MHKF=4F=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AE8C34022
	for <linux-media@archiver.kernel.org>; Mon, 17 Feb 2020 15:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C9820801
	for <linux-media@archiver.kernel.org>; Mon, 17 Feb 2020 15:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgBQPOO (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:14:14 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44141 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbgBQPOD (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 17 Feb 2020 10:14:03 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1j3i5x-0005WD-8A; Mon, 17 Feb 2020 16:14:01 +0100
Received: from mtr by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1j3i5w-0001aJ-BH; Mon, 17 Feb 2020 16:14:00 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        Michael Tretter <m.tretter@pengutronix.de>
Subject: [PATCH 10/18] media: allegro: skip filler data if possible
Date:   Mon, 17 Feb 2020 16:13:50 +0100
Message-Id: <20200217151358.5695-11-m.tretter@pengutronix.de>
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

The driver instructs the firmware to leave some space space in front of
the coded frame data for SPS/PPS data. If the driver receives an IDR, it
writes the SPS/PPS into that free space and fills the rest with filler
data. However, if there is no additional data, the driver can use the
plane offset to skip this space instead of adding filler data.

As the size of the SPS/PPS is only available after writing it, keep the
filler data between the SPS/PPS and the coded frame data.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
 .../staging/media/allegro-dvt/allegro-core.c  | 25 +++++++++++--------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/media/allegro-dvt/allegro-core.c b/drivers/staging/media/allegro-dvt/allegro-core.c
index 868dd9b35400..71ed3abc61f0 100644
--- a/drivers/staging/media/allegro-dvt/allegro-core.c
+++ b/drivers/staging/media/allegro-dvt/allegro-core.c
@@ -1637,17 +1637,22 @@ static void allegro_channel_finish_frame(struct allegro_channel *channel,
 			 channel->mcu_channel_id, len);
 	}
 
-	len = nal_h264_write_filler(&dev->plat_dev->dev, curr, free);
-	if (len < 0) {
-		v4l2_err(&dev->v4l2_dev,
-			 "failed to write %zd filler data\n", free);
-		goto err;
+	if (msg->slice_type != AL_ENC_SLICE_TYPE_I && !msg->is_idr) {
+		dst_buf->vb2_buf.planes[0].data_offset = free;
+		free = 0;
+	} else {
+		len = nal_h264_write_filler(&dev->plat_dev->dev, curr, free);
+		if (len < 0) {
+			v4l2_err(&dev->v4l2_dev,
+					"failed to write %zd filler data\n", free);
+			goto err;
+		}
+		curr += len;
+		free -= len;
+		v4l2_dbg(2, debug, &dev->v4l2_dev,
+				"channel %d: wrote %zd bytes filler nal unit\n",
+				channel->mcu_channel_id, len);
 	}
-	curr += len;
-	free -= len;
-	v4l2_dbg(2, debug, &dev->v4l2_dev,
-		 "channel %d: wrote %zd bytes filler nal unit\n",
-		 channel->mcu_channel_id, len);
 
 	if (free != 0) {
 		v4l2_err(&dev->v4l2_dev,
-- 
2.20.1

