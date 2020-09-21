Return-Path: <SRS0=F5P7=C6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE754C43463
	for <linux-media@archiver.kernel.org>; Mon, 21 Sep 2020 08:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81C5F20BED
	for <linux-media@archiver.kernel.org>; Mon, 21 Sep 2020 08:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgIUIDV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 21 Sep 2020 04:03:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13741 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726551AbgIUICZ (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 21 Sep 2020 04:02:25 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 558CE626DBA23AF9D5D4;
        Mon, 21 Sep 2020 16:02:23 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 16:02:15 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] media: media/pci: simplify the return expression of verify_window_lock
Date:   Mon, 21 Sep 2020 16:24:39 +0800
Message-ID: <20200921082439.2591565-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Simplify the return expression.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/media/pci/bt8xx/bttv-driver.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/media/pci/bt8xx/bttv-driver.c b/drivers/media/pci/bt8xx/bttv-driver.c
index 8c61d292dec1..4f7eaec20dc3 100644
--- a/drivers/media/pci/bt8xx/bttv-driver.c
+++ b/drivers/media/pci/bt8xx/bttv-driver.c
@@ -2058,7 +2058,6 @@ verify_window_lock(struct bttv_fh *fh, struct v4l2_window *win,
 {
 	enum v4l2_field field;
 	unsigned int width_mask;
-	int rc;
 
 	if (win->w.width < 48)
 		win->w.width = 48;
@@ -2111,13 +2110,10 @@ verify_window_lock(struct bttv_fh *fh, struct v4l2_window *win,
 	win->w.width -= win->w.left & ~width_mask;
 	win->w.left = (win->w.left - width_mask - 1) & width_mask;
 
-	rc = limit_scaled_size_lock(fh, &win->w.width, &win->w.height,
-			       field, width_mask,
-			       /* width_bias: round down */ 0,
-			       adjust_size, adjust_crop);
-	if (0 != rc)
-		return rc;
-	return 0;
+	return limit_scaled_size_lock(fh, &win->w.width, &win->w.height,
+				      field, width_mask,
+				      /* width_bias: round down */ 0,
+				      adjust_size, adjust_crop);
 }
 
 static int setup_window_lock(struct bttv_fh *fh, struct bttv *btv,
-- 
2.25.1

