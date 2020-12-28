Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBB6C433E0
	for <linux-media@archiver.kernel.org>; Mon, 28 Dec 2020 12:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21225208B3
	for <linux-media@archiver.kernel.org>; Mon, 28 Dec 2020 12:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgL1MW1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 28 Dec 2020 07:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbgL1MW1 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 28 Dec 2020 07:22:27 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B69C061796
        for <linux-media@vger.kernel.org>; Mon, 28 Dec 2020 04:21:46 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 6D33C1F4446A
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Cc:     kernel@collabora.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 3/3] media: imx: Clean capture unregister
Date:   Mon, 28 Dec 2020 09:21:31 -0300
Message-Id: <20201228122131.138454-3-ezequiel@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228122131.138454-1-ezequiel@collabora.com>
References: <20201228122131.138454-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

No locking is needed to call video_unregister_device(). Drop it.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/staging/media/imx/imx-media-capture.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
index c1931eb2540e..e10ce103a5b4 100644
--- a/drivers/staging/media/imx/imx-media-capture.c
+++ b/drivers/staging/media/imx/imx-media-capture.c
@@ -816,14 +816,8 @@ void imx_media_capture_device_unregister(struct imx_media_video_dev *vdev)
 	struct capture_priv *priv = to_capture_priv(vdev);
 	struct video_device *vfd = priv->vdev.vfd;
 
-	mutex_lock(&priv->mutex);
-
-	if (video_is_registered(vfd)) {
-		video_unregister_device(vfd);
-		media_entity_cleanup(&vfd->entity);
-	}
-
-	mutex_unlock(&priv->mutex);
+	media_entity_cleanup(&vfd->entity);
+	video_unregister_device(vfd);
 }
 EXPORT_SYMBOL_GPL(imx_media_capture_device_unregister);
 
-- 
2.29.2

