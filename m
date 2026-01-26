Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D7B303A1D
	for <linux-media@vger.kernel.org>; Mon, 26 Jan 2026 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769420987; cv=none; b=PweS6KgE0BgFh6Sp3ADsn6lwV6Jg+OLPyIsBHjkxb8G4ZR6Bmt9aW7Tn88d3oPh0mnt1PbsQBzku280ZC+12kHSGZeF5D7eTS9O9aNvgXJ1O8NgmaBu3ck+EFq8dr6yf/xz1/eLlpwOsqGnix1LlY+XpWHAOr3Ze9vZh+WUBTWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769420987; c=relaxed/simple;
	bh=RunNfY6DAjYj07zBWZKspZZ0/qrJfuE8wHSX/NWoupw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eXuWhHSKbZ63qWgapRKTaVJvad293lrbZZrDy0791wS6XApW6lE3C0od2RjS/aeaf+Gm4Fqxj869wc90yQqyRwf/5EEo53o0Hhkq1rseKWt9+VLGQuPoiBW9T4PsBBjCmFzJn/XK+cT7dqJ0KOpUDbn6Ax7BQvWhmTu/n9sdMiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=snLfa7gY; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="snLfa7gY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769420983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sOJFB+oF5VjUPhjg85f0tYFrmxxrS29kvKkgsvAPHOE=;
	b=snLfa7gY50z2v7oTjl+pLZPxaQeJ3PNPW6QxedMYdLnvuBQEoAN1n154IDOciis7SZr/rP
	6hUL9Tq5Sy5i/13+uZqCijVvckZqOLCqCTWlUH/2DH22gGnYPMgz/d2yfXzGWHvVJtRi+P
	HXcJyJoB+M4CdPctbRvo5yLtiYpZmtQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Devarsh Thakkar <devarsht@ti.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sebastian Fricke <sebastian.fricke@collabora.com>,
	David Huang <d-huang@ti.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Hans Verkuil <hverkuil@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] media: imagination: Fix value clamping in calculate_qp_tables
Date: Mon, 26 Jan 2026 10:49:27 +0100
Message-ID: <20260126094927.213302-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The local variable 'val' was never clamped to 1 or 255 because the
return value of clamp() was not used. Fix this by assigning the clamped
value back to 'val'.

Cc: stable@vger.kernel.org
Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/media/platform/imagination/e5010-jpeg-enc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
index 1c6e076033ec..d1df00df2f32 100644
--- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
+++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
@@ -175,12 +175,12 @@ static void calculate_qp_tables(struct e5010_context *ctx)
 		long long delta = v4l2_jpeg_ref_table_chroma_qt[i] * contrast + luminosity;
 		int val = (int)(v4l2_jpeg_ref_table_chroma_qt[i] + delta);
 
-		clamp(val, 1, 255);
+		val = clamp(val, 1, 255);
 		ctx->chroma_qp[i] = quality == -50 ? 1 : val;
 
 		delta = v4l2_jpeg_ref_table_luma_qt[i] * contrast + luminosity;
 		val = (int)(v4l2_jpeg_ref_table_luma_qt[i] + delta);
-		clamp(val, 1, 255);
+		val = clamp(val, 1, 255);
 		ctx->luma_qp[i] = quality == -50 ? 1 : val;
 	}
 
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

