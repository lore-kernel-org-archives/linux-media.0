Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0442F49F1
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871800; cv=none; b=pbvAR377IDKRsYTBn3/5BlQc/Tg2rrddZLhtyxORgsPlHMloIpo3nkGZdwNaTgmagJ+0xstN7Ispi33Gct2ifUsRkHc4MKwe7wMLeEM+ryne04zBqTpk9QSFwhIVHrOcc0/R9LJs7KLi0NpQby1ZHJ27T/ur36cXMPGVzTHa+Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871800; c=relaxed/simple;
	bh=u+fGuDGhPULDAlQePOG1Fb6NppZp2du65FcEAu71qsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G94x8LHGGOH3xw3szJP36SLZOdb29ZAOD06i+Ut+bnbHguUWuhGNR80kT8H5KnjKjEHgvHSn0XDjtuXr041JoDmIq9FhyZ56voGmJFcBayPKm4tS93nPr3JKGLmS5JyM4UvkgRvss3mp8nlkuRZR0pNMEDmiFQf6Ke11GwAcx4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vIpU4-0004Ul-9L; Tue, 11 Nov 2025 15:36:36 +0100
From: Michael Tretter <m.tretter@pengutronix.de>
Date: Tue, 11 Nov 2025 15:36:16 +0100
Subject: [PATCH 3/4] media: adv7180: implement g_register and s_register
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-b4-adv7180-vpp-sub-device-v1-3-9877fe9f709b@pengutronix.de>
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

The g_register and s_register callbacks are useful for debugging the
adv7180.

Implement the callbacks to expose the register debugging to userspace.

Signed-off-by: Thorsten Schmelzer <tschmelzer@topcon.com>
Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
 drivers/media/i2c/adv7180.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c
index 4152f2049a6d..d289cbc2eefd 100644
--- a/drivers/media/i2c/adv7180.c
+++ b/drivers/media/i2c/adv7180.c
@@ -969,6 +969,32 @@ static int adv7180_subscribe_event(struct v4l2_subdev *sd,
 	}
 }
 
+#ifdef CONFIG_VIDEO_ADV_DEBUG
+static int adv7180_g_register(struct v4l2_subdev *sd,
+			      struct v4l2_dbg_register *reg)
+{
+	struct adv7180_state *state = to_state(sd);
+	int ret;
+
+	ret = adv7180_read(state, reg->reg);
+	if (ret < 0)
+		return ret;
+
+	reg->val = ret;
+	reg->size = 1;
+
+	return 0;
+}
+
+static int adv7180_s_register(struct v4l2_subdev *sd,
+			      const struct v4l2_dbg_register *reg)
+{
+	struct adv7180_state *state = to_state(sd);
+
+	return adv7180_write(state, reg->reg, reg->val);
+}
+#endif
+
 static const struct v4l2_subdev_video_ops adv7180_video_ops = {
 	.s_std = adv7180_s_std,
 	.g_std = adv7180_g_std,
@@ -982,6 +1008,10 @@ static const struct v4l2_subdev_video_ops adv7180_video_ops = {
 static const struct v4l2_subdev_core_ops adv7180_core_ops = {
 	.subscribe_event = adv7180_subscribe_event,
 	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
+#ifdef CONFIG_VIDEO_ADV_DEBUG
+	.g_register = adv7180_g_register,
+	.s_register = adv7180_s_register,
+#endif
 };
 
 static const struct v4l2_subdev_pad_ops adv7180_pad_ops = {

-- 
2.47.3

