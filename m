Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED752299A81
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510602; cv=none; b=QX8ouk0JXnnyqfG5zfnTGB9zlQFGCkUWQnG0GGdgpyTvEP0OlmJyTujRU6N4Luq0Tf7Wbg7uA1mQx3Jih7Z31txqaN+G/7hYcXqiaDDShwPBCKk0vdgH1fNfRDagDIGbizcWQFtoV7gqabwJvc0XlwOV3MbW1SMpyuNdidVvU2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510602; c=relaxed/simple;
	bh=O3bvkfV5QbGsc+GXY07pTF/lPqZFj/CEJygNCquciLk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WymMCqJi/t9yU5fLWXUcmq4Td1FMLYj5YNHuVUmU0+bIVj9xSOdSMscRWgQx1ITwGfRxLTecODeUZhzmJHDgJLambI7h1QqAPX4XyFXeK3oslMWvBUQVvyCNp1G97vF9k0vegvY1dIo0F4aKAzef/7mfLvof5qAAHEIYHm+DVsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vHJWH-0003HZ-Jj; Fri, 07 Nov 2025 11:16:37 +0100
From: Michael Tretter <m.tretter@pengutronix.de>
Subject: [PATCH 0/3] media: imx-csi: cleanup media pipeline start
Date: Fri, 07 Nov 2025 11:16:32 +0100
Message-Id: <20251107-media-imx-cleanup-v1-0-f82a693c28f4@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAADHDWkC/x3MQQqAIBBA0avErBvQwYi6SrQQnWogTZQiiO6et
 HyL/x8onIULjM0DmS8pcsQK3TbgNhtXRvHVQIo6rVWPgb1YlHCj29nGM+GgiPxgtGVjoHYp8yL
 3/5zm9/0AuPJy4WMAAAA=
X-Change-ID: 20251107-media-imx-cleanup-9022d941ae44
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

The imx media device currently assumes that there is only a single media
pipeline. However, the media graph has multiple imx capture devices.
These may be started separately on media pipelines if they don't cause
conflicts in the media graph.

Move the media pipeline from the media device to the capture devices to
properly track and handle multiple media pipelines for the imx-csi.
Refactor the code to start the media pipeline from the driver to help
the reader.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
Michael Tretter (3):
      media: imx-csi: move media_pipeline to video device
      media: imx-csi: explicitly start media pipeline on pad 0
      media: imx-csi: use media_pad_is_streaming helper

 drivers/staging/media/imx/imx-media-capture.c |  8 ++++----
 drivers/staging/media/imx/imx-media-utils.c   | 12 ++++++++----
 drivers/staging/media/imx/imx-media.h         |  7 ++++---
 3 files changed, 16 insertions(+), 11 deletions(-)
---
base-commit: 1a31cb2782104969e48c7ce7e4fc06e403fcb5cf
change-id: 20251107-media-imx-cleanup-9022d941ae44

Best regards,
-- 
Michael Tretter <m.tretter@pengutronix.de>

