Return-Path: <SRS0=MHKF=4F=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DE8C34021
	for <linux-media@archiver.kernel.org>; Mon, 17 Feb 2020 17:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCC02070B
	for <linux-media@archiver.kernel.org>; Mon, 17 Feb 2020 17:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgBQRv0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:51:26 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43078 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgBQRvZ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 17 Feb 2020 12:51:25 -0500
Received: from localhost.localdomain (p200300CB87166A0024B68010760D030E.dip0.t-ipconnect.de [IPv6:2003:cb:8716:6a00:24b6:8010:760d:30e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A4C66293E78;
        Mon, 17 Feb 2020 17:51:23 +0000 (GMT)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     dafna.hirschfeld@collabora.com, helen.koike@collabora.com,
        ezequiel@collabora.com, hverkuil@xs4all.nl, kernel@collabora.com,
        dafna3@gmail.com, sakari.ailus@linux.intel.com,
        linux-rockchip@lists.infradead.org, mchehab@kernel.org
Subject: [PATCH] media: staging: rkisp1: destroy subdevs' mutexes when unregistering
Date:   Mon, 17 Feb 2020 18:51:13 +0100
Message-Id: <20200217175113.8216-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

call 'mutex_destroy' on the locks of the subdevices 'isp' and 'resizer'
when unregistering and when failing to register.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
This patch is a follow-up patch for the patchset:
'media: staging: rkisp1: add serialization to the isp and resizer ops'

 drivers/staging/media/rkisp1/rkisp1-isp.c     | 5 ++++-
 drivers/staging/media/rkisp1/rkisp1-resizer.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/rkisp1/rkisp1-isp.c b/drivers/staging/media/rkisp1/rkisp1-isp.c
index aa7a842f97f8..36c0251911c9 100644
--- a/drivers/staging/media/rkisp1/rkisp1-isp.c
+++ b/drivers/staging/media/rkisp1/rkisp1-isp.c
@@ -1051,7 +1051,7 @@ int rkisp1_isp_register(struct rkisp1_device *rkisp1,
 	mutex_init(&isp->ops_lock);
 	ret = media_entity_pads_init(&sd->entity, RKISP1_ISP_PAD_MAX, pads);
 	if (ret)
-		return ret;
+		goto err_destroy_mutex;
 
 	ret = v4l2_device_register_subdev(v4l2_dev, sd);
 	if (ret) {
@@ -1064,6 +1064,8 @@ int rkisp1_isp_register(struct rkisp1_device *rkisp1,
 
 err_cleanup_media_entity:
 	media_entity_cleanup(&sd->entity);
+err_destroy_mutex:
+	mutex_destroy(&isp->ops_lock);
 
 	return ret;
 }
@@ -1074,6 +1076,7 @@ void rkisp1_isp_unregister(struct rkisp1_device *rkisp1)
 
 	v4l2_device_unregister_subdev(sd);
 	media_entity_cleanup(&sd->entity);
+	mutex_destroy(&rkisp1->isp.ops_lock);
 }
 
 /* ----------------------------------------------------------------------------
diff --git a/drivers/staging/media/rkisp1/rkisp1-resizer.c b/drivers/staging/media/rkisp1/rkisp1-resizer.c
index 87799fbf0363..0b4385153920 100644
--- a/drivers/staging/media/rkisp1/rkisp1-resizer.c
+++ b/drivers/staging/media/rkisp1/rkisp1-resizer.c
@@ -695,6 +695,7 @@ static void rkisp1_rsz_unregister(struct rkisp1_resizer *rsz)
 {
 	v4l2_device_unregister_subdev(&rsz->sd);
 	media_entity_cleanup(&rsz->sd.entity);
+	mutex_destroy(&rsz->ops_lock);
 }
 
 static int rkisp1_rsz_register(struct rkisp1_resizer *rsz)
@@ -727,7 +728,7 @@ static int rkisp1_rsz_register(struct rkisp1_resizer *rsz)
 	mutex_init(&rsz->ops_lock);
 	ret = media_entity_pads_init(&sd->entity, 2, pads);
 	if (ret)
-		return ret;
+		goto err_destroy_mutex;
 
 	ret = v4l2_device_register_subdev(&rsz->rkisp1->v4l2_dev, sd);
 	if (ret) {
@@ -740,6 +741,8 @@ static int rkisp1_rsz_register(struct rkisp1_resizer *rsz)
 
 err_cleanup_media_entity:
 	media_entity_cleanup(&sd->entity);
+err_destroy_mutex:
+	mutex_destroy(&rsz->ops_lock);
 
 	return ret;
 }
-- 
2.17.1

