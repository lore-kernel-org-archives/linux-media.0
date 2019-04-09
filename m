Return-Path: <SRS0=ytLV=SL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34279C10F0E
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 12:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C142084F
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 12:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjOWdGHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfDIMjI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:39:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35162 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfDIMjI (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 9 Apr 2019 08:39:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id t4so14322062ljc.2
        for <linux-media@vger.kernel.org>; Tue, 09 Apr 2019 05:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NkoQb578JSAnE3igCN2DXs3A6JfOYuu1+qK77aGjoVc=;
        b=OjOWdGHKT2D0XN33+/sveqS6RWjx46nuKorLMjmk6WOdwEF0brfb+akCb+OhfVkKOp
         zdkut+bQ5NJjC1WgXUj0F6BTHysQEn2dhjkRoqXQ3CXu5vWVOLZr+mU4KM2i1r5FO6LA
         dwCvryq17sRrxtsEahX6HbckHD1GEWkR0E/VZdQPnW+g7VXqR4Mh5qw4hAUcNXTXF3ps
         6MSpUxK3uXedqMvR/5ONEWlMnWaM/4P7x6zi28KuYOzaQVEsFW92mk75xQMJBAJNIsU3
         ZHRFACD+RqDqZ/4MKKPKTn6m7RQdV1GwLK3E7SM2ubZxfCBGmChj4779K/M0UBfRhKEM
         gg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NkoQb578JSAnE3igCN2DXs3A6JfOYuu1+qK77aGjoVc=;
        b=Idxlx0aSXjJ4raYuGlOWHmBEEQVadGJ3az/uLdHSym3WcdFG7vwyKj2AlkGsKWLmVy
         qE0dXfzvXzttT1IiYdiMM8hTwXS3uzrj/oDmf9zYMfWXDM7LngHMQ3T+u7w03w6uz1dl
         2IpL3/QCCopH5y/1eRUYXHAahC5GQ9U8HTvwkAq7DtijNQNKJ9ORvXNTqUCmBldAmged
         nmZdH/3fo9AVxS+NIrS3/QYDOlT+nWKMQibmCitna62QhY9upwqYfrrWEelOvgqvNAcb
         D5mnasDUVwseyW7YyqWQU4gEHEJpHMfPabIBcCItZ1mLduZx4U0HSOWYM/em5HHcF+Mb
         NeVQ==
X-Gm-Message-State: APjAAAWpLx58HqGAj7+bwFHYRgPNPYQFQielGLpMS2Zmboqywjg2vHdS
        UnOuRUUEQu4kiqRGPwFxOq+eWOnv
X-Google-Smtp-Source: APXvYqxOk4ISS4nSAVxvVRrF0eg9IB/7CGt969Dndo/bcHojhB3TM1tA/Te096DN8IpYFaohg0+Nfg==
X-Received: by 2002:a2e:91cb:: with SMTP id u11mr18881535ljg.64.1554813545155;
        Tue, 09 Apr 2019 05:39:05 -0700 (PDT)
Received: from localhost.localdomain (broadband-95-84-200-6.ip.moscow.rt.ru. [95.84.200.6])
        by smtp.gmail.com with ESMTPSA id t23sm6749976ljc.13.2019.04.09.05.39.03
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 05:39:04 -0700 (PDT)
From:   =?UTF-8?q?=D0=A0=D1=83=D1=81=D0=BB=D0=B0=D0=BD=20=D0=98=D0=B6=D0=B1=D1=83=D0=BB=D0=B0=D1=82=D0=BE=D0=B2?= 
        <lrn1986@gmail.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 6/8] [PATCH for ZBar] Make zbargtk build on Windows
Date:   Tue,  9 Apr 2019 12:38:40 +0000
Message-Id: <20190409123842.19600-7-lrn1986@gmail.com>
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

The code is mostly platform-agnostic, except for this small part
that is written for X. Add ifdefs with an appropriate W32 header,
and call zbar_window_attach() with correct W32 arguments.
Use HAVE_X as a condition.

Signed-off-by: Руслан Ижбулатов <lrn1986@gmail.com>
---
 gtk/zbargtk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/gtk/zbargtk.c b/gtk/zbargtk.c
index c7e05e3..595acfe 100644
--- a/gtk/zbargtk.c
+++ b/gtk/zbargtk.c
@@ -22,7 +22,11 @@
  *------------------------------------------------------------------------*/
 
 #include <gtk/gtksignal.h>
+#ifdef HAVE_X
 #include <gdk/gdkx.h>
+#elif defined(_WIN32)
+#include <gdk/gdkwin32.h>
+#endif
 
 #include <zbar/zbargtk.h>
 #include "zbargtkprivate.h"
@@ -380,9 +384,15 @@ static void zbar_gtk_realize (GtkWidget *widget)
     gdk_window_set_back_pixmap(widget->window, NULL, TRUE);
 
     /* attach zbar_window to underlying X window */
+#ifdef HAVE_X
     if(zbar_window_attach(zbar->window,
                            gdk_x11_drawable_get_xdisplay(widget->window),
                            gdk_x11_drawable_get_xid(widget->window)))
+#elif defined(_WIN32)
+    if(zbar_window_attach(zbar->window,
+                           GDK_WINDOW_HWND (widget->window),
+                           0))
+#endif
         zbar_window_error_spew(zbar->window, 0);
 }
 
-- 
2.4.0

