Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7262330329;
	Tue, 27 Jan 2026 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769504201; cv=none; b=F3TrjXQQgz5amyPV7IKUL8/HmbYZ9HkZPmhOpH2BdtIQPaQgtjMTxgGN7VbMBpClriOYv9/thzLn+/GuAcHkLHT/YCqPYuAXIOTaSpcHvheT5nxVHQ5opLZ6+VKro8rfX4gGY4IMvRzAD8E14XI0J6Ta3BU4wZqM0RzVoRWKrg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769504201; c=relaxed/simple;
	bh=YSC8kL8Rjr8EC8MeFfA+OjR6ATnoKTBFb320XpZmk00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eGM+RLjs8yVLRv4kUimmg4pxsDv7QVT6waP15KyIJyFOVEL8JfCoiGOfIDGDdHpOIE8yA9jPl96nwTLUQ/WqvnVdMg5rlNUO8NVTRXb1+zUxIMHqLgmtd7gEE7b6Vi/CrLosvx5szghJG55ww4E8R7hlv/CD84JBckBUg1EI2RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=jXZyAEVH; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jXZyAEVH"
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 66C1D186F;
	Tue, 27 Jan 2026 09:55:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1769504156;
	bh=YSC8kL8Rjr8EC8MeFfA+OjR6ATnoKTBFb320XpZmk00=;
	h=From:Date:Subject:To:Cc:From;
	b=jXZyAEVHpDYsdDlv0oceFn9gcj8AJTibtpCPYyBjrIJ1br9U3oTcrDzNRzKxYvozx
	 8t9F6DRDaKMQje0VVX7cWO4pGbnQ4gkfbu5mVKiaJFaGhGT3zVl9oadtmTLspjTnGq
	 6JEBpJV4/iYuF9xGYOeDOxTaSVRxytVUnC9wb1wY=
From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Date: Tue, 27 Jan 2026 10:56:12 +0200
Subject: [PATCH] media: renesas: vin: Fix RAW8 (again)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-rcar-fix-raw8-again-v1-1-642283bc0fa4@ideasonboard.com>
X-B4-Tracking: v=1; b=H4sIAKt9eGkC/x2MQQqAMAzAviI9W3AbOPUr4qFuVXuZ0oEK4t8dH
 gNJHsiswhmG6gHlU7LsqYCpKwgbpZVRYmGwjW0bYz1qIMVFblS6OqSVJGEfKdDceYrOQSkP5WL
 813F63w/kdWM1ZQAAAA==
X-Change-ID: 20260127-rcar-fix-raw8-again-9dacab87ad33
To: =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Hans Verkuil <hverkuil@kernel.org>
Cc: =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3149;
 i=tomi.valkeinen+renesas@ideasonboard.com; h=from:subject:message-id;
 bh=YSC8kL8Rjr8EC8MeFfA+OjR6ATnoKTBFb320XpZmk00=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpeH296bDP6mbvLctvWmEdn0UOCvPTmrJ6f1Ajx
 RltEpMp2ESJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaXh9vQAKCRD6PaqMvJYe
 9ZKDD/94kt/m4UeGr/1EG80Ky390bkC0Pq8wYgOSduOcHACXNUXeveYYskuz8dpfzBDlXquja3A
 3IlrVItVD9kA2nhdhU2hRUBAzy2pFPgniYun2XiY8VNtNBg90mnBCzIpUKZdbjqq3ezfEKcDj2p
 j+uzHY5MT5hyuHWqDQosu+6Y+WIsC2q7yc7l7s9UiOTHq0ZR2ifB6ElYBLzeoyk+b+8KbOYyRYy
 jNXKJdBRX564NUVyvRwH4rE0LvHDC9S2zeMfx+68m1A2bk7mwKDOH/9ZU2B1qwAVCNGETZNJdjB
 SfU5ZbWFKLOcgnooK2nEhgo5Znks/NJTh3Hq9Zq/3VuWoj+TmD3Fp2YKL7W2oNORtSO2KQOw4/N
 HCB75KMEr4BDEnXmtL/DBQuAKYfKFTcm6PA9UQFcO5+gBYxNOrQMU884xvQM03yg3ie1fAKQr5F
 4QK4DtOY42EqLM9RyC/Nvu3pvlNKFx3XglV7f9EY5s6nagl15z2Yu/fw2KQTWLofKx0vtdxBZPv
 vs/42DiRu5D4T5VSW1bXBK2ggeME+1DOnw87M2RlMXZer39sfHW0c8+lztMtttetxkcyM70Glqg
 kegEz3C/uafpB3XAlUfISA87WNg/kyHFB7XWkI8Z/QURqSwzYqAN22aPjRns2Z9lPBwT3aP6KNq
 UJVZ/0gxyfVrAwg==
