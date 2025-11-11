Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30B8302CA3
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871799; cv=none; b=KlGz4uH/qEhIsxT6ICSp6mCMucqFuMLt//pBnWiUBX2tIT1yggS61a3a2HARZ8di6LxBmiu94qXilTsnNx3OyeasXI1WvevILtvkKKx1Gpi4gD5h2K4s125jyvZQxLewyT8a39eJjieC93TktP+Q3EepmjxmqoSrOMlMoZJhwvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871799; c=relaxed/simple;
	bh=rJFjSaWVvKo++wfTtlWEzrnXG3ul3yvXKa6GqQjo92s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iZ+Gu4ngckqHxVcRERzpDSYq0ySoZbqTKTJIgiBaQX2pus7pny0lRdlohItQh2bNkC0bbHTOeSyL6zHSEM1HsjacjTVOl1moas5QG6PWmLna6u74WCNZpRrk/l5SwPD3Rv0V2wCxn34wMsQEMd0Bf/Ww+2Ni+yMp5Hr3flOBkd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vIpU4-0004Ul-Au; Tue, 11 Nov 2025 15:36:36 +0100
From: Michael Tretter <m.tretter@pengutronix.de>
Date: Tue, 11 Nov 2025 15:36:17 +0100
Subject: [PATCH 4/4] media: adv7180: fix frame interval in progressive mode
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-b4-adv7180-vpp-sub-device-v1-4-9877fe9f709b@pengutronix.de>
References: <20251111-b4-adv7180-vpp-sub-device-v1-0-9877fe9f709b@pengutronix.de>
In-Reply-To: <20251111-b4-adv7180-vpp-sub-device-v1-0-9877fe9f709b@pengutronix.de>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 kernel@pengutronix.de, Michael Tretter <m.tretter@pengutronix.de>, 
 Thorsten Schmelzer <tschmelzer@topcon.com>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org

From: Thorsten Schmelzer <tschmelzer@topcon.com>

The ADV7280-M may internally convert interlaced video input to
progressive video. If this mode is enabled, the ADV7280-M delivers
progressive video at the full refresh rate of 50 FPS (PAL) or 60 FPS
(NTSC).

Fix the reported frame interval if progressive video is enabled.

Signed-off-by: Thorsten Schmelzer <tschmelzer@topcon.com>
Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
 drivers/media/i2c/adv7180.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c
index d289cbc2eefd..3a5a0818bc5f 100644
--- a/drivers/media/i2c/adv7180.c
+++ b/drivers/media/i2c/adv7180.c
@@ -491,6 +491,7 @@ static int adv7180_get_frame_interval(struct v4l2_subdev *sd,
 				      struct v4l2_subdev_frame_interval *fi)
 {
 	struct adv7180_state *state = to_state(sd);
+	bool progressive;
 
 	/*
 	 * FIXME: Implement support for V4L2_SUBDEV_FORMAT_TRY, using the V4L2
@@ -499,12 +500,14 @@ static int adv7180_get_frame_interval(struct v4l2_subdev *sd,
 	if (fi->which != V4L2_SUBDEV_FORMAT_ACTIVE)
 		return -EINVAL;
 
+	progressive = (state->field == V4L2_FIELD_NONE);
+
 	if (state->curr_norm & V4L2_STD_525_60) {
 		fi->interval.numerator = 1001;
-		fi->interval.denominator = 30000;
+		fi->interval.denominator = progressive ? 60000 : 30000;
 	} else {
 		fi->interval.numerator = 1;
-		fi->interval.denominator = 25;
+		fi->interval.denominator = progressive ? 50 : 25;
 	}
 
 	return 0;

-- 
2.47.3

