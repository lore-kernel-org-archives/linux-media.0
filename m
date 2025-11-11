Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119CE36C585;
	Tue, 11 Nov 2025 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877789; cv=none; b=Ss0XvITux6UQT6Ag7prClorhw3MAC+j9yYv6xZ2Cehuw5mpA0t00Hlv1M3rZXVEpDoRt9oIoZx9loI2JTf4wZanpR3o2/UBA5m3GWVuRVjH3bHrzYPDP73kRs32jCNDdm112GJ8tuNKD3r9EhUIsOtY9BHPSrOyhubePnzWo4Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877789; c=relaxed/simple;
	bh=cTyl9DFfAu/dbpAG5WM+M+mb2gQCMDFd0XKNEogrbKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QhcIxR4dUW8d1d/+J4/r20dOZih6/yR2H5gI1jbycEgraCPLd3GzHZWxoJk/WsNcVsWQkUEe38KHDfmVa2C0/ZxNaK+j4I+P8GEMxJBQDNR/lxxQNGjqv+18PUvzkbCuA70jBhKZm/g0TByKwRnTLw5LB7dIaXx7utXJpxwAceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=e3pfBqLX; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="e3pfBqLX"
Received: from [127.0.1.1] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3853E1F17;
	Tue, 11 Nov 2025 17:14:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762877653;
	bh=cTyl9DFfAu/dbpAG5WM+M+mb2gQCMDFd0XKNEogrbKU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e3pfBqLXKhNJjCPLuRSVd+6YkVcjRXXD6JDLwsy92Dzesev8YqiOVNDcwL6k0v0dP
	 EbW1fl2YPqdHplmdEPYZp8tGBGLnIQwAAMXTxVvaI9FQRuOVqUTKfBlAGWXyOu3bdb
	 Kp1ay0RwtwvHiujUkSKDXhjgCryPQWlxp7XLSPEk=
From: Daniel Scally <dan.scally@ideasonboard.com>
Date: Tue, 11 Nov 2025 16:15:51 +0000
Subject: [PATCH v13 07/15] MAINTAINERS: Add entry for mali-c55 driver
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-c55-v13-7-3dc581355e3a@ideasonboard.com>
References: <20251111-c55-v13-0-3dc581355e3a@ideasonboard.com>
In-Reply-To: <20251111-c55-v13-0-3dc581355e3a@ideasonboard.com>
To: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
Cc: Anthony.McGivern@arm.com, jacopo.mondi@ideasonboard.com, 
 nayden.kanchev@arm.com, robh+dt@kernel.org, mchehab@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 jerome.forissier@linaro.org, kieran.bingham@ideasonboard.com, 
 laurent.pinchart@ideasonboard.com, dan.scally@ideasonboard.com, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830;
 i=dan.scally@ideasonboard.com; h=from:subject:message-id;
 bh=cTyl9DFfAu/dbpAG5WM+M+mb2gQCMDFd0XKNEogrbKU=;
 b=owEBbQKS/ZANAwAKAchJV3psRXUyAcsmYgBpE2FDiMDD6RH36rHYlbsFPrH+2+ma/QzOg/dx1
 hs0EHXNkLKJAjMEAAEKAB0WIQQqyuwyDnZdb+mxmm/ISVd6bEV1MgUCaRNhQwAKCRDISVd6bEV1
 MioDD/9keUujPevWBwD8RVMqfkAq69iTKVVkl1H0G6ijnV20+uEr0BxiTMu1+sxpcGsuDPdn5f6
 /+3HNI8lGikyHWl7z2M+x+/4ok6vvhXKmMUl+PYBOoYXG74OpKamjYNu+CTgsdYSUsto1GlTDdG
 fs2TTFebi8WdksQCYKGMapsGS3MhqtcKRP/GBcvSZwXv1N0YjajjlP5zqRTX0RbXiMCecn/BvOX
 7w0cCfUZMKP5unI71yGdBb4xERAUajjNQ+6zJ8NO+MQtwOkSukdoq9nx6gxXZ0qsSxBYU5BWIUJ
 wi1rS078IGBrpLLPYkuQnPNdXoRJBN2lBV27RQxDjOXZmBI8Zp77mUZ/BYcm6nS9zMukzhS9epE
 4Tu0neqBLnzpmguEERvt2QeDKAD6wHnQSLCzSuUQ4IdIuPPIz+LlQvk1kJOBO5sDmgKRd60d3U0
 swaS8aopzqPUgpS9sf+rVYNsBTOwUV1didfe1Xoao57PZLd34cYbJswtsYnTELPaMH9mxPU4ZWO
 Dr+LUkVr+trHymSTzqHAC+i2fYqMaPJIr6IRRlrHc7vPyxCKd4mHGGEsMT9guKYIU8gWEkNfo33
 f0Ns4nq3G6FyAc2knuKnKEZNsPJWeEV/yJ9kil6W+0zSwayv0nlCARESSTFgV9zIFigAJNGV3H3
 9mJo4VUNlYXqTAA==
X-Developer-Key: i=dan.scally@ideasonboard.com; a=openpgp;
 fpr=EEC699ACA1B7CB5D31330C0BBD501C2A3546CCF6

Add a MAINTAINERS entry for the mali-c55 driver and its associated
documentation.

Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Co-developed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Daniel Scally <dan.scally@ideasonboard.com>
---
Changes in v12:

        - None

Changes in v11:

        - None

Changes in v10:

	- None

Changes in v9:

	- Added a File line for
	  Documentation/userspace-api/media/drivers/mali-c55.rst

Changes in v8:

	- None

Changes in v7:

	- None

Changes in v6:

	- None

Changes in v5:

	- None

Changes in v4:
	- None

Changes in v3:

	- none

Changes in v2:

	- none
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa379a0c5af49c0fce3de8135ae0471ac15540c8..ead49648bdaa4eb6fa8b8d6d82d0a370d8dc97ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2105,6 +2105,18 @@ F:	drivers/gpu/drm/ci/xfails/panfrost*
 F:	drivers/gpu/drm/panfrost/
 F:	include/uapi/drm/panfrost_drm.h
 
+ARM MALI-C55 ISP DRIVER
+M:	Daniel Scally <dan.scally@ideasonboard.com>
+M:	Jacopo Mondi <jacopo.mondi@ideasonboard.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/admin-guide/media/mali-c55-graph.dot
+F:	Documentation/admin-guide/media/mali-c55.rst
+F:	Documentation/devicetree/bindings/media/arm,mali-c55.yaml
+F:	Documentation/userspace-api/media/drivers/mali-c55.rst
+F:	drivers/media/platform/arm/mali-c55/
+
 ARM MALI PANTHOR DRM DRIVER
 M:	Boris Brezillon <boris.brezillon@collabora.com>
 M:	Steven Price <steven.price@arm.com>

-- 
2.43.0

