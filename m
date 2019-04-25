Return-Path: <SRS0=19ZY=S3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04330C282E3
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 07:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C449F21903
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 07:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbfDYHMw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:12:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60382 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388382AbfDYHMv (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Apr 2019 03:12:51 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5735C282F53;
        Thu, 25 Apr 2019 08:12:50 +0100 (BST)
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>, linux-media@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>, kernel@collabora.com,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v4 08/21] rockchip/vpu: Get vdev from the file arg in vidioc_querycap()
Date:   Thu, 25 Apr 2019 09:12:29 +0200
Message-Id: <20190425071242.18315-9-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425071242.18315-1-boris.brezillon@collabora.com>
References: <20190425071242.18315-1-boris.brezillon@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This makes the function more generic so it can easily be re-used when
adding support for the decoding functionality.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
Changes from v3:
* New patch
---
 drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c
index 0ace50746f2e..7c7c20ab2733 100644
--- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c
+++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c
@@ -65,9 +65,10 @@ static int vidioc_querycap(struct file *file, void *priv,
 			   struct v4l2_capability *cap)
 {
 	struct rockchip_vpu_dev *vpu = video_drvdata(file);
+	struct video_device *vdev = video_devdata(file);
 
 	strscpy(cap->driver, vpu->dev->driver->name, sizeof(cap->driver));
-	strscpy(cap->card, vpu->vfd_enc->name, sizeof(cap->card));
+	strscpy(cap->card, vdev->name, sizeof(cap->card));
 	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform: %s",
 		 vpu->dev->driver->name);
 	return 0;
-- 
2.20.1

