Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1418AC4332E
	for <linux-media@archiver.kernel.org>; Thu, 11 Mar 2021 11:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD16264F90
	for <linux-media@archiver.kernel.org>; Thu, 11 Mar 2021 11:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhCKLZ6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 11 Mar 2021 06:25:58 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:31885 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbhCKLZa (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 11 Mar 2021 06:25:30 -0500
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 11 Mar 2021 03:25:31 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 11 Mar 2021 03:25:29 -0800
X-QCInternal: smtphost
Received: from dikshita-linux.qualcomm.com ([10.204.65.237])
  by ironmsg02-blr.qualcomm.com with ESMTP; 11 Mar 2021 16:55:08 +0530
Received: by dikshita-linux.qualcomm.com (Postfix, from userid 347544)
        id 457D2212F0; Thu, 11 Mar 2021 16:55:07 +0530 (IST)
From:   Dikshita Agarwal <dikshita@codeaurora.org>
To:     linux-media@vger.kernel.org, hverkuil-cisco@xs4all.nl,
        stanimir.varbanov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, Dikshita Agarwal <dikshita@codeaurora.org>
Subject: [PATCH v8 0/2] Add encoder ctrls for long term reference
Date:   Thu, 11 Mar 2021 16:54:59 +0530
Message-Id: <1615461901-16675-1-git-send-email-dikshita@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This series add the encoder controls for long term reference (LTR)
and support for the same in venus driver.

Dikshita Agarwal (2):
  media: v4l2-ctrl: add controls for long term reference.
  venus: venc: Add support for Long Term Reference (LTR) controls

Changes since v7:
- addressed comments regarding documentation.

 .../userspace-api/media/v4l/ext-ctrls-codec.rst    | 18 ++++++++
 drivers/media/platform/qcom/venus/venc_ctrls.c     | 49 +++++++++++++++++++++-
 drivers/media/v4l2-core/v4l2-ctrls.c               | 14 +++++++
 include/uapi/linux/v4l2-controls.h                 |  3 ++
 4 files changed, 83 insertions(+), 1 deletion(-)

-- 
2.7.4

