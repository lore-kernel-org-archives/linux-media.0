Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0312326C399;
	Tue, 11 Nov 2025 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877775; cv=none; b=FrKww4oI2XKyhlz8Px0CovSHxNj+FaiLchE4UW9RmteY4IrsIqVns02pCQNB9UU7NgGfhXAI9uxrNAOXIMu7UefggWfRl/n4FtmOq0dyOlqOESwo7P3f3yoNsuRoijxEOLF/lfNno8kCMPhUAf9v7IQiJzFdY5TFFyFOHmiNo/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877775; c=relaxed/simple;
	bh=/E1+DqbWeRNuR+fw9bEa2pEPBNYgFft6M1UycrhLvqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I+DLitTWfAQv2ibuBkpT1l2oUAg+O2K+7iRMKDHNQVrQ+LwwWHK1/PYcbTLHJdp4knCAtY5/ILZ26jbkkRJtCIyFdIkoke1Z2F+DW6J+xXTLPyoeocouoBPlB63KiXReyyo4HbpKl1Q2q9mm5FPUKsWHeIGVPxwk/pcRJDal95Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LZSYMrVD; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LZSYMrVD"
Received: from [127.0.1.1] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 575D31E4E;
	Tue, 11 Nov 2025 17:14:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762877648;
	bh=/E1+DqbWeRNuR+fw9bEa2pEPBNYgFft6M1UycrhLvqo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LZSYMrVDBWO+790ZKKcvoj3tp5KrV6a9nOgSfuEB/bGrzu1AIHFA1roWb55OSzwwn
	 hi8xxtMMVRsA4a80DaCpXJCRiWJb1omrVmC6LIVFhS7g3IsQfjKewhVo1LbMNCW3DS
	 fzoIc+UDhgsWFqplduY0vNj2banPZhDwdbaoDqAg=
From: Daniel Scally <dan.scally@ideasonboard.com>
Date: Tue, 11 Nov 2025 16:15:45 +0000
Subject: [PATCH v13 01/15] media: uapi: Add MEDIA_BUS_FMT_RGB202020_1X60
 format code
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-c55-v13-1-3dc581355e3a@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5887;
 i=dan.scally@ideasonboard.com; h=from:subject:message-id;
 bh=/E1+DqbWeRNuR+fw9bEa2pEPBNYgFft6M1UycrhLvqo=;
 b=owEBbQKS/ZANAwAKAchJV3psRXUyAcsmYgBpE2FBW6KSbxo79khalpTumiH0zrRs0Gzw/HfxI
 5JOhrscN+uJAjMEAAEKAB0WIQQqyuwyDnZdb+mxmm/ISVd6bEV1MgUCaRNhQQAKCRDISVd6bEV1
 MsV0EACrs+U1FxArG/eFI5vmlyLeqobbffjbLmZlVGQ45ifYK2mXSjSX6mCf/Wf3h2Yb1N9YRAf
 e0niPNPw+STzK8opxehBuypPa1dzRIk+K0oTgngV0uagQXWO/3BtAa20fEc8SsG50flNGEecFVQ
 ZMp4OO5muDi2qcF+1c1T4YHxI6KKE5PEqx8dNulW8Qi+dO40CCAyqTOiP8MVSz9QroHGRq82aYy
 VE16JrhqsEmtNnkQuhExdtmiTmFVnm0ju/YFp8AzT3hi8ua7vV4IJ/J1zZdRSLWqJCo7b6ih7uC
 6xYLzOwAjj9cef1IZ1Zql2lcXLKyQk3j53hhK1P4YxoXWtuYyGlB/dk/wsdaim2rI1Zu5GZhotD
 9uzbMJUMv7boUKZM9NOVrJD7Jp2fIPhchAgP8aB7VZuAkv2HEtGkJ8y7fKuu+x5stYV3JJV8JwC
 +zeRqNIH49PJEbqn/lsKtjOXTMZEzJ1nmIprIAU84+OsmL65j6gyKQ0gF9P33/YLR0gHjToVc+w
 DszhavxfyHKKy98cNGp4wPZRc0W59D3dFtopIW66AQduEiEPiFOjmw/eP6nb5x+G5REwUvsksuS
 fKDXUm3ybkfleb0fCLKZR5N80FOn/XyFcWP9uXDRO/DyAPhDClUkxRzQRRgbIkWCtwWK6omu7eG
 jfK9nb2TFFAzE1w==
X-Developer-Key: i=dan.scally@ideasonboard.com; a=openpgp;
 fpr=EEC699ACA1B7CB5D31330C0BBD501C2A3546CCF6

The Mali-C55 ISP by ARM requires 20-bits per colour channel input on
the bus. Add a new media bus format code to represent it.

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Nayden Kanchev <nayden.kanchev@arm.com>
Co-developed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Daniel Scally <dan.scally@ideasonboard.com>
---
Changes in v10:

	- None

Changes in v9:

	- None

Changes in v8:

	- None

Changes in v7:

	- None

Changes in v6:

	- Fixed the table formatting

Changes in v5:

	- none

Changes in v4:

	- None

Changes in v3:

	- None

Changes in v2:

	- none
---
 .../userspace-api/media/v4l/subdev-formats.rst     | 168 +++++++++++++++++++++
 include/uapi/linux/media-bus-format.h              |   3 +-
 2 files changed, 170 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/subdev-formats.rst b/Documentation/userspace-api/media/v4l/subdev-formats.rst
index 1904390df830cb55d513b6d604762f55c9e0c28d..894592e15a2becb84f02ac39168d2deed20d3a90 100644
--- a/Documentation/userspace-api/media/v4l/subdev-formats.rst
+++ b/Documentation/userspace-api/media/v4l/subdev-formats.rst
@@ -2225,6 +2225,174 @@ The following table list existing packed 48bit wide RGB formats.
 
     \endgroup
 
