Return-Path: <SRS0=busD=42=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE24FC10F27
	for <linux-media@archiver.kernel.org>; Mon,  9 Mar 2020 14:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9583821655
	for <linux-media@archiver.kernel.org>; Mon,  9 Mar 2020 14:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tuHqmPuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgCIO7d (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 9 Mar 2020 10:59:33 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:33893 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgCIO7d (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 9 Mar 2020 10:59:33 -0400
Received: by mail-lf1-f51.google.com with SMTP id i19so2041498lfl.1
        for <linux-media@vger.kernel.org>; Mon, 09 Mar 2020 07:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id;
        bh=DEzEC8BjLUnhqJX2rzBJ5a/+Y27YQAj4/2JPBK5EdSE=;
        b=tuHqmPuQCumDn8IzaoHpYyeF5us58Gt7WOlAiPAQkZ1/jE2Z008LJY29hOPxTa+Jp7
         A91bbXdYjeJH43hsoDJdIVA8ERzp1zVlXabTIfjRHlZjj7ZJMOU74JBKq2GlLzUeJFLp
         QeLcEc0e0mOaODoXAjw570RAWK15t/yfO3g8PzSjTdRLO4QNtTK6KuET3myUdAz2leSD
         F+HYwnf6Nn9Hes2ZtA45ycnHJpAk4uM1HS0PnmytXgXMyhBWzJfBd+27inYgKZh7Scgk
         Dey73ASQuKZX8kGG3QMKC2Kxxb1MZI+q9ML/J/jUxwHhJWCcz7SPtI4uPoUGEw1kwBnd
         6Vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=DEzEC8BjLUnhqJX2rzBJ5a/+Y27YQAj4/2JPBK5EdSE=;
        b=DQlVaXqybUjTWH4/CP0SqSBUnFOH1TZxrJABlM6P4gP94XV+z9uJCHnJCgszq59yvi
         4EbaaQlTtahQmQn8q1EdbanyRGMKlvtd+IF8OCPW+zlIOqkxUevDmbh1WZo11VlzOG8e
         SJLLduMl3geh0CRfxUA08Q55TuL2HpSypL2fsXJns6aCsYNzGCV8JjB3spNHq0N+gdgM
         glMZjOph4JqeXoUGHggQcVy2npvL4PNfvjVz1hoKvo1YqQhDgpIo3hhKpF7NSzgr2Ibg
         Uuqn6pGHXRZot4JgE898VmLIiO2J2IQfS4dgdJQak6y6U4KHBWRakwvOcg4jFIqWZ8BF
         TZnw==
X-Gm-Message-State: ANhLgQ2MbyFitxbznICmgcMuvWsjqlULNLue00JAQaUi2KQ6bM/4MDaB
        pfJsXg1QSUH7JHrRNcBF2mRTJ0c1Eb0=
X-Google-Smtp-Source: ADFU+vuaYIp8RVkjSFA9qUVMJgxmSSVnZyUyxm7aQpOGU/dOwHwWe5DK+B0toGmsztn+TyJ93FUmpQ==
X-Received: by 2002:ac2:5111:: with SMTP id q17mr10060667lfb.51.1583765970483;
        Mon, 09 Mar 2020 07:59:30 -0700 (PDT)
Received: from localhost.localdomain ([94.155.124.210])
        by smtp.gmail.com with ESMTPSA id m24sm26630419ljb.81.2020.03.09.07.59.29
        for <linux-media@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 07:59:29 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org
Subject: [GIT PULL for v5.6] Venus fixes for v5.6-rc6
Date:   Mon,  9 Mar 2020 16:59:15 +0200
Message-Id: <20200309145915.9411-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

Here is one regression fix for v5.6-rc1, the driver isn't loaded
on sdm845 platforms.

regards,
Stan

The following changes since commit d171c45da874e3858a83e6377e00280a507fe2f2:

  media: hantro: Fix broken media controller links (2020-02-24 15:10:39 +0100)

are available in the Git repository at:

  git://linuxtv.org/svarbanov/media_tree.git tags/venus-fixes-v5.6

for you to fetch changes up to d2470e3979ea4a0fd08b4189b4afbccd78c8892b:

  venus: firmware: Ignore secure call error on first resume (2020-03-09 16:41:46 +0200)

----------------------------------------------------------------
Venus fixes for v5.6

----------------------------------------------------------------
Stanimir Varbanov (1):
      venus: firmware: Ignore secure call error on first resume

 drivers/media/platform/qcom/venus/firmware.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)
