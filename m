Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9CCC433E0
	for <linux-media@archiver.kernel.org>; Thu,  4 Feb 2021 16:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB5EA64F10
	for <linux-media@archiver.kernel.org>; Thu,  4 Feb 2021 16:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237916AbhBDQSM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 4 Feb 2021 11:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237858AbhBDQSE (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 4 Feb 2021 11:18:04 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99BFC0613D6;
        Thu,  4 Feb 2021 08:17:23 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 1ED021F45BAA
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        kernel@collabora.com
Subject: [PATCH] media: uapi: Correct doc comment in H264 uAPI
Date:   Thu,  4 Feb 2021 17:16:59 +0100
Message-Id: <20210204161659.31673-1-andrzej.p@collabora.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

struct v4l2_ctrl_h264_pps members obviously match picture parameter syntax,
not sequence parameter syntax.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
 include/uapi/linux/v4l2-controls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 823b214aac0c..5f9925129d09 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -1307,7 +1307,7 @@ struct v4l2_ctrl_h264_sps {
  * struct v4l2_ctrl_h264_pps - H264 picture parameter set
  *
  * Except where noted, all the members on this picture parameter set
- * structure match the sequence parameter set syntax as specified
+ * structure match the picture parameter set syntax as specified
  * by the H264 specification.
  *
  * In particular, V4L2_H264_PPS_FLAG_SCALING_MATRIX_PRESENT flag
-- 
2.17.1

