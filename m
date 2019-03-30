Return-Path: <SRS0=IMFm=SB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C46C43381
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 14:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42255218A3
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 14:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knETNovw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbfC3OBw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 30 Mar 2019 10:01:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42862 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730832AbfC3OBw (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 30 Mar 2019 10:01:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id r15so2363468pfn.9
        for <linux-media@vger.kernel.org>; Sat, 30 Mar 2019 07:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=El37trIfcT5Xnqpbt+DDC26KxBeO0bYNlPsDAubf7LQ=;
        b=knETNovwRV4bajrMP1UJTuFn6MPV5DABsc1edbIE6Rp7TJAZs+CrH2oZmBkZ2Ru4x6
         PolN1vQvaP+s5jsnu9+AH3P20ewtFaZ8x9th6KM6TabZM3LnXhMr0+MicuiOkKn+nwxP
         7n5ui/cPNhQD2UxHMmbY0a+6Pxggp+zdmG1hRYsCFBDRleHcA+DW/IImgEybJCMclOqJ
         Vl0JQLnNx+9sPbFWhg04zJrXGu41gcFki3dFgs6JNaM02LBK8zPKfCiAz2riY9nYiakO
         w0nXtUjWKeGrdlTXIVXCv4u/BWjNm9IcsJindtKy6IUbvFM/7ER5o/zTsnz8ZszaKkgA
         XacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=El37trIfcT5Xnqpbt+DDC26KxBeO0bYNlPsDAubf7LQ=;
        b=c6FgM45y2bpNG2Z9MZwXeHkWzS/YFRtyc6I7HmbVJSvunwby6g4Le+giMJ2CzRQ4bO
         uBTsespOxrfgbhyHv1KAZ4KggfzUxMpyjZoRIhSfXU6gLH9USAtU8ILNTnMeG4SP3OjJ
         EWwpdb+55nPC+MoiBtP5/FdAI4EO8HLsfH0aLcinik+WFvOK0zjM+0xy0l/VSeJNrAwJ
         ABiqn90j5N0nizqCUNphvdJWpdXN7eL0B9XzF2zQj/07SMPjdCBXfd9CnZVfaSp6tDH/
         7eiAXQkDuwIAyh8WB7L8LHra5fLN/M3W6MHslYAK5xD+tF+PbmY6yCxTycesmIFYIGeW
         zCxw==
X-Gm-Message-State: APjAAAXGn5cKtbvK6tSPlEeIKoeThQG8KjalERanxubB2yxvJ2gl5+iz
        SDA/IzinF+AdcUfbYmbaUl/jOUgE
X-Google-Smtp-Source: APXvYqxI+hqBqyZ5y4z18P9O5mY0k5/PichIPbSNGRjQ7zVSVsxdl078jJ602HtRWq8W2DvDfi0aZw==
X-Received: by 2002:a63:2ace:: with SMTP id q197mr7376773pgq.371.1553954511904;
        Sat, 30 Mar 2019 07:01:51 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:1b24:991b:df50:ea3f])
        by smtp.gmail.com with ESMTPSA id b72sm18294289pga.86.2019.03.30.07.01.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Mar 2019 07:01:51 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 2/2] media: ov2659: fix unbalanced mutex_lock/unlock
Date:   Sat, 30 Mar 2019 23:01:32 +0900
Message-Id: <1553954492-24982-3-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553954492-24982-1-git-send-email-akinobu.mita@gmail.com>
References: <1553954492-24982-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Avoid returning with mutex locked.

Fixes: fa8cb6444c32 ("[media] ov2659: Don't depend on subdev API")
Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/media/i2c/ov2659.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov2659.c b/drivers/media/i2c/ov2659.c
index a1e9a98..5ed2413 100644
--- a/drivers/media/i2c/ov2659.c
+++ b/drivers/media/i2c/ov2659.c
@@ -1132,7 +1132,7 @@ static int ov2659_set_fmt(struct v4l2_subdev *sd,
 		mf = v4l2_subdev_get_try_format(sd, cfg, fmt->pad);
 		*mf = fmt->format;
 #else
-		return -ENOTTY;
+		ret = -ENOTTY;
 #endif
 	} else {
 		s64 val;
-- 
2.7.4

