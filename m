Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9B42FB0BF
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 01:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762480715; cv=none; b=Kp/FrX/ZJMZAJVNVKo1ti2fcSBMZN6K5/j48PyWEPM1bKytI7+1S8H7aitGZvy792n2RovhiWm6bEaeTU5bknz6QIjFonYRfG9s672TU+YYi4dKWoh4o6jgYdf/doL1QAMH4LI+xftWEDkpb9NLXszDCl/oqyMiZTDYG8k+nb2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762480715; c=relaxed/simple;
	bh=uG6W6EGVvynR2boS3SSnkyIPmPaeHbFuuSi3+WJXZak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V98QW+wBo7yD+vMVigDjQLwFqsPjDEYJKXp1FlYM3KeytzKRffHYCzLwUXENrv+smtN0oyt9VusPpo8JkYJL3K5Vt1YC+qPKogjwDHSXImnx0y+zCHDoyficxInLg9/BAgz4FIrrsvvMArH7EqZ/zYRcL735kIXPmxh+5OTBLSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Bg1RkcZ0; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Bg1RkcZ0"
Received: from pendragon.ideasonboard.com (82-203-161-95.bb.dnainternet.fi [82.203.161.95])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id A0B081AA6;
	Fri,  7 Nov 2025 02:56:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762480589;
	bh=uG6W6EGVvynR2boS3SSnkyIPmPaeHbFuuSi3+WJXZak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bg1RkcZ0d7iBNgYcrFMwEqfsvosEk4uR70arXpsjWuMhtLJGH9JgvsHk13+ikub4R
	 0PGEC3RC96xEgC4XVT2pkFe1xdkp/wADvKj//HO7mwzOmEUHHdWqMpGI/sl+7Xma7A
	 w2yyhvF4mNU8nmVtHSkKfT+N1sWgjXw3wJ62UUiY=
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
Subject: [PATCH v1 4/6] media: imx-mipi-csis: Group runtime parameters in structure
Date: Fri,  7 Nov 2025 03:58:11 +0200
Message-ID: <20251107015813.5834-5-laurent.pinchart@ideasonboard.com>
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

The mipi_csis_set_params() functions programs the hardware with a mix of
parameters computed earlier when starting streaming and stored in the
mipi_csis_device structure, and parameters retrieved from pad formats
passed to the function through the whole call stack.

Multi-channel support will require computing and applying more
parameters. To prepare for that, refactor the code and store all
parameters in a single mipi_csis_params structure, and pass it to
functions as appropriate to replace the other arguments.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/nxp/imx-mipi-csis.c | 72 +++++++++++++---------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-mipi-csis.c b/drivers/media/platform/nxp/imx-mipi-csis.c
index f4b19576a235..9dd264af181f 100644
--- a/drivers/media/platform/nxp/imx-mipi-csis.c
+++ b/drivers/media/platform/nxp/imx-mipi-csis.c
@@ -333,6 +333,19 @@ struct mipi_csis_info {
 	unsigned int num_clocks;
 };
 
