Return-Path: <SRS0=19ZY=S3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8EBC43219
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 18:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEFD2067C
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 18:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbfDYShD (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:37:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35420 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbfDYShD (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Apr 2019 14:37:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id C66FF282BC9
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com, Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 4/5] media: coda: Remove pic_run_work worker
Date:   Thu, 25 Apr 2019 15:35:45 -0300
Message-Id: <20190425183546.16244-5-ezequiel@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425183546.16244-1-ezequiel@collabora.com>
References: <20190425183546.16244-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

There isn't any reason to run the mem2mem job on a separate worker,
because the mem2mem framework guarantees that device_run will never
run in interrupt context.

Therefore, get rid of the extra pic_run_work worker, and instead
run the job in the context of .device_run itself.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/media/platform/coda/coda-common.c | 9 ---------
 drivers/media/platform/coda/coda.h        | 1 -
 2 files changed, 10 deletions(-)

diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index 617d4547ec82..e0227593a649 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -1306,14 +1306,6 @@ static void coda_device_run(void *m2m_priv)
 {
 	struct coda_ctx *ctx = m2m_priv;
 	struct coda_dev *dev = ctx->dev;
-
-	queue_work(dev->workqueue, &ctx->pic_run_work);
-}
-
-static void coda_pic_run_work(struct work_struct *work)
-{
-	struct coda_ctx *ctx = container_of(work, struct coda_ctx, pic_run_work);
-	struct coda_dev *dev = ctx->dev;
 	int ret;
 
 	mutex_lock(&ctx->buffer_mutex);
@@ -2233,7 +2225,6 @@ static int coda_open(struct file *file)
 	ctx->ops = ctx->cvd->ops;
 	ctx->use_bit = !ctx->cvd->direct;
 	init_completion(&ctx->completion);
-	INIT_WORK(&ctx->pic_run_work, coda_pic_run_work);
 	if (ctx->ops->seq_end_work)
 		INIT_WORK(&ctx->seq_end_work, ctx->ops->seq_end_work);
 	v4l2_fh_init(&ctx->fh, video_devdata(file));
diff --git a/drivers/media/platform/coda/coda.h b/drivers/media/platform/coda/coda.h
index 31c80bda2c0b..6870edeb6324 100644
--- a/drivers/media/platform/coda/coda.h
+++ b/drivers/media/platform/coda/coda.h
@@ -194,7 +194,6 @@ struct coda_context_ops {
 struct coda_ctx {
 	struct coda_dev			*dev;
 	struct mutex			buffer_mutex;
-	struct work_struct		pic_run_work;
 	struct work_struct		seq_end_work;
 	struct completion		completion;
 	const struct coda_video_device	*cvd;
-- 
2.20.1

