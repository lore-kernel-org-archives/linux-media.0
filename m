Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1FDC433FE
	for <linux-media@archiver.kernel.org>; Sat, 18 Sep 2021 15:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15E861284
	for <linux-media@archiver.kernel.org>; Sat, 18 Sep 2021 15:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239738AbhIRPGS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 18 Sep 2021 11:06:18 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:37855 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239611AbhIRPGS (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 18 Sep 2021 11:06:18 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id D129A4000A;
        Sat, 18 Sep 2021 15:04:51 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     tomi.valkeinen@ideasonboard.com, sakari.ailus@linux.intel.com,
        laurent.pinchart@ideasonboard.com, niklas.soderlund@ragnatech.se,
        kieran.bingham@ideasonboard.com
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas NIZAN <tnizan@witekio.com>, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 5/5] media: rcar-vin: Support multiplexed CSI-2 receiver
Date:   Sat, 18 Sep 2021 17:05:07 +0200
Message-Id: <20210918150507.987294-6-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210918150507.987294-1-jacopo+renesas@jmondi.org>
References: <20210918150507.987294-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The R-Car CSI-2 receiver supports multiplexed streams.

The VIN driver inspects the CSI-2 subdevice format with the intent of
validating formats at stream start time.

Each VIN instance is connected to a CSI-2 receiver which exposes a
single stream and since it has acquired support for multiplexed streams
maintains the format information in its v4l2_subdev_state per-stream.

Instrument the VIN driver to fetch the CSI-2 receiver format from the
streams configuration by setting the stream identifier to 0 and pass to
the subdevice its own state where to retrieve format information from.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/media/platform/rcar-vin/rcar-dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/rcar-vin/rcar-dma.c b/drivers/media/platform/rcar-vin/rcar-dma.c
index 83b2f923cf98..a6f3701f3f3f 100644
--- a/drivers/media/platform/rcar-vin/rcar-dma.c
+++ b/drivers/media/platform/rcar-vin/rcar-dma.c
@@ -1119,7 +1119,8 @@ static int rvin_mc_validate_format(struct rvin_dev *vin, struct v4l2_subdev *sd,
 	};
 
 	fmt.pad = pad->index;
-	if (v4l2_subdev_call(sd, pad, get_fmt, NULL, &fmt))
+	fmt.stream = 0;
+	if (v4l2_subdev_call(sd, pad, get_fmt, sd->state, &fmt))
 		return -EPIPE;
 
 	switch (fmt.format.code) {
-- 
2.32.0

