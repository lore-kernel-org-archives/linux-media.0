Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E27F21CC55
	for <linux-media@vger.kernel.org>; Wed,  5 Nov 2025 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355961; cv=none; b=U9pev12HydVomY3ek21bbZa8h738uxE2EYsiFszgU5fZWnXdNlZ2L42ho1koqOa7hp4BfmJT6Y86ydujsSjUVz5bUJYUVQUc8VXjZvFWB6pyS6G0uvRHqEqNSRX47kOnIMAzz4kmIvlcIZ8kcOLTgGu40mX6ueYkVxhDDpm48ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355961; c=relaxed/simple;
	bh=ZgWPGx7mIkJ8YYrX3sMPKx3tm3HlevoxY+b8FqsxBXM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sn9v5tFst47asUvpopdzBKBQveT41bNLtYxJHQMvrZtCYzp0ZBAR11pJ7MOBDmO+eLcW1sAX6g/tEARaFN5Op0SAUQKwSwS7Fe/HcmeKTOPu61B39aaNj3BO8qqA1zGFF95ZE8mTj7Nokm6MU70D4I3S/0J8CACQr9GvU/XOh3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vGfHy-0002IK-1b; Wed, 05 Nov 2025 16:19:10 +0100
From: Michael Tretter <m.tretter@pengutronix.de>
Subject: [PATCH 0/2] media: staging: imx: fix multiple video input
Date: Wed, 05 Nov 2025 16:18:48 +0100
Message-Id: <20251105-media-imx-fixes-v1-0-99e48b4f5cbc@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANhqC2kC/x3LQQqAIBBA0avIrBtQQYSuEi1Mx5qFFgohiHdPW
 j4+v0OlwlRhFR0KvVz5zhNqEeAvl09CDtOgpTZKSYOJAjvk1DByo4rOU7TW28MpDfN6Cv1hTts
 +xge4w6S6YQAAAA==
X-Change-ID: 20251105-media-imx-fixes-acef77c7ba12
To: Steve Longerbeam <slongerbeam@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Hans Verkuil <hans.verkuil@cisco.com>
Cc: linux-media@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
 Michael Tretter <michael.tretter@pengutronix.de>, 
 Michael Tretter <m.tretter@pengutronix.de>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org

If the IMX media pipeline is configured to receive multiple video
inputs, the second input stream may be broken on start. This happens if
the IMX CSI hardware has to be reconfigured for the second stream, while
the first stream is already running.

The IMX CSI driver configures the IMX CSI in the link_validate callback.
The media pipeline is only validated on the first start. Thus, any later
start of the media pipeline skips the validation and directly starts
streaming. This may leave the hardware in an inconsistent state compared
to the driver configuration. Moving the hardware configuration to the
stream start to make sure that the hardware is configured correctly.

Patch 1 removes the caching of the upstream mbus_config in
csi_link_validate and explicitly request the mbus_config in csi_start,
to get rid of this implicit dependency.

Patch 2 actually moves the hardware register setting from
csi_link_validate to csi_start to fix the skipped hardware
reconfiguration.

Signed-off-by: Michael Tretter <michael.tretter@pengutronix.de>
---
Michael Tretter (2):
      media: staging: imx: request mbus_config in csi_start
      media: staging: imx: configure src_mux in csi_start

 drivers/staging/media/imx/imx-media-csi.c | 84 ++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 36 deletions(-)
---
base-commit: 27afd6e066cfd80ddbe22a4a11b99174ac89cced
change-id: 20251105-media-imx-fixes-acef77c7ba12

Best regards,
-- 
Michael Tretter <m.tretter@pengutronix.de>

