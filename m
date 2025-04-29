Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD852D81AE;
	Tue, 29 Apr 2025 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970831; cv=none; b=OJExlldkVPv8RPYZQttXaiBRvHTVUC5Lhj1aaiGSIKM04BLPO8WzD7dCuYAID+UIYCZ+RBEAv39XeWf+mBRReTX4hZ+S2nnS8nXX3l6f7YeUTbWPb3hVVX3Pdw2ruzYnSuz7+Tqq4bnfDX7PNBMPaBYsHeYPN0SZHvKDS2Mg8qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970831; c=relaxed/simple;
	bh=VhhjcaS0e9RmFb9D4hHy4jkKkyw1drYPOsFP6l5zVdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEAjrovcCnaZQPkxveMoENFmF5HJ1JFPwM5KH2R5Wztnp54bni48UPNh9IC0JToOqEser8dxzC62mG6hYaTa3bVXZNE7r1f61Qon9/B0Xh/pHRRNkYGnXWq/qQPnpyQylFj8rZ7aXXIw/xRXpCdHe9WZaXahuM0CHpWqSUOMwQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=vDc/Abcu; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vDc/Abcu"
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1199918D7;
	Wed, 30 Apr 2025 01:53:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1745970812;
	bh=VhhjcaS0e9RmFb9D4hHy4jkKkyw1drYPOsFP6l5zVdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vDc/AbcuhWpbr4VFNFsRrRjJZbPK0lNXZc2sPmlolveBMiDfa4qSt1v9KwzYL/8cZ
	 yYMi5gJ0ug7hXWnL9z67QChcVHQhU4aNT7VvFJOxwt8wa6HwhP1Gx84q8WJVTiOXEP
	 7N25foAZa6TcjX4sDZYn2OQGnT5G1YOyvwgM9yYk=
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 6/7] media: renesas: vsp1: Fix format propagation on the BRX
Date: Wed, 30 Apr 2025 02:53:21 +0300
Message-ID: <20250429235322.29826-7-laurent.pinchart+renesas@ideasonboard.com>
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

The format width and height is never propagated to the BRX source pad,
leaving its initial configuration invalid. Propagate the whole format
from the first sink pad to the source pad instead of only propagating
the media bus code. This fixes compliance with the subdev format
propagation rules.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/media/platform/renesas/vsp1/vsp1_brx.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/renesas/vsp1/vsp1_brx.c b/drivers/media/platform/renesas/vsp1/vsp1_brx.c
index dd651cef93e4..911359faa600 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_brx.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_brx.c
@@ -156,14 +156,20 @@ static int brx_set_format(struct v4l2_subdev *subdev,
 		compose->height = format->height;
 	}
 
-	/* Propagate the format code to all pads. */
+	/*
+	 * Propagate the format code to all pads, and the whole format to the
+	 * source pad.
+	 */
 	if (fmt->pad == BRX_PAD_SINK(0)) {
 		unsigned int i;
 
-		for (i = 0; i <= brx->entity.source_pad; ++i) {
+		for (i = 0; i < brx->entity.source_pad; ++i) {
 			format = v4l2_subdev_state_get_format(state, i);
 			format->code = fmt->format.code;
 		}
+
+		format = v4l2_subdev_state_get_format(state, i);
+		*format = fmt->format;
 	}
 
 done:
-- 
Regards,

Laurent Pinchart

