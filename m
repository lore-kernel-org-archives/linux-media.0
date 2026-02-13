Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0160036074B;
	Fri, 13 Feb 2026 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770991335; cv=none; b=V7KoMJ0/9Uq19JwbQFXIdfz8AL4rUdMYwagw96SR2Kv3dLcKvozOi4nN8tPBsokAWTzZRugLZHWfeqgN03RXHjAN01JneZ37MObXw8hvtH+avbAQM4NPaqCiJxKbd3ZxfRdcHAKQYoM4IMuF0m1idiIoODiiDep6nR2dD+BpKpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770991335; c=relaxed/simple;
	bh=9kXjyYaL4aJFjcgrdkKkCBrOvdUj19zGBigH7bk/Tvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EDqShMYQiATUZzs5ImPnBYLMrkw6JtRarnSVwTQ29HD+Ac0ZF9MkHnlVLzfOdjRtjlWhbsadkrLuqeM8DeT2xHhPAfDkCRKZDZDZA6PRgzCMHloNaT3+T78Lxt7MvzmnKV13fdc4apPk7rUGI6TjbrLi9JwJfI9dupuG6YtaTI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=eUey0DPY; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="eUey0DPY"
Received: from ping.linuxembedded.co.uk (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CB22E2691;
	Fri, 13 Feb 2026 15:01:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770991279;
	bh=9kXjyYaL4aJFjcgrdkKkCBrOvdUj19zGBigH7bk/Tvo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eUey0DPYiRRmKTPIkpLQtnZDEO1BKEIVSU+p27mgJm8qOuOQnBzclsm/bScB0uFNy
	 fMldCzeDr3LwEvHKCwC7rrjOQS1w5USQ06zPiyzntnhSu66CtN6gmXriDY1BMpStFO
	 QuUS99jOjmLwAWS+MOGuroFoLH9zZeYE1ydAitRw=
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Date: Fri, 13 Feb 2026 14:01:44 +0000
Subject: [PATCH v2 05/25] media: i2c: imx283: Remove horizontal_ob
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-mainline-imx283-v2-v2-5-be40a3770ebf@ideasonboard.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770991325; l=1513;
 i=kieran.bingham@ideasonboard.com; s=20260207; h=from:subject:message-id;
 bh=9kXjyYaL4aJFjcgrdkKkCBrOvdUj19zGBigH7bk/Tvo=;
 b=BxTYFOA/Dfh4csfUUvJgOoxZ0Hbw35akOXoeBM6OFwLqR021WW7CenFBaRHLFMF94tX8+U2An
 AIfRC2jllbeD9x/JI+NcPzYD3eu1U1RMs9tzT73bLcc2qRThgPyThij
X-Developer-Key: i=kieran.bingham@ideasonboard.com; a=ed25519;
 pk=FVXKN7YuwHc6UtbRUeTMAmranfsQomA+vnilfglWdaY=

The horizontal optical black values are not used as we do not enable
HOB output - and instead directly use HTRIMMING to request the desired
horizontal cropping position.

Remove the unused reference to simplify.

Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 drivers/media/i2c/imx283.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/media/i2c/imx283.c b/drivers/media/i2c/imx283.c
index 3e97ad38f716..fe63700da872 100644
--- a/drivers/media/i2c/imx283.c
+++ b/drivers/media/i2c/imx283.c
@@ -382,7 +382,6 @@ struct imx283_mode {
 	u8 vbin_ratio;
 
 	/* Optical Blanking */
-	u32 horizontal_ob;
 	u32 vertical_ob;
 
 	/* Analog crop rectangle. */
@@ -466,7 +465,6 @@ static const struct imx283_mode supported_modes_12bit[] = {
 		.default_vmax = 4000,
 
 		.min_shr = 11,
-		.horizontal_ob = 96,
 		.vertical_ob = 16,
 		.crop = {
 			.top = 40,
@@ -497,7 +495,6 @@ static const struct imx283_mode supported_modes_12bit[] = {
 		.vbin_ratio = 2,
 
 		.min_shr = 12,
-		.horizontal_ob = 48,
 		.vertical_ob = 4,
 
 		.crop = {
@@ -529,7 +526,6 @@ static const struct imx283_mode supported_modes_12bit[] = {
 		.vbin_ratio = 3,
 
 		.min_shr = 16,
-		.horizontal_ob = 32,
 		.vertical_ob = 4,
 
 		.crop = {
@@ -555,7 +551,6 @@ static const struct imx283_mode supported_modes_10bit[] = {
 		.default_vmax = 3840,
 
 		.min_shr = 10,
-		.horizontal_ob = 96,
 		.vertical_ob = 16,
 		.crop = {
 			.top = 40,

-- 
2.52.0

