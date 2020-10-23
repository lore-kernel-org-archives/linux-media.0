Return-Path: <SRS0=FqJP=D6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D53C388F9
	for <linux-media@archiver.kernel.org>; Fri, 23 Oct 2020 12:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD81121D43
	for <linux-media@archiver.kernel.org>; Fri, 23 Oct 2020 12:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WDPqCpqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464129AbgJWM5X (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 23 Oct 2020 08:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464123AbgJWM5V (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 23 Oct 2020 08:57:21 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBB6C0613D4
        for <linux-media@vger.kernel.org>; Fri, 23 Oct 2020 05:57:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d78so1348585wmd.3
        for <linux-media@vger.kernel.org>; Fri, 23 Oct 2020 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d6MrggB0Obs1H04N41aSmGHcG+3VEtp3I3jrGd1sX7s=;
        b=WDPqCpqYtdLl5HzEhfzTRo048t+1HiWYtcoArblp2lCFQ8qTX+N12yUTonYt0fQ/08
         rlPwUTh9AFEXdOybZ0j4ccVA3VZJGpH6MW/3Lr3YTmAsRCqN/l+xayh9wj/+FkYd1S2G
         pgn1gvtA8A8zF/iRxFjGeUf9QZOBubeSNiiY4jLt/eovO9lw4dkmnsWqcbaifDyvJwjK
         JrS4A5FU+L+657HVqdf/nE1DmTXvIFKy/4HhUgk39wNM39LH/tWUiWQTIk7QvqUvjr18
         nrrvN1mfFwhQyTi9xE8wimHfsCwJvhwpL2VVguH0MmFLM34Y+a/LkibITahVWNMcvau1
         CHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d6MrggB0Obs1H04N41aSmGHcG+3VEtp3I3jrGd1sX7s=;
        b=lrKs4lC2Kg4OtjnVU1atyXMHuICI1LxfNgj9TNAtBqz37ZVqOdIj4R3RrtQ7nGSNjc
         u9pJDksRxl/TGU7x3JZ91OHgjSHxbP5TjlvFMZk0bn3/p2MoJE07kR80pLKwoEM9N37t
         T/N6YRKh9J7uINNDIu0ye7fjnTiVSLNnDHGHS0UuSo3MCmO6ebKh06YLGVjLQmqpmVvJ
         eV7QaT9hJDS0ADCYxLKbKJRhwGp+s8ZNpVtj6va4UJtUuxMV7nJ8NJs66KQPE58mdu6x
         nUL6K+GwgOc/NDyQbP/Tea87IqJuLUiI68vWtuW2p1Tve4kF8ohPZkUuBFltk7IqIbbL
         SDuQ==
X-Gm-Message-State: AOAM530xICUU1NLvRfNL7NZIALrprt5o4wVLVrmazwAhN0VaBbiQvmxv
        DF04gBVmfJeitUGO7F1HmmhmhaylQT5ZFfnB
X-Google-Smtp-Source: ABdhPJzIX1wH2yyINNscu6kMfYr8TjsWeoOPLFENzOLAo1bgjsKLNPdEgtdPDNcPqjpYaKS3hbQIUQ==
X-Received: by 2002:a1c:f002:: with SMTP id a2mr2316469wmb.129.1603457839699;
        Fri, 23 Oct 2020 05:57:19 -0700 (PDT)
Received: from localhost.localdomain (hst-221-77.medicom.bg. [84.238.221.77])
        by smtp.gmail.com with ESMTPSA id s19sm3475873wmc.0.2020.10.23.05.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 05:57:19 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 0/4] Venus stateful encoder compliance
Date:   Fri, 23 Oct 2020 15:57:00 +0300
Message-Id: <20201023125704.4984-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello,

Тhis patchset is an attempt to make Venus encoder driver compliant with
stateful encoder spec. There are still few details which need to be
cleaned up so this can be treated as WIP. For example the usage of m2m
helpers to update the states and handing of the LAST capture buffer for
Drain state. Here mainly I re-designed the driver to able to handle
capture/output queues independently and properly go in and out of Reset
state.

These patches depend on [1].  

Comments are welcome!

regards,
Stan

[1] https://lkml.org/lkml/2020/10/19/432

Stanimir Varbanov (4):
  venus: hfi: Use correct state in unload resources
  venus: helpers: Add a new helper for buffer processing
  venus: venc: Handle reset encoder state
  venus: helpers: Delete unused stop streaming helper

 drivers/media/platform/qcom/venus/core.h    |  10 +-
 drivers/media/platform/qcom/venus/helpers.c |  63 ++---
 drivers/media/platform/qcom/venus/helpers.h |   2 +-
 drivers/media/platform/qcom/venus/hfi.c     |   2 +-
 drivers/media/platform/qcom/venus/hfi.h     |   1 -
 drivers/media/platform/qcom/venus/venc.c    | 242 ++++++++++++++++----
 6 files changed, 219 insertions(+), 101 deletions(-)

-- 
2.17.1

