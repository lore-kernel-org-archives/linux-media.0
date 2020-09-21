Return-Path: <SRS0=F5P7=C6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427C8C43464
	for <linux-media@archiver.kernel.org>; Mon, 21 Sep 2020 12:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0948D2151B
	for <linux-media@archiver.kernel.org>; Mon, 21 Sep 2020 12:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qti.qualcomm.com header.i=@qti.qualcomm.com header.b="e9G0ScWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgIUMsi (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 21 Sep 2020 08:48:38 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:41023 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgIUMse (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 21 Sep 2020 08:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1600692514; x=1632228514;
  h=from:to:cc:subject:date:message-id;
  bh=aZMDGH/QxK/Xu1ccqYQ3KxkvrzH2gMYAzF0dSipOzIk=;
  b=e9G0ScWYtxfxix2LGz0bjI/VHXr9me9zFCKyLK5WYqzwfAaoAq98VdAG
   xodzLmaMEZZdkrk2tIXbGaOqpepqUl22BuCJulD7DML6PQzDsYuWRFweg
   4iLkczxFKE0gO5Q1JC1tAEdOYE8yJMx+I8GCf8pqogw4WKLenJ1RBaRDO
   Y=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 21 Sep 2020 05:42:29 -0700
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Sep 2020 05:42:27 -0700
Received: from dikshita-linux.qualcomm.com ([10.204.65.237])
  by ironmsg02-blr.qualcomm.com with ESMTP; 21 Sep 2020 18:12:03 +0530
Received: by dikshita-linux.qualcomm.com (Postfix, from userid 347544)
        id 417494DEF; Mon, 21 Sep 2020 18:12:02 +0530 (IST)
From:   Dikshita Agarwal <dikshita@qti.qualcomm.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@collabora.com, stanimir.varbanov@linaro.org,
        vgarodia@codeaurora.org, majja@codeaurora.org,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>
Subject: [PATCH 0/2] Add new controls for QP and layer bitrate
Date:   Mon, 21 Sep 2020 18:11:51 +0530
Message-Id: <1600692113-32279-1-git-send-email-dikshita@qti.qualcomm.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This series adds frame specific min/max qp controls for hevc and
layer wise bitrate control for h264.

Dikshita Agarwal (2):
  media: v4l2-ctrl: Add frame-specific min/max qp controls for hevc
  media: v4l2-ctrl: Add layer wise bitrate controls for h264

 .../userspace-api/media/v4l/ext-ctrls-codec.rst    | 74 +++++++++++++++++++++-
 drivers/media/v4l2-core/v4l2-ctrls.c               | 15 +++++
 include/uapi/linux/v4l2-controls.h                 | 17 +++++
 3 files changed, 104 insertions(+), 2 deletions(-)

-- 
1.9.1

