Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306A6C388F7
	for <linux-media@archiver.kernel.org>; Mon,  9 Nov 2020 16:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1AFB20809
	for <linux-media@archiver.kernel.org>; Mon,  9 Nov 2020 16:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbgKIQuH (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 9 Nov 2020 11:50:07 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:33909 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730709AbgKIQuH (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 9 Nov 2020 11:50:07 -0500
X-Originating-IP: 93.34.118.233
Received: from uno.lan (93-34-118-233.ip49.fastwebnet.it [93.34.118.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id E4F2D1BF213;
        Mon,  9 Nov 2020 16:50:03 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     linux-media@vger.kernel.org
Cc:     Jacopo Mondi <jacopo@jmondi.org>, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, hverkuil@xs4all.nl,
        laurent.pinchart@ideasonboard.com,
        roman.kovalivskyi@globallogic.com, dafna.hirschfeld@collabora.com,
        dave.stevenson@raspberrypi.org, naush@raspberrypi.com,
        erosca@de.adit-jv.com
Subject: [PATCH v3 10/29] media: ov5647: Protect s_stream() with mutex
Date:   Mon,  9 Nov 2020 17:49:15 +0100
Message-Id: <20201109164934.134919-11-jacopo@jmondi.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201109164934.134919-1-jacopo@jmondi.org>
References: <20201109164934.134919-1-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Use the driver mutex to protect s_stream() operations.
This will become more relevant once the sensor will support more formats
and set_format() could be issue concurrently to s_stream().

Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/media/i2c/ov5647.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
index f18e3ad342ebf..d386791f87500 100644
--- a/drivers/media/i2c/ov5647.c
+++ b/drivers/media/i2c/ov5647.c
@@ -460,10 +460,17 @@ static const struct v4l2_subdev_core_ops ov5647_subdev_core_ops = {
 
 static int ov5647_s_stream(struct v4l2_subdev *sd, int enable)
 {
+	struct ov5647 *sensor = to_state(sd);
+	int ret;
+
+	mutex_lock(&sensor->lock);
 	if (enable)
-		return ov5647_stream_on(sd);
+		ret = ov5647_stream_on(sd);
 	else
-		return ov5647_stream_off(sd);
+		ret = ov5647_stream_off(sd);
+	mutex_unlock(&sensor->lock);
+
+	return ret;
 }
 
 static const struct v4l2_subdev_video_ops ov5647_subdev_video_ops = {
-- 
2.29.1

