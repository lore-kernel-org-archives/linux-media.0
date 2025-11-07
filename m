Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E882FB0B1
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 01:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762480710; cv=none; b=e52zQQn69ziOPjwgPtFsfMa8XNjKkkns0LVMTBIsPFiVhs/GqXHH/qMQYRw1lD0cY8RTvOIpAUeSrDZt2yaFcMYJJ+eE6tj3AbZD7/t09KcQ/+6lOqTkMCSiViMxEv5JErVv8Vq/bFy2W9rdLG5tbB/PMPVuzgf5ETw4+GLdpVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762480710; c=relaxed/simple;
	bh=uH2x0vf8EbOBq0eDnQOUzx+KZyWnycPYiaqoQtihubg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mm3kRXhUnpcBzp0Aupf2+qHtzeTLZnVo2HnBdlHhbpoUuMteB+6gP1d/elbfjug8bTOqWumLHrYMr2RVsNmeXoB9HwXgw2hMWYVZ1czMm5lU9UhFOW186rf7ijfQzP4YgX1Z8qw8LFN7+MtFCq9nNtMsNxzqO7oNIIU9xU4a4fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ZdthZbof; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZdthZbof"
Received: from pendragon.ideasonboard.com (82-203-161-95.bb.dnainternet.fi [82.203.161.95])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 4409D16AE;
	Fri,  7 Nov 2025 02:56:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762480584;
	bh=uH2x0vf8EbOBq0eDnQOUzx+KZyWnycPYiaqoQtihubg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZdthZbofQTyNprdG2FKNw/3qbe6Ozu/7xtZTvfVBhIB0BREBPoVNjmRKDwyvXHRZW
	 Qk9fcwH8k7vJGh6XdNF/HOrgOJ1QUu9n2TWv1hr94ZCRFA1IgVnpm/zPMC2ujanpKZ
	 5DfMGt3eo3E7M3/mG6lOALZXZLXPkHjjLP5aLxpk=
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
Subject: [PATCH v1 1/6] media: imx-mipi-csis: Add VC-related register fields
Date: Fri,  7 Nov 2025 03:58:08 +0200
Message-ID: <20251107015813.5834-2-laurent.pinchart@ideasonboard.com>
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

The CMN_CTRL and ISPCFG registers have fiels related to virtual channel
handling. In CMN_CTRL, the INTERLEAVE_MODE field is 2 bits wide, and
controls filtering by DT, VC or both. The VC number is then set in the
ISPCFG.VIRTUAL_CHANNEL field.

Expand the definition of the register macros to support those features,
and set the VC ID to 0 explicitly instead of relying on the default
register value. This prepares for VC filtering but does not modify the
driver's behaviour.

While at it, use GENMASK in the last few register mask macros that don't
use it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/nxp/imx-mipi-csis.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-mipi-csis.c b/drivers/media/platform/nxp/imx-mipi-csis.c
index d5de7854f579..42b1ec8eed96 100644
--- a/drivers/media/platform/nxp/imx-mipi-csis.c
+++ b/drivers/media/platform/nxp/imx-mipi-csis.c
@@ -55,7 +55,11 @@
 /* CSIS common control */
 #define MIPI_CSIS_CMN_CTRL			0x04
 #define MIPI_CSIS_CMN_CTRL_UPDATE_SHADOW(n)	BIT((n) + 16)
-#define MIPI_CSIS_CMN_CTRL_INTERLEAVE_MODE_DT	BIT(10)
+#define MIPI_CSIS_CMN_CTRL_INTERLEAVE_MODE_NONE	(0 << 10)
+#define MIPI_CSIS_CMN_CTRL_INTERLEAVE_MODE_DT	(1 << 10)
+#define MIPI_CSIS_CMN_CTRL_INTERLEAVE_MODE_VC	(2 << 10)
+#define MIPI_CSIS_CMN_CTRL_INTERLEAVE_MODE_VCDT	(3 << 10)
+#define MIPI_CSIS_CMN_CTRL_INTERLEAVE_MODE_MASK	GENMASK(11, 10)
 #define MIPI_CSIS_CMN_CTRL_LANE_NUMBER(n)	((n) << 8)
 #define MIPI_CSIS_CMN_CTRL_LANE_NUMBER_MASK	GENMASK(9, 8)
 #define MIPI_CSIS_CMN_CTRL_UPDATE_SHADOW_CTRL	BIT(2)
@@ -179,6 +183,8 @@
 #define MIPI_CSIS_ISPCFG_PARALLEL		BIT(11)
 #define MIPI_CSIS_ISPCFG_DATAFORMAT(fmt)	((fmt) << 2)
 #define MIPI_CSIS_ISPCFG_DATAFORMAT_MASK	GENMASK(7, 2)
+#define MIPI_CSIS_ISPCFG_VIRTUAL_CHANNEL(vc)	((vc) << 0)
+#define MIPI_CSIS_ISPCFG_VIRTUAL_CHANNEL_MASK	GENMASK(1, 0)
 
 /* ISP Image Resolution register */
 #define MIPI_CSIS_ISP_RESOL_CH(n)		(0x44 + (n) * 0x10)
@@ -588,7 +594,8 @@ static void __mipi_csis_set_format(struct mipi_csis_device *csis,
 	/* Color format */
 	val = mipi_csis_read(csis, MIPI_CSIS_ISP_CONFIG_CH(0));
 	val &= ~(MIPI_CSIS_ISPCFG_PARALLEL | MIPI_CSIS_ISPCFG_PIXEL_MODE_MASK |
-		 MIPI_CSIS_ISPCFG_DATAFORMAT_MASK);
+		 MIPI_CSIS_ISPCFG_DATAFORMAT_MASK |
+		 MIPI_CSIS_ISPCFG_VIRTUAL_CHANNEL_MASK);
 
 	/*
 	 * YUV 4:2:2 can be transferred with 8 or 16 bits per clock sample
@@ -607,6 +614,8 @@ static void __mipi_csis_set_format(struct mipi_csis_device *csis,
 		val |= MIPI_CSIS_ISPCFG_PIXEL_MODE_DUAL;
 
 	val |= MIPI_CSIS_ISPCFG_DATAFORMAT(csis_fmt->data_type);
+	val |= MIPI_CSIS_ISPCFG_VIRTUAL_CHANNEL(0);
+
 	mipi_csis_write(csis, MIPI_CSIS_ISP_CONFIG_CH(0), val);
 
 	/* Pixel resolution */
@@ -672,10 +681,14 @@ static void mipi_csis_set_params(struct mipi_csis_device *csis,
 	u32 val;
 
 	val = mipi_csis_read(csis, MIPI_CSIS_CMN_CTRL);
-	val &= ~MIPI_CSIS_CMN_CTRL_LANE_NUMBER_MASK;
+	val &= ~(MIPI_CSIS_CMN_CTRL_LANE_NUMBER_MASK |
+		 MIPI_CSIS_CMN_CTRL_INTERLEAVE_MODE_MASK);
+
 	val |= MIPI_CSIS_CMN_CTRL_LANE_NUMBER(lanes - 1);
+
 	if (csis->info->version == MIPI_CSIS_V3_3)
 		val |= MIPI_CSIS_CMN_CTRL_INTERLEAVE_MODE_DT;
+
 	mipi_csis_write(csis, MIPI_CSIS_CMN_CTRL, val);
 
 	__mipi_csis_set_format(csis, format, csis_fmt);
-- 
Regards,

Laurent Pinchart

