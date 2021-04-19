Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715C4C433ED
	for <linux-media@archiver.kernel.org>; Mon, 19 Apr 2021 19:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2316561370
	for <linux-media@archiver.kernel.org>; Mon, 19 Apr 2021 19:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241967AbhDSTYI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 19 Apr 2021 15:24:08 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:44355 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241694AbhDSTX5 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 19 Apr 2021 15:23:57 -0400
X-Originating-IP: 24.194.32.49
Received: from coplandos.local (cpe-24-194-32-49.nycap.res.rr.com [24.194.32.49])
        (Authenticated sender: vrzh@vrzh.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 2F9D060009;
        Mon, 19 Apr 2021 19:23:24 +0000 (UTC)
From:   Martiros Shakhzadyan <vrzh@vrzh.net>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Martiros Shakhzadyan <vrzh@vrzh.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org
Subject: [PATCH 6/8] staging: media: atomisp: Replace if else clause with a ternary
Date:   Mon, 19 Apr 2021 15:26:00 -0400
Message-Id: <20210419192602.498815-7-vrzh@vrzh.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210419192602.498815-1-vrzh@vrzh.net>
References: <20210419192602.498815-1-vrzh@vrzh.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Use the ternary operator for conditional variable assignment in
create_host_video_pipeline().

Signed-off-by: Martiros Shakhzadyan <vrzh@vrzh.net>
---
 drivers/staging/media/atomisp/pci/sh_css.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
index 71e8133abf04..3d58b9b3d50d 100644
--- a/drivers/staging/media/atomisp/pci/sh_css.c
+++ b/drivers/staging/media/atomisp/pci/sh_css.c
@@ -3617,11 +3617,8 @@ static int create_host_video_pipeline(struct ia_css_pipe *pipe)
 		struct ia_css_frame *tmp_out_frame = NULL;
 
 		for (i = 0; i < num_yuv_scaler; i++) {
-			if (is_output_stage[i]) {
-				tmp_out_frame = out_frame;
-			} else {
-				tmp_out_frame = NULL;
-			}
+			tmp_out_frame = is_output_stage[i] ? out_frame : NULL;
+
 			err = add_yuv_scaler_stage(pipe, me, tmp_in_frame, tmp_out_frame,
 						   NULL,
 						   &yuv_scaler_binary[i],
-- 
2.31.1

