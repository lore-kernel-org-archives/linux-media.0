Return-Path: <SRS0=o2oZ=AG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ECCC433DF
	for <linux-media@archiver.kernel.org>; Thu, 25 Jun 2020 17:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A14207E8
	for <linux-media@archiver.kernel.org>; Thu, 25 Jun 2020 17:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406869AbgFYRnJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:43:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39094 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406853AbgFYRnI (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Jun 2020 13:43:08 -0400
Received: from localhost.localdomain (p200300cb8737cf00e4140a231ed1025d.dip0.t-ipconnect.de [IPv6:2003:cb:8737:cf00:e414:a23:1ed1:25d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 765732A5763;
        Thu, 25 Jun 2020 18:43:06 +0100 (BST)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com
Cc:     dafna.hirschfeld@collabora.com, helen.koike@collabora.com,
        ezequiel@collabora.com, hverkuil@xs4all.nl, kernel@collabora.com,
        dafna3@gmail.com, sakari.ailus@linux.intel.com,
        linux-rockchip@lists.infradead.org, mchehab@kernel.org,
        tfiga@chromium.org
Subject: [PATCH 3/3] media: staging: rkisp1: params: in 'stop_streaming' don't release the lock while returning buffers
Date:   Thu, 25 Jun 2020 19:42:57 +0200
Message-Id: <20200625174257.22216-4-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200625174257.22216-1-dafna.hirschfeld@collabora.com>
References: <20200625174257.22216-1-dafna.hirschfeld@collabora.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

In the stop_streaming callback 'rkisp1_params_vb2_stop_streaming'
there is no need to release the lock 'config_lock' and then acquire
it again at each iteration when returning all buffers.
This is because the stream is about to end and there is no need
to let the isr access a buffer.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/staging/media/rkisp1/rkisp1-params.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/media/rkisp1/rkisp1-params.c b/drivers/staging/media/rkisp1/rkisp1-params.c
index bf006dbeee2d..5169b02731f1 100644
--- a/drivers/staging/media/rkisp1/rkisp1-params.c
+++ b/drivers/staging/media/rkisp1/rkisp1-params.c
@@ -1488,19 +1488,13 @@ static void rkisp1_params_vb2_stop_streaming(struct vb2_queue *vq)
 	/* stop params input firstly */
 	spin_lock_irqsave(&params->config_lock, flags);
 	params->is_streaming = false;
-	spin_unlock_irqrestore(&params->config_lock, flags);
 
 	for (i = 0; i < RKISP1_ISP_PARAMS_REQ_BUFS_MAX; i++) {
-		spin_lock_irqsave(&params->config_lock, flags);
 		if (!list_empty(&params->params)) {
 			buf = list_first_entry(&params->params,
 					       struct rkisp1_buffer, queue);
 			list_del(&buf->queue);
-			spin_unlock_irqrestore(&params->config_lock,
-					       flags);
 		} else {
-			spin_unlock_irqrestore(&params->config_lock,
-					       flags);
 			break;
 		}
 
@@ -1508,6 +1502,7 @@ static void rkisp1_params_vb2_stop_streaming(struct vb2_queue *vq)
 			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
 		buf = NULL;
 	}
+	spin_unlock_irqrestore(&params->config_lock, flags);
 }
 
 static int
-- 
2.17.1

