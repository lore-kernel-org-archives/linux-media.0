Return-Path: <SRS0=7IOK=UF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D24BC04AB5
	for <linux-media@archiver.kernel.org>; Thu,  6 Jun 2019 12:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623AB2070B
	for <linux-media@archiver.kernel.org>; Thu,  6 Jun 2019 12:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfFFMLm (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 6 Jun 2019 08:11:42 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:33751 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726818AbfFFMLg (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 6 Jun 2019 08:11:36 -0400
Received: from tschai.fritz.box ([46.9.252.75])
        by smtp-cloud7.xs4all.net with ESMTPA
        id YrExhzc7c3qlsYrF0hma8W; Thu, 06 Jun 2019 14:11:34 +0200
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 1/9] vicodec: move v4l2_ctrl_request_complete after spin_unlock
Date:   Thu,  6 Jun 2019 14:11:23 +0200
Message-Id: <20190606121131.37110-2-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606121131.37110-1-hverkuil-cisco@xs4all.nl>
References: <20190606121131.37110-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOn0xyroRqL5QP8liqsoTsLycAN2IBYMo8Q3SNQCOA0k+iBTi8+pKVp8arNb/HcMLRnep9VamkauqlctVcItfilNYM/JmofT87+ttE719AFWE8JnEtL1
 RbMJnJh+HqaYKk6dkiYi+rmHvGEV0E+GKG/mld8LHlIcXK069NZ7i0k8BbDVk+cn/DqUqTrbSTCNr7xeD2IwY7Rc8AGnGjKjficRNYB13N1UojCCxGkTl4wf
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

v4l2_ctrl_request_complete can sleep, so can't be called while
a spinlock is held.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/platform/vicodec/vicodec-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index 72c56756e45b..358469f23191 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -442,14 +442,14 @@ static void device_run(void *priv)
 		ctx->comp_has_next_frame = false;
 	}
 	v4l2_m2m_buf_done(dst_buf, state);
-	if (ctx->is_stateless && src_req)
-		v4l2_ctrl_request_complete(src_req, &ctx->hdl);
 
 	ctx->comp_size = 0;
 	ctx->header_size = 0;
 	ctx->comp_magic_cnt = 0;
 	ctx->comp_has_frame = false;
 	spin_unlock(ctx->lock);
+	if (ctx->is_stateless && src_req)
+		v4l2_ctrl_request_complete(src_req, &ctx->hdl);
 
 	if (ctx->is_enc)
 		v4l2_m2m_job_finish(dev->stateful_enc.m2m_dev, ctx->fh.m2m_ctx);
-- 
2.20.1

