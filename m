Return-Path: <SRS0=MHKF=4F=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DA1C34025
	for <linux-media@archiver.kernel.org>; Mon, 17 Feb 2020 15:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D26208C4
	for <linux-media@archiver.kernel.org>; Mon, 17 Feb 2020 15:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgBQPOE (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:14:04 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36869 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbgBQPOE (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 17 Feb 2020 10:14:04 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1j3i5x-0005WH-Ch; Mon, 17 Feb 2020 16:14:01 +0100
Received: from mtr by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1j3i5w-0001ai-Cv; Mon, 17 Feb 2020 16:14:00 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        Michael Tretter <m.tretter@pengutronix.de>
Subject: [PATCH 14/18] media: allegro: handle dependency of bitrate and bitrate_peak
Date:   Mon, 17 Feb 2020 16:13:54 +0100
Message-Id: <20200217151358.5695-15-m.tretter@pengutronix.de>
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

The peak bitrate must not be smaller than the configured bitrate. Update
the other control whenever one of the controls changes to reflect this
dependency.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
 drivers/staging/media/allegro-dvt/allegro-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/media/allegro-dvt/allegro-core.c b/drivers/staging/media/allegro-dvt/allegro-core.c
index 8c26158eab93..cedb09ea649f 100644
--- a/drivers/staging/media/allegro-dvt/allegro-core.c
+++ b/drivers/staging/media/allegro-dvt/allegro-core.c
@@ -2403,9 +2403,15 @@ static int allegro_s_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	case V4L2_CID_MPEG_VIDEO_BITRATE:
 		channel->bitrate = ctrl->val;
+		if (channel->bitrate > channel->bitrate_peak)
+			__v4l2_ctrl_s_ctrl(channel->mpeg_video_bitrate_peak,
+					   channel->bitrate);
 		break;
 	case V4L2_CID_MPEG_VIDEO_BITRATE_PEAK:
 		channel->bitrate_peak = ctrl->val;
+		if (channel->bitrate_peak < channel->bitrate)
+			__v4l2_ctrl_s_ctrl(channel->mpeg_video_bitrate,
+					   channel->bitrate_peak);
 		break;
 	case V4L2_CID_MPEG_VIDEO_H264_CPB_SIZE:
 		channel->cpb_size = ctrl->val;
-- 
2.20.1

