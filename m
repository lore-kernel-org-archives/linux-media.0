Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172643EF0C2;
	Wed,  4 Feb 2026 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770204320; cv=none; b=QbIIDQSml6QqKYpHs/ADxDJKQpdFspx4uC7Av2PYlvt7yAhXYA5sKRnRoFrq3q9KQBqB0+0UA2QRZg3+o5D/DYqDIIFc3vO6u1fR3mNgcYzuBR3YJKHFJXHpHWMksCg7GDPu9TwpGsSyDMqH3KsYAJxfFbeOGSkIvJs4IspkVgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770204320; c=relaxed/simple;
	bh=iclPN213YkwPa7GEz0O6Lo/r6Ez5c+6GrJlnrVg1GZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWKiqTIzShm7T0eIJAm9EHD94nptU5EWabWrTI8waXk59fbN8IMcVsaaHKI6NckF45dasFIgLLEOrqDsD8C3NtwnY8q7nOJqcbzSgWzUyKFqRDi3zp3visNTul+1Y/uOSznU2T3SPvzmSMVp2QSSlIAjPWJ4LQLON02cOnc3XZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=I9Ba2pMZ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="I9Ba2pMZ"
Received: from t16.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5E1B210C4;
	Wed,  4 Feb 2026 12:24:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770204271;
	bh=iclPN213YkwPa7GEz0O6Lo/r6Ez5c+6GrJlnrVg1GZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I9Ba2pMZwtZSybtnMEdOBP0t/mo3fP4PY8d9Lo3MRnP9uOIzMtjSE+VRC8lzugVDT
	 LMH6Feh3sZoewAhb1udhgHhos9uggsP6Kc75OKE9y6yCADp8Vcuej5tOCt5bru85Q2
	 6kCFBVxhvfnSovc2XGyIZc5ggDjyX8MZgB1fNt6o=
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
Subject: [PATCH v1 1/6] media: rkisp1-resizer: Add YUV source formats to resizer
Date: Wed,  4 Feb 2026 11:25:01 +0000
Message-ID: <20260204112506.3706049-2-isaac.scott@ideasonboard.com>
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

To be able to use YUV bypass, YUV formats need to be available on the
source pad of the rkisp1 resizer. Add them.

Signed-off-by: Isaac Scott <isaac.scott@ideasonboard.com>
---
 .../platform/rockchip/rkisp1/rkisp1-resizer.c     | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
index 8e6b753d3081..e72b76ab078c 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
@@ -23,11 +23,26 @@ struct rkisp1_rsz_yuv_mbus_info {
 };
 
 static const struct rkisp1_rsz_yuv_mbus_info rkisp1_rsz_yuv_src_formats[] = {
+	{
+		.mbus_code	= MEDIA_BUS_FMT_UYVY8_2X8, /* YUV422 */
+		.hdiv		= 1,
+		.vdiv		= 1,
+	},
+	{
+		.mbus_code	= MEDIA_BUS_FMT_VYUY8_2X8, /* YUV422 */
+		.hdiv		= 1,
+		.vdiv		= 1,
+	},
 	{
 		.mbus_code	= MEDIA_BUS_FMT_YUYV8_2X8, /* YUV422 */
 		.hdiv		= 2,
 		.vdiv		= 1,
 	},
+	{
+		.mbus_code	= MEDIA_BUS_FMT_YVYU8_2X8, /* YUV422 */
+		.hdiv		= 1,
+		.vdiv		= 1,
+	},
 	{
 		.mbus_code	= MEDIA_BUS_FMT_YUYV8_1_5X8, /* YUV420 */
 		.hdiv		= 2,
-- 
2.43.0

