Return-Path: <SRS0=VeA5=3C=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E9CC33CA9
	for <linux-media@archiver.kernel.org>; Mon, 13 Jan 2020 21:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85AF222C2
	for <linux-media@archiver.kernel.org>; Mon, 13 Jan 2020 21:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgAMVzv (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 13 Jan 2020 16:55:51 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52416 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgAMVzu (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 13 Jan 2020 16:55:50 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id D849929131E
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     dafna.hirschfeld@collabora.com, helen.koike@collabora.com,
        ezequiel@collabora.com, skhan@linuxfoundation.org,
        hverkuil@xs4all.nl, kernel@collabora.com, dafna3@gmail.com
Subject: [PATCH v4 6/6] media: vimc: Track the media device by calling v4l2_device_get/put
Date:   Mon, 13 Jan 2020 23:55:06 +0200
Message-Id: <20200113215506.13329-7-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200113215506.13329-1-dafna.hirschfeld@collabora.com>
References: <20200113215506.13329-1-dafna.hirschfeld@collabora.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

After a successful media_device_register call, call v4l2_device_get().
and set the media_devnode release callback to a function that
calls v4l2_device_put().
That should ensure that the v4l2_device's release callback is called
when the very last user of any of the registered device nodes has
closed its fh.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/media/platform/vimc/vimc-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/media/platform/vimc/vimc-core.c b/drivers/media/platform/vimc/vimc-core.c
index 9d4e8bc89620..0f03e9cec075 100644
--- a/drivers/media/platform/vimc/vimc-core.c
+++ b/drivers/media/platform/vimc/vimc-core.c
@@ -214,6 +214,14 @@ static void vimc_v4l2_dev_release(struct v4l2_device *v4l2_dev)
 	kfree(vimc);
 }
 
+static void vimc_media_device_release(struct media_devnode *devnode)
+{
+	struct media_device *mdev = devnode->media_dev;
+	struct vimc_device *vimc = container_of(mdev, struct vimc_device, mdev);
+
+	v4l2_device_put(&vimc->v4l2_dev);
+}
+
 static int vimc_register_devices(struct vimc_device *vimc)
 {
 	int ret;
@@ -252,6 +260,8 @@ static int vimc_register_devices(struct vimc_device *vimc)
 		goto err_rm_subdevs;
 	}
 
+	v4l2_device_get(&vimc->v4l2_dev);
+	vimc->mdev.devnode->release = vimc_media_device_release;
 	/* Expose all subdev's nodes*/
 	ret = v4l2_device_register_subdev_nodes(&vimc->v4l2_dev);
 	if (ret) {
-- 
2.17.1

