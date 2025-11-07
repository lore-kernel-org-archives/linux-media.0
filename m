Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8012FB97A
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 01:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762480712; cv=none; b=hMxACnyIL705IXk4XViguBwQgtpJ5RuyHRmZn3JI+RG5Ot+/phqrAtJfO+N3KUcBuVm+nguTSwQrveLs+Wjb4/MYySq7djXOP9PpwLFQnHr7pcn1zdfRyF9c82ngFkuj1TdKwkX7qEXQ5Ub1CGce4BYO+KomuyCWGAIEzJijQHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762480712; c=relaxed/simple;
	bh=S/kflu1YlTkLdko5MRss86kACVuPGgH/NKUeSzY0q4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZjpTvgLKOvNMzTo81M+svcgOsjeMS9oti6xS4jb1mFmiSjwNP1pf9GSkfWX8+/83vw2VkTP1h3hPSjXBeOF59N6++zwMlq87PJ6gbIuDdeZNWbpNncuEUjnn/TB0sSyC8Rvdj38NkYeSkqdhTRsD4jUBdwrS4wQaWy28wUz2H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=lSUjzfIn; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lSUjzfIn"
Received: from pendragon.ideasonboard.com (82-203-161-95.bb.dnainternet.fi [82.203.161.95])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 4A2FC1849;
	Fri,  7 Nov 2025 02:56:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762480586;
	bh=S/kflu1YlTkLdko5MRss86kACVuPGgH/NKUeSzY0q4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lSUjzfInCIAWeChU9jkly4adYxvK2gIVhE8mHWIiAcCcr6H4Sq045T+fXnYpLDV+N
	 CJEEycoTsV92DN8NFuse6BfVcdomjq2B0KHbIvwK7btzEsnZlwvjkqiovsEssDofx2
	 9dtZdhqY9tIhx/WqoV6Gn9yIc+hGdkdAxZOQtUHo=
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
Subject: [PATCH v1 2/6] media: imx-mipi-csis: Switch to .enable_streams()
Date: Fri,  7 Nov 2025 03:58:09 +0200
Message-ID: <20251107015813.5834-3-laurent.pinchart@ideasonboard.com>
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

To prepare for multi-stream support, switch from the legacy .s_stream()
operation to the .enable_streams() and .disable_streams() operations.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/nxp/imx-mipi-csis.c | 146 ++++++++++++---------
 1 file changed, 87 insertions(+), 59 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-mipi-csis.c b/drivers/media/platform/nxp/imx-mipi-csis.c
index 42b1ec8eed96..f142e79acbcf 100644
--- a/drivers/media/platform/nxp/imx-mipi-csis.c
+++ b/drivers/media/platform/nxp/imx-mipi-csis.c
@@ -350,6 +350,7 @@ struct mipi_csis_device {
 	struct {
 		struct v4l2_subdev *sd;
 		const struct media_pad *pad;
+		u64 enabled_streams;
 	} source;
 
 	struct v4l2_mbus_config_mipi_csi2 bus;
@@ -1019,64 +1020,6 @@ static struct mipi_csis_device *sd_to_mipi_csis_device(struct v4l2_subdev *sdev)
 	return container_of(sdev, struct mipi_csis_device, sd);
 }
 
-static int mipi_csis_s_stream(struct v4l2_subdev *sd, int enable)
-{
-	struct mipi_csis_device *csis = sd_to_mipi_csis_device(sd);
-	const struct v4l2_mbus_framefmt *format;
-	const struct csis_pix_format *csis_fmt;
-	struct v4l2_subdev_state *state;
-	int ret;
-
-	if (!enable) {
-		v4l2_subdev_disable_streams(csis->source.sd,
-					    csis->source.pad->index, BIT(0));
-
-		mipi_csis_stop_stream(csis);
-		if (csis->debug.enable)
-			mipi_csis_log_counters(csis, true);
-
-		pm_runtime_put(csis->dev);
-
-		return 0;
-	}
-
-	state = v4l2_subdev_lock_and_get_active_state(sd);
-
-	format = v4l2_subdev_state_get_format(state, CSIS_PAD_SINK);
-	csis_fmt = find_csis_format(format->code);
-
-	ret = mipi_csis_calculate_params(csis, csis_fmt);
-	if (ret < 0)
-		goto err_unlock;
-
-	mipi_csis_clear_counters(csis);
-
-	ret = pm_runtime_resume_and_get(csis->dev);
-	if (ret < 0)
-		goto err_unlock;
-
-	mipi_csis_start_stream(csis, format, csis_fmt);
-
-	ret = v4l2_subdev_enable_streams(csis->source.sd,
-					 csis->source.pad->index, BIT(0));
-	if (ret < 0)
-		goto err_stop;
-
-	mipi_csis_log_counters(csis, true);
-
-	v4l2_subdev_unlock_state(state);
-
-	return 0;
-
-err_stop:
-	mipi_csis_stop_stream(csis);
-	pm_runtime_put(csis->dev);
-err_unlock:
-	v4l2_subdev_unlock_state(state);
-
-	return ret;
-}
-
 static int mipi_csis_enum_mbus_code(struct v4l2_subdev *sd,
 				    struct v4l2_subdev_state *state,
 				    struct v4l2_subdev_mbus_code_enum *code)
