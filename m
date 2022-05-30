Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20FDC433F5
	for <linux-media@archiver.kernel.org>; Mon, 30 May 2022 07:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbiE3H6I (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 30 May 2022 03:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiE3H6H (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 30 May 2022 03:58:07 -0400
Received: from mail.meizu.com (edge01.meizu.com [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02564F458;
        Mon, 30 May 2022 00:58:04 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 30 May
 2022 15:58:06 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Mon, 30 May
 2022 15:58:02 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-media@vger.kernel.org>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] media: atomisp-mt9m114: Fix pointer dereferenced before checking
Date:   Mon, 30 May 2022 15:58:01 +0800
Message-ID: <1653897481-25681-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The info->data is dereferencing before null checking, so move
it after checking.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
index 00d6842c07d6..3c81ab73cdae 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
@@ -616,13 +616,15 @@ static int mt9m114_get_intg_factor(struct i2c_client *client,
 				   struct camera_mipi_info *info,
 				   const struct mt9m114_res_struct *res)
 {
-	struct atomisp_sensor_mode_data *buf = &info->data;
+	struct atomisp_sensor_mode_data *buf;
 	u32 reg_val;
 	int ret;
 
 	if (!info)
 		return -EINVAL;
 
+	buf = &info->data;
+
 	ret =  mt9m114_read_reg(client, MISENSOR_32BIT,
 				REG_PIXEL_CLK, &reg_val);
 	if (ret)
-- 
2.7.4

