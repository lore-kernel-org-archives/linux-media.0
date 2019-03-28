Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2737C43381
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 20:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6072173C
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 20:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfC1UGJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:06:09 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:44769 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfC1UGI (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 16:06:08 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 9ABF2E000E;
        Thu, 28 Mar 2019 20:06:05 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     sakari.ailus@linux.intel.com, laurent.pinchart@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>, luca@lucaceresoli.net,
        ian.arkver.dev@gmail.com, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 16/31] v4l: Add CSI-2 bus configuration to frame descriptors
Date:   Thu, 28 Mar 2019 21:05:53 +0100
Message-Id: <20190328200608.9463-17-jacopo+renesas@jmondi.org>
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

From: Sakari Ailus <sakari.ailus@linux.intel.com>

Add CSI-2 bus specific configuration to the frame descriptors. This allows
obtaining the virtual channel and data type information for each stream
the transmitter is sending.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 include/media/v4l2-subdev.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index 9c5b616a4819..4c6f90f03dcd 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -317,6 +317,17 @@ struct v4l2_subdev_audio_ops {
 	int (*s_stream)(struct v4l2_subdev *sd, int enable);
 };
 
+/**
+ * struct v4l2_mbus_frame_desc_entry_csi2
+ *
+ * @channel: CSI-2 virtual channel
+ * @data_type: CSI-2 data type ID
+ */
+struct v4l2_mbus_frame_desc_entry_csi2 {
+	u8 channel;
+	u8 data_type;
+};
+
 /**
  * enum v4l2_mbus_frame_desc_entry - media bus frame description flags
  *
@@ -340,11 +351,16 @@ enum v4l2_mbus_frame_desc_flags {
  *		%FRAME_DESC_FL_BLOB is not set.
  * @length:	number of octets per frame, valid if @flags
  *		%V4L2_MBUS_FRAME_DESC_FL_LEN_MAX is set.
+ * @bus:	Bus specific frame descriptor parameters
+ * @bus.csi2:	CSI-2 specific bus configuration
  */
 struct v4l2_mbus_frame_desc_entry {
 	enum v4l2_mbus_frame_desc_flags flags;
 	u32 pixelcode;
 	u32 length;
+	union {
+		struct v4l2_mbus_frame_desc_entry_csi2 csi2;
+	} bus;
 };
 
 #define V4L2_FRAME_DESC_ENTRY_MAX	4
-- 
2.21.0

