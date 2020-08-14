Return-Path: <SRS0=xFXP=BY=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043C2C433E1
	for <linux-media@archiver.kernel.org>; Fri, 14 Aug 2020 20:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C468820774
	for <linux-media@archiver.kernel.org>; Fri, 14 Aug 2020 20:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="arhmDL8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgHNUyj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgHNUyi (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 14 Aug 2020 16:54:38 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E718C061386
        for <linux-media@vger.kernel.org>; Fri, 14 Aug 2020 13:54:38 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h19so11286331ljg.13
        for <linux-media@vger.kernel.org>; Fri, 14 Aug 2020 13:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1FDKw0O5eWt4YU9CAFYlMQLGqQJ37dmu6qNrHuMqcRQ=;
        b=arhmDL8vT23JBvzxpJv91eUUdxiZXfmUexqllb1641LB0jGGd+HkHFMfCe3n3UDz3S
         dMUKeWEZwQYhpfYmGD/43DeFiRPlX8/536nYrg/WvhEqZOabilD0V9JYMjINp7jEAjJ5
         uDZXWUSaRky02uqIayG9p8wT1uq7Uunp7ArTqKk5JGC1DT12IR6DRgqbmSgyakg9/Edm
         E7dhMR6zP+9azLjLYkWUGo/a0oUGBvdyP4INGy3FuSk1vYGE1x9a28udmHb7ZKW8R4GR
         yRt+5pQyM7pVx3Q7jjtkydu3a62isTD+46eotZSyNxw3sLYfrAReo52CNCK3txPlppq4
         WDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1FDKw0O5eWt4YU9CAFYlMQLGqQJ37dmu6qNrHuMqcRQ=;
        b=l+jZ7ZCU8EoV1y34yXCvX7ZItnaDw9DzSPNcFj6oJ1zDjENU7fwEE7kqWH3kB/p4xM
         VVQulLtXD8DLAJkKc5SYeM+Zb70KSOtT8MRBMqVzVzhqrjv8dKcBTcPb2Tkm4wc6m/d6
         XQRM15xEiabth4+Ye2R9lIQ4Kvjn6JNpoh2tttkB5h9NANIAbOG3Oi3fQMDlLJgZcf8B
         fTX86G7iXlMeghXITn+PrR/Ol8vuhWQTm/ZncRzuOvCuF18yr0tjAzjkdYY5lVcYMfch
         EmYy4V3/HxyyL4Nxpuus66oHbR+Wr+ZXrR34Nv0qPFBrwU9WoJsixua06JPUmkzJMI4F
         8K/A==
X-Gm-Message-State: AOAM530uemTOQrLUB2ATm9lu3Y3K0pjQ1ofVbjmA1weYOHIZJHNsLG/e
        euAv37sbgAeu/iIg9qgTkskxGX0zM3acDQ==
X-Google-Smtp-Source: ABdhPJwBV78C0P4u8Hc+zfdCX6Itq38Fw/gxcSmfDj+x9xJUcP+9+mfQEk7F/t+DrDJiIOhXragm4A==
X-Received: by 2002:a2e:2a84:: with SMTP id q126mr2054347ljq.289.1597438476455;
        Fri, 14 Aug 2020 13:54:36 -0700 (PDT)
Received: from localhost.localdomain (37-144-159-139.broadband.corbina.ru. [37.144.159.139])
        by smtp.googlemail.com with ESMTPSA id j26sm1963601lja.111.2020.08.14.13.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 13:54:35 -0700 (PDT)
From:   Andrey Konovalov <andrey.konovalov@linaro.org>
To:     mchehab@kernel.org, robert.foss@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        peter.griffin@linaro.org,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Subject: [PATCH 0/3] media: camss: extend VIDIOC_ENUM_* ioctls support
Date:   Fri, 14 Aug 2020 23:54:00 +0300
Message-Id: <20200814205403.27639-1-andrey.konovalov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The first two patches add mbus_code filtering support to VIDIOC_ENUM_FMT
implementation, and VIDIOC_ENUM_FRAMESIZES support.

The minimum and the maximum frame size values are deduced from
__video_try_fmt() code.

The third patch replaces harcoded limits in __video_try_fmt() with
the definitions introduced by the second patch.

Andrey Konovalov (3):
  media: camss: Make use of V4L2_CAP_IO_MC
  media: camss: add support for vidioc_enum_framesizes ioctl
  media: camss: __video_try_fmt(): don't use hardcoded constants

 .../media/platform/qcom/camss/camss-video.c   | 112 +++++++++++++++---
 1 file changed, 95 insertions(+), 17 deletions(-)

-- 
2.17.1

