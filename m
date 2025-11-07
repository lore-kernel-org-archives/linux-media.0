Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD86302742
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510603; cv=none; b=BfXO0GaNgt24V/TzmgkyTqGGex/DTB4DcZWpkmHfxxeTWvaUl9b8I+x4AyPgU7pqSBunZ2zHUMJlC+74VgRnWlRc810K4geFXf5asGIGQbkf0Xee0rIqYF7VU+tf3i2m9ip2pLkd+jQVyeTovV56OuqM1DEqivoT6ZJFmtQXIxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510603; c=relaxed/simple;
	bh=/BBvlPJiyWBIzDICKzroygGmWbARSAzrY+QzXWCf0TY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NJJ9IL5YO6c7NdlB8bCyM8vu65uFi8Z0enYJXSa/ZSsDhCZANCuan/0TAm3BROAEQ0/9mAycb5/HIL2jx/plyDd+U8K3ezakPKxA5q3WWQ8a9BeFPWI9GnRM0GZbvdzmv1u/e7gtaq/bvcwvcrCVxIwH8zBDt/68J/uGFIsDNxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vHJWH-0003HZ-Md; Fri, 07 Nov 2025 11:16:37 +0100
From: Michael Tretter <m.tretter@pengutronix.de>
Date: Fri, 07 Nov 2025 11:16:34 +0100
Subject: [PATCH 2/3] media: imx-csi: explicitly start media pipeline on pad
 0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-media-imx-cleanup-v1-2-f82a693c28f4@pengutronix.de>
References: <20251107-media-imx-cleanup-v1-0-f82a693c28f4@pengutronix.de>
In-Reply-To: <20251107-media-imx-cleanup-v1-0-f82a693c28f4@pengutronix.de>
To: Steve Longerbeam <slongerbeam@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-media@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Michael Tretter <m.tretter@pengutronix.de>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org

entity->pads is an array that contains all the pads of an entity.

Calling __media_pipeline_start() or __media_pipeline_stop() on the pads,
implicitly starts the pipeline with the first pad in this array as
origin.

Explicitly use the first pad to start the pipeline to make this more
obvious to the reader.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
 drivers/staging/media/imx/imx-media-utils.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/media/imx/imx-media-utils.c
index f520529a7cfe..6d69f69c16c1 100644
--- a/drivers/staging/media/imx/imx-media-utils.c
+++ b/drivers/staging/media/imx/imx-media-utils.c
@@ -755,6 +755,7 @@ int imx_media_pipeline_set_stream(struct imx_media_dev *imxmd,
 {
 	struct v4l2_subdev *sd;
 	int ret = 0;
+	struct media_pad *pad;
 
 	if (!is_media_entity_v4l2_subdev(entity))
 		return -EINVAL;
@@ -762,17 +763,19 @@ int imx_media_pipeline_set_stream(struct imx_media_dev *imxmd,
 
 	mutex_lock(&imxmd->md.graph_mutex);
 
+	pad = &entity->pads[0];
+
 	if (on) {
-		ret = __media_pipeline_start(entity->pads, &vdev->pipe);
+		ret = __media_pipeline_start(pad, &vdev->pipe);
 		if (ret)
 			goto out;
 		ret = v4l2_subdev_call(sd, video, s_stream, 1);
 		if (ret)
-			__media_pipeline_stop(entity->pads);
+			__media_pipeline_stop(pad);
 	} else {
 		v4l2_subdev_call(sd, video, s_stream, 0);
-		if (media_pad_pipeline(entity->pads))
-			__media_pipeline_stop(entity->pads);
+		if (media_pad_pipeline(pad))
+			__media_pipeline_stop(pad);
 	}
 
 out:

-- 
2.47.3

