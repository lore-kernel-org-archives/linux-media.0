Return-Path: <SRS0=ytLV=SL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D491C282CE
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 12:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE1F2084C
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 12:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSJS8tli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfDIMjJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:39:09 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41408 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfDIMjI (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 9 Apr 2019 08:39:08 -0400
Received: by mail-lf1-f65.google.com with SMTP id 10so12174165lfr.8
        for <linux-media@vger.kernel.org>; Tue, 09 Apr 2019 05:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zTdJXWq0k+dcD89r7VXGae18kAgM7OT1o3BmJqWA25g=;
        b=VSJS8tliHyhAHx9w5PcegTxfTiXRV40/IxvTpR7HDJfSQeE1qJ6Xd33EQSBd/BaHTT
         5lespF0aI/sqnz7pzM2xsez6q+IMbL5zIRGy3XqMvOismvJHAAw+BcyhVTHorMKan0tJ
         kBkVG2T9EU17+up2ZhDcH0jZHE53dx0wx0wSJ/yZgVeSTbZXEJ/BQMLG6a+625wvUAbp
         SqVC9qOtuwRST7ppiiBojxMIkDMtrCyhFGFd7e53OiMA/vTkFqBgjIWPEFNOY71t2G+g
         DRMGAcXDZVwi/HSHdxXdQxKBTacDit+u1Lxam+6pcGtIS8SDWJZV0/G44Z0eUUydHu6+
         uGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zTdJXWq0k+dcD89r7VXGae18kAgM7OT1o3BmJqWA25g=;
        b=crldUKTX1ShIxyBKwiQfUZgd9Q1MucWH/nHqv7SGzlUrZYkw2chBhuXxEMY9UO3T0J
         9cjtTRdg8aI8eVF7FfpIBLqvmSZ3PHehqb26PuwShjJeSCLiwJQduWHhXc1UybLtAgn9
         1/+xfmL59vVu2wJGAJw2I1xjIBnOUYjjg6XNlhEeP8m9D9mUvafzg5+XxmvqFC4cN2Ea
         Qpqy2kDRr0/rjUGzSPpQiel8Z4irWLs5qXMxN0S42w8pDBwq7wlMOupC0oxKA9J9lBO4
         15w1XnPxqAoXXVdWbzGCaeZ5J7ltlALyffgUr0LiH2BrMs2ia2Y2phx094mTLar5FTpR
         YUEw==
X-Gm-Message-State: APjAAAWd6VZF5V7JTXeBp+NmDxqbb1PgElifncTAlZY2WENTCZSA7KU0
        326k8xzyi5tmm878ov0oVBxtDhbR
X-Google-Smtp-Source: APXvYqwnGq6f4wfUbFja2go3k++yLDerFv+Gjsp8OZS5IX8g97UD3UsEGTSYFVvPIvB+PuDqoxNu/w==
X-Received: by 2002:ac2:5489:: with SMTP id t9mr7607273lfk.62.1554813546476;
        Tue, 09 Apr 2019 05:39:06 -0700 (PDT)
Received: from localhost.localdomain (broadband-95-84-200-6.ip.moscow.rt.ru. [95.84.200.6])
        by smtp.gmail.com with ESMTPSA id t23sm6749976ljc.13.2019.04.09.05.39.05
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 05:39:05 -0700 (PDT)
From:   =?UTF-8?q?=D0=A0=D1=83=D1=81=D0=BB=D0=B0=D0=BD=20=D0=98=D0=B6=D0=B1=D1=83=D0=BB=D0=B0=D1=82=D0=BE=D0=B2?= 
        <lrn1986@gmail.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 7/8] [PATCH for ZBar] Make use of glib thread names
Date:   Tue,  9 Apr 2019 12:38:41 +0000
Message-Id: <20190409123842.19600-8-lrn1986@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409123842.19600-1-lrn1986@gmail.com>
References: <20190409123842.19600-1-lrn1986@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This is optional, but why not use it?

Signed-off-by: Руслан Ижбулатов <lrn1986@gmail.com>
---
 gtk/zbargtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gtk/zbargtk.c b/gtk/zbargtk.c
index 595acfe..c16f05c 100644
--- a/gtk/zbargtk.c
+++ b/gtk/zbargtk.c
@@ -637,7 +637,7 @@ static void zbar_gtk_init (ZBarGtk *self)
 
     /* spawn a thread to handle decoding and video */
     zbar->queue = g_async_queue_new();
-    zbar->thread = g_thread_new(NULL, zbar_gtk_processing_thread, self);
+    zbar->thread = g_thread_new("zbar gtk processing thread", zbar_gtk_processing_thread, self);
     g_assert(zbar->thread);
 }
 
-- 
2.4.0

