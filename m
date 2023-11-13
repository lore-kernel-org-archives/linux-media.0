Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42821C2B7
	for <linux-media@vger.kernel.org>; Mon, 13 Nov 2023 10:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Ro+BXqp3"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241DC135
	for <linux-media@vger.kernel.org>; Mon, 13 Nov 2023 02:17:14 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 22E2A10A;
	Mon, 13 Nov 2023 11:16:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1699870607;
	bh=FW8CeYG0XjUIcMGDaUkR8/E/DrGWF7zbJ3v4Hwljb0Y=;
	h=From:To:Cc:Subject:Date:From;
	b=Ro+BXqp34oz03sZF7YYMl+Iq83fX4WVuG5ZyWdqwdJ0SV09uyqRGEl1HgRkXV1O93
	 w6Y3JkMeKhzfRM3oTpu7pv60gntk8fLzshiVR+OVt3an57b6LZgNJFnjHfN0soKWSR
	 bU0W6OiJgCjIDb/GDJs/0Uu0qqiN7xZq1XraggIU=
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@iki.fi>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: [PATCH v1 0/2] media: v4l2-subdev: Fix link validation issue
Date: Mon, 13 Nov 2023 12:17:16 +0200
Message-ID: <20231113101718.6098-1-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This small patch series addresses an incorrect (in my opinion) warning
printed by the v4l2_subdev_link_validate() helper. Patch 1/2 is a small
drive-by cleanup, and the important change is in 2/2. Please see the
patch commit message for details.

The series has been tested with the VSP1 driver, and correctly gets rid
of the warning.

Laurent Pinchart (2):
  media: v4l2-subdev: Drop unreacheable warning
  media: v4l2-subdev: Relax warnings in link validation

 drivers/media/v4l2-core/v4l2-subdev.c | 38 ++++++++++++++++-----------
 1 file changed, 23 insertions(+), 15 deletions(-)


base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
Regards,

Laurent Pinchart

