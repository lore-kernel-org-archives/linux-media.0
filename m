Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9C1363C62;
	Fri, 13 Feb 2026 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770991368; cv=none; b=SilEp5RasYrzP+0gS32q7AUnSj/xtTw+zNUEvTmOcm7p+qsau5RxHskMT/edYmwoixtTWNR48F3xpEENdpi7Qq5ut6IVEp9gH/sOxR8JGuJfPEef1S+Iv+t+aItZ7D7kezAJ3eOGyaVU4+WDR3dLbx0PQNj74LkULcXXDRp7T4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770991368; c=relaxed/simple;
	bh=2WgGoX5anWO8ec8ptn6Vz02ywqnBiOH3zospwkSrUyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xy8XukLY6wqozqSLYogPokHrsZotzJ9g7l5zLMWnjZEuhtBUw9a9qF2DzNKQpPPqQgYKOttonxkGuJAQFjuDSkO45OsaqPFV8pX/zkREYHcA2+GvRu846xB5GVcYGNypj36qHXM07upLO1lK5X5/Zgp8c/+TtOxo6jJonw2EeyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=eidpHQw1; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="eidpHQw1"
Received: from ping.linuxembedded.co.uk (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 12B1427F6;
	Fri, 13 Feb 2026 15:01:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770991284;
	bh=2WgGoX5anWO8ec8ptn6Vz02ywqnBiOH3zospwkSrUyY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eidpHQw1DID1MU6NQXUB11jA4XVIgJoNPNmKyWRY8WnWUUlwiRO6zHO+1yEvwTtjh
	 hxh5AilgwpudVUI9KP4jS67Rs79ZhDOSrL/Zn0c26UU6+yQwLd+UUgZIWPApe2fAY8
	 ndxgm6Hz0snqt0m+5fEoeNMnbj2HSIr4dTQQzW4c=
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Date: Fri, 13 Feb 2026 14:01:58 +0000
Subject: [PATCH v2 19/25] media: i2c: imx283: Provide Native pixel array
 capture mode
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-mainline-imx283-v2-v2-19-be40a3770ebf@ideasonboard.com>
References: <20260213-mainline-imx283-v2-v2-0-be40a3770ebf@ideasonboard.com>
In-Reply-To: <20260213-mainline-imx283-v2-v2-0-be40a3770ebf@ideasonboard.com>
To: Umang Jain <uajain@igalia.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>
Cc: Jai Luthra <jai.luthra@ideasonboard.com>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770991325; l=1104;
 i=kieran.bingham@ideasonboard.com; s=20260207; h=from:subject:message-id;
 bh=2WgGoX5anWO8ec8ptn6Vz02ywqnBiOH3zospwkSrUyY=;
 b=JvFS7SVDjOF+DDNn0f/82yMDi6j88Y6+mbOZPnSm1kG23TxmmUi9qd2dUuHqggjBsGOxmWE2S
 T4YKJsS4MlxB5+lTlWbXbTiDh53ihUyAsEW3uCW3RABt5VWwlRPPbhO
X-Developer-Key: i=kieran.bingham@ideasonboard.com; a=ed25519;
 pk=FVXKN7YuwHc6UtbRUeTMAmranfsQomA+vnilfglWdaY=

Provide a mode that outputs all pixels from the full native array.

Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 drivers/media/i2c/imx283.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/media/i2c/imx283.c b/drivers/media/i2c/imx283.c
index df48793835fd..4976c08c6832 100644
--- a/drivers/media/i2c/imx283.c
+++ b/drivers/media/i2c/imx283.c
@@ -508,6 +508,21 @@ static const struct imx283_reg_list link_freq_reglist[] = {
 
 /* Mode configs */
 static const struct imx283_mode supported_modes_12bit[] = {
+	{
+		/* Full Native pixel array, including HOB/VOB. 5592x3710 */
+		.scan = &imx283_scan_modes[IMX283_MODE_0],
+
+		.width = 5592,
+		.height = 3710, /* 3694 + 16 additional lines for VOB */
+		.min_hmax = 5914, /* 887 @ 480MHz/72MHz */
+		.min_vmax = 3793, /* Lines */
+
+		/* 20.00 FPS */
+		.default_hmax = 6000, /* 900 @ 480MHz/72MHz */
+		.default_vmax = 4000,
+
+		.crop = imx283_native_area,
+	},
 	{
 		/* 20MPix 21.40 fps readout mode 0 */
 		.scan = &imx283_scan_modes[IMX283_MODE_0],

-- 
2.52.0

