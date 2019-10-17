Return-Path: <SRS0=c9eX=YK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480FFFA3735
	for <linux-media@archiver.kernel.org>; Thu, 17 Oct 2019 11:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBA52089C
	for <linux-media@archiver.kernel.org>; Thu, 17 Oct 2019 11:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405876AbfJQLWS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:22:18 -0400
Received: from retiisi.org.uk ([95.216.213.190]:39734 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405787AbfJQLWS (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 17 Oct 2019 07:22:18 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1002])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id CCEB2634C8E
        for <linux-media@vger.kernel.org>; Thu, 17 Oct 2019 14:21:47 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 6/7] smiapp: Rename update_mode as pll_blanking_update
Date:   Thu, 17 Oct 2019 14:18:55 +0300
Message-Id: <20191017111856.10270-7-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017111856.10270-1-sakari.ailus@linux.intel.com>
References: <20191017111856.10270-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Rename the confusingly named smiapp_update_mode() function as
smiapp_pll_blanking_update(). The function is used to calculate new PLL
and blanking configuration after binning or scaling configuration has been
changed.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/smiapp/smiapp-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/smiapp/smiapp-core.c b/drivers/media/i2c/smiapp/smiapp-core.c
index 174a965c17b8..2af796abb6b8 100644
--- a/drivers/media/i2c/smiapp/smiapp-core.c
+++ b/drivers/media/i2c/smiapp/smiapp-core.c
@@ -867,7 +867,7 @@ static void smiapp_update_blanking(struct smiapp_sensor *sensor)
 	__smiapp_update_exposure_limits(sensor);
 }
 
-static int smiapp_update_mode(struct smiapp_sensor *sensor)
+static int smiapp_pll_blanking_update(struct smiapp_sensor *sensor)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&sensor->src->sd);
 	int rval;
@@ -2047,7 +2047,7 @@ static int smiapp_set_compose(struct v4l2_subdev *subdev,
 	smiapp_propagate(subdev, cfg, sel->which, V4L2_SEL_TGT_COMPOSE);
 
 	if (sel->which == V4L2_SUBDEV_FORMAT_ACTIVE)
-		return smiapp_update_mode(sensor);
+		return smiapp_pll_blanking_update(sensor);
 
 	return 0;
 }
@@ -3043,7 +3043,7 @@ static int smiapp_probe(struct i2c_client *client)
 	}
 
 	mutex_lock(&sensor->mutex);
-	rval = smiapp_update_mode(sensor);
+	rval = smiapp_pll_blanking_update(sensor);
 	mutex_unlock(&sensor->mutex);
 	if (rval) {
 		dev_err(&client->dev, "update mode failed\n");
-- 
2.20.1

