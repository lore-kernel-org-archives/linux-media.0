Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63643C433FE
	for <linux-media@archiver.kernel.org>; Tue, 12 Apr 2022 09:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241096AbiDLJ43 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 12 Apr 2022 05:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353110AbiDLHhT (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 12 Apr 2022 03:37:19 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB10515B3;
        Tue, 12 Apr 2022 00:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649747378; x=1681283378;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=z06j5AVzHa6o6Kzxt9hg4CRwdmgU9XsrbbQKYiYjRhE=;
  b=geCHbM6EO2UrtIV+GBZb+axMQixif3eRg9xSz37JWsQL7mGm3caWhkjR
   hRybhgbsX3UgzKiYU27pl5waWxEaX1rxnbi3oCF4feuJ5RqKVe/SCsxcm
   JE0EcLIG9tUEwxp9R1zqTBqa9PWJHdQlqnbBZ9UkYbBGs95e3LLmmnt+R
   s=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 12 Apr 2022 00:09:34 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 00:09:34 -0700
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 12 Apr 2022 00:09:32 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <linux-media@vger.kernel.org>, <stanimir.varbanov@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <quic_vgarodia@quicinc.com>
Subject: [PATCH 0/2] Venus fixes 
Date:   Tue, 12 Apr 2022 12:39:14 +0530
Message-ID: <1649747356-3207-1-git-send-email-quic_vgarodia@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The series consist of following fixes
1. Internal buffers handling during reset sequence.
2. Venus power on sequence during stream off.

Please review and share your comments.

Vikash Garodia (2):
  media: venus: do not queue internal buffers from previous sequence
  media: venus: vdec: ensure venus is powered on during stream off

 drivers/media/platform/qcom/venus/helpers.c | 37 ++++++++++++++++++++++-------
 drivers/media/platform/qcom/venus/vdec.c    |  2 ++
 2 files changed, 30 insertions(+), 9 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

