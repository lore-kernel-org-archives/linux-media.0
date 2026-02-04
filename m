Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172E93EF0C3;
	Wed,  4 Feb 2026 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770204320; cv=none; b=e/XsAloMlFse0WK85C+j5Swvdmlb22tdlFwCUS5ky8pPtxKJbUjATpV9xbreygIv42nqWa/CDFkfuxdXAdxBwjpe0l40XbgjCjlqWErNZBVQc0+I/57rgnxVPWp9bYDMmjWUnVD3+HZQHhYPI0NVWZShcRyWv0NMLtFfdzZ2UII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770204320; c=relaxed/simple;
	bh=BN1rqD2UnDUl0GUeoH96i0K4YwyQWxp/kIksm/8/gh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjZ80efTKyijPuH36NN2v4mQe/dH3rY6zU0EuXFOtqy5YJPgvpIklnwV3ngxiXD7/pIjFWxweJT7Qza469iKUdTah1YHKU+Ge3HZR6PF9rGnvIDjhfMpIjz98tVlpc/HBxPqpGLqnvQXnLl6/HDmySIUdWXlL6Odd7GzTT+sItY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=SnyoIVet; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SnyoIVet"
Received: from t16.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B7F1F1337;
	Wed,  4 Feb 2026 12:24:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770204272;
	bh=BN1rqD2UnDUl0GUeoH96i0K4YwyQWxp/kIksm/8/gh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SnyoIVeti2D98FR9LQYR8dnmP+B0sto2MCJoSJfJcfthO3SVDwDpoBY2A2ldKGCUZ
	 XlduBL7e/IgT5lLUvErEGe5ofevcnQLkzNyCEq85ZXZ9zPe+4jtENkL8xEBXNC8yhs
	 GS2iVo2JLgEPVZfHylUzVxxAZuiR7SRLtXdg8XcY=
From: Isaac Scott <isaac.scott@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: dafna@fastmail.com,
	laurent.pinchart@ideasonboard.com,
	mchehab@kernel.org,
	heiko@sntech.de,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Isaac Scott <isaac.scott@ideasonboard.com>
Subject: [PATCH v1 2/6] media: rkisp1-isp: Add in_bypass flag for YUV bypass
Date: Wed,  4 Feb 2026 11:25:02 +0000
Message-ID: <20260204112506.3706049-3-isaac.scott@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204112506.3706049-1-isaac.scott@ideasonboard.com>
References: <20260204112506.3706049-1-isaac.scott@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rkisp1 features a 'bypass' mode for RAW and YUV formats. This
disables all ISP blocks, and makes the rkisp1 display input data from
the mipi csi receiver at the output, unmodified.

To determine whether we can activate bypass, we can detect whether both
the source and sink formats are YUV. If they are, we can set a new
in_bypass flag.

For YUV bypass, we should configure the ISP input to interpret incoming
H/VSYNC signals as data enable / disable. Add this.

Signed-off-by: Isaac Scott <isaac.scott@ideasonboard.com>
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-common.h | 1 +
 drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c    | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
index 5e6a4d5f6fd1..d90233e31ad3 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
@@ -532,6 +532,7 @@ struct rkisp1_device {
 	struct rkisp1_debug debug;
 	const struct rkisp1_info *info;
 	int irqs[RKISP1_NUM_IRQS];
+	bool in_bypass;
 	bool irqs_enabled;
 };
 
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
index 2311672cedb1..f636d738b7e8 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
@@ -212,6 +212,8 @@ static int rkisp1_config_isp(struct rkisp1_isp *isp,
 	const struct v4l2_mbus_framefmt *sink_frm;
 	const struct v4l2_rect *sink_crop;
 
+	rkisp1->in_bypass = false;
+
 	sink_frm = v4l2_subdev_state_get_format(sd_state,
 						RKISP1_ISP_PAD_SINK_VIDEO);
 	sink_crop = v4l2_subdev_state_get_crop(sd_state,
@@ -240,7 +242,10 @@ static int rkisp1_config_isp(struct rkisp1_isp *isp,
 		}
 	} else if (sink_fmt->pixel_enc == V4L2_PIXEL_ENC_YUV) {
 		acq_mult = 2;
-		if (mbus_type == V4L2_MBUS_CSI2_DPHY) {
+		if (src_fmt->pixel_enc == V4L2_PIXEL_ENC_YUV) {
+			isp_ctrl = RKISP1_CIF_ISP_CTRL_ISP_MODE_DATA_MODE;
+			rkisp1->in_bypass = true;
+		} else if (mbus_type == V4L2_MBUS_CSI2_DPHY) {
 			isp_ctrl = RKISP1_CIF_ISP_CTRL_ISP_MODE_ITU601;
 		} else {
 			if (mbus_type == V4L2_MBUS_BT656)
-- 
2.43.0

