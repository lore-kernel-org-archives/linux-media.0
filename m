Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088D2C10F06
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 20:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4E520811
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 20:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfC1UGV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:06:21 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:37471 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfC1UGU (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 16:06:20 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id D4636E0010;
        Thu, 28 Mar 2019 20:06:17 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     sakari.ailus@linux.intel.com, laurent.pinchart@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>, luca@lucaceresoli.net,
        ian.arkver.dev@gmail.com, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 23/31] adv748x: csi2: add translation from pixelcode to CSI-2 datatype
Date:   Thu, 28 Mar 2019 21:06:00 +0100
Message-Id: <20190328200608.9463-24-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190328200608.9463-1-jacopo+renesas@jmondi.org>
References: <20190328200608.9463-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Prepare to implement frame descriptors to support multiplexed streams by
adding a function to map pixelcode to CSI-2 datatype. This is needed to
properly be able to fill out the struct v4l2_mbus_frame_desc.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/media/i2c/adv748x/adv748x-csi2.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/media/i2c/adv748x/adv748x-csi2.c b/drivers/media/i2c/adv748x/adv748x-csi2.c
index 2091cda50935..25798d723174 100644
--- a/drivers/media/i2c/adv748x/adv748x-csi2.c
+++ b/drivers/media/i2c/adv748x/adv748x-csi2.c
@@ -14,6 +14,28 @@
 
 #include "adv748x.h"
 
+struct adv748x_csi2_format {
+	unsigned int code;
+	unsigned int datatype;
+};
+
+static const struct adv748x_csi2_format adv748x_csi2_formats[] = {
+	{ .code = MEDIA_BUS_FMT_RGB888_1X24,    .datatype = 0x24, },
+	{ .code = MEDIA_BUS_FMT_UYVY8_1X16,     .datatype = 0x1e, },
+	{ .code = MEDIA_BUS_FMT_UYVY8_2X8,      .datatype = 0x1e, },
+	{ .code = MEDIA_BUS_FMT_YUYV10_2X10,    .datatype = 0x1e, },
+};
+
+static unsigned int adv748x_csi2_code_to_datatype(unsigned int code)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(adv748x_csi2_formats); i++)
+		if (adv748x_csi2_formats[i].code == code)
+			return adv748x_csi2_formats[i].datatype;
+	return 0;
+}
+
 static int adv748x_csi2_set_virtual_channel(struct adv748x_csi2 *tx,
 					    unsigned int vc)
 {
-- 
2.21.0

