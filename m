Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8EA2D81AE;
	Tue, 29 Apr 2025 23:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970827; cv=none; b=mfhtR1Zuyt45i2ilk0WsxQh9QuOZ25mkCCd+5e9QV5gLn+aoSue9QnOEcdxxVYZxn9M6mDLKq3yAaNz4fQbjZpL41Ag7mSWv58MDojKs1lo3f+LcdECA03/xOmtChMGKu6mu00vMi4iaLcI5a7Sj0g9v0ndPif4mIhXUQHo/0YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970827; c=relaxed/simple;
	bh=NcxQovZErs5UAAhzoE+sSw8pfUYvgyLxmoKBTsguoW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDuZcC08C2yTXXP3QOpp+MjC8/IrmEaYPd6FWzs3UXRCIpfUZ+8drqq8MZqtT9V6s993OT7AB8SMbnY1hk2Ph5F9lvKrFAyWmF/mlTZQa1oKfeCsmzKEK50tHW2lD0WMyyeb6j63+X1sD6ZItum53DKdhWLU0DX3rMHsCeeuzYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=NJoNjGIx; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NJoNjGIx"
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4A81A11D9;
	Wed, 30 Apr 2025 01:53:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1745970809;
	bh=NcxQovZErs5UAAhzoE+sSw8pfUYvgyLxmoKBTsguoW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NJoNjGIxPS94OQSAkb/PucxCm+jPItt8HV0u6/gbMMwqEvajsMgOiT52NONvDmhcS
	 x/5R+ZfuB5dPH9h+GL2LuKIDYrm3qNjTryd8sKPTX6YmFkEuaAeizfG4NZquldBAnm
	 JpyaKWX0pQTcWrnYhbr+OAprk5eqjW1owTDoHZo0=
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 4/7] media: renesas: vsp1: Fix RPF sink alignment for YUV formats
Date: Wed, 30 Apr 2025 02:53:19 +0300
Message-ID: <20250429235322.29826-5-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429235322.29826-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20250429235322.29826-1-laurent.pinchart+renesas@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reading YUV formats from memory, the hardware requires the crop
rectangle size and position to be aligned to multiples of two, depending
on the horizontal and vertical subsampling factors. The driver doesn't
enforce this, leading to incorrect operation.

As the crop rectangle is implemented on the RPF subdev's sink pad,
enforcing the constraint conditionally based on the subsampling factors
is difficult, as those are only known by the RPF video device. We could
perform the check at pipeline validation time, but that could lead to
confusing -EPIPE errors. As there is very few use cases for odd crop
offsets and sizes with non-subsampled YUV, take the easier and more
user-friendly route of enforcing the constraint on all YUV formats.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../media/platform/renesas/vsp1/vsp1_rwpf.c   | 41 ++++++++++++-------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/renesas/vsp1/vsp1_rwpf.c b/drivers/media/platform/renesas/vsp1/vsp1_rwpf.c
index 83ff2c266038..61f7e13ebeee 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_rwpf.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_rwpf.c
@@ -117,6 +117,17 @@ static int vsp1_rwpf_set_format(struct v4l2_subdev *subdev,
 				RWPF_MIN_WIDTH, rwpf->entity.max_width);
 	format->height = clamp_t(unsigned int, fmt->format.height,
 				 RWPF_MIN_HEIGHT, rwpf->entity.max_height);
+
+	/*
+	 * For YUV formats on the RPF, restrict the size to multiples of 2 to
+	 * avoid shifting the color plane.
+	 */
+	if (rwpf->entity.type == VSP1_ENTITY_RPF &&
+	    format->code == MEDIA_BUS_FMT_AYUV8_1X32) {
+		format->width = ALIGN(format->width, 2);
+		format->height = ALIGN(format->height, 2);
+	}
+
 	format->field = V4L2_FIELD_NONE;
 
 	format->colorspace = fmt->format.colorspace;
@@ -231,23 +242,23 @@ static int vsp1_rwpf_set_selection(struct v4l2_subdev *subdev,
 	/* Make sure the crop rectangle is entirely contained in the image. */
 	format = v4l2_subdev_state_get_format(state, RWPF_PAD_SINK);
 
-	/*
-	 * Restrict the crop rectangle coordinates to multiples of 2 to avoid
-	 * shifting the color plane.
-	 */
-	if (format->code == MEDIA_BUS_FMT_AYUV8_1X32) {
-		sel->r.left = ALIGN(sel->r.left, 2);
-		sel->r.top = ALIGN(sel->r.top, 2);
-		sel->r.width = round_down(sel->r.width, 2);
-		sel->r.height = round_down(sel->r.height, 2);
-	}
-
 	sel->r.left = min_t(unsigned int, sel->r.left, format->width - 2);
 	sel->r.top = min_t(unsigned int, sel->r.top, format->height - 2);
-	sel->r.width = min_t(unsigned int, sel->r.width,
-			     format->width - sel->r.left);
-	sel->r.height = min_t(unsigned int, sel->r.height,
-			      format->height - sel->r.top);
+	sel->r.width = clamp_t(unsigned int, sel->r.width, RWPF_MIN_WIDTH,
+			       format->width - sel->r.left);
+	sel->r.height = clamp_t(unsigned int, sel->r.height, RWPF_MIN_HEIGHT,
+				format->height - sel->r.top);
+
+	/*
+	 * For YUV formats, restrict the crop rectangle coordinates to multiples
+	 * of 2 to avoid shifting the color plane.
+	 */
+	if (format->code == MEDIA_BUS_FMT_AYUV8_1X32) {
+		sel->r.left = round_down(sel->r.left, 2);
+		sel->r.top = round_down(sel->r.top, 2);
+		sel->r.width = ALIGN(sel->r.width, 2);
+		sel->r.height = ALIGN(sel->r.height, 2);
+	}
 
 	crop = v4l2_subdev_state_get_crop(state, RWPF_PAD_SINK);
 	*crop = sel->r;
-- 
Regards,

Laurent Pinchart

