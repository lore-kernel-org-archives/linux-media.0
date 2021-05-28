Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D79C47087
	for <linux-media@archiver.kernel.org>; Fri, 28 May 2021 08:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6685613DA
	for <linux-media@archiver.kernel.org>; Fri, 28 May 2021 08:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbhE1Ii0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 28 May 2021 04:38:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33864 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbhE1Ii0 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 28 May 2021 04:38:26 -0400
Received: from localhost.localdomain (unknown [IPv6:2a00:a040:193:3500:ed56:60fb:a74f:177d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id AFD2F1F43DB8;
        Fri, 28 May 2021 09:36:49 +0100 (BST)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     dafna.hirschfeld@collabora.com, hverkuil@xs4all.nl,
        kernel@collabora.com, dafna3@gmail.com, mchehab@kernel.org,
        tfiga@chromium.org, tiffany.lin@mediatek.com,
        andrew-ct.chen@mediatek.com, matthias.bgg@gmail.com,
        hsinyi@chromium.org, maoguang.meng@mediatek.com,
        irui.wang@mediatek.com
Subject: [PATCH] media: mtk-vcodec: venc: fix return value when start_streaming fails
Date:   Fri, 28 May 2021 11:36:41 +0300
Message-Id: <20210528083641.5227-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

In case vb2ops_venc_start_streaming fails, the error value
is overwritten by the ret value of pm_runtime_put which might
be 0. Fix it.

Fixes: 985c73693fe5a (" media: mtk-vcodec: Separating mtk encoder driver")
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index 4831052f475d..5e0c53112c15 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -780,7 +780,7 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 {
 	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(q);
 	struct venc_enc_param param;
-	int ret;
+	int ret, pm_ret;
 	int i;
 
 	/* Once state turn into MTK_STATE_ABORT, we need stop_streaming
@@ -832,9 +832,9 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 	return 0;
 
 err_set_param:
-	ret = pm_runtime_put(&ctx->dev->plat_dev->dev);
-	if (ret < 0)
-		mtk_v4l2_err("pm_runtime_put fail %d", ret);
+	pm_ret = pm_runtime_put(&ctx->dev->plat_dev->dev);
+	if (pm_ret < 0)
+		mtk_v4l2_err("pm_runtime_put fail %d", pm_ret);
 
 err_start_stream:
 	for (i = 0; i < q->num_buffers; ++i) {
-- 
2.17.1

