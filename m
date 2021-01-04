Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A5EC433DB
	for <linux-media@archiver.kernel.org>; Mon,  4 Jan 2021 20:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28E6C2225E
	for <linux-media@archiver.kernel.org>; Mon,  4 Jan 2021 20:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbhADUfe (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 4 Jan 2021 15:35:34 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35478 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbhADUfe (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 4 Jan 2021 15:35:34 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id C55061F44F08
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Cc:     kernel@collabora.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2 2/3] media: imx: Fix csc/scaler unregister
Date:   Mon,  4 Jan 2021 17:34:40 -0300
Message-Id: <20210104203441.168778-2-ezequiel@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210104203441.168778-1-ezequiel@collabora.com>
References: <20210104203441.168778-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The csc/scaler device private struct is released by
ipu_csc_scaler_video_device_release(), which can be called
by video_unregister_device() if there are no users
of the underlying struct video device.

Therefore, the mutex can't be held when calling
video_unregister_device() as its memory may be freed
by it, leading to a kernel oops.

Fortunately, the fix is quite simple as no locking
is needed when calling video_unregister_device(): v4l2-core
already has its own internal locking, and the structures
are also properly refcounted.

Fixes: a8ef0488cc59 ("media: imx: add csc/scaler mem2mem device")
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/media/imx/imx-media-csc-scaler.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-csc-scaler.c b/drivers/staging/media/imx/imx-media-csc-scaler.c
index fab1155a5958..63a0204502a8 100644
--- a/drivers/staging/media/imx/imx-media-csc-scaler.c
+++ b/drivers/staging/media/imx/imx-media-csc-scaler.c
@@ -869,11 +869,7 @@ void imx_media_csc_scaler_device_unregister(struct imx_media_video_dev *vdev)
 	struct ipu_csc_scaler_priv *priv = vdev_to_priv(vdev);
 	struct video_device *vfd = priv->vdev.vfd;
 
-	mutex_lock(&priv->mutex);
-
 	video_unregister_device(vfd);
-
-	mutex_unlock(&priv->mutex);
 }
 
 struct imx_media_video_dev *
-- 
2.29.2

