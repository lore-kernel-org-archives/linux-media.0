Return-Path: <SRS0=r2fB=WZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB92C3A5A1
	for <linux-media@archiver.kernel.org>; Thu, 29 Aug 2019 01:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AF620856
	for <linux-media@archiver.kernel.org>; Thu, 29 Aug 2019 01:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfH2BT0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 28 Aug 2019 21:19:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5684 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726079AbfH2BT0 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 28 Aug 2019 21:19:26 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 56502D4257AF612B3DC8;
        Thu, 29 Aug 2019 09:19:24 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 29 Aug 2019 09:19:15 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-media@vger.kernel.org>,
        <devel@driverdev.osuosl.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] media: imx: remove unused including <linux/version.h>
Date:   Thu, 29 Aug 2019 01:22:41 +0000
Message-ID: <20190829012241.133597-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Remove including <linux/version.h> that don't need it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/media/imx/imx-media-csc-scaler.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/media/imx/imx-media-csc-scaler.c b/drivers/staging/media/imx/imx-media-csc-scaler.c
index de599af59ffc..2b635ebf62d6 100644
--- a/drivers/staging/media/imx/imx-media-csc-scaler.c
+++ b/drivers/staging/media/imx/imx-media-csc-scaler.c
@@ -8,7 +8,6 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
-#include <linux/version.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <video/imx-ipu-v3.h>





