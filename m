Return-Path: <SRS0=IMFm=SB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D2FC43381
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 14:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818E5218AC
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 14:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBC2YOny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbfC3OBu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 30 Mar 2019 10:01:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45591 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730832AbfC3OBu (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 30 Mar 2019 10:01:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id y3so2532978pgk.12
        for <linux-media@vger.kernel.org>; Sat, 30 Mar 2019 07:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NRSN2gW2UsEiodzhVmvL27Mq5xFHHpwzHpOeOYU7YQE=;
        b=GBC2YOnyJLLSaGuA78uXB05r3/svvKPaT7JRpE+kbXN+3RTbOqNMr+JBrHoWo/vTqE
         Z+goU8A9TU0ydpnCvxWNySJgTVrJVg7u9BxfkOktaO0FWUEKavTJHYfeF0JXVQUDyZmH
         6k2OLisE1lLFezHBik2L/wIU/GKl5YOCy2jqvyRJAdQHC5ZC3vNY9JpM4/tKgzqxLJ7+
         SCDTvW4pJWc1XI2xqm84aXd+ebpRa0MyEvI8U3hmbJCUKNmyz86XPau1CCXuk3CLaLho
         Hs04hz1S9KoCG3tx9W4cvaj2W93uGBpD1BhYv5GCvodBFyqvHYnSiJzpde8Ml1heCMi/
         7zTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NRSN2gW2UsEiodzhVmvL27Mq5xFHHpwzHpOeOYU7YQE=;
        b=d6NL5rS7DwOG2twVIZR0ErkXpxY8ZQx9hY8B+9EY/cUrSxncQq3Q2vPhbQmeYi0ULC
         eOHnOf0JdnrVrIr0u8/vcqhWg4EpsPiyg1kOlC/r0ozZJPqpGLRJNCUkkFg3JNSw8Mmk
         sXpEilkQQZ/oNPDafunaqbyqsVT3HNbnyD6OoYuaC6vQ8eOUy8U0SWZEip0dEW+MgaSG
         Jm0calpddcyI4i0mDQv6//HhoC7zDt96FwSdDbg3bHaWzXPgSeDDANS9PBsa03VRn2Ez
         mG1DTk6ey2Go3cFLfg0caqe871ny/It5fCuytMB27NXa60UyONPmZkpjuYun7T2A/2CP
         mz1A==
X-Gm-Message-State: APjAAAXBukv06xt1z/Ok/U/5Gl5xeJ74lkdypWeMezrRQGEKl1SKSB9N
        ADWs5+NQ2PmCMbriHuKbjsdms6qq
X-Google-Smtp-Source: APXvYqwtwJWRjMZT22d1w66f34kd8mrvUeN35b+DepuREJ4wJYkG9iZQUTBCPNkbB/KfQJOYy1mwHw==
X-Received: by 2002:a62:1fc3:: with SMTP id l64mr19455425pfj.37.1553954509727;
        Sat, 30 Mar 2019 07:01:49 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:1b24:991b:df50:ea3f])
        by smtp.gmail.com with ESMTPSA id b72sm18294289pga.86.2019.03.30.07.01.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Mar 2019 07:01:49 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 1/2] media: ov2659: make S_FMT ioctl succeed even if requested format doesn't match
Date:   Sat, 30 Mar 2019 23:01:31 +0900
Message-Id: <1553954492-24982-2-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553954492-24982-1-git-send-email-akinobu.mita@gmail.com>
References: <1553954492-24982-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This driver returns an error if unsupported media bus pixel code is
requested by VIDIOC_SUBDEV_S_FMT.

But according to Documentation/media/uapi/v4l/vidioc-subdev-g-fmt.rst,

Drivers must not return an error solely because the requested format
doesn't match the device capabilities. They must instead modify the
format to match what the hardware can provide.

So select default format code and return success in that case.

This is detected by v4l2-compliance.

Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/media/i2c/ov2659.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov2659.c b/drivers/media/i2c/ov2659.c
index 799acce..a1e9a98 100644
--- a/drivers/media/i2c/ov2659.c
+++ b/drivers/media/i2c/ov2659.c
@@ -1117,8 +1117,10 @@ static int ov2659_set_fmt(struct v4l2_subdev *sd,
 		if (ov2659_formats[index].code == mf->code)
 			break;
 
-	if (index < 0)
-		return -EINVAL;
+	if (index < 0) {
+		index = 0;
+		mf->code = ov2659_formats[index].code;
+	}
 
 	mf->colorspace = V4L2_COLORSPACE_SRGB;
 	mf->field = V4L2_FIELD_NONE;
-- 
2.7.4