@@ -1211,6 +1154,89 @@ static int mipi_csis_get_frame_desc(struct v4l2_subdev *sd, unsigned int pad,
 	return 0;
 }
 
+static int mipi_csis_enable_streams(struct v4l2_subdev *sd,
+				    struct v4l2_subdev_state *state,
+				    u32 pad, u64 streams_mask)
+{
+	struct mipi_csis_device *csis = sd_to_mipi_csis_device(sd);
+	u64 sink_streams;
+	int ret;
+
+	sink_streams = v4l2_subdev_state_xlate_streams(state, CSIS_PAD_SOURCE,
+						       CSIS_PAD_SINK,
+						       &streams_mask);
+	if (!sink_streams || !streams_mask)
+		return -EINVAL;
+
+	/* Start the CSIS with the first stream. */
+	if (!csis->source.enabled_streams) {
+		const struct v4l2_mbus_framefmt *format;
+		const struct csis_pix_format *csis_fmt;
+
+		format = v4l2_subdev_state_get_format(state, CSIS_PAD_SINK);
+		csis_fmt = find_csis_format(format->code);
+
+		ret = mipi_csis_calculate_params(csis, csis_fmt);
+		if (ret)
+			return ret;
+
+		mipi_csis_clear_counters(csis);
+
+		ret = pm_runtime_resume_and_get(csis->dev);
+		if (ret < 0)
+			return ret;
+
+		mipi_csis_start_stream(csis, format, csis_fmt);
+	}
+
+	ret = v4l2_subdev_enable_streams(csis->source.sd,
+					 csis->source.pad->index, sink_streams);
+	if (ret) {
+		if (!csis->source.enabled_streams) {
+			mipi_csis_stop_stream(csis);
+			pm_runtime_put(csis->dev);
+		}
+
+		return ret;
+	}
+
+	mipi_csis_log_counters(csis, true);
+
+	csis->source.enabled_streams |= streams_mask;
+
+	return 0;
+}
+
+static int mipi_csis_disable_streams(struct v4l2_subdev *sd,
+				     struct v4l2_subdev_state *state,
+				     u32 pad, u64 streams_mask)
+{
+	struct mipi_csis_device *csis = sd_to_mipi_csis_device(sd);
+	u64 sink_streams;
+
+	sink_streams = v4l2_subdev_state_xlate_streams(state, CSIS_PAD_SOURCE,
+						       CSIS_PAD_SINK,
+						       &streams_mask);
+	if (!sink_streams || !streams_mask)
+		return -EINVAL;
+
+	v4l2_subdev_disable_streams(csis->source.sd,
+				    csis->source.pad->index, sink_streams);
+
+	csis->source.enabled_streams &= ~streams_mask;
+
+	/* Stop the CSIS with the last stream. */
+	if (!csis->source.enabled_streams) {
+		mipi_csis_stop_stream(csis);
+		pm_runtime_put(csis->dev);
+
+		if (csis->debug.enable)
+			mipi_csis_log_counters(csis, true);
+	}
+
+	return 0;
+}
+
 static int mipi_csis_init_state(struct v4l2_subdev *sd,
 				struct v4l2_subdev_state *state)
 {
@@ -1263,7 +1289,7 @@ static const struct v4l2_subdev_core_ops mipi_csis_core_ops = {
 };
 
 static const struct v4l2_subdev_video_ops mipi_csis_video_ops = {
-	.s_stream	= mipi_csis_s_stream,
+	.s_stream		= v4l2_subdev_s_stream_helper,
 };
 
 static const struct v4l2_subdev_pad_ops mipi_csis_pad_ops = {
@@ -1271,6 +1297,8 @@ static const struct v4l2_subdev_pad_ops mipi_csis_pad_ops = {
 	.get_fmt		= v4l2_subdev_get_fmt,
 	.set_fmt		= mipi_csis_set_fmt,
 	.get_frame_desc		= mipi_csis_get_frame_desc,
+	.enable_streams		= mipi_csis_enable_streams,
+	.disable_streams	= mipi_csis_disable_streams,
 };
 
 static const struct v4l2_subdev_ops mipi_csis_subdev_ops = {
-- 
Regards,

Laurent Pinchart

