Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E946AC433B4
	for <linux-media@archiver.kernel.org>; Mon, 19 Apr 2021 19:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3CB061369
	for <linux-media@archiver.kernel.org>; Mon, 19 Apr 2021 19:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241691AbhDSTXz (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 19 Apr 2021 15:23:55 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:37309 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241676AbhDSTXu (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 19 Apr 2021 15:23:50 -0400
X-Originating-IP: 24.194.32.49
Received: from coplandos.local (cpe-24-194-32-49.nycap.res.rr.com [24.194.32.49])
        (Authenticated sender: vrzh@vrzh.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 736E260003;
        Mon, 19 Apr 2021 19:23:18 +0000 (UTC)
From:   Martiros Shakhzadyan <vrzh@vrzh.net>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Martiros Shakhzadyan <vrzh@vrzh.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org
Subject: [PATCH 4/8] staging: media: atomisp: Replace goto with immediate return in sh_css_pipe_get_grid_info()
Date:   Mon, 19 Apr 2021 15:25:58 -0400
Message-Id: <20210419192602.498815-5-vrzh@vrzh.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210419192602.498815-1-vrzh@vrzh.net>
References: <20210419192602.498815-1-vrzh@vrzh.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Replace centralized exit goto with an immediate exit log and return, in
order for the log macro to properly display the file line.

Signed-off-by: Martiros Shakhzadyan <vrzh@vrzh.net>
---
 drivers/staging/media/atomisp/pci/sh_css.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
index 4d4f030e0fe0..87438b5948ba 100644
--- a/drivers/staging/media/atomisp/pci/sh_css.c
+++ b/drivers/staging/media/atomisp/pci/sh_css.c
@@ -5181,8 +5181,10 @@ sh_css_pipe_get_grid_info(struct ia_css_pipe *pipe,
 
 	if (binary) {
 		err = ia_css_binary_3a_grid_info(binary, info, pipe);
-		if (err)
-			goto ERR;
+		if (err) {
+			IA_CSS_LEAVE_ERR_PRIVATE(err);
+			return err;
+		}
 	} else {
 		memset(&info->s3a_grid, 0, sizeof(info->s3a_grid));
 	}
@@ -5207,7 +5209,6 @@ sh_css_pipe_get_grid_info(struct ia_css_pipe *pipe,
 
 	info->vamem_type = IA_CSS_VAMEM_TYPE_2;
 
-ERR :
 	IA_CSS_LEAVE_ERR_PRIVATE(err);
 	return err;
 }
-- 
2.31.1

