Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8304FC4320A
	for <linux-media@archiver.kernel.org>; Mon, 30 Aug 2021 11:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F0276113D
	for <linux-media@archiver.kernel.org>; Mon, 30 Aug 2021 11:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbhH3LDd (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 30 Aug 2021 07:03:33 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:43892 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236480AbhH3LD1 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 30 Aug 2021 07:03:27 -0400
Received: from deskari.lan (91-158-153-130.elisa-laajakaista.fi [91.158.153.130])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9328A1543;
        Mon, 30 Aug 2021 13:02:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1630321350;
        bh=uAejeEnF4wLo8/PXKQHvt/Yl7pOuK99aODYQikJB0tI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=thg4wqZhu7FXLR3DpqDhShnY7UmkZUaNZq4dkDhZaEQLSa3G9DJtGEJuUZxUANYic
         9twVr9e1p8fpiT9wORJsjqVs1axIjOcA9iAqz2kiKcBgl/oBCyjPbfnN1HHP4GZfGO
         O2tbbLjnNeUks4MzKQXkKdywkNKaXK86uadTi6P8=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     linux-media@vger.kernel.org, sakari.ailus@linux.intel.com,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        niklas.soderlund+renesas@ragnatech.se
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v8 22/36] media: Add bus type to frame descriptors
Date:   Mon, 30 Aug 2021 14:01:02 +0300
Message-Id: <20210830110116.488338-23-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210830110116.488338-1-tomi.valkeinen@ideasonboard.com>
References: <20210830110116.488338-1-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Sakari Ailus <sakari.ailus@linux.intel.com>

Add the media bus type to the frame descriptor. CSI-2 specific
information will be added in next patch to the frame descriptor.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

- Make the bus type a named enum
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 include/media/v4l2-subdev.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index 2290b5025fc0..65471e579815 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -344,12 +344,32 @@ struct v4l2_mbus_frame_desc_entry {
 
 #define V4L2_FRAME_DESC_ENTRY_MAX	4
 
+/**
+ * enum v4l2_mbus_frame_desc_type - media bus frame description type
+ *
+ * @V4L2_MBUS_FRAME_DESC_TYPE_UNDEFINED:
+ *	Undefined frame desc type. Drivers should not use this, it is
+ *	for backwards compatibility.
+ * @V4L2_MBUS_FRAME_DESC_TYPE_PARALLEL:
+ *	Parallel media bus.
+ * @V4L2_MBUS_FRAME_DESC_TYPE_CSI2:
+ *	CSI-2 media bus. Frame desc parameters must be set in
+ *	&struct v4l2_mbus_frame_desc_entry->csi2.
+ */
+enum v4l2_mbus_frame_desc_type {
+	V4L2_MBUS_FRAME_DESC_TYPE_UNDEFINED = 0,
+	V4L2_MBUS_FRAME_DESC_TYPE_PARALLEL,
+	V4L2_MBUS_FRAME_DESC_TYPE_CSI2,
+};
+
 /**
  * struct v4l2_mbus_frame_desc - media bus data frame description
+ * @type: type of the bus (enum v4l2_mbus_frame_desc_type)
  * @entry: frame descriptors array
  * @num_entries: number of entries in @entry array
  */
 struct v4l2_mbus_frame_desc {
+	enum v4l2_mbus_frame_desc_type type;
 	struct v4l2_mbus_frame_desc_entry entry[V4L2_FRAME_DESC_ENTRY_MAX];
 	unsigned short num_entries;
 };
-- 
2.25.1

