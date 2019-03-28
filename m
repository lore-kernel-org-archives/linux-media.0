Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1323C43381
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 16:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CC821773
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 16:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfC1QRi (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:17:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53728 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfC1QRi (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 12:17:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id DBCEF281A13
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hans.verkuil@cisco.com>, kernel@collabora.com,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH] media: vb2: Minor function naming fix
Date:   Thu, 28 Mar 2019 13:16:30 -0300
Message-Id: <20190328161630.30386-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Minor fix for helper function and comment, s/v4l2_vb2_buffer/vb2_v4l2_buffer.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/media/common/videobuf2/videobuf2-v4l2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index b11a779e97b0..1c3147275785 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -122,9 +122,9 @@ static int __verify_length(struct vb2_buffer *vb, const struct v4l2_buffer *b)
 }
 
 /*
- * __init_v4l2_vb2_buffer() - initialize the v4l2_vb2_buffer struct
+ * __init_vb2_v4l2_buffer() - initialize the vb2_v4l2_buffer struct
  */
-static void __init_v4l2_vb2_buffer(struct vb2_buffer *vb)
+static void __init_vb2_v4l2_buffer(struct vb2_buffer *vb)
 {
 	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
 
@@ -595,7 +595,7 @@ static int __fill_vb2_buffer(struct vb2_buffer *vb, struct vb2_plane *planes)
 
 static const struct vb2_buf_ops v4l2_buf_ops = {
 	.verify_planes_array	= __verify_planes_array_core,
-	.init_buffer		= __init_v4l2_vb2_buffer,
+	.init_buffer		= __init_vb2_v4l2_buffer,
 	.fill_user_buffer	= __fill_v4l2_buffer,
 	.fill_vb2_buffer	= __fill_vb2_buffer,
 	.copy_timestamp		= __copy_timestamp,
-- 
2.20.1

