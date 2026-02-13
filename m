Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A156F363C4E;
	Fri, 13 Feb 2026 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770991367; cv=none; b=dd2vQqwgX5/imOLNcwYEwIytNt+137oL0WJttPD5E57bk6m0H0nrw7oAdql80I1IqEG4lkA4Xxfs6m8bavGUqgKZw6yNikZ8+cW9u1kq9dptUK/BWmMzCLwV9ihW1fVUjUXD/ApGDv/hQYN+OuWL7iUqlhucngS+sIVzk/Qyk6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770991367; c=relaxed/simple;
	bh=wi2tcDwDnfbgeUOKoPs3aaLiCLXC032zvoFk/I/sCsg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ab8FvuN/BGPrqQsYBSCiVYkcFoj7RJRnGa5YszSctzsy2NPkSFYiYh4WZUHLK5Ns8dEFe3kBRzNuBXPcRoGudQsm8cU+cJOm61vXldYMxbGmAGOiGDmdrQ/htruPXK7u0SaQe1MwUQBKA0a7BGahSjOU9QN7mS0ziYoKSRVBR8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Sdq1NGMK; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Sdq1NGMK"
Received: from ping.linuxembedded.co.uk (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id AA4AA27F4;
	Fri, 13 Feb 2026 15:01:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770991283;
	bh=wi2tcDwDnfbgeUOKoPs3aaLiCLXC032zvoFk/I/sCsg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Sdq1NGMK1Alyhfmw/H0Hldc9PwH7yQN6ow3qPJK0fWRpm1RLj1fbKBliytbl8kV5X
	 rkNTczDP7VJWGQyfO8hpkdkHK1GAr+4ZL2aC6u1OwzgIIbY3HohLg3Z16khUGLGm+N
	 tMyA6A48E6vi4Kzev8tjnTQzoivg1DLpHQz4swDo=
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Date: Fri, 13 Feb 2026 14:01:57 +0000
Subject: [PATCH v2 18/25] media: i2c: imx283: Reduce vertical cutting
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-mainline-imx283-v2-v2-18-be40a3770ebf@ideasonboard.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770991325; l=1113;
 i=kieran.bingham@ideasonboard.com; s=20260207; h=from:subject:message-id;
 bh=wi2tcDwDnfbgeUOKoPs3aaLiCLXC032zvoFk/I/sCsg=;
 b=krz3VgLnBbd33y4IqY31cwNy9iDTCUYi7VbeoJ7Gm62XdtpzUvDFN8x0hNCqcjez0FhhQQQOQ
 ou/Fu4tw+IuC1JAzLUibKt3ldly5j08GB1siS630GZMPP+7LAIeNd3Y
X-Developer-Key: i=kieran.bingham@ideasonboard.com; a=ed25519;
 pk=FVXKN7YuwHc6UtbRUeTMAmranfsQomA+vnilfglWdaY=

The size should represent the amount of lines to cut vertically
and exclude from the pixel array for the image data.

Keeping this at the expected value causes corruption on the last
line. Reduce by increasing the defined size of the image by
a single line to ensure that the data is valid for the final
output.

Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 drivers/media/i2c/imx283.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx283.c b/drivers/media/i2c/imx283.c
index 07958cd1889e..df48793835fd 100644
--- a/drivers/media/i2c/imx283.c
+++ b/drivers/media/i2c/imx283.c
@@ -1154,7 +1154,12 @@ static int imx283_start_streaming(struct imx283 *imx283,
 		 */
 		s16 top = mode->crop.top - 16;
 		u16 veff = mode->scan->veff;
-		u16 cut = veff - min(veff, y_out_size);
+
+		/*
+		 * Lots of empirical testing shows that we need to cut one less
+		 * line than expected or we get corruption in the last line.
+		 */
+		u16 cut = veff - min(veff, y_out_size + 1);
 
 		u32 v_widcut;
 		s32 v_pos;

-- 
2.52.0

