Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA9F2FB0A4
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 01:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762480717; cv=none; b=rNikhRaMRmMdE8VFB2vOfLgoO1xRIYUxHxIlULTgW6Dh/4vgQVnKW/Lo1Yswber5HE8DGJkrfV9jaj7oYC0t03CyLFhsXcY6pNCYDlYgS+Asv0lV+JweVi/DBQhu4OU8NvGrIZ1PGD8i2Vvsz++MJ918kEjKbyT6M8l0edICM3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762480717; c=relaxed/simple;
	bh=0vLPsMfAzRK7VoF8LC6/vKTDFB4O+nqy22RI4H7uGzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6oDEYhsnsrbpHFsJlu8ClWyPZZcTR4xqdKHO/VycnUhpRfaSMWRw7IPRuOF1saGj21y2BdiMew+XnJErTZk3lqvNCT8uXtutfJqpv3XVHMV4nmOLoDvZv0Rus07vQvVc3tAvLHXa6nHchpjOLO/jXGiENRLru2Gv3ROBsof3KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Ypo1kN1H; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Ypo1kN1H"
Received: from pendragon.ideasonboard.com (82-203-161-95.bb.dnainternet.fi [82.203.161.95])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 4ECED1D33;
	Fri,  7 Nov 2025 02:56:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762480591;
	bh=0vLPsMfAzRK7VoF8LC6/vKTDFB4O+nqy22RI4H7uGzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ypo1kN1HpkBIKf8NTTFyJ+KROSjTMa9phIJg2geRItnx0fLTZ5rfKrqT4qO19QYlb
	 C7TKKW9hSEgHuH94ZyAuyEZqfp1fmvxsDfCFP2jas1pgC5mmBtzVlyiDIj8x2Gi2G6
	 GG4Xi5YFQTlgY/Apz3orXjc5wsZSiFT+4AnKAlxc=
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
Subject: [PATCH v1 5/6] media: imx-mipi-csis: Set all per-channel registers in one function
Date: Fri,  7 Nov 2025 03:58:12 +0200
Message-ID: <20251107015813.5834-6-laurent.pinchart@ideasonboard.com>
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

The __mipi_csis_set_format() function programs most of the per-channel
registers, with the exception of the MIPI_CSIS_ISP_SYNC_CH register. To
prepare for multi-channel support, move programming of that register to
the function, and rename it to mipi_csis_set_channel_params() to clearly
indicate its purpose.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/nxp/imx-mipi-csis.c | 23 +++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-mipi-csis.c b/drivers/media/platform/nxp/imx-mipi-csis.c
index 9dd264af181f..d8c11223ed0a 100644
--- a/drivers/media/platform/nxp/imx-mipi-csis.c
+++ b/drivers/media/platform/nxp/imx-mipi-csis.c
@@ -597,13 +597,14 @@ static void mipi_csis_system_enable(struct mipi_csis_device *csis, int on)
 	mipi_csis_write(csis, MIPI_CSIS_DPHY_CMN_CTRL, val);
 }
 
-static void __mipi_csis_set_format(struct mipi_csis_device *csis,
-				   const struct mipi_csis_channel_params *params)
+static void mipi_csis_set_channel_params(struct mipi_csis_device *csis,
+					 unsigned int channel,
+					 const struct mipi_csis_channel_params *params)
 {
 	u32 val;
 
 	/* Color format */
-	val = mipi_csis_read(csis, MIPI_CSIS_ISP_CONFIG_CH(0));
+	val = mipi_csis_read(csis, MIPI_CSIS_ISP_CONFIG_CH(channel));
 	val &= ~(MIPI_CSIS_ISPCFG_PARALLEL | MIPI_CSIS_ISPCFG_PIXEL_MODE_MASK |
 		 MIPI_CSIS_ISPCFG_DATAFORMAT_MASK |
 		 MIPI_CSIS_ISPCFG_VIRTUAL_CHANNEL_MASK);
@@ -627,10 +628,15 @@ static void __mipi_csis_set_format(struct mipi_csis_device *csis,
 	val |= MIPI_CSIS_ISPCFG_DATAFORMAT(params->data_type);
 	val |= MIPI_CSIS_ISPCFG_VIRTUAL_CHANNEL(0);
 
-	mipi_csis_write(csis, MIPI_CSIS_ISP_CONFIG_CH(0), val);
+	mipi_csis_write(csis, MIPI_CSIS_ISP_CONFIG_CH(channel), val);
+
+	mipi_csis_write(csis, MIPI_CSIS_ISP_SYNC_CH(channel),
+			MIPI_CSIS_ISP_SYNC_HSYNC_LINTV(0) |
+			MIPI_CSIS_ISP_SYNC_VSYNC_SINTV(0) |
+			MIPI_CSIS_ISP_SYNC_VSYNC_EINTV(0));
 
 	/* Pixel resolution */
-	mipi_csis_write(csis, MIPI_CSIS_ISP_RESOL_CH(0),
+	mipi_csis_write(csis, MIPI_CSIS_ISP_RESOL_CH(channel),
 			MIPI_CSIS_ISP_RESOL_VRESOL(params->height) |
 			MIPI_CSIS_ISP_RESOL_HRESOL(params->width));
 }
@@ -711,17 +717,12 @@ static void mipi_csis_set_params(struct mipi_csis_device *csis,
 
 	mipi_csis_write(csis, MIPI_CSIS_CMN_CTRL, val);
 
-	__mipi_csis_set_format(csis, &params->channels[0]);
+	mipi_csis_set_channel_params(csis, 0, &params->channels[0]);
 
 	mipi_csis_write(csis, MIPI_CSIS_DPHY_CMN_CTRL,
 			MIPI_CSIS_DPHY_CMN_CTRL_HSSETTLE(params->hs_settle) |
 			MIPI_CSIS_DPHY_CMN_CTRL_CLKSETTLE(params->clk_settle));
 
-	mipi_csis_write(csis, MIPI_CSIS_ISP_SYNC_CH(0),
-			MIPI_CSIS_ISP_SYNC_HSYNC_LINTV(0) |
-			MIPI_CSIS_ISP_SYNC_VSYNC_SINTV(0) |
-			MIPI_CSIS_ISP_SYNC_VSYNC_EINTV(0));
-
 	val = mipi_csis_read(csis, MIPI_CSIS_CLK_CTRL);
 	val |= MIPI_CSIS_CLK_CTRL_WCLK_SRC(0);
 	val |= MIPI_CSIS_CLK_CTRL_CLKGATE_TRAIL(0, 15);
-- 
Regards,

Laurent Pinchart

