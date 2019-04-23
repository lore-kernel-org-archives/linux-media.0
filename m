Return-Path: <SRS0=z7aI=SZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B67C10F14
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 14:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6634217D9
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 14:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lCcCN+zu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfDWOHV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:07:21 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:35761 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfDWOHV (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 23 Apr 2019 10:07:21 -0400
Received: by mail-wm1-f52.google.com with SMTP id y197so262492wmd.0
        for <linux-media@vger.kernel.org>; Tue, 23 Apr 2019 07:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id;
        bh=d/a0zZ3tR2k7Vb30oj+toSlyCGxTLAwiwUEky6bo9Pg=;
        b=lCcCN+zuTb+rfs43H6Ln7n26xtjlEKJooHg3dGN6CG/XSNKcvX6eEdpBCz0tOt8taO
         YnY3tX/deSrbGMFcFrJDM3mF0g/krVubMLNIs4ykjzrixKZN6MgdNkU2X/NrBrH08P91
         btxr2TLYXZttpg8/r4T3bCZrsIrx76wjcFD+g3lLsD5fnAAKg9JFnEdnS0KkYPNPTC8W
         GGw7KeGhPfbwM3mUs4aegAXXExNtVur1T6xzucwPDjs3Rs+QOos/LdWQioa1vlE9vVFB
         LqEzdoXVyApZ+2MY20Qo6/rUpnY/g3WVNIF2vR+i9SDG4oGvcNZDLZrsdVk0GZZl66sD
         ec/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=d/a0zZ3tR2k7Vb30oj+toSlyCGxTLAwiwUEky6bo9Pg=;
        b=kFx2aLSYGYQxmn1eSLhr2B1//EuPdu/lcq95kGu4QpK3u2c95t2yTjGwdGZl1ulb1r
         lzOqOcAFt+rCKFFED9cq7rRmlAv206huO9uRUNsS9QCfBxdSA/g8EXKf1zT7aBWkvBlf
         5Hp01kriUWQNqAHkktPeULKJnKEfysP1L/l157O5OUGfG5EKUmO26mqd8sBogUs+WkUG
         PsQK6qcoR2k+RRp7djRz4y6g9ruLK+PcfI2ETMKQbRfTsSAEbhsh3j/HuuG7V/Yg/GBg
         M1fUSQu1UZB39NtrZh5h7Drh2W3wmhMgRMf8UhH0VrhC3wb0fcejCN9+D0vIofxfF4ue
         Gnpg==
X-Gm-Message-State: APjAAAWNmtyvQHH3Su84ub5NP44gVLaUnDWxBSCoppEednzd+86FYA+C
        KE36D7nTGD2W4GcW8Y8wzaRgKdtwbu8=
X-Google-Smtp-Source: APXvYqx8HJfaexKU07Np9Q95DiTnMobrnyn5R7kT1G+zhS2dbmRS/ggLTc1Nd3vtKxi+UCzI9tQggQ==
X-Received: by 2002:a1c:6889:: with SMTP id d131mr2490288wmc.114.1556028438749;
        Tue, 23 Apr 2019 07:07:18 -0700 (PDT)
Received: from localhost.localdomain ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id b8sm9748013wrf.21.2019.04.23.07.07.17
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 07:07:17 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org
Subject: [GIT PULL for v5.2] Venus updates - take2
Date:   Tue, 23 Apr 2019 17:07:02 +0300
Message-Id: <20190423140702.26044-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

Here is the second attempt.

Added two more fixes for Venus v4 properties and dynamic buffer mode.

Please pull.

The following changes since commit 26d5d1fe53e966efe567e9773d1158baef303e3b:

  venus: helpers: fix dynamic buffer mode for v4 (2019-04-23 15:57:17 +0300)

are available in the Git repository at:

  git://linuxtv.org/svarbanov/media_tree.git tags/venus-for-5.2-take2

for you to fetch changes up to 26d5d1fe53e966efe567e9773d1158baef303e3b:

  venus: helpers: fix dynamic buffer mode for v4 (2019-04-23 15:57:17 +0300)

----------------------------------------------------------------
Venus updates for v5.2

----------------------------------------------------------------
