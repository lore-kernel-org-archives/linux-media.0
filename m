Return-Path: <SRS0=ylfx=ST=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70552C282DA
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 14:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40479217D7
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 14:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOIYjStB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbfDQOG7 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:06:59 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40063 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQOG7 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 17 Apr 2019 10:06:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so12093480plr.7
        for <linux-media@vger.kernel.org>; Wed, 17 Apr 2019 07:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=us9G18P81iar7rzB08BUB/hHQo8AUsxOaKRGG9gYJGg=;
        b=HOIYjStBKkBQeswoVSsCQ8rDMT1bg3gd/2B7xu4AINLdFmnNps+Or275YbaZKmCPZf
         Qsp00pkYmdqWDYbdIG1HsXvdlKcpHlal3yE5EYWhHrw2t9BPftyrkTJEywmopa5Mu8gA
         6tdt/j2g9oTB0QBs/4P+bBcogf0k+FbiqAsGMQmrAluliC36LJVIMeZc1MGIMXb6Aj9h
         5SLp5Dq2bxCyxfULAM/ZJt5kZzWWeEvFJLeJJGJdjwAslUZSeFvgQOJAPsD8Hu+SJ52O
         k716HzP0+FA/zk0OclzNeef+59uaYQZ1CM+bmYn88fadYP+dcrfQsFwIUYoMiG2dZTS/
         7N2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=us9G18P81iar7rzB08BUB/hHQo8AUsxOaKRGG9gYJGg=;
        b=rWn+TEUsDc6R/WHWnABVdMbfD0WkyPfvVqMhb70iT/E3VYmdYkmro3vh2Xd7RQsU0N
         wjrQiN7el5GTZmPMQv2RV9hY2mcAwwbebIdZffk9TSDLkWYj2u45LLrxgVpiW4Zh2ze3
         m2Q0l1ebwOJX+jaSW2NZauZ7FjDVhBYigq5vGwlez1jMinHgecxz8oSElmd88jBxVNpM
         S2HmL3KP6cl561G4hnsXSJ5cpJmGvH3RZZuCxIOPZBM/yyGvW/hq58FWn9UBmErpuSPy
         B9uzbxrg1OtlXAda5M0DuZ3/5inCecNH2l15yz704JITm5YA6dXCk6JGW7FJecgUB2O9
         em7Q==
X-Gm-Message-State: APjAAAUEj55YC1YvH38vhQvTbR0rXyzKsCHfLzLCype+Mh1tinkDABfo
        JNtB0zdnNapbMGUJg7BuAA73razo
X-Google-Smtp-Source: APXvYqwm46WwjE/5RIQ5liMEsHUL0awnOTBhP12J4tjb9ANxHFJCd/A8yCOJijVyTln8VIVnfX5MGQ==
X-Received: by 2002:a17:902:e183:: with SMTP id cd3mr73394227plb.233.1555510019013;
        Wed, 17 Apr 2019 07:06:59 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:1b24:991b:df50:ea3f])
        by smtp.gmail.com with ESMTPSA id t82sm144498222pfa.153.2019.04.17.07.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Apr 2019 07:06:58 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 2/4] media: ov7740: avoid invalid framesize setting
Date:   Wed, 17 Apr 2019 23:06:39 +0900
Message-Id: <1555510001-23922-3-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555510001-23922-1-git-send-email-akinobu.mita@gmail.com>
References: <1555510001-23922-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

If the requested framesize by VIDIOC_SUBDEV_S_FMT is larger than supported
framesizes, it causes an out of bounds array access and the resulting
framesize is unexpected.

Avoid out of bounds array access and select the default framesize.

Cc: Wenyou Yang <wenyou.yang@microchip.com>
Cc: Eugen Hristev <eugen.hristev@microchip.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/media/i2c/ov7740.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov7740.c b/drivers/media/i2c/ov7740.c
index d122e35..5c0dfdf 100644
--- a/drivers/media/i2c/ov7740.c
+++ b/drivers/media/i2c/ov7740.c
@@ -785,7 +785,11 @@ static int ov7740_try_fmt_internal(struct v4l2_subdev *sd,
 
 		fsize++;
 	}
-
+	if (i >= ARRAY_SIZE(ov7740_framesizes)) {
+		fsize = &ov7740_framesizes[0];
+		fmt->width = fsize->width;
+		fmt->height = fsize->height;
+	}
 	if (ret_frmsize != NULL)
 		*ret_frmsize = fsize;
 
-- 
2.7.4

