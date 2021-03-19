Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8632AC433E6
	for <linux-media@archiver.kernel.org>; Fri, 19 Mar 2021 16:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C8346199A
	for <linux-media@archiver.kernel.org>; Fri, 19 Mar 2021 16:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhCSQmw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 19 Mar 2021 12:42:52 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:41879 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbhCSQm0 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 19 Mar 2021 12:42:26 -0400
X-Originating-IP: 5.92.35.220
Received: from uno.localdomain (mob-5-92-35-220.net.vodafone.it [5.92.35.220])
        (Authenticated sender: jacopo@jmondi.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 7C98EC0007;
        Fri, 19 Mar 2021 16:42:19 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     kieran.bingham+renesas@ideasonboard.com,
        laurent.pinchart+renesas@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se, geert@linux-m68k.org
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v3 16/19] media: i2c: rdacm20: Replace goto with a loop
Date:   Fri, 19 Mar 2021 17:41:45 +0100
Message-Id: <20210319164148.199192-17-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210319164148.199192-1-jacopo+renesas@jmondi.org>
References: <20210319164148.199192-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

During the camera module initialization the image sensor PID is read to
verify it can correctly be identified. The current implementation is
rather confused and uses a loop implemented with a label and a goto.

Replace it with a more compact for() loop.

No functional changes intended.

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/media/i2c/rdacm20.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/media/i2c/rdacm20.c b/drivers/media/i2c/rdacm20.c
index 7bdcfafa6c10..760705dd2918 100644
--- a/drivers/media/i2c/rdacm20.c
+++ b/drivers/media/i2c/rdacm20.c
@@ -59,6 +59,8 @@
  */
 #define OV10635_PIXEL_RATE		(44000000)
 
+#define OV10635_PID_TIMEOUT		3
+
 static const struct ov10635_reg {
 	u16	reg;
 	u8	val;
@@ -438,7 +440,7 @@ static int rdacm20_get_fmt(struct v4l2_subdev *sd,
 static int rdacm20_init(struct v4l2_subdev *sd, unsigned int val)
 {
 	struct rdacm20_device *dev = sd_to_rdacm20(sd);
-	unsigned int retry = 3;
+	unsigned int i;
 	int ret;
 
 	/*
@@ -478,23 +480,18 @@ static int rdacm20_init(struct v4l2_subdev *sd, unsigned int val)
 		return ret;
 	usleep_range(10000, 15000);
 
-again:
-	ret = ov10635_read16(dev, OV10635_PID);
-	if (ret < 0) {
-		if (retry--)
-			goto again;
+	for (i = 0; i < OV10635_PID_TIMEOUT; ++i) {
+		ret = ov10635_read16(dev, OV10635_PID);
+		if (ret == OV10635_VERSION)
+			break;
+		else if (ret >= 0)
+			/* Sometimes we get a successful read but a wrong ID. */
+			dev_dbg(dev->dev, "OV10635 ID mismatch (%d)\n", ret);
 
-		dev_err(dev->dev, "OV10635 ID read failed (%d)\n",
-			ret);
-		return -ENXIO;
+		usleep_range(1000, 2000);
 	}
-
-	if (ret != OV10635_VERSION) {
-		if (retry--)
-			goto again;
-
-		dev_err(dev->dev, "OV10635 ID mismatch (0x%04x)\n",
-			ret);
+	if (i == OV10635_PID_TIMEOUT) {
+		dev_err(dev->dev, "OV10635 ID read failed (%d)\n", ret);
 		return -ENXIO;
 	}
 
-- 
2.30.0

