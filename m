Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13D8C83F2C
	for <linux-media@archiver.kernel.org>; Sun,  3 Sep 2023 08:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbjICIPC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 3 Sep 2023 04:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbjICIO6 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sun, 3 Sep 2023 04:14:58 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A06D136
        for <linux-media@vger.kernel.org>; Sun,  3 Sep 2023 01:14:54 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RdkzS5jYsz1M8Fk;
        Sun,  3 Sep 2023 16:13:08 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sun, 3 Sep
 2023 16:14:51 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
        <andrzej.p@collabora.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next v3 2/2] media: cx231xx: Add EP5_BUF_SIZE and EP5_TIMEOUT_MS macros
Date:   Sun, 3 Sep 2023 16:14:40 +0800
Message-ID: <20230903081440.1564633-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230903081440.1564633-1-ruanjinjie@huawei.com>
References: <20230903081440.1564633-1-ruanjinjie@huawei.com>
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

Define EP5_BUF_SIZE and EP5_TIMEOUT_MS macros to make the code
more readable.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
v2:
- Adjust the patch to be the second.
- Adjust the macro name.
---
 drivers/media/usb/cx231xx/cx231xx-core.c | 4 ++--
 drivers/media/usb/cx231xx/cx231xx.h      | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/cx231xx/cx231xx-core.c b/drivers/media/usb/cx231xx/cx231xx-core.c
index 746727ea1a4c..57a8b4780a7d 100644
--- a/drivers/media/usb/cx231xx/cx231xx-core.c
+++ b/drivers/media/usb/cx231xx/cx231xx-core.c
@@ -751,12 +751,12 @@ int cx231xx_ep5_bulkout(struct cx231xx *dev, u8 *firmware, u16 size)
 	int ret = -ENOMEM;
 	u32 *buffer;
 
-	buffer = kmemdup(firmware, 4096, GFP_KERNEL);
+	buffer = kmemdup(firmware, EP5_BUF_SIZE, GFP_KERNEL);
 	if (buffer == NULL)
 		return -ENOMEM;
 
 	ret = usb_bulk_msg(dev->udev, usb_sndbulkpipe(dev->udev, 5),
-			buffer, 4096, &actlen, 2000);
+			buffer, EP5_BUF_SIZE, &actlen, EP5_TIMEOUT_MS);
 
 	if (ret)
 		dev_err(dev->dev,
diff --git a/drivers/media/usb/cx231xx/cx231xx.h b/drivers/media/usb/cx231xx/cx231xx.h
index 6929e4d97067..74339a6a2f71 100644
--- a/drivers/media/usb/cx231xx/cx231xx.h
+++ b/drivers/media/usb/cx231xx/cx231xx.h
@@ -120,6 +120,9 @@
 #define CX23417_OSC_EN   8
 #define CX23417_RESET    9
 
+#define EP5_BUF_SIZE     4096
+#define EP5_TIMEOUT_MS   2000
+
 struct cx23417_fmt {
 	u32   fourcc;          /* v4l2 format id */
 	int   depth;
-- 
2.34.1