X-Developer-Key: i=tomi.valkeinen+renesas@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Commit e7376745ad5c ("media: rcar-vin: Fix stride setting for RAW8
formats") removed dividing the stride by two for RAW8 formats. It is
unclear how this was tested, but in any of the recent tests this does
not seem to work and produces quite distorted images.

However, reverting the patch fixes the issues only partially. VNIS_REG
requires alignment to 16 bytes, and when dividing the stride by 2, in
some cases we end up with a non-aligned stride, producing a tilted
image. This issue has to be fixed in rvin_format_bytesperline() where we
do the alignment for bytesperline.

Adding back the stride division and increasing the alignment for RAW8
formats to 0x20 fixes the problems related to RAW8.

Fixes: e7376745ad5c ("media: rcar-vin: Fix stride setting for RAW8 formats")
Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
---
 drivers/media/platform/renesas/rcar-vin/rcar-dma.c | 22 ++++++++++++++++++++++
 .../media/platform/renesas/rcar-vin/rcar-v4l2.c    | 12 ++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/media/platform/renesas/rcar-vin/rcar-dma.c b/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
index b619d1436a41..f9af9177e02f 100644
--- a/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
+++ b/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
@@ -676,8 +676,30 @@ void rvin_crop_scale_comp(struct rvin_dev *vin)
 	if (vin->scaler)
 		vin->scaler(vin);
 
+	/*
+	 * VNIS_REG has four lowest bits always 0, i.e. the stride has to be
+	 * aligned to 16 bytes. This is done in rvin_format_bytesperline().
+	 */
+
 	fmt = rvin_format_from_pixel(vin, vin->format.pixelformat);
 	stride = vin->format.bytesperline / fmt->bpp;
+
+	/*
+	 * RAW8 format bpp is 1, but the hardware process RAW8 format in 2 pixel
+	 * units, so we need to divide the stride by 2.
+	 */
+	switch (vin->format.pixelformat) {
+	case V4L2_PIX_FMT_SBGGR8:
+	case V4L2_PIX_FMT_SGBRG8:
+	case V4L2_PIX_FMT_SGRBG8:
+	case V4L2_PIX_FMT_SRGGB8:
+	case V4L2_PIX_FMT_GREY:
+		stride /= 2;
+		break;
+	default:
+		break;
+	}
+
 	rvin_write(vin, stride, VNIS_REG);
 }
 
diff --git a/drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c b/drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c
index 079dbaf016c2..9d45e11898c1 100644
--- a/drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c
+++ b/drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c
@@ -155,6 +155,18 @@ static u32 rvin_format_bytesperline(struct rvin_dev *vin,
 	case V4L2_PIX_FMT_NV16:
 		align = 0x20;
 		break;
+	case V4L2_PIX_FMT_SBGGR8:
+	case V4L2_PIX_FMT_SGBRG8:
+	case V4L2_PIX_FMT_SGRBG8:
+	case V4L2_PIX_FMT_SRGGB8:
+	case V4L2_PIX_FMT_GREY:
+		/*
+		 * RAW8 format bpp is 1, but the hardware process RAW8 format in
+		 * 2 pixel units, and we need to align to 32 bytes. See
+		 * rvin_crop_scale_comp().
+		 */
+		align = 0x20;
+		break;
 	default:
 		align = 0x10;
 		break;

---
base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
change-id: 20260127-rcar-fix-raw8-again-9dacab87ad33

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>

