Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BCFC433B4
	for <linux-media@archiver.kernel.org>; Thu,  8 Apr 2021 13:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F44861151
	for <linux-media@archiver.kernel.org>; Thu,  8 Apr 2021 13:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhDHNfm (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 8 Apr 2021 09:35:42 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:22645 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbhDHNfj (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 8 Apr 2021 09:35:39 -0400
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 08 Apr 2021 06:35:26 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 08 Apr 2021 06:35:24 -0700
X-QCInternal: smtphost
Received: from c-mansur-linux.qualcomm.com ([10.204.90.208])
  by ironmsg02-blr.qualcomm.com with ESMTP; 08 Apr 2021 19:05:05 +0530
Received: by c-mansur-linux.qualcomm.com (Postfix, from userid 461723)
        id D21252177A; Thu,  8 Apr 2021 19:05:04 +0530 (IST)
From:   Mansur Alisha Shaik <mansur@codeaurora.org>
To:     linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, dikshita@codeaurora.org,
        Mansur Alisha Shaik <mansur@codeaurora.org>
Subject: [PATCH] venus: fix hw overload error log condition
Date:   Thu,  8 Apr 2021 19:05:00 +0530
Message-Id: <1617888900-857-1-git-send-email-mansur@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

In current video driver, frequency is calculated for all the
running video instances and check aganist maximum supported frequency.
If both calculated frequency and maximum supported frequency are same,
even then HW overload error is printed.
Fix this by printing error log only when frequency is greater than
maximum supported frequency.

Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>
---
 drivers/media/platform/qcom/venus/pm_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index dfe3ee8..9714ca7 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -1083,7 +1083,7 @@ static int load_scale_v4(struct venus_inst *inst)
 
 	freq = max(freq_core1, freq_core2);
 
-	if (freq >= table[0].freq) {
+	if (freq > table[0].freq) {
 		freq = table[0].freq;
 		dev_warn(dev, "HW is overloaded, needed: %lu max: %lu\n",
 			 freq, table[0].freq);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

