Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE679EEB582
	for <linux-media@archiver.kernel.org>; Sat,  9 Sep 2023 08:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344101AbjIIIg2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 9 Sep 2023 04:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbjIIIg1 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sat, 9 Sep 2023 04:36:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD8210FC
        for <linux-media@vger.kernel.org>; Sat,  9 Sep 2023 01:36:20 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RjR8H5r32zVjqg;
        Sat,  9 Sep 2023 16:33:35 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 9 Sep
 2023 16:36:16 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next v4 1/2] media: cx231xx: Switch to use kmemdup() helper
Date:   Sat, 9 Sep 2023 16:36:11 +0800
Message-ID: <20230909083612.1845757-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230909083612.1845757-1-ruanjinjie@huawei.com>
References: <20230909083612.1845757-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Use kmemdup() helper instead of open-coding to
simplify the code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
v4:
- Add Reviewed-by.
---
v3:
- Adjust use kmemdup() helper to be the first patch as suggested.
---
 drivers/media/usb/cx231xx/cx231xx-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/usb/cx231xx/cx231xx-core.c b/drivers/media/usb/cx231xx/cx231xx-core.c
index 727e6268567f..746727ea1a4c 100644
--- a/drivers/media/usb/cx231xx/cx231xx-core.c
+++ b/drivers/media/usb/cx231xx/cx231xx-core.c
@@ -751,10 +751,9 @@ int cx231xx_ep5_bulkout(struct cx231xx *dev, u8 *firmware, u16 size)
 	int ret = -ENOMEM;
 	u32 *buffer;
 
-	buffer = kzalloc(4096, GFP_KERNEL);
+	buffer = kmemdup(firmware, 4096, GFP_KERNEL);
 	if (buffer == NULL)
 		return -ENOMEM;
-	memcpy(&buffer[0], firmware, 4096);
 
 	ret = usb_bulk_msg(dev->udev, usb_sndbulkpipe(dev->udev, 5),
 			buffer, 4096, &actlen, 2000);
-- 
2.34.1

