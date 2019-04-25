Return-Path: <SRS0=19ZY=S3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E84C43219
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 21:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DD1206C0
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 21:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b6Uu5DGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388114AbfDYVm5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:42:57 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:37610 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388093AbfDYVm5 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Apr 2019 17:42:57 -0400
Received: by mail-wm1-f51.google.com with SMTP id y5so299206wma.2
        for <linux-media@vger.kernel.org>; Thu, 25 Apr 2019 14:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id;
        bh=nqBIRp2vSl4XwDYGmzrmGCeDv52wRDhbcbEOUq4h89E=;
        b=b6Uu5DGUpncxaVOqsQEy1KjIn3kArrRDdBRp4X58E0EdD2G7MpH5M6JN6tKs4rrszt
         xIH/T0jden8Tfny4Fla+XWSpaiELmfelahfikVwbhcR+uZTfDA7ZBbVQCw+WJetTU/i1
         is5qcvS2+tQChlCAh5jws53PY7XU5D15n4amGeTMt0gSJqgjeAlHwbkBPHLfSw/3inam
         FuzuK4N8xmb9CHBLcVZRKPUQbaAos+gvuJylXuH1cppok+lGrc+XTm9FvWi2ofsIy/wa
         TY17k+kVcCe5jSJ6AGf6Ba6o2kXfGNG8wiynunNcDwQ6ERVYXN5GXb802UA34gPZsD3A
         hxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=nqBIRp2vSl4XwDYGmzrmGCeDv52wRDhbcbEOUq4h89E=;
        b=mqfuoXWu9S9Xi63mgVXSrrl9TB6/k/jyTgdo/9FTnfoO9jlw8gms9v9pLmemeUhQgH
         7wECAeXeH1O8qvX4ESC7QT+JGWrQEW6ndSg0j7diUXzUEQH+7CyfR972Fr1tYlYXuuS4
         hFi3wyADQ4oASo2mSm5vFPcYieiogfdZlELDq6apkqE/nTqYr5naFKgjiP8KjSLeaYBT
         P5gKZbynNF2PmUQk/s/WmqT4SPjrN/hF1XuvvXv7ZmxJ6nnc9vXanWYZIPAI/Rt/M5QV
         FMjdCHKNYk9iCXIB3ZgwC1rI9SSD98qA/WZUR0nMhTPAfOWVE4HfTlJfnkveYn5gknYE
         fqHw==
X-Gm-Message-State: APjAAAUOoVSG0eH1NTLETT6kPQ3anxl1UxV5ipbVbfVS21S8tEKeCftl
        y8Eh4wsXLaGZmtPRI5wZKLbtl+TCwV4=
X-Google-Smtp-Source: APXvYqwRa+omBow4L8N1ckqs9pvEjS1vK2sAUstXqKCUQ61NJEzwyth0ar4atlK6TXMZLbPE9cycLw==
X-Received: by 2002:a1c:c181:: with SMTP id r123mr5020415wmf.13.1556228575059;
        Thu, 25 Apr 2019 14:42:55 -0700 (PDT)
Received: from localhost.localdomain (212-39-89-23.ip.btc-net.bg. [212.39.89.23])
        by smtp.gmail.com with ESMTPSA id 6sm15547723wra.85.2019.04.25.14.42.53
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 14:42:54 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org
Subject: [GIT PULL for v5.2] Venus updates - take3
Date:   Fri, 26 Apr 2019 00:41:34 +0300
Message-Id: <20190425214134.31905-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

Sorry for the inconvenience, here is the third attempt.

Added two more fixes for Venus v4 properties and dynamic buffer mode.

Please pull.

The following changes since commit 7afa8db323e37b9174cf78a1c9ab0ae7a9f5e7dd:

  media: vsp1: Add support for missing 16-bit RGB555 formats (2019-04-25 11:07:05 -0400)

are available in the Git repository at:

  git://linuxtv.org/svarbanov/media_tree.git tags/venus-for-5.2-take3

for you to fetch changes up to cac29335c397d116ec405a9b67466663de1606dd:

  venus: helpers: fix dynamic buffer mode for v4 (2019-04-26 00:08:22 +0300)

----------------------------------------------------------------
for v5.2

----------------------------------------------------------------
Alexandre Courbot (1):
      media: venus: core: fix max load for msm8996 and sdm845

Kelvin Lawson (1):
      media: venus: Add support for H265 controls

Stanimir Varbanov (2):
      venus: hfi_cmds: add more not-implemented properties
      venus: helpers: fix dynamic buffer mode for v4

 drivers/media/platform/qcom/venus/core.c       |  4 ++--
 drivers/media/platform/qcom/venus/helpers.c    |  7 +++++++
 drivers/media/platform/qcom/venus/hfi_cmds.c   |  2 ++
 drivers/media/platform/qcom/venus/venc_ctrls.c | 21 ++++++++++++++++++++-
 4 files changed, 31 insertions(+), 3 deletions(-)
