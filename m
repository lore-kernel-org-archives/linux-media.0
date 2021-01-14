Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC78BC433E0
	for <linux-media@archiver.kernel.org>; Thu, 14 Jan 2021 08:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90808239A1
	for <linux-media@archiver.kernel.org>; Thu, 14 Jan 2021 08:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbhANIzK (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 14 Jan 2021 03:55:10 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11098 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbhANIzK (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 14 Jan 2021 03:55:10 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DGdPX5GDBzMKJn;
        Thu, 14 Jan 2021 16:53:04 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Thu, 14 Jan 2021 16:54:14 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <stanimir.varbanov@linaro.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] media: venus: Mark bufreq_enc with static keyword
Date:   Thu, 14 Jan 2021 17:05:21 +0800
Message-ID: <1610615121-15340-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fix the following sparse warning:

drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c:1242:5: warning: symbol 'bufreq_enc' was not declared. Should it be static?

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c b/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
index 072e349..d43d1a5 100644
--- a/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
+++ b/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
@@ -1239,8 +1239,8 @@ static int bufreq_dec(struct hfi_plat_buffers_params *params, u32 buftype,
 	return 0;
 }
 
-int bufreq_enc(struct hfi_plat_buffers_params *params, u32 buftype,
-	       struct hfi_buffer_requirements *bufreq)
+static int bufreq_enc(struct hfi_plat_buffers_params *params, u32 buftype,
+		      struct hfi_buffer_requirements *bufreq)
 {
 	enum hfi_version version = params->version;
 	struct enc_bufsize_ops *enc_ops;
-- 
2.6.2

