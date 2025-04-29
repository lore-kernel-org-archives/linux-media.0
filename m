Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7F7248F54;
	Tue, 29 Apr 2025 23:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970824; cv=none; b=GtydvxY9V4g7orOtJgwuXzZeC9Dj131UuTz9rbq6n44Mq2j+djiAxRtawntA5RvF7f3EjT/GcNEz0sOUpW/jhmu0wIt+Zc6+1kQ3udTZ0p0uwz4CcLErlZzSVkQLPYXqwY8T8nu9jKEJ9woWUnIkx1o/eHhjXQfxocMwpa2+ij8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970824; c=relaxed/simple;
	bh=bAh4NY6JGUbLpUGXrZTGRGsqudQlq8viDBTWxFtnXNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPY/pyz1mQGu8E0bQLL7eJVopAUTebtGVE57u3cVeB2kkR5DHTCRax3a7sOZ8AICzhwW/F1qgJgVY4Vz9s0OGf9O4PRNVmzSgs9Uybd6YTYC2c/LePSrSuXeaULjqSxiuIypMEvILdZwYq4z2BzqSRg3t3DWGYJ3INgzVz9Bh7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=h+4JlsPO; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="h+4JlsPO"
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E877B11AA;
	Wed, 30 Apr 2025 01:53:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1745970808;
	bh=bAh4NY6JGUbLpUGXrZTGRGsqudQlq8viDBTWxFtnXNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h+4JlsPOIZETFWiH/pXAEZZx6ZHU7o2E+OE8rf8hVrB8StNXm6Ki20RoobnyPMZN5
	 FJ3S/DhAKJVyzxu//1Y8XuS7vuqcI339BxPtxA7UqFs2t5+hyACfMBODL90LbqXz70
	 DLZ7f5R3rHFUNvQxfdsIxy455MpKexbmX+JfIWCw=
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 3/7] media: renesas: vsp1: Fix code checks in frame size enumeration
Date: Wed, 30 Apr 2025 02:53:18 +0300
Message-ID: <20250429235322.29826-4-laurent.pinchart+renesas@ideasonboard.com>
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

The media bus code passed to the .enum_frame_size() operation for the
sink pad is required to be supported by the device, but not to match the
current format. All entities that use the vsp1_subdev_enum_frame_size()
helper, as well as the SRU and UDS entities that implement the operation
manually, perform the check incorrectly.

Fix the issue by implementing the correct code check in the
vsp1_subdev_enum_frame_size(). For the SRU and UDS, to avoid duplicating
code, use the vsp1_subdev_enum_frame_size() as a base and override the
enumerated size on the source pad with entity-specific constraints.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../media/platform/renesas/vsp1/vsp1_entity.c | 47 +++++++++++--------
 .../media/platform/renesas/vsp1/vsp1_sru.c    | 36 ++++++--------
 .../media/platform/renesas/vsp1/vsp1_uds.c    | 36 ++++++--------
 3 files changed, 58 insertions(+), 61 deletions(-)

