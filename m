Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB56F3803C8
	for <linux-media@vger.kernel.org>; Mon,  9 Feb 2026 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770651497; cv=none; b=GPABQAtJy8f9NqvpYzXpc/EtqpPP7DB59KfK+3lwYC1qKGvw7cMIE1pzlDfFiyfnjWnRVRzZi7YgFZWpOsILYW3tGaMKQiM8MDljvd5ns5n0PRZ5vvi4Zzk5PtRL9FC8yTKdMsRnsPvM4DPm77kOA+y3IKgp0jTq3Uaigdl6iek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770651497; c=relaxed/simple;
	bh=QKlzvN5Ibeyd+ZwXwOg2RWNZHh/JmCKBpn+iFp4nZow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHiXf2XOGuL/zQKOU01+1T15ERLGycq20Fp5R8WB1x8p8Af9a69ZXgm9hMUTj/+wWxbxKZ7ydGut357LEYPHtqcy1ZCbgxALQvopw3llEe7Ax/l0nA8ZCiDtzdebmUHOXZ5RiBv6SWyPq5JJ/60hevhQS+oX8VEgW7AMEUX+udc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=FQp29DCu; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="FQp29DCu"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4376de3f128so837059f8f.0
        for <linux-media@vger.kernel.org>; Mon, 09 Feb 2026 07:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770651495; x=1771256295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHwHnR/AkgDNwuGXRgvil2Ov0DASjUJHIHivMAy5Dsg=;
        b=FQp29DCuJDxbrCVTbvX7aF+FIHqxpkUhkigjvbLyWT3QwgkYRLSV/GwaZrGvRGvSyC
         f+oDPZjSzp+PtAAaXKYgPIeYHmijF65osYbSrrBbUN+u4vp5BGqfQZpDYCkNtOhgJp51
         Tt6GEg5ReXNtgxF+rU2/wSlv75MsjDXmjEvt/sxENuilBnC+axuKperGhbDnpIV/K5yn
         vDlKPzX0SdGwvZpw49HDwU8MqdHkCxoQdS05sOgJUolZst3eHxRUyAmf+TUmKcalq/ni
         22swsY2BPCnxo4N5D31pohhlzWO2ZQBf9F9C3XzXHjdPe4vNnF4YrBh5NKqcpubzG+Jq
         ZOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770651495; x=1771256295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RHwHnR/AkgDNwuGXRgvil2Ov0DASjUJHIHivMAy5Dsg=;
        b=uwJostxJU4ZFvexF6HeXKyh7sQlxk+hiFZ3InVheraZ3DXBnFe8Pup35sEm1wyzM7+
         vXa2J4YmWW6mGJzNdWAAxNhNDxeXI4CSGAMv9nfDvy+n61YPa8KWL5laldIRxicgUlfp
         sDTo7mIfPEKB0lLpGgWhtYUHPGEaRMCkYVGbpZg6K1kj79bA1pER6NKreD9Jd21by0Y9
         o8X3F9wwICPT6vdO0k7RKLJPcxpIlGxshuwj46XZ5RiNR5f/QOqQBraKD5UTIhZvUXTp
         NRuDGqoTQxH3Nv6WVqJtM0+sYzLEE1n3Yv1N0XHwc+td4QpeKXQu5LbFsr5+P6eF8faw
         ixMA==
X-Forwarded-Encrypted: i=1; AJvYcCVX0RdZwhSJWhnBAg5VHtYHjWGtaVdQvBfVCiOilCzcV64pMSk0gppBj0d9IRygcwBertNqZBuSNpJ+Xg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjXnrUeHsHhS8VzWgKE5RJOj0aXTc+tezwVsN35C9+or5OUQW6
	Ek/D7A79Py73nP6a0m1DhNIKeI0mXcyzAS/e72NpP7NsRl9Ir55goa7sKGmemKi3CN7pu0LDA5d
	ufLY2