+struct mipi_csis_channel_params {
+	unsigned int data_type;
+	unsigned int width;
+	unsigned int height;
+};
+
+struct mipi_csis_params {
+	u32 hs_settle;
+	u32 clk_settle;
+
+	struct mipi_csis_channel_params channels[MIPI_CSIS_MAX_CHANNELS];
+};
+
 struct mipi_csis_device {
 	struct device *dev;
 	void __iomem *regs;
@@ -355,8 +368,6 @@ struct mipi_csis_device {
 
 	struct v4l2_mbus_config_mipi_csi2 bus;
 	u32 clk_frequency;
-	u32 hs_settle;
-	u32 clk_settle;
 
 	spinlock_t slock;	/* Protect events */
 	struct mipi_csis_event events[MIPI_CSIS_NUM_EVENTS];
@@ -587,8 +598,7 @@ static void mipi_csis_system_enable(struct mipi_csis_device *csis, int on)
 }
 
 static void __mipi_csis_set_format(struct mipi_csis_device *csis,
-				   const struct v4l2_mbus_framefmt *format,
-				   const struct csis_pix_format *csis_fmt)
+				   const struct mipi_csis_channel_params *params)
 {
 	u32 val;
 
@@ -611,26 +621,36 @@ static void __mipi_csis_set_format(struct mipi_csis_device *csis,
 	 *
 	 * TODO: Verify which other formats require DUAL (or QUAD) modes.
 	 */
-	if (csis_fmt->data_type == MIPI_CSI2_DT_YUV422_8B)
+	if (params->data_type == MIPI_CSI2_DT_YUV422_8B)
 		val |= MIPI_CSIS_ISPCFG_PIXEL_MODE_DUAL;
 
-	val |= MIPI_CSIS_ISPCFG_DATAFORMAT(csis_fmt->data_type);
+	val |= MIPI_CSIS_ISPCFG_DATAFORMAT(params->data_type);
 	val |= MIPI_CSIS_ISPCFG_VIRTUAL_CHANNEL(0);
 
 	mipi_csis_write(csis, MIPI_CSIS_ISP_CONFIG_CH(0), val);
 
 	/* Pixel resolution */
 	mipi_csis_write(csis, MIPI_CSIS_ISP_RESOL_CH(0),
-			MIPI_CSIS_ISP_RESOL_VRESOL(format->height) |
-			MIPI_CSIS_ISP_RESOL_HRESOL(format->width));
+			MIPI_CSIS_ISP_RESOL_VRESOL(params->height) |
+			MIPI_CSIS_ISP_RESOL_HRESOL(params->width));
 }
 
 static int mipi_csis_calculate_params(struct mipi_csis_device *csis,
-				      const struct csis_pix_format *csis_fmt)
+				      const struct v4l2_subdev_state *state,
+				      struct mipi_csis_params *params)
 {
+	const struct v4l2_mbus_framefmt *format;
+	const struct csis_pix_format *csis_fmt;
 	s64 link_freq;
 	u32 lane_rate;
 
+	format = v4l2_subdev_state_get_format(state, CSIS_PAD_SINK);
+	csis_fmt = find_csis_format(format->code);
+
+	params->channels[0].data_type = csis_fmt->data_type;
+	params->channels[0].width = format->width;
+	params->channels[0].height = format->height;
+
 	/* Calculate the line rate from the pixel rate. */
 	link_freq = v4l2_get_link_freq(csis->source.pad, csis_fmt->width,
 				       csis->bus.num_data_lanes * 2);
@@ -653,30 +673,29 @@ static int mipi_csis_calculate_params(struct mipi_csis_device *csis,
 	 * (which is documented as corresponding to CSI-2 v0.87 to v1.00) until
 	 * we figure out how to compute it correctly.
 	 */
-	csis->hs_settle = (lane_rate - 5000000) / 45000000;
-	csis->clk_settle = 0;
+	params->hs_settle = (lane_rate - 5000000) / 45000000;
+	params->clk_settle = 0;
 
 	dev_dbg(csis->dev, "lane rate %u, Tclk_settle %u, Ths_settle %u\n",
-		lane_rate, csis->clk_settle, csis->hs_settle);
+		lane_rate, params->clk_settle, params->hs_settle);
 
 	if (csis->debug.hs_settle < 0xff) {
 		dev_dbg(csis->dev, "overriding Ths_settle with %u\n",
 			csis->debug.hs_settle);
-		csis->hs_settle = csis->debug.hs_settle;
+		params->hs_settle = csis->debug.hs_settle;
 	}
 
 	if (csis->debug.clk_settle < 4) {
 		dev_dbg(csis->dev, "overriding Tclk_settle with %u\n",
 			csis->debug.clk_settle);
-		csis->clk_settle = csis->debug.clk_settle;
+		params->clk_settle = csis->debug.clk_settle;
 	}
 
 	return 0;
 }
 
 static void mipi_csis_set_params(struct mipi_csis_device *csis,
-				 const struct v4l2_mbus_framefmt *format,
-				 const struct csis_pix_format *csis_fmt)
+				 const struct mipi_csis_params *params)
 {
 	int lanes = csis->bus.num_data_lanes;
 	u32 val;
@@ -692,11 +711,11 @@ static void mipi_csis_set_params(struct mipi_csis_device *csis,
 
 	mipi_csis_write(csis, MIPI_CSIS_CMN_CTRL, val);
 
-	__mipi_csis_set_format(csis, format, csis_fmt);
+	__mipi_csis_set_format(csis, &params->channels[0]);
 
 	mipi_csis_write(csis, MIPI_CSIS_DPHY_CMN_CTRL,
-			MIPI_CSIS_DPHY_CMN_CTRL_HSSETTLE(csis->hs_settle) |
-			MIPI_CSIS_DPHY_CMN_CTRL_CLKSETTLE(csis->clk_settle));
+			MIPI_CSIS_DPHY_CMN_CTRL_HSSETTLE(params->hs_settle) |
+			MIPI_CSIS_DPHY_CMN_CTRL_CLKSETTLE(params->clk_settle));
 
 	mipi_csis_write(csis, MIPI_CSIS_ISP_SYNC_CH(0),
 			MIPI_CSIS_ISP_SYNC_HSYNC_LINTV(0) |
@@ -771,11 +790,10 @@ static int mipi_csis_clk_get(struct mipi_csis_device *csis)
 }
 
 static void mipi_csis_start_stream(struct mipi_csis_device *csis,
-				   const struct v4l2_mbus_framefmt *format,
-				   const struct csis_pix_format *csis_fmt)
+				   const struct mipi_csis_params *params)
 {
 	mipi_csis_sw_reset(csis);
-	mipi_csis_set_params(csis, format, csis_fmt);
+	mipi_csis_set_params(csis, params);
 	mipi_csis_system_enable(csis, true);
 	mipi_csis_enable_interrupts(csis, true);
 }
@@ -1216,13 +1234,9 @@ static int mipi_csis_enable_streams(struct v4l2_subdev *sd,
 
 	/* Start the CSIS with the first stream. */
 	if (!csis->source.enabled_streams) {
-		const struct v4l2_mbus_framefmt *format;
-		const struct csis_pix_format *csis_fmt;
+		struct mipi_csis_params params;
 
-		format = v4l2_subdev_state_get_format(state, CSIS_PAD_SINK);
-		csis_fmt = find_csis_format(format->code);
-
-		ret = mipi_csis_calculate_params(csis, csis_fmt);
+		ret = mipi_csis_calculate_params(csis, state, &params);
 		if (ret)
 			return ret;
 
@@ -1232,7 +1246,7 @@ static int mipi_csis_enable_streams(struct v4l2_subdev *sd,
 		if (ret < 0)
 			return ret;
 
-		mipi_csis_start_stream(csis, format, csis_fmt);
+		mipi_csis_start_stream(csis, &params);
 	}
 
 	ret = v4l2_subdev_enable_streams(csis->source.sd,
-- 
Regards,

Laurent Pinchart