+The following table list existing packed 60bit wide RGB formats.
+
+.. tabularcolumns:: |p{4.0cm}|p{0.7cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|
+
+.. _v4l2-mbus-pixelcode-rgb-60:
+
+.. raw:: latex
+
+    \begingroup
+    \tiny
+    \setlength{\tabcolsep}{2pt}
+
+.. flat-table:: 60bit RGB formats
+    :header-rows:  3
+    :stub-columns: 0
+    :widths: 36 7 3 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
+
+    * - Identifier
+      - Code
+      -
+      - :cspan:`31` Data organization
+    * -
+      -
+      - Bit
+      -
+      -
+      -
+      -
+      - 59
+      - 58
+      - 57
+      - 56
+      - 55
+      - 54
+      - 53
+      - 52
+      - 51
+      - 50
+      - 49
+      - 48
+      - 47
+      - 46
+      - 45
+      - 44
+      - 43
+      - 42
+      - 41
+      - 40
+      - 39
+      - 38
+      - 37
+      - 36
+      - 35
+      - 34
+      - 33
+      - 32
+    * -
+      -
+      -
+      - 31
+      - 30
+      - 29
+      - 28
+      - 27
+      - 26
+      - 25
+      - 24
+      - 23
+      - 22
+      - 21
+      - 20
+      - 19
+      - 18
+      - 17
+      - 16
+      - 15
+      - 14
+      - 13
+      - 12
+      - 11
+      - 10
+      - 9
+      - 8
+      - 7
+      - 6
+      - 5
+      - 4
+      - 3
+      - 2
+      - 1
+      - 0
+    * .. _MEDIA-BUS-FMT-RGB202020-1X60:
+
+      - MEDIA_BUS_FMT_RGB202020_1X60
+      - 0x1026
+      -
+      -
+      -
+      -
+      -
+      - r\ :sub:`19`
+      - r\ :sub:`18`
+      - r\ :sub:`17`
+      - r\ :sub:`16`
+      - r\ :sub:`15`
+      - r\ :sub:`14`
+      - r\ :sub:`13`
+      - r\ :sub:`12`
+      - r\ :sub:`11`
+      - r\ :sub:`10`
+      - r\ :sub:`9`
+      - r\ :sub:`8`
+      - r\ :sub:`7`
+      - r\ :sub:`6`
+      - r\ :sub:`5`
+      - r\ :sub:`4`
+      - r\ :sub:`3`
+      - r\ :sub:`2`
+      - r\ :sub:`1`
+      - r\ :sub:`0`
+      - g\ :sub:`19`
+      - g\ :sub:`18`
+      - g\ :sub:`17`
+      - g\ :sub:`16`
+      - g\ :sub:`15`
+      - g\ :sub:`14`
+      - g\ :sub:`13`
+      - g\ :sub:`12`
+    * -
+      -
+      -
+      - g\ :sub:`11`
+      - g\ :sub:`10`
+      - g\ :sub:`9`
+      - g\ :sub:`8`
+      - g\ :sub:`7`
+      - g\ :sub:`6`
+      - g\ :sub:`5`
+      - g\ :sub:`4`
+      - g\ :sub:`3`
+      - g\ :sub:`2`
+      - g\ :sub:`1`
+      - g\ :sub:`0`
+      - b\ :sub:`19`
+      - b\ :sub:`18`
+      - b\ :sub:`17`
+      - b\ :sub:`16`
+      - b\ :sub:`15`
+      - b\ :sub:`14`
+      - b\ :sub:`13`
+      - b\ :sub:`12`
+      - b\ :sub:`11`
+      - b\ :sub:`10`
+      - b\ :sub:`9`
+      - b\ :sub:`8`
+      - b\ :sub:`7`
+      - b\ :sub:`6`
+      - b\ :sub:`5`
+      - b\ :sub:`4`
+      - b\ :sub:`3`
+      - b\ :sub:`2`
+      - b\ :sub:`1`
+      - b\ :sub:`0`
+
+.. raw:: latex
+
+    \endgroup
+
 On LVDS buses, usually each sample is transferred serialized in seven
 time slots per pixel clock, on three (18-bit) or four (24-bit) or five (30-bit)
 differential data pairs at the same time. The remaining bits are used
diff --git a/include/uapi/linux/media-bus-format.h b/include/uapi/linux/media-bus-format.h
index ff62056feed5b6588bfcfdff178f5b68eecd3a26..62ad82fd285a8ce24bd16c207c51c0e75ea95070 100644
--- a/include/uapi/linux/media-bus-format.h
+++ b/include/uapi/linux/media-bus-format.h
@@ -34,7 +34,7 @@
 
 #define MEDIA_BUS_FMT_FIXED			0x0001
 
-/* RGB - next is	0x1028 */
+/* RGB - next is	0x1029 */
 #define MEDIA_BUS_FMT_RGB444_1X12		0x1016
 #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_BE	0x1001
 #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_LE	0x1002
@@ -74,6 +74,7 @@
 #define MEDIA_BUS_FMT_RGB888_1X36_CPADLO	0x1021
 #define MEDIA_BUS_FMT_RGB121212_1X36		0x1019
 #define MEDIA_BUS_FMT_RGB161616_1X48		0x101a
+#define MEDIA_BUS_FMT_RGB202020_1X60		0x1028
 
 /* YUV (including grey) - next is	0x202f */
 #define MEDIA_BUS_FMT_Y8_1X8			0x2001

-- 
2.43.0

