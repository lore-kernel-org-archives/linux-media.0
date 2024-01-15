Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3233F11182
	for <linux-media@vger.kernel.org>; Mon, 15 Jan 2024 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="c0Y7Szk2"
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8642D1B44;
	Mon, 15 Jan 2024 11:29:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1705314567;
	bh=e0AMKuwCV3MSAMeJx4Y/8UgLvI4lpvgQfyz/U2F7fJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c0Y7Szk2SWt7hjMWyUvEN/H+tWagSh9wSCudm3u7VKDvKuSjCnmnE9PlSlrKu+/AI
	 3pudio7WfP4mcBSXvBUMbhNhEgYNOFfCNKD/lqIMAXxsEz/8WOV28V/9ZMpOK3j51W
	 mR8EywZNENbb+xcafu8LlGk+EAICM65dGUl2qidk=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@iki.fi>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Alexander Shiyan <eagle.alexander923@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Marek Vasut <marex@denx.de>,
	Martin Kepplinger <martin.kepplinger@puri.sm>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Purism Kernel Team <kernel@puri.sm>
Subject: [PATCH 7/7] media: nxp: imx8-isi: Mark all crossbar sink pads as MUST_CONNECT
Date: Mon, 15 Jan 2024 12:30:29 +0200
Message-ID: <20240115103029.28055-8-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115103029.28055-1-laurent.pinchart@ideasonboard.com>
References: <20240115103029.28055-1-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All the sink pads of the crossbar switch require an active link if
they're part of the pipeline. Mark them with the
MEDIA_PAD_FL_MUST_CONNECT flag to fail pipeline validation if they're
not connected. This allows removing a manual check when translating
streams.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 .../media/platform/nxp/imx8-isi/imx8-isi-crossbar.c    | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
index 44354931cf8a..c9a4d091b570 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
@@ -160,13 +160,6 @@ mxc_isi_crossbar_xlate_streams(struct mxc_isi_crossbar *xbar,
 	}
 
 	pad = media_pad_remote_pad_first(&xbar->pads[sink_pad]);
-	if (!pad) {
-		dev_dbg(xbar->isi->dev,
-			"no pad connected to crossbar input %u\n",
-			sink_pad);
-		return ERR_PTR(-EPIPE);
-	}
-
 	sd = media_entity_to_v4l2_subdev(pad->entity);
 	if (!sd) {
 		dev_dbg(xbar->isi->dev,
@@ -471,7 +464,8 @@ int mxc_isi_crossbar_init(struct mxc_isi_dev *isi)
 	}
 
 	for (i = 0; i < xbar->num_sinks; ++i)
-		xbar->pads[i].flags = MEDIA_PAD_FL_SINK;
+		xbar->pads[i].flags = MEDIA_PAD_FL_SINK
+				    | MEDIA_PAD_FL_MUST_CONNECT;
 	for (i = 0; i < xbar->num_sources; ++i)
 		xbar->pads[i + xbar->num_sinks].flags = MEDIA_PAD_FL_SOURCE;
 
-- 
Regards,

Laurent Pinchart

