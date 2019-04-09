Return-Path: <SRS0=ytLV=SL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D156C282DA
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 12:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1172084F
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 12:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BekEkR7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfDIMjG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:39:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37975 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfDIMjG (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 9 Apr 2019 08:39:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id p14so14298034ljg.5
        for <linux-media@vger.kernel.org>; Tue, 09 Apr 2019 05:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uixlQWwEyyKlq/iUFu337hzeJWP6UFu2/vD/88ZGijA=;
        b=BekEkR7YSdJ5PXQED+5etkPybEQfnzhQ6OJRocyxW9HwZwvXs0I6lQe3gmzALNp+YB
         lb9rWZCezbcFd19VsBW99qiu+GtyviwfG7qyQOB3Eya+HpZfzVn4UjksHJqOxzzUG36R
         T41gK9Y9xgripeZxUBXLonobhg2FtvgJ1AM1t+H3bJUmqYfNf+oe+LTocFeQeNK/78Dp
         8R073ETOkBmVv9vrhcN6FSoNM8FG0z7cN6Oag/xdwM4ED0bE3XF2QsRfYerJh99PtdlB
         cykF20UTgqdsiINEZVL7ckdmt/t1CeQ3edETTfpq8hcFZhcp35PMR3YhcmHKMPcVhudC
         v1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uixlQWwEyyKlq/iUFu337hzeJWP6UFu2/vD/88ZGijA=;
        b=OdWp2FG5N4sDgjsFdzKZZqbQhLzoPeb1uNDGOE+MnMaieIFYTsUJTH9xgOGxhMWkKB
         WH6CRV3OyjWzjWl/J3Ivf9E/Gfw09a6ja5oM9vL0BwBhbMm6FyGZ6vMKgPB8nGfsBWD2
         +NO9oMja0UPED7BZJJxYeTw4q4uaHN0cXFs6wQSyVYOZs+8dogwe7DYuXgawlAk+VQSu
         5O/I9gWmEUYku/6rL2AW1seFL3TCPNJMvl7RfBjxhvToN97CShNW6l44SGPi2Ag6efx8
         zwCr3Xannygqy5hoVNfMSgR2mXcEB02crIdOLbmlHZzo1A2QCEIwNVPgU9bN7zOGIf5v
         Vxwg==
X-Gm-Message-State: APjAAAUNMoAr5Gwa6jfRajR55kf/8p8DRGLSzRYmheOAPYmuW76oqI58
        kXDKZBDkdPTarJ8tQEuU5AI/8JLq
X-Google-Smtp-Source: APXvYqw/7YQpqLc7ABlNPAHJBvPrv26XXks7ybBVxwZ8WNkLPSzXk0GAgnJx4KIf74Gw9yak/UHqIw==
X-Received: by 2002:a2e:500d:: with SMTP id e13mr20698202ljb.169.1554813543688;
        Tue, 09 Apr 2019 05:39:03 -0700 (PDT)
Received: from localhost.localdomain (broadband-95-84-200-6.ip.moscow.rt.ru. [95.84.200.6])
        by smtp.gmail.com with ESMTPSA id t23sm6749976ljc.13.2019.04.09.05.39.02
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 05:39:02 -0700 (PDT)
From:   =?UTF-8?q?=D0=A0=D1=83=D1=81=D0=BB=D0=B0=D0=BD=20=D0=98=D0=B6=D0=B1=D1=83=D0=BB=D0=B0=D1=82=D0=BE=D0=B2?= 
        <lrn1986@gmail.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 5/8] [PATCH for ZBar] Use -no-undefined for libzbargtk
Date:   Tue,  9 Apr 2019 12:38:39 +0000
Message-Id: <20190409123842.19600-6-lrn1986@gmail.com>
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

-no-undefined is required to build shlibs on Windows.
Doesn't hurt on other platforms either (unless a shlib is built
with undefined symbols by design, which is not the case here).

Signed-off-by: Руслан Ижбулатов <lrn1986@gmail.com>
---
 gtk/Makefile.am.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gtk/Makefile.am.inc b/gtk/Makefile.am.inc
index 406fd86..f7e8e6c 100644
--- a/gtk/Makefile.am.inc
+++ b/gtk/Makefile.am.inc
@@ -1,7 +1,7 @@
 lib_LTLIBRARIES += gtk/libzbargtk.la
 gtk_libzbargtk_la_CPPFLAGS = -Igtk $(GTK_CFLAGS) $(AM_CPPFLAGS)
 gtk_libzbargtk_la_LDFLAGS = -version-info $(ZGTK_LIB_VERSION) \
-    -export-symbols-regex "^zbar_gtk_.*" $(AM_LDFLAGS)
+    -export-symbols-regex "^zbar_gtk_.*" $(AM_LDFLAGS) -no-undefined
 gtk_libzbargtk_la_LIBADD = $(GTK_LIBS) zbar/libzbar.la $(AM_LIBADD)
 
 dist_gtk_libzbargtk_la_SOURCES = gtk/zbargtk.c gtk/zbargtkprivate.h
-- 
2.4.0

