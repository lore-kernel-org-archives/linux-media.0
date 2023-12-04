Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QYIu4Je/"
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BFE184;
	Mon,  4 Dec 2023 05:24:03 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 640EC66071CC;
	Mon,  4 Dec 2023 13:24:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1701696241;
	bh=Td6waqKLfQADCpGtVukzLb1z1c+xWCgcYmy4mUTwhEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QYIu4Je/wnXRFw0SFkQ7Eq60kt3d91eWlmUmvf2Cj5q0PczHT970mjh3G3MovqjZx
	 oGGTnV3iT3vERDBgP06goLwxus9Cel/ivoJ2FdYzlkDNatZEDdrhT+f0YCF7aU+zNO
	 5zb0G7yq4w73dYvBr++4kRz9/aX1hRjgtYroPfyviFM2ZBYu4C8IgT4a/TYRLi+kyE
	 T/Cfr+K0iRsMHG7dVBl5RviAPi89RhyMB48CxM+QwJArSFHgj1C1qMZ2wI3HZVvyVI
	 uKk+ywXY5pYsa99DOee58zFfCrVbIGVMXYCJNcON7YWqMaDSAKcjhUTo7g7GOD3nFv
	 ehOrezeltVeTg==
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: hverkuil@xs4all.nl,
	mchehab@kernel.org,
	tfiga@chromium.org,
	m.szyprowski@samsung.com,
	matt.ranostay@konsulko.com
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2 14/36] media: ti: omap: Remove useless setting of min_buffers_needed
Date: Mon,  4 Dec 2023 14:23:01 +0100
Message-Id: <20231204132323.22811-15-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204132323.22811-1-benjamin.gaignard@collabora.com>
References: <20231204132323.22811-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver uses min_buffers_needed which vb2 uses to ensure
start_streaming is called when at least 'min_buffers_needed'
buffers are queued. However, this driver doesn't need this,
it can stream fine without any buffers queued.
Just drop this unnecessary restriction.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/platform/ti/omap/omap_vout.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/ti/omap/omap_vout.c b/drivers/media/platform/ti/omap/omap_vout.c
index 72ce903717d3..f67a45f1441b 100644
--- a/drivers/media/platform/ti/omap/omap_vout.c
+++ b/drivers/media/platform/ti/omap/omap_vout.c
@@ -1404,7 +1404,6 @@ static int __init omap_vout_setup_video_data(struct omap_vout_device *vout)
 	vq->ops = &omap_vout_vb2_ops;
 	vq->mem_ops = &vb2_dma_contig_memops;
 	vq->lock = &vout->lock;
-	vq->min_buffers_needed = 1;
 	vfd->queue = vq;
 
 	ret = vb2_queue_init(vq);
-- 
2.39.2

