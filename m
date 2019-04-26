Return-Path: <SRS0=gA2F=S4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA43C43218
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 19:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A701820652
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 19:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfDZTw0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:52:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40718 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfDZTw0 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 26 Apr 2019 15:52:26 -0400
Received: from localhost.localdomain (unknown [IPv6:2804:431:9718:9080:61b7:f4a4:2020:fc95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A18F1272EC0;
        Fri, 26 Apr 2019 20:52:20 +0100 (BST)
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, helen.koike@collabora.com,
        kernel@collabora.com, lucmaga@gmail.com,
        lkcamp@lists.libreplanetbr.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v5 09/14] media: vimc: cap: Allocate and verify mplanar buffers
Date:   Fri, 26 Apr 2019 16:51:09 -0300
Message-Id: <20190426195114.5002-10-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426195114.5002-1-andrealmeid@collabora.com>
References: <20190426195114.5002-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

If the driver is in multiplanar mode, fill the vb2 structures
with the planes sizes and verify it the sizes allocated to the
planes are enough.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
Acked-by: Helen Koike <helen.koike@collabora.com>
---
Change in v5: none

Change in v4: none

Change in v3: none

Change in v2:
- Use IS_MULTIPLANAR macro

 drivers/media/platform/vimc/vimc-capture.c | 42 ++++++++++++++++++----
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/vimc/vimc-capture.c b/drivers/media/platform/vimc/vimc-capture.c
index 60e888a3f588..0439a5a008e8 100644
--- a/drivers/media/platform/vimc/vimc-capture.c
+++ b/drivers/media/platform/vimc/vimc-capture.c
@@ -425,12 +425,28 @@ static int vimc_cap_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 				struct device *alloc_devs[])
 {
 	struct vimc_cap_device *vcap = vb2_get_drv_priv(vq);
+	const struct v4l2_plane_pix_format *plane_fmt =
+		vcap->format.fmt.pix_mp.plane_fmt;
+	unsigned int i;
+
+	if (IS_MULTIPLANAR(vcap)) {
+		for (i = 0; i < *nplanes; i++)
+			if (sizes[i] < plane_fmt[i].sizeimage)
+				return -EINVAL;
+	} else if (*nplanes && sizes[0] < vcap->format.fmt.pix.sizeimage)
+		return -EINVAL;
 
 	if (*nplanes)
-		return sizes[0] < vcap->format.fmt.pix.sizeimage ? -EINVAL : 0;
-	/* We don't support multiplanes for now */
-	*nplanes = 1;
-	sizes[0] = vcap->format.fmt.pix.sizeimage;
+		return 0;
+
+	if (IS_MULTIPLANAR(vcap)) {
+		*nplanes = vcap->format.fmt.pix_mp.num_planes;
+		for (i = 0; i < *nplanes; i++)
+			sizes[i] = plane_fmt[i].sizeimage;
+	} else {
+		*nplanes = 1;
+		sizes[0] = vcap->format.fmt.pix.sizeimage;
+	}
 
 	return 0;
 }
@@ -438,9 +454,23 @@ static int vimc_cap_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 static int vimc_cap_buffer_prepare(struct vb2_buffer *vb)
 {
 	struct vimc_cap_device *vcap = vb2_get_drv_priv(vb->vb2_queue);
-	unsigned long size = vcap->format.fmt.pix.sizeimage;
+	unsigned long size;
+	unsigned int i;
 
-	if (vb2_plane_size(vb, 0) < size) {
+	if (IS_MULTIPLANAR(vcap)) {
+		for (i = 0; i < vb->num_planes; i++) {
+			size = vcap->format.fmt.pix_mp.plane_fmt[i].sizeimage;
+			if (vb2_plane_size(vb, i) < size) {
+				dev_err(vcap->dev,
+					"%s: buffer too small (%lu < %lu)\n",
+					vcap->vdev.name, vb2_plane_size(vb, i),
+					size);
+
+				return -EINVAL;
+			}
+		}
+	} else if (vb2_plane_size(vb, 0) < vcap->format.fmt.pix.sizeimage) {
+		size = vcap->format.fmt.pix.sizeimage;
 		dev_err(vcap->dev, "%s: buffer too small (%lu < %lu)\n",
 			vcap->vdev.name, vb2_plane_size(vb, 0), size);
 		return -EINVAL;
-- 
2.21.0

