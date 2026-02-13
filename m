Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0D036166F;
	Fri, 13 Feb 2026 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770991365; cv=none; b=t2TSjJWJXnbMoWw8QSBX51VKbl72VtX0xPaWye6YOY730P7yGpU0pwrR7A8WXYIe5ngQiyJGEFNOkEUWbllRypHPb85IuEbfNSkmGsFgvlWdY2dgwIaVrtWy7MQ71dWrsoxdWHtVGH9fPYq3ERmxGHjWCtGBH9SzXsYYKBq6NDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770991365; c=relaxed/simple;
	bh=P8a1SLszacb9BbOHbpLbKJIYNfiXLjxCTLO8qGQtWW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VAtrOe4wF0sVvmj7aofWooftQKkOhyYiXONL7YhZz2rQZa6Hc/IE55z77qQt+DygPTVS0kYFRgnaYnI8kbHGeDvRquWiZyalle2ZaDLfJ9NpjGAUJHvXY8RjxW8KBwC+76JottQ5DxJYktO9Z82Ce0XmBo4xJIRmalgHuRw2ILI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=OR1Kl9fV; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OR1Kl9fV"
Received: from ping.linuxembedded.co.uk (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4EB85276B;
	Fri, 13 Feb 2026 15:01:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770991283;
	bh=P8a1SLszacb9BbOHbpLbKJIYNfiXLjxCTLO8qGQtWW4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OR1Kl9fVXIhDi1WxR4Lp7FFQDtEn2GJU3QSrRQbRxObhzN1IEDs0U7ApzbYltP2nk
	 qKuPVOfLHY2N0KoWR0SEpvkE16x3CFmzGLJ57bQCBI3sVsjzR3c590VMF2wMCTetGV
	 9trkIXBs4VVPjm55n2o4kRFRT5KPlqtITq+QpYvY=
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Date: Fri, 13 Feb 2026 14:01:56 +0000
Subject: [PATCH v2 17/25] media: i2c: imx283: Crop leading lines with user
 clamp
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-mainline-imx283-v2-v2-17-be40a3770ebf@ideasonboard.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770991325; l=2034;
 i=kieran.bingham@ideasonboard.com; s=20260207; h=from:subject:message-id;
 bh=P8a1SLszacb9BbOHbpLbKJIYNfiXLjxCTLO8qGQtWW4=;
 b=gF5RdG93ja+kMVZW/x0PE6VYLLP3fqIaoO0zN5FK+MF7rzFM8pIOtjeilfXSKKFS0L+d1WfYA
 dAfr3CITjkJDMB5YnSmeFpBYUaIYFIxv11m5HrTb9bS9mfPciyXtnFI
X-Developer-Key: i=kieran.bingham@ideasonboard.com; a=ed25519;
 pk=FVXKN7YuwHc6UtbRUeTMAmranfsQomA+vnilfglWdaY=

The IMX283 introduces an extra line on the all-pixel scan out modes to
prevent bayer re-ordering on flip handling.

This is undesireable as it introduces the line in all crop
configurations when the image is not flipped.

The OB_SIZE_V register determines how many lines from the output will be
directed into the custom data type for optical black region.

To overcome the extra line which is forcefully added, utilise the
vertical optical black region to redirect the extra line. An additional
line also needs to be redirected to once again retain the bayer order.

Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 drivers/media/i2c/imx283.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/media/i2c/imx283.c b/drivers/media/i2c/imx283.c
index c3a44d2c6508..07958cd1889e 100644
--- a/drivers/media/i2c/imx283.c
+++ b/drivers/media/i2c/imx283.c
@@ -1169,6 +1169,29 @@ static int imx283_start_streaming(struct imx283 *imx283,
 		/* Clamp our top position now that VOB is handled */
 		top = max_t(s16, 0, top);
 
+		/*
+		 * The all-pixel scan modes introduce an 'extra line' at the
+		 * start of the image when not flipped. This is understood to be
+		 * a mechanism to preserve bayer ordering regardless of vflip
+		 * however it introduces an undesirable line of black pixels.
+		 *
+		 * Crop this by adding two extra lines and moving them into the
+		 * OB data type without impacting the effective image height or
+		 * positioning.
+		 *
+		 * It's ok for top to go negative here as the sensor does in
+		 * fact have extra 'hidden' lines in this region and the sensor
+		 * supports negative vertical cropping positions. (estimated
+		 * about 48 extra lines)
+		 */
+		if ((scan_mode(mode->scan, IMX283_MODE_0) ||
+		     scan_mode(mode->scan, IMX283_MODE_1)) &&
+		    imx283->vflip->val == 0) {
+			top -= 2;
+			v_ob += 2;
+			write_v_size += 2;
+		}
+
 		if (imx283->vflip->val)
 			top = -top;
 

-- 
2.52.0

