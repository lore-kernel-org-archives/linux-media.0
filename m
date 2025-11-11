Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1DD3730C3;
	Tue, 11 Nov 2025 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877798; cv=none; b=neP+7C6r+YDNg6EcqV76BrkiNe6zA546qlduXuoSa89cJ75YIvGcSiVWNLZrhGUUW0PgVg3UqJfYv26hwYnCXQEMS90PWO+LUFID5XirkPoNpQI3Q8D+UbA+ANiGKwe3VA/dxtM3ZXMR5w19Ope7N0yu2R9e6VKJEAmPxvr97Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877798; c=relaxed/simple;
	bh=v2X7VK7nM2bGEb+ow9XfrpJWYDLuHQovjQyKVJftHhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c8rX2sYtRcuuAOJdh68EzKDM4LF7wXMJuzrKwRO/PewjAveEJvcSDRsRAj58p6IRoebGXYFqtinCi4yfnv9IkYbSOLZhismCWZl5gx8fJa+VKlgLc+ji1KG3qf3bFAE50tj1TnZDH+I+j1ONfqR2y1St24aTKZhNRz17uYE31Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=AMjSnC8z; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="AMjSnC8z"
Received: from [127.0.1.1] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 403EB20E3;
	Tue, 11 Nov 2025 17:14:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762877657;
	bh=v2X7VK7nM2bGEb+ow9XfrpJWYDLuHQovjQyKVJftHhs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AMjSnC8zq2TQYpiy/HzbpiH2r9id5V/P+NQe11bpPEvxHzbKPWS30aOx8CQYck0Ui
	 yIOw2b3DIXzq20tu1L3NyFqD/y9j1a7Qk5KL9XMFjXcHKrGh5cerYZ7NwnLQrohpIJ
	 UoMY8P+xu9pm9tKwMhylu8/6eiHeWKeb49EBuvfc=
From: Daniel Scally <dan.scally@ideasonboard.com>
Date: Tue, 11 Nov 2025 16:15:56 +0000
Subject: [PATCH v13 12/15] media: mali-c55: Add image formats for Mali-C55
 parameters buffer
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-c55-v13-12-3dc581355e3a@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2363;
 i=dan.scally@ideasonboard.com; h=from:subject:message-id;
 bh=PrxszCZi58ifsOIXdqFtQE1S0MX4/MfscuzVz5Jzg3o=;
 b=owEBbQKS/ZANAwAKAchJV3psRXUyAcsmYgBpE2FEe9hoiyiZaLPKtVj3V9GAGLK9gr2m3l44i
 elIS7lPCqqJAjMEAAEKAB0WIQQqyuwyDnZdb+mxmm/ISVd6bEV1MgUCaRNhRAAKCRDISVd6bEV1
 MnwjEACDjThQz+zLzbznf6zvNi03vjHrSYBpa+pA57HdKtP4l7/vT1kcKPME7l5xcR4lVrpd5cA
 4RwaguuiWebAOjCpxMZbEu8NAZA5IeQS5/UMxSFAEEMm93BR4vIyumwQDiCbgBHGXE/tP50xxkP
 YMxoBYfca0UYGdigcKGaFKCdWfpztZw03zbA7r8u1GCqia0C4xr+ZP9Xpq/IEACUFJnfiiFil8t
 amAHZ2j2CQMRWNgzxia3nGz97VBdoMTqEU+y10gu5bzmTgwWGpXRTnpv3tnL57Ynfz4F7JRNZOq
 Fs8AO2tk2SEXn+fQQDyeACHUpyWOAGQG8E9iWp7OZYZSxXj2as2h6/0A2b/kRJ5iRzSCtHHStZN
 q8P3mJHR2D5lzwIl8Jq3n4I8N8E22ryjpXEZO1+q9FdK6K9TFPjZqp/bR5lTjqJeGw8HSWu1tSH
 gyiVT2+9sM8gEP6FEv0TB2m/TWsAPKR5LG/fRD20gHPi1qUUB6JB4tU3QFxM6fCXIbqP/dCjDah
 NjsCyBRaRHVKqNRCwxbXuTAyvUFMo4F6aS4h3mwEzQEFMrnO1mKGFQbvDUH5XbiJ4JwLAeW9t1Z
 NICyD2l+ujUQ8GPR1QzOt/X3azj80B7eQjBdmPUdeE5rtT37F1QINtga1lQRSpmvmuF7mplRLGA
 jOxmD6lQSvr0X+w==
X-Developer-Key: i=dan.scally@ideasonboard.com; a=openpgp;
 fpr=EEC699ACA1B7CB5D31330C0BBD501C2A3546CCF6

From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

Add a new V4L2 meta format code for the Mali-C55 parameters.

Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Nayden Kanchev  <nayden.kanchev@arm.com>
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

	- None

Changes in v8:

	- None

Changes in v7:

	- None

Changes in v6:

	- None

Changes in v5:

	- New patch
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
 include/uapi/linux/videodev2.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index bfab29938b8f43f3224e4bc794c21eb5b6e368a2..98512ea4cc5b9d725e1851af2ed38df85bb4fa8c 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1469,6 +1469,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_META_FMT_RK_ISP1_EXT_PARAMS:	descr = "Rockchip ISP1 Ext 3A Params"; break;
 	case V4L2_META_FMT_C3ISP_PARAMS:	descr = "Amlogic C3 ISP Parameters"; break;
 	case V4L2_META_FMT_C3ISP_STATS:		descr = "Amlogic C3 ISP Statistics"; break;
+	case V4L2_META_FMT_MALI_C55_PARAMS:	descr = "ARM Mali-C55 ISP Parameters"; break;
 	case V4L2_META_FMT_MALI_C55_STATS:	descr = "ARM Mali-C55 ISP 3A Statistics"; break;
 	case V4L2_PIX_FMT_NV12_8L128:	descr = "NV12 (8x128 Linear)"; break;
 	case V4L2_PIX_FMT_NV12M_8L128:	descr = "NV12M (8x128 Linear)"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index cba4b131166773ae0d52c00de6e1c304bd08573a..add08188f06890182a5c399a223c1ab0a546cae1 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -885,6 +885,7 @@ struct v4l2_pix_format {
 #define V4L2_META_FMT_RPI_FE_STATS	v4l2_fourcc('R', 'P', 'F', 'S') /* PiSP FE stats */
 
 /* Vendor specific - used for Arm Mali-C55 ISP */
+#define V4L2_META_FMT_MALI_C55_PARAMS	v4l2_fourcc('C', '5', '5', 'P') /* ARM Mali-C55 Parameters */
 #define V4L2_META_FMT_MALI_C55_STATS	v4l2_fourcc('C', '5', '5', 'S') /* ARM Mali-C55 3A Statistics */
 
 #ifdef __KERNEL__

-- 
2.43.0

