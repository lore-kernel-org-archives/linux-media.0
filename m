Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606BD36C595;
	Tue, 11 Nov 2025 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877791; cv=none; b=CFwRWsq4OFPhjsdZc6393kj0fwXbAznG4vIWsaSm6xnEC3vDK4o2+xSCy+yCryXjVZz9RuDKJeKyL+Tfs3+CTGkLL4cVlFdlp3OrO8forZA5t63W752e5GCaBoCMcGXbJHva8GD/TAAjq7mjkTJy05Y0KiGOGD6CL39E64oYgdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877791; c=relaxed/simple;
	bh=CzpGklnvEveNZ32xlH2FueSqnRlwcvM0qaALq3kE6Bg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iv2ymYVv71RXIiHtkFssCDprGvPina5f6oEtys9ZngoFKg7OOQE4L55dB0syiUkQayR5Nxj3iN2Y94+ngyWbOhrZhz6f9JKmG3V2SY/hQZq+uRSV5zVlKjDpkaUVSXzQeMcD6EGKL3sMwSueEtICa4kX6aHcsmZRe/ara7NcF60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Bz/XQmR4; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Bz/XQmR4"
Received: from [127.0.1.1] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id F3AA71FDD;
	Tue, 11 Nov 2025 17:14:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762877654;
	bh=CzpGklnvEveNZ32xlH2FueSqnRlwcvM0qaALq3kE6Bg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Bz/XQmR4jBFY5o8BxLvHHqWxEjHzAdpy6ynjtGirqSwJ1cd1dIzEMjvI44CERKPsO
	 GiWhm3KzgXFDkcW+Qtwi5uh2MVVgF53yeXQk6DyDB8V714pnlu/PIogYykdIw4jJnw
	 xbg4NEL5QEPOrvA+HWeKmsuNYbbmTlqAzKXAJ5pQ=
From: Daniel Scally <dan.scally@ideasonboard.com>
Date: Tue, 11 Nov 2025 16:15:52 +0000
Subject: [PATCH v13 08/15] media: Add MALI_C55_3A_STATS meta format
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-c55-v13-8-3dc581355e3a@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2544;
 i=dan.scally@ideasonboard.com; h=from:subject:message-id;
 bh=CzpGklnvEveNZ32xlH2FueSqnRlwcvM0qaALq3kE6Bg=;
 b=owEBbQKS/ZANAwAKAchJV3psRXUyAcsmYgBpE2FDSkkt+cJhumgIEYCfySm74dPPoHtJUj068
 fYrqYc4r3qJAjMEAAEKAB0WIQQqyuwyDnZdb+mxmm/ISVd6bEV1MgUCaRNhQwAKCRDISVd6bEV1
 MpkvD/43vGsqYxOOsFbScihNbXpQNFocr5e55pZ9nD+48/p8xOTFVz2Q35K4n6bHBKOZqlmbuBY
 ChqhAeDe6qD8JsutWA6LoRTQ5czKjgZR2LTXc+kSGpuJ9J1PK2rGX9eOJI4ESdUXGRPRIWy0Inl
 rjbXIOAMpPU5KfZ3g4n1Hvecg9EAfp0KZO9R12axSiHUcGSnL23eI7IQhvkOcta39R2UB6TDw+z
 /mHj/AT5P4lodvwhD+NItP1SXaSU2LiWpXQLnCFwnhRmOhaWf+xBC6DcxuLd4Bil5rp+Mhnn9sm
 HAZHf8352U/d+ri3qaUie/8Ff6frbye0RaHSnqG/r3uxjrPKJdagRC8l55wJGdz3Y6v6w6khG8o
 CxU/QHkVMDKu25IFBcJuUo2GkNT0nuvXZa6mlCssksN+4Eot6+tw5Q3PQbtVrKgl9cTE3E7z3WZ
 4Bvtn3kQLZtMJwikCUCnQ5nz2VLqKxwFWyRBS6yPQ/Dufmoc923h4DU1DesGFKpDo3ZjL5a/yR+
 TXzlhI1KuEdH3l5mEZPnACusc2f54jqmYgieqPo4ZjiOM0rTXNOBa1XJ4nNHmrt9+jtfG8IpBf0
 iL0GYeZ4mQoXIrCo9pW7VjCmrVOTKYYUZKNAWcVguWLer//cIQlX8yoxZeM9/wP6KZ3ZMfZ14Bx
 JVH4JUG2hxJQ9Rw==
X-Developer-Key: i=dan.scally@ideasonboard.com; a=openpgp;
 fpr=EEC699ACA1B7CB5D31330C0BBD501C2A3546CCF6

Add a new meta format for the Mali-C55 ISP's 3A Statistics along
with a new descriptor entry.

Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Nayden Kanchev  <nayden.kanchev@arm.com>
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

	- None

Changes in v8:

	- None

Changes in v7:

	- None

Changes in v6:

	- New patch

Changes in v5:

	- New patch
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
 include/uapi/linux/videodev2.h       | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 01cf52c3ea33e1a01e1b306036ba4e57ef5c95d0..bfab29938b8f43f3224e4bc794c21eb5b6e368a2 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1469,6 +1469,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_META_FMT_RK_ISP1_EXT_PARAMS:	descr = "Rockchip ISP1 Ext 3A Params"; break;
 	case V4L2_META_FMT_C3ISP_PARAMS:	descr = "Amlogic C3 ISP Parameters"; break;
 	case V4L2_META_FMT_C3ISP_STATS:		descr = "Amlogic C3 ISP Statistics"; break;
+	case V4L2_META_FMT_MALI_C55_STATS:	descr = "ARM Mali-C55 ISP 3A Statistics"; break;
 	case V4L2_PIX_FMT_NV12_8L128:	descr = "NV12 (8x128 Linear)"; break;
 	case V4L2_PIX_FMT_NV12M_8L128:	descr = "NV12M (8x128 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_10BE_8L128:	descr = "10-bit NV12 (8x128 Linear, BE)"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index becd08fdbddb857f8f2bf205d2164dc6e20e80b2..cba4b131166773ae0d52c00de6e1c304bd08573a 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -884,6 +884,9 @@ struct v4l2_pix_format {
 #define V4L2_META_FMT_RPI_FE_CFG	v4l2_fourcc('R', 'P', 'F', 'C') /* PiSP FE configuration */
 #define V4L2_META_FMT_RPI_FE_STATS	v4l2_fourcc('R', 'P', 'F', 'S') /* PiSP FE stats */
 
+/* Vendor specific - used for Arm Mali-C55 ISP */
+#define V4L2_META_FMT_MALI_C55_STATS	v4l2_fourcc('C', '5', '5', 'S') /* ARM Mali-C55 3A Statistics */
+
 #ifdef __KERNEL__
 /*
  * Line-based metadata formats. Remember to update v4l_fill_fmtdesc() when

-- 
2.43.0

