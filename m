Return-Path: <SRS0=8X75=UE=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEA1C28CC5
	for <linux-media@archiver.kernel.org>; Wed,  5 Jun 2019 21:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA280206BB
	for <linux-media@archiver.kernel.org>; Wed,  5 Jun 2019 21:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559771645;
	bh=Dm/usv2Lp33uGkK3aDiRre3Dz2r14D+/ly9LsMz6mb8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=UV5T+lMVTEbW4BbeGihorkOILd8Fvj4n6YEFKiia1bpOYobsM3DLAtCfAcemqae8o
	 CXqCiVKSPpBqJ8wQ251S7e4ejjDEzJTMIbUozKOR1IL1wj3tPWC8CrXb5dXZ70dOy9
	 RlqgbBCLDq3mH9PZbnCpjwgKn3ur/WhEswDz+4Fg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfFEVxx (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 5 Jun 2019 17:53:53 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55455 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfFEVxx (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 5 Jun 2019 17:53:53 -0400
Received: by mail-it1-f195.google.com with SMTP id i21so5928848ita.5
        for <linux-media@vger.kernel.org>; Wed, 05 Jun 2019 14:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K+r7RaKysQWVK1kSGMptDDC44bF0ZIkuhOXfBK5LAE8=;
        b=W9wQlz4ewzWgIHUvyjdmghjfzs2N93XSM6bBGBSNwyk7szuqaElR9hETXLl5AiPMJ/
         HVMUsJErFNl3toJvO3QnBP70fopnoqjTCFvhqB6H9mBnv8ZfAXzor5U+HT7IiDfx8Si0
         b3PYidfXUcVIi8lUY3FNf0rtvCAWGe7BaT1ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K+r7RaKysQWVK1kSGMptDDC44bF0ZIkuhOXfBK5LAE8=;
        b=VxTXq5LppjNguKD2tkPIyRyRKcDa4BZUktfs8C8aNMm+IWGOiQR/ZfHrvirs37ukP7
         WspdfGSckaQwd3/kfNys8fGQ+G1yGSNkEcCBjqw/Zz4A4XEl+6Ylxb2eHhFe1XA7T94A
         SnIJS43TpZu6BV/AnShsbYT33CuINhAvMwzmBCJBWSURXEMLr3PKYaclyQ56Sr+TCI8D
         GxRZQAwfE3R1y0ATXMewLVeYkGEU76KLSy3gIUulcX/zH61jftcpz01yLRtkc5ITcly1
         Jvf0AG36b3eNXTCldPAXfvcRiqDMQ5Ja/IFPwG6LL7cogUJX8G3iHQ+KSaT6jvY8LnbI
         X6UQ==
X-Gm-Message-State: APjAAAWds2+Ny1FUuTF4pUkM3HOj84ff7LyTJyyBgCWmj8x5QoDOX1kT
        APx8zJL+isaEKHEeSky7B1U43Q==
X-Google-Smtp-Source: APXvYqxtbeU9CnF1kOfkcBsm2/XWPfxEpuuzggpK+0/Cf1Ern2i+PfGC8ou5qpL8iPjP+HcxjVQrxA==
X-Received: by 2002:a24:2e8c:: with SMTP id i134mr27696135ita.9.1559771632716;
        Wed, 05 Jun 2019 14:53:52 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e127sm37484ite.33.2019.06.05.14.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 14:53:52 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        sakari.ailus@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, ezequiel@collabora.com,
        paul.kocialkowski@bootlin.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Fixes to cppcheck errors in v4l2-ioctl.c
Date:   Wed,  5 Jun 2019 15:53:46 -0600
Message-Id: <cover.1559764506.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

cppcheck runs on the kernel found a couple of cppcheck errors in
v4l2-ioctl.c. These two patches fix them.

Shuah Khan (2):
  media: v4l2-core: Shifting signed 32-bit value by 31 bits error
  media: v4l2-core: fix uninitialized variable error

 drivers/media/v4l2-core/v4l2-ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1

