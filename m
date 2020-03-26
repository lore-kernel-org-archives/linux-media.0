Return-Path: <SRS0=KtNH=5L=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2836C2D0E9
	for <linux-media@archiver.kernel.org>; Thu, 26 Mar 2020 20:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFD52074D
	for <linux-media@archiver.kernel.org>; Thu, 26 Mar 2020 20:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgCZUQe (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 26 Mar 2020 16:16:34 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52836 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgCZUQd (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 26 Mar 2020 16:16:33 -0400
Received: from localhost.localdomain (unknown [IPv6:2a02:810a:113f:ad1c:b024:988e:8796:31a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 99CC0283C93;
        Thu, 26 Mar 2020 20:16:32 +0000 (GMT)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org, dafna.hirschfeld@collabora.com,
        helen.koike@collabora.com, ezequiel@collabora.com,
        hverkuil@xs4all.nl, kernel@collabora.com, dafna3@gmail.com,
        sakari.ailus@linux.intel.com, linux-rockchip@lists.infradead.org,
        mchehab@kernel.org, laurent.pinchart@ideasonboard.com
Subject: [PATCH 3/4] media: staging: rkisp1: cap: support uv swapped plane formats
Date:   Thu, 26 Mar 2020 21:16:09 +0100
Message-Id: <20200326201610.31762-4-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326201610.31762-1-dafna.hirschfeld@collabora.com>
References: <20200326201610.31762-1-dafna.hirschfeld@collabora.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Plane formats with the u and v planes swapped can be
supported by changing the address of the cb and cr in
the buffer.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/staging/media/rkisp1/rkisp1-capture.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/staging/media/rkisp1/rkisp1-capture.c b/drivers/staging/media/rkisp1/rkisp1-capture.c
index fa2849209433..2d274e8f565b 100644
--- a/drivers/staging/media/rkisp1/rkisp1-capture.c
+++ b/drivers/staging/media/rkisp1/rkisp1-capture.c
@@ -41,6 +41,10 @@
 	(((write_format) == RKISP1_MI_CTRL_MP_WRITE_YUV_SPLA) ||	\
 	 ((write_format) == RKISP1_MI_CTRL_SP_WRITE_SPLA))
 
+#define RKISP1_IS_PLANAR(write_format)					\
+	(((write_format) == RKISP1_MI_CTRL_SP_WRITE_PLA) ||		\
+	 ((write_format) == RKISP1_MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8))
+
 enum rkisp1_plane {
 	RKISP1_PLANE_Y	= 0,
 	RKISP1_PLANE_CB	= 1,
@@ -788,6 +792,19 @@ static void rkisp1_vb2_buf_queue(struct vb2_buffer *vb)
 			rkisp1_pixfmt_comp_size(pixm, RKISP1_PLANE_CB);
 	}
 
+	/*
+	 * uv swap can be supported for plane formats by switching
+	 * the address of cb and cr
+	 */
+	if (RKISP1_IS_PLANAR(cap->pix.cfg->write_format) &&
+	    cap->pix.cfg->uv_swap) {
+		ispbuf->buff_addr[RKISP1_PLANE_CR] =
+			ispbuf->buff_addr[RKISP1_PLANE_CB];
+		ispbuf->buff_addr[RKISP1_PLANE_CB] =
+			ispbuf->buff_addr[RKISP1_PLANE_CR] +
+			rkisp1_pixfmt_comp_size(pixm, RKISP1_PLANE_CR);
+	}
+
 	spin_lock_irqsave(&cap->buf.lock, flags);
 
 	/*
-- 
2.17.1

