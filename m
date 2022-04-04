Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E2DC47080
	for <linux-media@archiver.kernel.org>; Mon,  4 Apr 2022 21:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379009AbiDDVSd (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379151AbiDDQhs (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 4 Apr 2022 12:37:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5253F15A3C
        for <linux-media@vger.kernel.org>; Mon,  4 Apr 2022 09:35:52 -0700 (PDT)
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbPgE-0004CX-Ml; Mon, 04 Apr 2022 18:35:50 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>, kernel@pengutronix.de
Subject: [PATCH 4/7] media: coda: disable stateful encoder ioctls for jpeg encoder
Date:   Mon,  4 Apr 2022 18:35:30 +0200
Message-Id: <20220404163533.707508-4-p.zabel@pengutronix.de>
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

Use v4l2_disable_ioctl() to disable the stateful encoder ioctls
VIDIOC_ENUM_FRAMEINTERVALS, VIDIOC_G_PARM, and VIDIOC_S_PARM for
the jpeg encoder device, to fix this v4l2-compliance test failure:

		fail: v4l2-test-formats.cpp(68): node->is_m2m && !(node->codec_mask & STATEFUL_ENCODER)
	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: FAIL
		fail: v4l2-test-formats.cpp(1363): node->is_m2m && !is_stateful_enc
	test VIDIOC_G/S_PARM: FAIL

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/platform/chips-media/coda-common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/chips-media/coda-common.c b/drivers/media/platform/chips-media/coda-common.c
index c60473b18b6b..4a7346ed771e 100644
--- a/drivers/media/platform/chips-media/coda-common.c
+++ b/drivers/media/platform/chips-media/coda-common.c
@@ -2882,6 +2882,11 @@ static int coda_register_device(struct coda_dev *dev, int i)
 	if (dev->devtype->vdevs[i]->type == CODA_INST_ENCODER) {
 		v4l2_disable_ioctl(vfd, VIDIOC_DECODER_CMD);
 		v4l2_disable_ioctl(vfd, VIDIOC_TRY_DECODER_CMD);
+		if (dev->devtype->vdevs[i]->dst_formats[0] == V4L2_PIX_FMT_JPEG) {
+			v4l2_disable_ioctl(vfd, VIDIOC_ENUM_FRAMEINTERVALS);
+			v4l2_disable_ioctl(vfd, VIDIOC_G_PARM);
+			v4l2_disable_ioctl(vfd, VIDIOC_S_PARM);
+		}
 	} else {
 		v4l2_disable_ioctl(vfd, VIDIOC_ENCODER_CMD);
 		v4l2_disable_ioctl(vfd, VIDIOC_TRY_ENCODER_CMD);
-- 
2.30.2

