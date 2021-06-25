Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9445C49EBC
	for <linux-media@archiver.kernel.org>; Fri, 25 Jun 2021 08:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F8E461433
	for <linux-media@archiver.kernel.org>; Fri, 25 Jun 2021 08:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhFYIZt (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 25 Jun 2021 04:25:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53640 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhFYIZs (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 25 Jun 2021 04:25:48 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id 329101F41611
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com, dafna.hirschfeld@collabora.com,
        helen.koike@collabora.com, ezequiel@collabora.com,
        hverkuil@xs4all.nl, kernel@collabora.com, dafna3@gmail.com,
        sakari.ailus@linux.intel.com, linux-rockchip@lists.infradead.org,
        mchehab@kernel.org, tfiga@chromium.org
Subject: [PATCH 2/2] media: rkisp1: cap: initialize dma buf address in 'buf_init' cb
Date:   Fri, 25 Jun 2021 11:23:09 +0300
Message-Id: <20210625082309.24944-3-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210625082309.24944-1-dafna.hirschfeld@collabora.com>
References: <20210625082309.24944-1-dafna.hirschfeld@collabora.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Initializing the dma addresses of the capture buffers can
move to the 'buf_init' callback, since it is enough to do
it once for each buffer and not every time it is queued.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 .../media/platform/rockchip/rkisp1/rkisp1-capture.c  | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
index 60cd2200e7ae..41988eb0ec0a 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
@@ -750,7 +750,7 @@ static int rkisp1_vb2_queue_setup(struct vb2_queue *queue,
 	return 0;
 }
 
-static void rkisp1_vb2_buf_queue(struct vb2_buffer *vb)
+static int rkisp1_vb2_buf_init(struct vb2_buffer *vb)
 {
 	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
 	struct rkisp1_buffer *ispbuf =
@@ -780,6 +780,15 @@ static void rkisp1_vb2_buf_queue(struct vb2_buffer *vb)
 	if (cap->pix.info->comp_planes == 3 && cap->pix.cfg->uv_swap)
 		swap(ispbuf->buff_addr[RKISP1_PLANE_CR],
 		     ispbuf->buff_addr[RKISP1_PLANE_CB]);
+	return 0;
+}
+
+static void rkisp1_vb2_buf_queue(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct rkisp1_buffer *ispbuf =
+		container_of(vbuf, struct rkisp1_buffer, vb);
+	struct rkisp1_capture *cap = vb->vb2_queue->drv_priv;
 
 	spin_lock_irq(&cap->buf.lock);
 	list_add_tail(&ispbuf->queue, &cap->buf.queue);
@@ -1039,6 +1048,7 @@ rkisp1_vb2_start_streaming(struct vb2_queue *queue, unsigned int count)
 
 static const struct vb2_ops rkisp1_vb2_ops = {
 	.queue_setup = rkisp1_vb2_queue_setup,
+	.buf_init = rkisp1_vb2_buf_init,
 	.buf_queue = rkisp1_vb2_buf_queue,
 	.buf_prepare = rkisp1_vb2_buf_prepare,
 	.wait_prepare = vb2_ops_wait_prepare,
-- 
2.17.1

