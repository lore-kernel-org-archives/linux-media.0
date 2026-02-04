Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8F33F0745;
	Wed,  4 Feb 2026 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770204323; cv=none; b=YARS6mquXqIfA7eLRe/0VonNc02LI5nNexaWfiNg26PaXagvK93Z4UeCQO7DVVts+rvxYxRhm6l7sh4WlaqwtsjKeAk1WYvMs4Cz3FQo5ho92Am/Gwo/t+GSFox+4GJuZeCiFU5FHhqkC68c8WlkOcrIU30U6dm38YkPJ+8UVDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770204323; c=relaxed/simple;
	bh=Bt1EGAdaqcvf0NyytShh8FFlf4eE/kulWr9PEZlTjh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6zWDsKAssMyZ7LKmCalGI/uvfr14PCS58/m96ZfmSZyQ7dr4Yx1BVok+f+J0lLW8X3X7fLu8CqXPYKt5eoPogm23sQT8g1sWpXZZOr4+Dwqw02oRuwzCKeBnJjNIi+kWUyjCA/JPN2U7CZMNkVLO7Cx5Bb477iCYqwZqRA8eEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=CfDh3q0c; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="CfDh3q0c"
Received: from t16.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 49AFD13AB;
	Wed,  4 Feb 2026 12:24:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770204279;
	bh=Bt1EGAdaqcvf0NyytShh8FFlf4eE/kulWr9PEZlTjh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CfDh3q0c14ZEYW60C/Y3EC2oNNN13NbkHClS0vfboFM4vgN/lHfvOYllJV2JqxIZH
	 hkiLBx6yFbhH/k6EKdmhi1pj/w78MDgKGWkaQr7ThPoSnr4KZkielFqrk2AQWHx+LM
	 y7lOV3+9tqCDyZfhy85HP1Jvln8uDrB98A+sBmRw=
From: Isaac Scott <isaac.scott@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: dafna@fastmail.com,
	laurent.pinchart@ideasonboard.com,
	mchehab@kernel.org,
	heiko@sntech.de,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Isaac Scott <isaac.scott@ideasonboard.com>
Subject: [PATCH v1 6/6] media: rkisp1: Treat 8 bus width and 16 bus width formats the same
Date: Wed,  4 Feb 2026 11:25:06 +0000
Message-ID: <20260204112506.3706049-7-isaac.scott@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204112506.3706049-1-isaac.scott@ideasonboard.com>
References: <20260204112506.3706049-1-isaac.scott@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As MIPI CSI is a serial interface, we should be able to use a bit depth
of 16 in the same way as 8 bit depth. Add a fallthrough case to ensure
we don't reject 16 bit depth formats.

Signed-off-by: Isaac Scott <isaac.scott@ideasonboard.com>
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
index c457593526c5..722ebcfbddbb 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
@@ -265,6 +265,7 @@ static int rkisp1_config_isp(struct rkisp1_isp *isp,
 
 		switch (sink_fmt->bus_width) {
 		case 8:
+		case 16:
 			acq_prop |= RKISP1_CIF_ISP_ACQ_PROP_IN_SEL_8B_ZERO;
 			break;
 		case 10:
-- 
2.43.0

