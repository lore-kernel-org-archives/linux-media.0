Return-Path: <SRS0=xPRW=BZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE12C433DF
	for <linux-media@archiver.kernel.org>; Sat, 15 Aug 2020 22:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57244205CB
	for <linux-media@archiver.kernel.org>; Sat, 15 Aug 2020 22:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgHOWDq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgHOVvK (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A01C02B8CB
        for <linux-media@vger.kernel.org>; Sat, 15 Aug 2020 03:38:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id A43D229A975
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com, dafna.hirschfeld@collabora.com,
        helen.koike@collabora.com, ezequiel@collabora.com,
        hverkuil@xs4all.nl, kernel@collabora.com, dafna3@gmail.com,
        sakari.ailus@linux.intel.com, linux-rockchip@lists.infradead.org,
        mchehab@kernel.org, tfiga@chromium.org
Subject: [PATCH v2 13/14] media: staging: rkisp1: call media_pipeline_start/stop from stats and params
Date:   Sat, 15 Aug 2020 12:37:33 +0200
Message-Id: <20200815103734.31153-14-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200815103734.31153-1-dafna.hirschfeld@collabora.com>
References: <20200815103734.31153-1-dafna.hirschfeld@collabora.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The stats and params video nodes register a media entity
and therefore they need to call media_pipeline_start/stop.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/staging/media/rkisp1/rkisp1-params.c | 9 +++++++++
 drivers/staging/media/rkisp1/rkisp1-stats.c  | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/staging/media/rkisp1/rkisp1-params.c b/drivers/staging/media/rkisp1/rkisp1-params.c
index cc242ad5106e..7d5c21fa630e 100644
--- a/drivers/staging/media/rkisp1/rkisp1-params.c
+++ b/drivers/staging/media/rkisp1/rkisp1-params.c
@@ -1488,14 +1488,23 @@ static void rkisp1_params_vb2_stop_streaming(struct vb2_queue *vq)
 
 	list_for_each_entry(buf, &tmp_list, queue)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+
+	media_pipeline_stop(&params->vnode.vdev.entity);
 }
 
 static int
 rkisp1_params_vb2_start_streaming(struct vb2_queue *queue, unsigned int count)
 {
 	struct rkisp1_params *params = queue->drv_priv;
+	struct media_entity *entity = &params->vnode.vdev.entity;
 	unsigned long flags;
+	int ret;
 
+	ret = media_pipeline_start(entity, &params->rkisp1->pipe);
+	if (ret) {
+		dev_err(params->rkisp1->dev, "params: start pipeline failed %d\n", ret);
+		return ret;
+	}
 	spin_lock_irqsave(&params->config_lock, flags);
 	params->is_streaming = true;
 	spin_unlock_irqrestore(&params->config_lock, flags);
diff --git a/drivers/staging/media/rkisp1/rkisp1-stats.c b/drivers/staging/media/rkisp1/rkisp1-stats.c
index c86beba709db..b314fb6a4562 100644
--- a/drivers/staging/media/rkisp1/rkisp1-stats.c
+++ b/drivers/staging/media/rkisp1/rkisp1-stats.c
@@ -150,12 +150,21 @@ static void rkisp1_stats_vb2_stop_streaming(struct vb2_queue *vq)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
 	}
 	spin_unlock_irq(&stats->lock);
+	media_pipeline_stop(&stats->vnode.vdev.entity);
 }
 
 static int
 rkisp1_stats_vb2_start_streaming(struct vb2_queue *queue, unsigned int count)
 {
 	struct rkisp1_stats *stats = queue->drv_priv;
+	struct media_entity *entity = &stats->vnode.vdev.entity;
+	int ret;
+
+	ret = media_pipeline_start(entity, &stats->rkisp1->pipe);
+	if (ret) {
+		dev_err(stats->rkisp1->dev, "stats: start pipeline failed %d\n", ret);
+		return ret;
+	}
 
 	spin_lock_irq(&stats->lock);
 	stats->is_streaming = true;
-- 
2.17.1

