Return-Path: <SRS0=lAxh=YL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2587CA9EAC
	for <linux-media@archiver.kernel.org>; Fri, 18 Oct 2019 15:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4270222C6
	for <linux-media@archiver.kernel.org>; Fri, 18 Oct 2019 15:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437909AbfJRPKn (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:10:43 -0400
Received: from retiisi.org.uk ([95.216.213.190]:51500 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406825AbfJRPKm (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 18 Oct 2019 11:10:42 -0400
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id 05AD4634C8B;
        Fri, 18 Oct 2019 18:10:07 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com
Subject: [PATCH 3/3] smiapp: Put the device again if starting streaming fails
Date:   Fri, 18 Oct 2019 18:07:20 +0300
Message-Id: <20191018150720.31674-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018150720.31674-1-sakari.ailus@linux.intel.com>
References: <20191018150720.31674-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

If there was an error in starting streaming, put the runtime usage count
of the device.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/smiapp/smiapp-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/smiapp/smiapp-core.c b/drivers/media/i2c/smiapp/smiapp-core.c
index bcc703b83309..6bbad1c3b8fc 100644
--- a/drivers/media/i2c/smiapp/smiapp-core.c
+++ b/drivers/media/i2c/smiapp/smiapp-core.c
@@ -1565,8 +1565,11 @@ static int smiapp_set_stream(struct v4l2_subdev *subdev, int enable)
 	sensor->streaming = true;
 
 	rval = smiapp_start_streaming(sensor);
-	if (rval < 0)
+	if (rval < 0) {
 		sensor->streaming = false;
+		pm_runtime_mark_last_busy(&client->dev);
+		pm_runtime_put_autosuspend(&client->dev);
+	}
 
 	return rval;
 }
-- 
2.20.1

