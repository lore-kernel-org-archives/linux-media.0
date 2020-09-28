Return-Path: <SRS0=+xP7=DF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB65C4346E
	for <linux-media@archiver.kernel.org>; Mon, 28 Sep 2020 03:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7255E2311C
	for <linux-media@archiver.kernel.org>; Mon, 28 Sep 2020 03:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgI1DIg (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 27 Sep 2020 23:08:36 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:7600 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgI1DIg (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 27 Sep 2020 23:08:36 -0400
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 27 Sep 2020 20:08:36 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 27 Sep 2020 20:08:34 -0700
X-QCInternal: smtphost
Received: from c-mansur-linux.qualcomm.com ([10.204.90.208])
  by ironmsg01-blr.qualcomm.com with ESMTP; 28 Sep 2020 08:38:21 +0530
Received: by c-mansur-linux.qualcomm.com (Postfix, from userid 461723)
        id DD60421C27; Mon, 28 Sep 2020 08:38:19 +0530 (IST)
From:   Mansur Alisha Shaik <mansur@codeaurora.org>
To:     linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, swboyd@chromium.org,
        Mansur Alisha Shaik <mansur@codeaurora.org>
Subject: [RESEND v3 0/4] Venus - change clk enable, disable order and change bw values
Date:   Mon, 28 Sep 2020 08:38:12 +0530
Message-Id: <1601262496-27026-1-git-send-email-mansur@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The intention of this patchset is to correct clock enable and disable
order and vote for venus-ebi and cpucfg paths with average bandwidth
instad of peak bandwidth since with current implementation we are seeing
clock related warning during XO-SD and suspend device while video playback

---
Resending v3 patches by correcting fixes tag

Mansur Alisha Shaik (4):
  venus: core: change clk enable and disable order in resume and suspend
  venus: core: vote for video-mem path
  venus: core: vote with average bandwidth and peak bandwidth as zero
  venus: put dummy vote on video-mem path after last session release

 drivers/media/platform/qcom/venus/core.c       | 32 ++++++++++++++++++++------
 drivers/media/platform/qcom/venus/pm_helpers.c | 10 ++++++++
 2 files changed, 35 insertions(+), 7 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

