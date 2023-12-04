Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="f7AymoDN"
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD2719A4;
	Mon,  4 Dec 2023 05:24:23 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 19C1C660711D;
	Mon,  4 Dec 2023 13:24:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1701696262;
	bh=Gl50yamOqxp5F3J61bdrX38ELoxqbgPRLIk274ynKbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f7AymoDN23peeo2rYK+6KBvHLhLevEnsznJewdctG2+XbxaZqVFAotigw//kcWyeL
	 0/yS9hdKsu8JlMHkZ48H6r22r5ftYMnRpd9yo6OAq02BPB8bEg4w5Eu3R1kq3g+FCX
	 Cl2cfj8wftNOLQSM5Gk/Rknxfeg/SuoH+xUr3+0OVDpaloGrFqo0Z6oyDVA8S/Quzr
	 /jEejnMap3aV9zOb04kFrMuMWSk9j6SwwrJ70/ZfucGS4taGygNhCYAUVm5ZKqwHBd
	 Me8/GJU6+c2Jpgq4Whw6bxOGbcbr9ZswbeULXElhiFk+pwpJ72KU867vQIkSDbu1xf
	 XAMJB4rlRNaiQ==
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
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 29/36] media: sunxi: sun6i-csi: Fix misuse of min_buffers_needed field
Date: Mon,  4 Dec 2023 14:23:16 +0100
Message-Id: <20231204132323.22811-30-benjamin.gaignard@collabora.com>
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

'min_buffers_needed' is suppose to be used to indicate the number
of buffers needed by DMA engine to start streaming.
sun6i-csi driver doesn't use DMA engine and just want to specify
the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
That 'min_reqbufs_allocation' field purpose so use it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Chen-Yu Tsai <wens@csie.org>
CC: Jernej Skrabec <jernej.skrabec@gmail.com>
CC: Samuel Holland <samuel@sholland.org>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index cf6aadbc130b..73e721936d27 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -1010,7 +1010,7 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
 	queue->buf_struct_size = sizeof(struct sun6i_csi_buffer);
 	queue->ops = &sun6i_csi_capture_queue_ops;
 	queue->mem_ops = &vb2_dma_contig_memops;
-	queue->min_buffers_needed = 2;
+	queue->min_reqbufs_allocation = 2;
 	queue->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	queue->lock = &capture->lock;
 	queue->dev = csi_dev->dev;
-- 
2.39.2