diff --git a/drivers/media/platform/renesas/vsp1/vsp1_entity.c b/drivers/media/platform/renesas/vsp1/vsp1_entity.c
index 0d4fe0028b13..a3d4bf2887ec 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_entity.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_entity.c
@@ -233,42 +233,51 @@ int vsp1_subdev_enum_frame_size(struct v4l2_subdev *subdev,
 				struct v4l2_subdev_frame_size_enum *fse)
 {
 	struct vsp1_entity *entity = to_vsp1_entity(subdev);
-	struct v4l2_subdev_state *state;
-	struct v4l2_mbus_framefmt *format;
-	int ret = 0;
 
-	state = vsp1_entity_get_state(entity, sd_state, fse->which);
-	if (!state)
+	if (fse->index)
 		return -EINVAL;
 
-	format = v4l2_subdev_state_get_format(state, fse->pad);
-
-	mutex_lock(&entity->lock);
-
-	if (fse->index || fse->code != format->code) {
-		ret = -EINVAL;
-		goto done;
-	}
-
 	if (fse->pad == 0) {
+		unsigned int i;
+
+		for (i = 0; i < entity->num_codes; ++i) {
+			if (fse->code == entity->codes[i])
+				break;
+		}
+
+		if (i == entity->num_codes)
+			return -EINVAL;
+
 		fse->min_width = entity->min_width;
 		fse->max_width = entity->max_width;
 		fse->min_height = entity->min_height;
 		fse->max_height = entity->max_height;
 	} else {
+		struct v4l2_subdev_state *state;
+		struct v4l2_mbus_framefmt *format;
+
+		state = vsp1_entity_get_state(entity, sd_state, fse->which);
+		if (!state)
+			return -EINVAL;
+
 		/*
-		 * The size on the source pad are fixed and always identical to
-		 * the size on the sink pad.
+		 * The media bus code and size on the source pad are fixed and
+		 * always identical to the sink pad.
 		 */
+		format = v4l2_subdev_state_get_format(state, 0);
+
+		guard(mutex)(&entity->lock);
+
+		if (fse->code != format->code)
+			return -EINVAL;
+
 		fse->min_width = format->width;
 		fse->max_width = format->width;
 		fse->min_height = format->height;
 		fse->max_height = format->height;
 	}
 
-done:
-	mutex_unlock(&entity->lock);
-	return ret;
+	return 0;
 }
 
 /*
diff --git a/drivers/media/platform/renesas/vsp1/vsp1_sru.c b/drivers/media/platform/renesas/vsp1/vsp1_sru.c
index 1dc34e6a510d..e821eac1cbc2 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_sru.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_sru.c
@@ -116,29 +116,25 @@ static int sru_enum_frame_size(struct v4l2_subdev *subdev,
 			       struct v4l2_subdev_frame_size_enum *fse)
 {
 	struct vsp1_sru *sru = to_sru(subdev);
-	struct v4l2_subdev_state *state;
-	struct v4l2_mbus_framefmt *format;
-	int ret = 0;
+	int ret;
 
-	state = vsp1_entity_get_state(&sru->entity, sd_state, fse->which);
-	if (!state)
-		return -EINVAL;
+	ret = vsp1_subdev_enum_frame_size(subdev, sd_state, fse);
+	if (ret)
+		return ret;
 
-	format = v4l2_subdev_state_get_format(state, SRU_PAD_SINK);
+	if (fse->pad == SRU_PAD_SOURCE) {
+		struct v4l2_subdev_state *state;
+		struct v4l2_mbus_framefmt *format;
 
-	mutex_lock(&sru->entity.lock);
+		state = vsp1_entity_get_state(&sru->entity, sd_state,
+					      fse->which);
+		if (!state)
+			return -EINVAL;
 
-	if (fse->index || fse->code != format->code) {
-		ret = -EINVAL;
-		goto done;
-	}
+		format = v4l2_subdev_state_get_format(state, SRU_PAD_SINK);
+
+		guard(mutex)(&sru->entity.lock);
 
-	if (fse->pad == SRU_PAD_SINK) {
-		fse->min_width = SRU_MIN_SIZE;
-		fse->max_width = SRU_MAX_SIZE;
-		fse->min_height = SRU_MIN_SIZE;
-		fse->max_height = SRU_MAX_SIZE;
-	} else {
 		fse->min_width = format->width;
 		fse->min_height = format->height;
 		if (format->width <= SRU_MAX_SIZE / 2 &&
@@ -151,9 +147,7 @@ static int sru_enum_frame_size(struct v4l2_subdev *subdev,
 		}
 	}
 
-done:
-	mutex_unlock(&sru->entity.lock);
-	return ret;
+	return 0;
 }
 
 static void sru_try_format(struct vsp1_sru *sru,
diff --git a/drivers/media/platform/renesas/vsp1/vsp1_uds.c b/drivers/media/platform/renesas/vsp1/vsp1_uds.c
index 8006d49ffbea..95c9939ae077 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_uds.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_uds.c
@@ -121,38 +121,32 @@ static int uds_enum_frame_size(struct v4l2_subdev *subdev,
 			       struct v4l2_subdev_frame_size_enum *fse)
 {
 	struct vsp1_uds *uds = to_uds(subdev);
-	struct v4l2_subdev_state *state;
-	struct v4l2_mbus_framefmt *format;
-	int ret = 0;
+	int ret;
 
-	state = vsp1_entity_get_state(&uds->entity, sd_state, fse->which);
-	if (!state)
-		return -EINVAL;
+	ret = vsp1_subdev_enum_frame_size(subdev, sd_state, fse);
+	if (ret)
+		return ret;
 
-	format = v4l2_subdev_state_get_format(state, UDS_PAD_SINK);
+	if (fse->pad == UDS_PAD_SOURCE) {
+		struct v4l2_subdev_state *state;
+		struct v4l2_mbus_framefmt *format;
 
-	mutex_lock(&uds->entity.lock);
+		state = vsp1_entity_get_state(&uds->entity, sd_state,
+					      fse->which);
+		if (!state)
+			return -EINVAL;
 
-	if (fse->index || fse->code != format->code) {
-		ret = -EINVAL;
-		goto done;
-	}
+		format = v4l2_subdev_state_get_format(state, UDS_PAD_SINK);
+
+		guard(mutex)(&uds->entity.lock);
 
-	if (fse->pad == UDS_PAD_SINK) {
-		fse->min_width = UDS_MIN_SIZE;
-		fse->max_width = UDS_MAX_SIZE;
-		fse->min_height = UDS_MIN_SIZE;
-		fse->max_height = UDS_MAX_SIZE;
-	} else {
 		uds_output_limits(format->width, &fse->min_width,
 				  &fse->max_width);
 		uds_output_limits(format->height, &fse->min_height,
 				  &fse->max_height);
 	}
 
-done:
-	mutex_unlock(&uds->entity.lock);
-	return ret;
+	return 0;
 }
 
 static void uds_try_format(struct vsp1_uds *uds,
-- 
Regards,

Laurent Pinchart

