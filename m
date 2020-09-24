Return-Path: <SRS0=PL4U=DB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C643EC4727E
	for <linux-media@archiver.kernel.org>; Thu, 24 Sep 2020 17:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85503239CF
	for <linux-media@archiver.kernel.org>; Thu, 24 Sep 2020 17:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgIXRbk (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 24 Sep 2020 13:31:40 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:33711 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbgIXRbh (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 24 Sep 2020 13:31:37 -0400
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 24 Sep 2020 10:31:37 -0700
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 24 Sep 2020 10:31:35 -0700
Received: from dikshita-linux.qualcomm.com ([10.204.65.237])
  by ironmsg01-blr.qualcomm.com with ESMTP; 24 Sep 2020 23:01:17 +0530
Received: by dikshita-linux.qualcomm.com (Postfix, from userid 347544)
        id 9088D4E7E; Thu, 24 Sep 2020 23:01:16 +0530 (IST)
From:   Dikshita Agarwal <dikshita@codeaurora.org>
To:     linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, Dikshita Agarwal <dikshita@codeaurora.org>
Subject: [PATCH 0/2] Venus: fix handling of crop and s_fmt
Date:   Thu, 24 Sep 2020 23:01:12 +0530
Message-Id: <1600968674-11559-1-git-send-email-dikshita@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Dikshita Agarwal (1):
  venus: venc: update output format based on capture format.

Stanimir Varbanov (1):
  venus: venc: fix handlig of S_SELECTION and G_SELECTION

 drivers/media/platform/qcom/venus/venc.c | 48 ++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 21 deletions(-)

-- 
1.9.1

