Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE2E139D1E
	for <linux-media@vger.kernel.org>; Sat, 13 Jul 2024 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720885389; cv=none; b=vGvTYvceItZLGcM68qcPFqTBMA7Jhv9ArgT7mI5oncGUJPgOWHRdoo34UwebcleS46GNmK8I7oil3ar8qMddWe3bQumpaK349rznVVcVYTPc/OVWt4YtGBcvI8Wtxgofy3yo36WkBwBwhaDBp4gsy0LCeDfnwFwScfpy3A9FI1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720885389; c=relaxed/simple;
	bh=HEc1KoxYYIGW0f3G7ayt/Mv1IZKt4p0KavnHqnHVlOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srnIaH/sMlcI1yY8MWIDLCT8IvEbLdSkKsFrrOfYFIDIJRiQy4FFcCWh/GTtM4rqfJsVDrbnBIM3ENtXV2lFqNrYXDp8my6Q1h4NRE9YcaehGYsfZDtyeHrBdZ0mcF547st9brBqubBe4PNsflz563LS80yK+av8IAiPARglFyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=To17i5pZ; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="To17i5pZ"
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 5874D887BF;
	Sat, 13 Jul 2024 17:43:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720885386;
	bh=NV0PygndnXlbyLZp9hp02uWg0pHsWZxFuJG/yzxUuO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=To17i5pZiuRyPvVfYKXetxZRZ843dCCp/Xcu99C5mo1FXyoE8Am6L2sYSH/opoCsg
	 SQgxw2PE08SR6C4s72g2+wVCvD3gQECo3GKfWq+DZARTA/kKVXAKXKJ38SF5K0Yez4
	 S0M70tzgi6r4vNQCgGdIKgson+db8btVXgkfX1vhViCgmUwA1DumJksxql1dieeGdW
	 JSOIoasuzmydUyBTEd56WHKKmBJzQvwpPvw8tSvaRvtvs6it8CErJhQZdcT3TpukB6
	 YB66+PktoxU5FIui6SlbopjT2hJ879B3dqg5FD5rp5CtOa14BcVGnmqWX5SWJeWxWW
	 Rv8bskCEA/twg==
From: Marek Vasut <marex@denx.de>
To: linux-media@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Michael Tretter <m.tretter@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 3/3] media: i2c: isl7998x: Implement get_mbus_config
Date: Sat, 13 Jul 2024 17:41:56 +0200
Message-ID: <20240713154242.107903-3-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240713154242.107903-1-marex@denx.de>
References: <20240713154242.107903-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This is used e.g. by imx6-mipi-csi2.c to determine the CSI2 lane count.
Implement the callback in isl7998x driver so it can be used with i.MX6
CSI2 receiver.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Michael Tretter <m.tretter@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-media@vger.kernel.org
---
 drivers/media/i2c/isl7998x.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/i2c/isl7998x.c b/drivers/media/i2c/isl7998x.c
index 7d2799e498520..560f4845b5e62 100644
--- a/drivers/media/i2c/isl7998x.c
+++ b/drivers/media/i2c/isl7998x.c
@@ -1045,6 +1045,17 @@ static int isl7998x_set_fmt(struct v4l2_subdev *sd,
 	return 0;
 }
 
+static int isl7998x_get_mbus_config(struct v4l2_subdev *sd, unsigned int pad,
+				    struct v4l2_mbus_config *cfg)
+{
+	struct isl7998x *isl7998x = sd_to_isl7998x(sd);
+
+	cfg->type = V4L2_MBUS_CSI2_DPHY;
+	cfg->bus.mipi_csi2.num_data_lanes = isl7998x->nr_mipi_lanes;
+
+	return 0;
+}
+
 static int isl7998x_set_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct isl7998x *isl7998x = container_of(ctrl->handler,
@@ -1104,6 +1115,7 @@ static const struct v4l2_subdev_pad_ops isl7998x_subdev_pad_ops = {
 	.enum_frame_size	= isl7998x_enum_frame_size,
 	.get_fmt		= isl7998x_get_fmt,
 	.set_fmt		= isl7998x_set_fmt,
+	.get_mbus_config	= isl7998x_get_mbus_config,
 };
 
 static const struct v4l2_subdev_ops isl7998x_subdev_ops = {
-- 
2.43.0

