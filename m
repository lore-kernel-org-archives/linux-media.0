Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB426C28D13
	for <linux-media@archiver.kernel.org>; Mon, 22 Aug 2022 09:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbiHVJku (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 22 Aug 2022 05:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbiHVJkt (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 22 Aug 2022 05:40:49 -0400
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB182981D
        for <linux-media@vger.kernel.org>; Mon, 22 Aug 2022 02:40:47 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id Q3vIojkHpGYmzQ3vIop5B6; Mon, 22 Aug 2022 11:40:46 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 22 Aug 2022 11:40:46 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Xavier Roumegue <xavier.roumegue@oss.nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: dw100: Fix an error handling path in dw100_probe()
Date:   Mon, 22 Aug 2022 11:40:43 +0200
Message-Id: <7213b90d0d872be154cff81aec1ad8a4a77116af.1661161223.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

After a successful call to media_device_init() it is safer to call
media_device_init().

Add the missing call in the error handling path of the probe, as already
done in the remove function.

Fixes: bd090d4d995a ("media: dw100: Add i.MX8MP dw100 dewarper driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/media/platform/nxp/dw100/dw100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/nxp/dw100/dw100.c b/drivers/media/platform/nxp/dw100/dw100.c
index 94518f0e486b..b3b057798ab6 100644
--- a/drivers/media/platform/nxp/dw100/dw100.c
+++ b/drivers/media/platform/nxp/dw100/dw100.c
@@ -1623,6 +1623,7 @@ static int dw100_probe(struct platform_device *pdev)
 error_v4l2:
 	video_unregister_device(vfd);
 err_m2m:
+	media_device_cleanup(&dw_dev->mdev);
 	v4l2_m2m_release(dw_dev->m2m_dev);
 err_v4l2:
 	v4l2_device_unregister(&dw_dev->v4l2_dev);
-- 
2.34.1

