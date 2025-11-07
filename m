Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0332FBDED
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 01:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762480713; cv=none; b=KFM2e6FZubz9vE34awFZ4tMq0fniuSHK3Mb3O0oGGqZIoUXvp4foKNkymbRVtG6K7d3+163PuXc9HqMlcPvDjsRqlafY3cgNGrBTaSpvY5jHl+b0fHfq+ZxBNF5HHeDhVhkB1cuByKSCntLK2cUUO4p4xlcyikMv906tzDj4Qug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762480713; c=relaxed/simple;
	bh=kz2MpXhV1Ha9S9mU1z1qGENKYDeOPjL7Z2VdiDb5rjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnxY4QDzUU1bBtKnDKlu2sftoCqTJQokxytYzHBszXAG3FffiznoCV95LUy4kjAV2w5Wy25aVH6a03P+0M48rp0Dc3aQLKplZukG3pCVb9idxAgnTqv8mjDcv1nlEApdM0CSmK9kZoSwnI4yNqlII1k6DfSKgml3sTyU/cdhkaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=HzjCwE8I; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="HzjCwE8I"
Received: from pendragon.ideasonboard.com (82-203-161-95.bb.dnainternet.fi [82.203.161.95])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id E924619E5;
	Fri,  7 Nov 2025 02:56:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762480588;
	bh=kz2MpXhV1Ha9S9mU1z1qGENKYDeOPjL7Z2VdiDb5rjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HzjCwE8I5YVEFDAJ+fRZXyAyXcOMw4IKCRSOX1Z3RWJIYrvNBfCHqpwYRy/7rkHSz
	 1Mrb57vDIW6IT45PTZenAKVbeE7QYYG/4ibDgd/4CA5u0h4LRgj2+TRKVJ9QBbZYGN
	 elXaR9+AWHkBODSUJazlMRNraOssV4r93kEJ4h5M=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Rui Miguel Silva <rmfrfs@gmail.com>,
	Martin Kepplinger <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH v1 3/6] media: imx-mipi-csis: Implement the .set_routing() operation
Date: Fri,  7 Nov 2025 03:58:10 +0200
Message-ID: <20251107015813.5834-4-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107015813.5834-1-laurent.pinchart@ideasonboard.com>
References: <20251107015813.5834-1-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for multi-stream support, implement the .set_routing()
operation. The routing table is currently hardcoded to a single route.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/nxp/imx-mipi-csis.c | 73 ++++++++++++++++++----
 1 file changed, 60 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-mipi-csis.c b/drivers/media/platform/nxp/imx-mipi-csis.c
index f142e79acbcf..f4b19576a235 100644
--- a/drivers/media/platform/nxp/imx-mipi-csis.c
+++ b/drivers/media/platform/nxp/imx-mipi-csis.c
@@ -1154,6 +1154,52 @@ static int mipi_csis_get_frame_desc(struct v4l2_subdev *sd, unsigned int pad,
 	return 0;
 }
 
+static int __mipi_csis_set_routing(struct v4l2_subdev *sd,
+				   struct v4l2_subdev_state *state,
+				   struct v4l2_subdev_krouting *routing)
+{
+	static const struct v4l2_mbus_framefmt format = {
+		.width = MIPI_CSIS_DEF_PIX_WIDTH,
+		.height = MIPI_CSIS_DEF_PIX_HEIGHT,
+		.code = mipi_csis_formats[0].code,
+		.field = V4L2_FIELD_NONE,
+		.colorspace = V4L2_XFER_FUNC_709,
+		.ycbcr_enc = V4L2_YCBCR_ENC_601,
+		.quantization = V4L2_QUANTIZATION_LIM_RANGE,
+		.xfer_func = V4L2_XFER_FUNC_SRGB,
+	};
+	int ret;
+
+	ret = v4l2_subdev_routing_validate(sd, routing,
+					   V4L2_SUBDEV_ROUTING_NO_1_TO_N);
+	if (ret)
+		return ret;
+
+	/* Only a single route is supported for now. */
+	if (routing->num_routes != 1 ||
+	    !(routing->routes[0].flags & V4L2_SUBDEV_ROUTE_FL_ACTIVE))
+		return -EINVAL;
+
+	ret = v4l2_subdev_set_routing_with_fmt(sd, state, routing, &format);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int mipi_csis_set_routing(struct v4l2_subdev *sd,
+				 struct v4l2_subdev_state *state,
+				 enum v4l2_subdev_format_whence which,
+				 struct v4l2_subdev_krouting *routing)
+{
+	struct mipi_csis_device *csis = sd_to_mipi_csis_device(sd);
+
+	if (which == V4L2_SUBDEV_FORMAT_ACTIVE && csis->source.enabled_streams)
+		return -EBUSY;
+
+	return __mipi_csis_set_routing(sd, state, routing);
+}
+
 static int mipi_csis_enable_streams(struct v4l2_subdev *sd,
 				    struct v4l2_subdev_state *state,
 				    u32 pad, u64 streams_mask)
@@ -1240,22 +1286,22 @@ static int mipi_csis_disable_streams(struct v4l2_subdev *sd,
 static int mipi_csis_init_state(struct v4l2_subdev *sd,
 				struct v4l2_subdev_state *state)
 {
-	struct v4l2_subdev_format fmt = {
-		.pad = CSIS_PAD_SINK,
+	struct v4l2_subdev_route routes[] = {
+		{
+			.sink_pad = CSIS_PAD_SINK,
+			.sink_stream = 0,
+			.source_pad = CSIS_PAD_SOURCE,
+			.source_stream = 0,
+			.flags = V4L2_SUBDEV_ROUTE_FL_ACTIVE,
+		},
 	};
 
-	fmt.format.code = mipi_csis_formats[0].code;
-	fmt.format.width = MIPI_CSIS_DEF_PIX_WIDTH;
-	fmt.format.height = MIPI_CSIS_DEF_PIX_HEIGHT;
+	struct v4l2_subdev_krouting routing = {
+		.num_routes = ARRAY_SIZE(routes),
+		.routes = routes,
+	};
 
-	fmt.format.colorspace = V4L2_COLORSPACE_SMPTE170M;
-	fmt.format.xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(fmt.format.colorspace);
-	fmt.format.ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(fmt.format.colorspace);
-	fmt.format.quantization =
-		V4L2_MAP_QUANTIZATION_DEFAULT(false, fmt.format.colorspace,
-					      fmt.format.ycbcr_enc);
-
-	return mipi_csis_set_fmt(sd, state, &fmt);
+	return __mipi_csis_set_routing(sd, state, &routing);
 }
 
 static int mipi_csis_log_status(struct v4l2_subdev *sd)
@@ -1297,6 +1343,7 @@ static const struct v4l2_subdev_pad_ops mipi_csis_pad_ops = {
 	.get_fmt		= v4l2_subdev_get_fmt,
 	.set_fmt		= mipi_csis_set_fmt,
 	.get_frame_desc		= mipi_csis_get_frame_desc,
+	.set_routing		= mipi_csis_set_routing,
 	.enable_streams		= mipi_csis_enable_streams,
 	.disable_streams	= mipi_csis_disable_streams,
 };
-- 
Regards,

Laurent Pinchart

