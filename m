Return-Path: <SRS0=Gl4L=SD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0299C4360F
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 08:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912C7213A2
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 08:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lc4Y9DAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731937AbfDAISq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:18:46 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:42322 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731802AbfDAISp (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 1 Apr 2019 04:18:45 -0400
Received: by mail-pg1-f178.google.com with SMTP id p6so4357754pgh.9
        for <linux-media@vger.kernel.org>; Mon, 01 Apr 2019 01:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id;
        bh=jUxxzgsFPLgQONY+0oOKR7um9wenQQDgHoKuoj4IeRI=;
        b=lc4Y9DAfZYlAHZZ6rRGuzC2LNykXIwBUDuvn6qDeoeXl0rDFjCAsRZGjU+U4VzDRgw
         pWYrLpNuFD19k8kHy1BE9UH/G1ilXaTKfB4xurito/cnEt2YMwOA72w9NRFfl2G7WmAz
         BxL9tdDX5p3+XRoSVKpjmIkhzugDyKnrxJeC3gUUsHHW8TYgdIF4ZuSYnEwL7piB3iSe
         Wab2d7l9NATr/0Vfh7+xZdOeR8OqxS0+0NLicHcox9fAgjbr7aOGuvN/xX63E3ze6kGx
         f2uvd9a2Zi3SBJAhrhm/tGOKnP6jRyBKcRTE1LVkJ1ClE4mJZNmSrUTeGomBlOKvgupG
         FoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=jUxxzgsFPLgQONY+0oOKR7um9wenQQDgHoKuoj4IeRI=;
        b=XRSws88nmMT3OKw/PEfbpgnKA4yA+EyzEeN1P8Kbb5nDdcc70c3yoHBSWyESDjvFAO
         sn3UegChIxVuQymtcvoTSLZ+EQwgWwI97K//BkfwDo11PA7HSrk6ZIKbc+BIjfrhhjMQ
         fCA69QKcrhUr+rMaotWJTs3/HInDByJBlmjNOuXMbcE/Vc3KbDSz30YHoRzbmkvdjONi
         eEp0pi6ELpVSBuTOR/q8jDSkvdcVeVFTiMPHqDz182RE20LGpWcHOP+7GwDzRwiEJgR7
         4cqD5Ip/fblOJZaKRodDapn0D4I7ZqI+zEb9/LZVLOBFyyu3rbFahacRq4FI/zMWAfp+
         t/ww==
X-Gm-Message-State: APjAAAX4LM6utTTeaalfrFRF5G1D8oy+gRJSz2XZ/98s4PCLkamwR2IF
        h8KgionMcvz1L1NqtlKkEyQWq0GtKG0=
X-Google-Smtp-Source: APXvYqxbYUDGKM5n6yMphJLvPQgduQUSfWJCm0YQw0uUGLHXbmjpxc0fMVQ9rJ07CIazPNgofVyT/A==
X-Received: by 2002:a63:c204:: with SMTP id b4mr59023440pgd.335.1554106724807;
        Mon, 01 Apr 2019 01:18:44 -0700 (PDT)
Received: from localhost.localdomain ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id h187sm5719302pfc.52.2019.04.01.01.18.43
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 01:18:44 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org
Subject: [GIT PULL for v5.2] Venus updates
Date:   Mon,  1 Apr 2019 11:18:17 +0300
Message-Id: <20190401081817.14386-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

Here are two patches, one fix and one which makes gstreamer happy with h265.

Please pull.


The following changes since commit 3e11851d16ea7eff1cfa66b1cb7b35967876dd1e:

  media: venus: Add support for H265 controls required by gstreamer V4L2 H265 module. (2019-04-01 10:44:05 +0300)

are available in the Git repository at:

  git://linuxtv.org/svarbanov/media_tree.git tags/venus-for-5.2

for you to fetch changes up to 3e11851d16ea7eff1cfa66b1cb7b35967876dd1e:

  media: venus: Add support for H265 controls required by gstreamer V4L2 H265 module. (2019-04-01 10:44:05 +0300)

----------------------------------------------------------------
venus for 5.2

----------------------------------------------------------------
