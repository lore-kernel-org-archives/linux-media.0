Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717F13EFD18;
	Wed,  4 Feb 2026 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770204323; cv=none; b=g9xF4p0vdgIlkr8OFIyJGWctZgxlINeJNIK9smFDhgULjiYtAoWIsto0DQ1LBWfVQZRYyGUzjb3gLZLrfwD206ByA8a4O0vV1fIx3m+jXtVuuyb7gF2fR9HtEUOEYb/MBaEFl1xNbF8CxCNply3hdqJMZ7H5Jiieepl2/g0ZUEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770204323; c=relaxed/simple;
	bh=UusNAsGsuADFh1LH6Jjf0gCE90ONPblIBTQZe3RyvTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfPjBh1PyJsCdPfGoyDw+01aAcTuOCVt9klxmmX+aGHpCJ5Mr5HlwzMhAnuhBg4i5qW/BKjQjqEISphzssPUeV3b+fQTXkamy/Eb2WX0udxUs0ylELJbCH5gBMk1Ld9DI0PrlRL8vLrKgeKIE+64vJIeo45aao48vxb6+2Wn6/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=pYTgLfH4; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pYTgLfH4"
Received: from t16.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8580013CA;
	Wed,  4 Feb 2026 12:24:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770204277;
	bh=UusNAsGsuADFh1LH6Jjf0gCE90ONPblIBTQZe3RyvTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pYTgLfH4dCqrkwTHh3DyTlB/tVpX+dr3Bj6rgebnkyOdUQg9ljmR6905Ya0RlILki
	 7qwVR4wA2Liz1HfhBSL4WxU2krZd9hBbY2O1bPNJER5m93VuXDz8BMiPEd5REw0a57
	 b8J+P8fnFPQ7fjbWvkxL9ahytugVAVLKdH4SRWEc=
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
Subject: [PATCH v1 5/6] media: rkisp1: Give buffers back instead of dropping in bypass mode
Date: Wed,  4 Feb 2026 11:25:05 +0000
Message-ID: <20260204112506.3706049-6-isaac.scott@ideasonboard.com>
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

In the data mode used for YUV passthrough, falling VSYNC events are used
to determine when a buffer is complete. This means there is no 'Frame
End' signal.

Previously, all buffers would be dropped when bypass mode was active.
Instead of dropping every frame, we should return the buffer to user
space if it is marked as complete by a falling VSYNC signal.

Signed-off-by: Isaac Scott <isaac.scott@ideasonboard.com>
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
index 867cdddf9f89..2753be39ab33 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
@@ -832,6 +832,11 @@ irqreturn_t rkisp1_capture_isr(int irq, void *ctx)
 	for (i = 0; i < dev_count; ++i) {
 		struct rkisp1_capture *cap = &rkisp1->capture_devs[i];
 
+		if (rkisp1->in_bypass) {
+			rkisp1_handle_buffer(cap);
+			continue;
+		}
+
 		if (!(status & RKISP1_CIF_MI_FRAME(cap)))
 			continue;
 		if (!cap->is_stopping) {
-- 
2.43.0

