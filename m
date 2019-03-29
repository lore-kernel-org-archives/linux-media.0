Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B469BC4360F
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 15:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F629206DD
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 15:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbfC2P30 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:29:26 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:36406 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728938AbfC2P30 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 29 Mar 2019 11:29:26 -0400
Received: from test-no.fritz.box ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 9tRYhPNkWUjKf9tRchwWqk; Fri, 29 Mar 2019 16:29:25 +0100
From:   hverkuil-cisco@xs4all.nl
To:     linux-media@vger.kernel.org
Cc:     Dafna Hirschfeld <dafna3@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [RFC PATCH 3/5] vicodec: add V4L2_CID_MIN_BUFFERS_FOR_OUTPUT
Date:   Fri, 29 Mar 2019 16:29:18 +0100
Message-Id: <20190329152920.30179-4-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329152920.30179-1-hverkuil-cisco@xs4all.nl>
References: <20190329152920.30179-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLXKiIlvnN3diLgi5pvnP5v52/OlZhwwUac3zIRWJbdV3IOGRjkhLXxwp0SZyO6EvxIxwd0MZrgt5U6PVz79wPm+/XMwERjFfEd8CW1zUECCzei5/qpU
 itcDxQrK/hWX3OtNSeWRO7Tu/52/h6OMkGwOvXo/GR0gZjIwxOHTl2d8lxBTXlMbTvSt3YPJynWbNcEg+2mAKV+9STulibi3zy6apbbo/8a7o1A4qHAUPjU0
 ueGhgwtVpFJg/bg6/qhMVn6zqdCz6ZetFqpEK0zCNfqeCxvxHLY8v1MBsPaeqTTg
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

The stateful encoder requires the presence of this control.
Since a single buffer is sufficient for vicodec, we just
set this control to 1.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/platform/vicodec/vicodec-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index 3b5124838f15..b0c1d7cd1db6 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -1841,13 +1841,16 @@ static int vicodec_open(struct file *file)
 	file->private_data = &ctx->fh;
 	ctx->dev = dev;
 	hdl = &ctx->hdl;
-	v4l2_ctrl_handler_init(hdl, 4);
+	v4l2_ctrl_handler_init(hdl, 5);
 	v4l2_ctrl_new_std(hdl, &vicodec_ctrl_ops, V4L2_CID_MPEG_VIDEO_GOP_SIZE,
 			  1, 16, 1, 10);
 	v4l2_ctrl_new_std(hdl, &vicodec_ctrl_ops, V4L2_CID_FWHT_I_FRAME_QP,
 			  1, 31, 1, 20);
 	v4l2_ctrl_new_std(hdl, &vicodec_ctrl_ops, V4L2_CID_FWHT_P_FRAME_QP,
 			  1, 31, 1, 20);
+	if (ctx->is_enc)
+		v4l2_ctrl_new_std(hdl, &vicodec_ctrl_ops,
+				  V4L2_CID_MIN_BUFFERS_FOR_OUTPUT, 1, 1, 1, 1);
 	if (ctx->is_stateless)
 		v4l2_ctrl_new_custom(hdl, &vicodec_ctrl_stateless_state, NULL);
 	if (hdl->error) {
-- 
2.20.1

