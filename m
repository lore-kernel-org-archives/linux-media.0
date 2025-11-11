Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C452F5339
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871799; cv=none; b=rdDnar/eq/BulK0iLFA/SZnM1s2LFvSro33XP+54vGnCpO0D7KjhDrLAxKAoRGaKbP0BfUtUl23+oH6nTTic23JLW3HBYCQxFKQbo8G/e/Pq9YWNgkxk5uzRBq/cj9ci5FQgXC/89tHu8+FB4zTWk4WzNZG2rAvrxbvQwgDK2H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871799; c=relaxed/simple;
	bh=NSHW+iEwcgPDJgnnlre4y7ZLL79WFUxR3azPJsCpSnk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HthhAzSKLkun/K7Kxr/Tj2asK/oyBosDLqldZB0SXkPeXHhG2f08+p0If0q3MyPBvyRaa4Wml+zAX5vPNNHkv88eKfPZ0mAEySUpnSilReoj+ujwCH7eEMvYjYIg2fok2iEWCDnf000C7MW/aYVl6o+GsVZIU9vGzA89Z2CqsQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vIpU4-0004Ul-56; Tue, 11 Nov 2025 15:36:36 +0100
From: Michael Tretter <m.tretter@pengutronix.de>
Subject: [PATCH 0/4] media: adv7180: make VPP handling more flexible
Date: Tue, 11 Nov 2025 15:36:13 +0100
Message-Id: <20251111-b4-adv7180-vpp-sub-device-v1-0-9877fe9f709b@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN1JE2kC/x2MSQqAMAwAvyI5G7AuVP2KeOgSNRctLRZB+neDc
 5vDzAuJIlOCuXohUubE1ymi6grcYc6dkL04tE07KAFtj8ZnrcYGcwiYboteOkdone8GbbTpJwX
 Sh0gbP/97WUv5AKt6uGFrAAAA
X-Change-ID: 20251111-b4-adv7180-vpp-sub-device-bcd357a7a491
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

The adv7280 and adv7280-m have a Video Post Processor (VPP) unit that is
able to de-interlace the video signal.

This series makes the handling of the VPP more flexible. Furthermore, it
fixes the reported frame interval if the VPP is enabled.

Patches 1 and 2 add the device tree bindings and driver handling to
specify the (programmable) I2C address of the VPP slave device via
device tree.

Patch 3 exposes the registers of the adv via CONFIG_VIDEO_ADV_DEBUG to
user space for improved debugging capabilities.

Patch 4 fixes the frame interval that is reported by the driver if the
de-interlacing is active.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
Michael Tretter (1):
      media: dt-bindings: adi,adv7180: add VPP and CSI register maps

Thorsten Schmelzer (3):
      media: adv7180: add support for ancillary devices
      media: adv7180: implement g_register and s_register
      media: adv7180: fix frame interval in progressive mode

 .../devicetree/bindings/media/i2c/adi,adv7180.yaml | 44 +++++++++++++++++
 drivers/media/i2c/adv7180.c                        | 55 ++++++++++++++++++----
 2 files changed, 89 insertions(+), 10 deletions(-)
---
base-commit: b4fbb13db86adb0bae1d7f968b61ea8dc9635e33
change-id: 20251111-b4-adv7180-vpp-sub-device-bcd357a7a491

Best regards,
-- 
Michael Tretter <m.tretter@pengutronix.de>

