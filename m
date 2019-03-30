Return-Path: <SRS0=IMFm=SB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23277C43381
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 14:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12FD218A6
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 14:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTt3LP3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbfC3OBs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 30 Mar 2019 10:01:48 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:42570 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730832AbfC3OBs (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 30 Mar 2019 10:01:48 -0400
Received: by mail-pg1-f181.google.com with SMTP id p6so2538291pgh.9
        for <linux-media@vger.kernel.org>; Sat, 30 Mar 2019 07:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=If097gK8Q4yKJ6x0Hn75dYvxLRtQOnxfa8KTYIviMqM=;
        b=aTt3LP3B9LVwcUs2IT2Q77MHlpPlWqJyLHA96VGusEAHxchfAByEtQfG0Q1w43X2HD
         0ESt0zlAUByk2i/R4TTHgvjMi08HItDhaGaYqCvlh6uZUFbnY3wLUopaPmOOCmyQraku
         ozgxa9hg8gLMCHkvDklzBFVI4nVk/3VfCeImIYAwC+q8hOEEbdm0gr9dTMtwJojR9hFS
         /4eFDtppn+tqvC3LRHpM1j1Lw5Q16Kli8EqlEGwRJZdIOD1xPGwhI3Q9kJetz/lvYztP
         jaDbodjI5yTPW1Zfw9YxTVwyE8+5TCBfmql5JxxlBYi3ut0HCKA4vvcaJYZhYkAIjKEF
         1sYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=If097gK8Q4yKJ6x0Hn75dYvxLRtQOnxfa8KTYIviMqM=;
        b=WRnohapBSODYGY5ZX41Wz1BF7NULIgymGzE3/WEbbWQekkUvvC7skMjvp21YzaQJoR
         hxDJx4oWWbzxpqRsmTAILDRtdy5Z1judiu4YHnmOfw+jP/sLPclPh5gelHjb4SJ62I7S
         G2zwrrj9VJQpzb9sowSkwqB6Bprf8SFWSZhF6sIDywrN0hfjwL9rZDF54OgD6VIOnPsz
         cBBkyN7F+3qyrrARIxePD3BzRrayMY1xkHHAL2BNYUZ8w8Gns2xdNjoXzyHI+s2UzA/j
         GA2DEvMNIUGVEP2cUkBnzrShkwkU7wFp8FdwTSDq+18w7i/KAsYGlQ4ZBVhy8MtTeWQv
         kpfg==
X-Gm-Message-State: APjAAAXsL3Fm/ng/3US1S0LGD77qrForD3ytWwhOzWCF/UGVK8TzPBUs
        ckzgLpEL5pWEdyaSCrhxj+Y48kP3
X-Google-Smtp-Source: APXvYqwIGVdesJre89+Lo4mRyNck5orbuL41AHDQXmnml7Dm4yxCyIXVry9ZdnsTRsbjFP5XOPkXjA==
X-Received: by 2002:a65:64cf:: with SMTP id t15mr36933696pgv.322.1553954507199;
        Sat, 30 Mar 2019 07:01:47 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:1b24:991b:df50:ea3f])
        by smtp.gmail.com with ESMTPSA id b72sm18294289pga.86.2019.03.30.07.01.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Mar 2019 07:01:45 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 0/2] media: ov2659: two fixes for ov2659 driver
Date:   Sat, 30 Mar 2019 23:01:30 +0900
Message-Id: <1553954492-24982-1-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This patchset contains two fixes for ov2659 driver.

Akinobu Mita (2):
  media: ov2659: make S_FMT ioctl succeed even if requested format
    doesn't match
  media: ov2659: fix unbalanced mutex_lock/unlock

 drivers/media/i2c/ov2659.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.7.4

