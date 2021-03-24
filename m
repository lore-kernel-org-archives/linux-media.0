Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA43C433C1
	for <linux-media@archiver.kernel.org>; Wed, 24 Mar 2021 14:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 104DD61992
	for <linux-media@archiver.kernel.org>; Wed, 24 Mar 2021 14:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbhCXOQL (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 24 Mar 2021 10:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbhCXOQD (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 24 Mar 2021 10:16:03 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341BDC061763;
        Wed, 24 Mar 2021 07:16:03 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id j17so12275473qvo.13;
        Wed, 24 Mar 2021 07:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d2Youf0Yxi4iyqPIUQ6ZuRur8QBrcIlN40Gbzk7GzUk=;
        b=oazhYYvcq9TUfQE6Lt5MYKJnRXerNhgTLu0jf5yhPLIcrz4cPzvDwB0g5F4MXkFL2H
         ZyhD3MPSfklt2mQGmtWcMn2gB3i427tV3JbQC3jAbLkCZbVfrNmld3jjzEw3UOUow2Ph
         iunEpvGG0Dhn/tlSqovDjzvNmc4JhAaqWKYJM64qOSURua+03twyx72rKRjlkhG8XR5i
         QZh1CF3+Xs7qEk2qOTujxOdMRGjk5pLRFauCrMonLRp3k/aRvpPCZAwsstm6kgTS9CV9
         /X9CSJDdFLb2Ec3+hs7asDUxRDmwiYJdNNRama9AMc9o1ubJoPxZbaq1A/J6rkLgzx3Q
         jJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d2Youf0Yxi4iyqPIUQ6ZuRur8QBrcIlN40Gbzk7GzUk=;
        b=BFCTiCvkMiIbyg/bk309ePV5xLCr1oZfRoxSoMD51BMBxDKMW9WwtfbMQ95cJgu071
         wVIM4cO+yKMdCPsMz+xY9s1P3qmrU4Usn1lE3KCBtdfVOY02fUN67XQj+TQfq+zllf1x
         V0hhpsS6dFuTZzj5ZNFljw96wTt1LeUlP53n0yelq6OQkWStSUKfTjXfoJ0guihuOpxO
         OpXWCtDtOFscv+tZDUttxIjgheDGuGsHkJYTlWZOjaBtJPREfAZlbOdjSfnT5reiNis0
         m1KriiG8M6QDrDtmSEzn8WdRO1FKFi2e3e6s4cB35+VY7kakWTFJ6P6yi4dyjeo7Riuw
         uqlw==
X-Gm-Message-State: AOAM530P0eNBHARWyqLDC51qw3fvo89av27Oiw7Legdpfru7n5BtZzhr
        epRO8qWBDVZfE7qOx4Rf/Oo=
X-Google-Smtp-Source: ABdhPJxVnlawsw7TWltHKpM4BfUoBIt4IOOzEq+tXEUTtOimsyVA4I91EYcRKKmpP8weYjJeiBs3NQ==
X-Received: by 2002:ad4:540a:: with SMTP id f10mr3146952qvt.26.1616595362491;
        Wed, 24 Mar 2021 07:16:02 -0700 (PDT)
Received: from Slackware.localdomain ([156.146.36.138])
        by smtp.gmail.com with ESMTPSA id v128sm1794669qkc.127.2021.03.24.07.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 07:16:01 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     mchehab@kernel.org, gustavoars@kernel.org,
        sakari.ailus@linux.intel.com, hverkuil-cisco@xs4all.nl,
        unixbhaskar@gmail.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] media: cx88: Fix a typo
Date:   Wed, 24 Mar 2021 19:47:43 +0530
Message-Id: <20210324141743.11961-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


s/sillicon/silicon/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/media/pci/cx88/cx88-cards.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx88/cx88-cards.c b/drivers/media/pci/cx88/cx88-cards.c
index 8e224fc0474d..f01e48c23f8e 100644
--- a/drivers/media/pci/cx88/cx88-cards.c
+++ b/drivers/media/pci/cx88/cx88-cards.c
@@ -3206,7 +3206,7 @@ static int cx88_xc4000_tuner_callback(struct cx88_core *core,

 /*
  * Tuner callback function. Currently only needed for the Pinnacle
- * PCTV HD 800i with an xc5000 sillicon tuner. This is used for both
+ * PCTV HD 800i with an xc5000 silicon tuner. This is used for both
  * analog tuner attach (tuner-core.c) and dvb tuner attach (cx88-dvb.c)
  */
 static int cx88_xc5000_tuner_callback(struct cx88_core *core,
--
2.30.1

