Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6C8C433DB
	for <linux-media@archiver.kernel.org>; Mon, 28 Dec 2020 12:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7C6220897
	for <linux-media@archiver.kernel.org>; Mon, 28 Dec 2020 12:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgL1MWV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 28 Dec 2020 07:22:21 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58796 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbgL1MWV (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 28 Dec 2020 07:22:21 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id B656C1F44465
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Cc:     kernel@collabora.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 1/3] media: imx: Unregister csc/scaler only if registered
Date:   Mon, 28 Dec 2020 09:21:29 -0300
Message-Id: <20201228122131.138454-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The csc/scaler device pointer (imxmd->m2m_vdev) is assigned
after the imx media device v4l2-async probe completes,
therefore we need to check if the device is non-NULL
before trying to unregister it.

This can be the case if the non-completed imx media device
is unbinded (or the driver is removed), leading to a kernel oops.

Fixes: a8ef0488cc59 ("media: imx: add csc/scaler mem2mem device")
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/staging/media/imx/imx-media-dev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/imx/imx-media-dev.c b/drivers/staging/media/imx/imx-media-dev.c
index 6d2205461e56..b6d5f844ad79 100644
--- a/drivers/staging/media/imx/imx-media-dev.c
+++ b/drivers/staging/media/imx/imx-media-dev.c
@@ -107,10 +107,14 @@ static int imx_media_remove(struct platform_device *pdev)
 
 	v4l2_info(&imxmd->v4l2_dev, "Removing imx-media\n");
 
+	if (imxmd->m2m_vdev) {
+		imx_media_csc_scaler_device_unregister(imxmd->m2m_vdev);
+		imxmd->m2m_vdev = NULL;
+	}
+
 	v4l2_async_notifier_unregister(&imxmd->notifier);
 	imx_media_unregister_ipu_internal_subdevs(imxmd);
 	v4l2_async_notifier_cleanup(&imxmd->notifier);
-	imx_media_csc_scaler_device_unregister(imxmd->m2m_vdev);
 	media_device_unregister(&imxmd->md);
 	v4l2_device_unregister(&imxmd->v4l2_dev);
 	media_device_cleanup(&imxmd->md);
-- 
2.29.2

