Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EB934CFCA;
	Tue, 27 Jan 2026 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.14.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769517812; cv=none; b=c6s9aMkQYIxdLNNNhtHbvV93rnAyY37tIc8FSzMXGh7c0SFNlgeGvU4JHJbABmtYX0jg3ZlAuoJJfu6g2kzVhwkqOGDKATawRjr3lLFu9ruX+uugR0gliPI5jH9LKyNfE9mb9MoJQBNKx0gNnWdkkQeLFZjWBlGjG8WonNHhU5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769517812; c=relaxed/simple;
	bh=c5utIMcf0nK0SGOCNFv+pIfgjawAjtDMNzpKoDsKYq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VrJFX4BIsKdY3qSPMa86axAKp3SQcBNLiNrkWuDtzVc3RKb4fxJOjWY5QJDugB/6OUCdljZpdATghpOq1iJfPv4tzgmwdJp0nBEAhk9FRB1TEAM2KtOdpEoQjknrmQBi20luQRW94k6ofIw3q/yOPAgzvTEPIsDIcXL+9vinViM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org; spf=pass smtp.mailfrom=gpxsee.org; arc=none smtp.client-ip=37.205.14.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from localhost (unknown [62.77.71.229])
	by mx.gpxsee.org (Postfix) with ESMTPSA id 2E6B48574B;
	Tue, 27 Jan 2026 13:43:24 +0100 (CET)
From: tumic@gpxsee.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
Subject: [PATCH v2 1/2] media:pci:mgb4: Add zDML color mapping support
Date: Tue, 27 Jan 2026 13:43:07 +0100
Message-ID: <20260127124308.344380-2-tumic@gpxsee.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127124308.344380-1-tumic@gpxsee.org>
References: <20260127124308.344380-1-tumic@gpxsee.org>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Martin Tůma <martin.tuma@digiteqautomotive.com>

Add zDML (a special signal mapping as used in Audi Digital Matrix Lights)
color mapping support. In addition to extending the already existing color
mapping property of the inputs, the same property is added for the outputs
that must be configured in the same way as the inputs.

Signed-off-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
---
 drivers/media/pci/mgb4/mgb4_sysfs_in.c  | 18 +++++--
 drivers/media/pci/mgb4/mgb4_sysfs_out.c | 62 +++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/mgb4/mgb4_sysfs_in.c b/drivers/media/pci/mgb4/mgb4_sysfs_in.c
index 4cd4addcd0a5..80ff05450e98 100644
--- a/drivers/media/pci/mgb4/mgb4_sysfs_in.c
+++ b/drivers/media/pci/mgb4/mgb4_sysfs_in.c
@@ -128,7 +128,16 @@ static ssize_t color_mapping_show(struct device *dev,
 	u32 config = mgb4_read_reg(&vindev->mgbdev->video,
 	  vindev->config->regs.config);
 
-	return sprintf(buf, "%s\n", config & (1U << 8) ? "0" : "1");
+	switch ((config >> 7) & 3) {
+	case 0: /* SPWG/VESA */
+		return sprintf(buf, "1\n");
+	case 1: /* ZDML */
+		return sprintf(buf, "2\n");
+	case 2: /* OLDI/JEIDA */
+		return sprintf(buf, "0\n");
+	default:
+		return -EIO;
+	}
 }
 
 /*
@@ -151,17 +160,20 @@ static ssize_t color_mapping_store(struct device *dev,
 
 	switch (val) {
 	case 0: /* OLDI/JEIDA */
-		fpga_data = (1U << 8);
+		fpga_data = 2;
 		break;
 	case 1: /* SPWG/VESA */
 		fpga_data = 0;
 		break;
+	case 2: /* ZDML */
+		fpga_data = 1;
+		break;
 	default:
 		return -EINVAL;
 	}
 
 	mgb4_mask_reg(&vindev->mgbdev->video, vindev->config->regs.config,
-		      1U << 8, fpga_data);
+		      3U << 7, fpga_data << 7);
 
 	return count;
 }
diff --git a/drivers/media/pci/mgb4/mgb4_sysfs_out.c b/drivers/media/pci/mgb4/mgb4_sysfs_out.c
index 5769f3ca6c2f..d807218e28ca 100644
--- a/drivers/media/pci/mgb4/mgb4_sysfs_out.c
+++ b/drivers/media/pci/mgb4/mgb4_sysfs_out.c
@@ -143,6 +143,64 @@ static ssize_t video_source_store(struct device *dev,
 	return ret;
 }
 
+static ssize_t color_mapping_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	u32 config = mgb4_read_reg(&voutdev->mgbdev->video,
+	  voutdev->config->regs.config);
+
+	switch ((config >> 6) & 3) {
+	case 0: /* SPWG/VESA */
+		return sprintf(buf, "1\n");
+	case 1: /* ZDML */
+		return sprintf(buf, "2\n");
+	case 2: /* OLDI/JEIDA */
+		return sprintf(buf, "0\n");
+	default:
+		return -EIO;
+	}
+}
+
+/*
+ * Color mapping change is expected to be called on live streams. Video device
+ * locking/queue check is not needed.
+ */
+static ssize_t color_mapping_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	u32 fpga_data;
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	switch (val) {
+	case 0: /* OLDI/JEIDA */
+		fpga_data = 2;
+		break;
+	case 1: /* SPWG/VESA */
+		fpga_data = 0;
+		break;
+	case 2: /* ZDML */
+		fpga_data = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mgb4_mask_reg(&voutdev->mgbdev->video, voutdev->config->regs.config,
+		      3U << 6, fpga_data << 6);
+
+	return count;
+}
+
 static ssize_t display_width_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
@@ -711,6 +769,7 @@ static DEVICE_ATTR_RW(hback_porch);
 static DEVICE_ATTR_RW(hfront_porch);
 static DEVICE_ATTR_RW(vback_porch);
 static DEVICE_ATTR_RW(vfront_porch);
+static DEVICE_ATTR_RW(color_mapping);
 
 static DEVICE_ATTR_RW(fpdl3_output_width);
 
@@ -731,6 +790,7 @@ struct attribute *mgb4_fpdl3_out_attrs[] = {
 	&dev_attr_vback_porch.attr,
 	&dev_attr_vfront_porch.attr,
 	&dev_attr_fpdl3_output_width.attr,
+	&dev_attr_color_mapping.attr,
 	NULL
 };
 
@@ -740,6 +800,7 @@ struct attribute *mgb4_gmsl3_out_attrs[] = {
 	&dev_attr_display_width.attr,
 	&dev_attr_display_height.attr,
 	&dev_attr_frame_rate.attr,
+	&dev_attr_color_mapping.attr,
 	NULL
 };
 
@@ -759,5 +820,6 @@ struct attribute *mgb4_gmsl1_out_attrs[] = {
 	&dev_attr_hfront_porch.attr,
 	&dev_attr_vback_porch.attr,
 	&dev_attr_vfront_porch.attr,
+	&dev_attr_color_mapping.attr,
 	NULL
 };
-- 
2.52.0

