Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="J7Mw8BYc"
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717462102;
	Mon, 27 Nov 2023 08:55:32 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 800036607332;
	Mon, 27 Nov 2023 16:55:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1701104131;
	bh=6CSGRDiRO2lms0wmXZEstJJokqkWndIp5smKK5ehYIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J7Mw8BYcjh+HAx9EHuD5fXzhsVfCxdRCEtvz6kxPPisGcj/BjvZK0XvHWOdNU65Qd
	 it31XKO2UrDstoCrnrQT0G1QxAI2CaPBB9k8A7g8fYXE0K+T3LdwZ4KwStLepJpSC/
	 hJiahT1bN4TTma3pTkZ1zjLRTQK4eQMjmmZAoTl0JtFOG4xk2hdW4xDTuR2YIcA8Wu
	 BOH6/Oy285pZ3z5U1wse4tYdhb4lsbxuK47nAAk3uMI9k7+zb40ffFYK9iGR/gnoP1
	 oiAWMuN3Y3uM2lz67aCyIZYMMwYABSCocGAikiGOHdgPhpKaoDwSRq/pYkPGNVPSmJ
	 tZ1xh73ZqnCOg==
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
Subject: [PATCH 32/55] media: saa7146: Stop abusing of min_buffers_needed field
Date: Mon, 27 Nov 2023 17:54:31 +0100
Message-Id: <20231127165454.166373-33-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127165454.166373-1-benjamin.gaignard@collabora.com>
References: <20231127165454.166373-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'min_buffers_needed' is suppose to be used to indicate the number
of buffers needed by DMA engine to start streaming.
saa7146 driver doesn't use DMA engine and just want to specify
the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
That 'min_reqbufs_allocation' field purpose so use it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/common/saa7146/saa7146_fops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/common/saa7146/saa7146_fops.c b/drivers/media/common/saa7146/saa7146_fops.c
index 79214459387a..db4d725a05d4 100644
--- a/drivers/media/common/saa7146/saa7146_fops.c
+++ b/drivers/media/common/saa7146/saa7146_fops.c
@@ -387,7 +387,7 @@ int saa7146_register_device(struct video_device *vfd, struct saa7146_dev *dev,
 	q->gfp_flags = __GFP_DMA32;
 	q->buf_struct_size = sizeof(struct saa7146_buf);
 	q->lock = &dev->v4l2_lock;
-	q->min_buffers_needed = 2;
+	q->min_reqbufs_allocation = 2;
 	q->dev = &dev->pci->dev;
 	err = vb2_queue_init(q);
 	if (err)
-- 
2.39.2