X-Gm-Gg: AZuq6aIK7ehYLARWLpl5jn1SE7ojw8SfcvtPLwqTEYCi+dt3no+XAZX5wbTko+nSmF3
	j9MeXzKCIJDzzb7DRcMgU4j/SCgyh6jyd5rFEOlPdKA3isxOiKHLc1wFSbMnkL7jUN+5yRF21O7
	Ad1fEpk79oOa35AbQxcMIdbVo66rpyU+ZayhXc22EZND87tqpazNd5lWMWdIVYkO7S54mOxYNiO
	8EfrpnFokvSq6sEXY2FNQflbBJHR1G4XLHuFUTqjh7c4Fq7dXlM5zkjB4MmHzTJz4gB43/z4SgI
	5qFFL6qevBKRF9Daf3BSllB9dKXxqsUaMCU/Xc8PJqipnPFgWTmncsnIK8oaYnN5MOgOkGRjW0m
	aCKIeZownQ6P63dWVf7nlXNyVIxkMI9yooa1BZo4BXpI2UMAiBSBWy4T7jVvPX/L90fa00uHSfz
	z8ug==
X-Received: by 2002:a5d:5f91:0:b0:432:852d:5662 with SMTP id ffacd0b85a97d-4362938f401mr17980642f8f.63.1770651495066;
        Mon, 09 Feb 2026 07:38:15 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296b25casm28647578f8f.4.2026.02.09.07.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 07:38:14 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	iommu@lists.linux.dev,
	linux-media@vger.kernel.org
Cc: sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com,
	Brian.Starkey@arm.com,
	jstultz@google.com,
	tjmercier@google.com,
	christian.koenig@amd.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	sean.anderson@linux.dev,
	ptesarik@suse.com,
	catalin.marinas@arm.com,
	aneesh.kumar@kernel.org,
	suzuki.poulose@arm.com,
	steven.price@arm.com,
	thomas.lendacky@amd.com,
	john.allen@amd.com,
	ashish.kalra@amd.com,
	suravee.suthikulpanit@amd.com,
	linux-coco@lists.linux.dev
Subject: [PATCH 4/5] dma-buf: heaps: allow heap to specify valid heap flags
Date: Mon,  9 Feb 2026 16:38:08 +0100
Message-ID: <20260209153809.250835-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260209153809.250835-1-jiri@resnulli.us>
References: <20260209153809.250835-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Currently the flags, which are unused, are validated for all heaps.
Since the follow-up patch introduces a flag valid for only one of the
heaps, allow to specify the valid flags per-heap.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/dma-buf/dma-heap.c | 5 ++++-
 include/linux/dma-heap.h   | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index 8ab49924f8b7..4751bcef4b19 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -28,6 +28,7 @@
  * @name:		used for debugging/device-node name
  * @ops:		ops struct for this heap
  * @priv:		private data for this heap
+ * @valid_heap_flags:	valid heap flags for this heap
  * @heap_devt:		heap device node
  * @list:		list head connecting to list of heaps
  * @heap_cdev:		heap char device
@@ -38,6 +39,7 @@ struct dma_heap {
 	const char *name;
 	const struct dma_heap_ops *ops;
 	void *priv;
+	u64 valid_heap_flags;
 	dev_t heap_devt;
 	struct list_head list;
 	struct cdev heap_cdev;
@@ -105,7 +107,7 @@ static long dma_heap_ioctl_allocate(struct file *file, void *data)
 	if (heap_allocation->fd_flags & ~DMA_HEAP_VALID_FD_FLAGS)
 		return -EINVAL;
 
-	if (heap_allocation->heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
+	if (heap_allocation->heap_flags & ~heap->valid_heap_flags)
 		return -EINVAL;
 
 	fd = dma_heap_buffer_alloc(heap, heap_allocation->len,
@@ -246,6 +248,7 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 	heap->name = exp_info->name;
 	heap->ops = exp_info->ops;
 	heap->priv = exp_info->priv;
+	heap->valid_heap_flags = exp_info->valid_heap_flags;
 
 	/* Find unused minor number */
 	ret = xa_alloc(&dma_heap_minors, &minor, heap,
diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
index 27d15f60950a..7cfb531a9281 100644
--- a/include/linux/dma-heap.h
+++ b/include/linux/dma-heap.h
@@ -31,6 +31,7 @@ struct dma_heap_ops {
  * @name:	used for debugging/device-node name
  * @ops:	ops struct for this heap
  * @priv:	heap exporter private data
+ * @valid_heap_flags:	valid heap flags for this heap
  *
  * Information needed to export a new dmabuf heap.
  */
@@ -38,6 +39,7 @@ struct dma_heap_export_info {
 	const char *name;
 	const struct dma_heap_ops *ops;
 	void *priv;
+	u64 valid_heap_flags;
 };
 
 void *dma_heap_get_drvdata(struct dma_heap *heap);
-- 
2.51.1

