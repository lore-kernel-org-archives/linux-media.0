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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3214CC282DA
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 12:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CA22084C
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 12:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6mA+bei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfDIMjF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:39:05 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42571 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfDIMjE (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 9 Apr 2019 08:39:04 -0400
Received: by mail-lj1-f193.google.com with SMTP id v22so14294638lje.9
        for <linux-media@vger.kernel.org>; Tue, 09 Apr 2019 05:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1xN5DUo7WPUJzr6sXLTceZWuvITTVSaglvf0OIWVNdg=;
        b=o6mA+beiEV0wlmbBwk9Sdkfx8QY63+Stdx66XE3hwak1YDEw6rgU63vHWbwuw8MWEB
         /2wCjcO+dFSpW+4x+9CDq0IWh9m8KAmIybF4XS6cBWgftmJqXiPfeXEj8d8bhQ4KCigh
         S3lFMEmT4nkjthtrNGw4rikTfPzePZMRw09YdZ7ArsrE1Mv2cX+hyx2lNtB+L6GUh5Pn
         Ke/W2ZqoGir3jRhsTvSOSgbO6+m8SdlsZku5Vw/RgzxEIc0aKxHnTEG5Y8zoUq/tp7Bu
         QF3RKIJpmdidU5IKQD5IbLQn6aUMcLTuQILdRu/UtiVTYDkv0BvDC4hJKGhcu2nwHgwG
         iHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1xN5DUo7WPUJzr6sXLTceZWuvITTVSaglvf0OIWVNdg=;
        b=XgZ90Dd1U4Nj8aF9X8LP37J0eMK2DcygAGueQs5nzUx0eQooh08e42FHRE5BaifE6h
         Rc/1IR5ShqJBr/rAOAB394Jj86FVtY07q5xuLjkDubg1WTZRf+KOfmG/6WzyBgsz5BFh
         xG3n7Pt/w8Y2UnxE9e0EWdyTwjgk0LLQYCrfyhwrkaCwqIzkrf5/xkHHC0wsGQbqgO1X
         po+ylWki+deHCtytfMxBgxLBATbaVIqEKOTmw5ui4dvBnXu3ksKzcn5BozWj7HFbBH6s
         ReNs3YPq6zZXJ6RjScOds15p5Y1QUJeE+Ouds4fCXxennGmCj07r/0y+GaSI8j35tj7l
         Jp0w==
X-Gm-Message-State: APjAAAUK4XOwAhtrs2hH4VNrWKXUBBpColRn4D/61gfxgD/zQH2TX6lY
        O58khZgwbgrGoeF5wL+HdKKxBt/Y
X-Google-Smtp-Source: APXvYqxEBA2kffCrAX+HHrA1V0Q/rXagzLklt/eFCd4CPsH1DtTOR7QHyqdgwJq102E6mg7va/Lb3g==
X-Received: by 2002:a2e:9a0f:: with SMTP id o15mr19374354lji.130.1554813542394;
        Tue, 09 Apr 2019 05:39:02 -0700 (PDT)
Received: from localhost.localdomain (broadband-95-84-200-6.ip.moscow.rt.ru. [95.84.200.6])
        by smtp.gmail.com with ESMTPSA id t23sm6749976ljc.13.2019.04.09.05.39.01
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 05:39:01 -0700 (PDT)
From:   =?UTF-8?q?=D0=A0=D1=83=D1=81=D0=BB=D0=B0=D0=BD=20=D0=98=D0=B6=D0=B1=D1=83=D0=BB=D0=B0=D1=82=D0=BE=D0=B2?= 
        <lrn1986@gmail.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 4/8] [PATCH for ZBar] Disable zbarcam-gtk on Windows
Date:   Tue,  9 Apr 2019 12:38:38 +0000
Message-Id: <20190409123842.19600-5-lrn1986@gmail.com>
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

It requires scan_video.c, which includes linux/videodev2.h, so
the code is clearly not meant to be built for Windows, even if
GTK is available there.

Signed-off-by: Руслан Ижбулатов <lrn1986@gmail.com>
---
 zbarcam/Makefile.am.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/zbarcam/Makefile.am.inc b/zbarcam/Makefile.am.inc
index b112783..ad16d3c 100644
--- a/zbarcam/Makefile.am.inc
+++ b/zbarcam/Makefile.am.inc
@@ -5,12 +5,14 @@ zbarcam_zbarcam_LDADD = zbar/libzbar.la
 CLEANFILES += zbarcam/.libs/zbarcam zbarcam/moc_zbarcam_qt.h
 
 if HAVE_GTK
+if !WIN32
 bin_PROGRAMS += zbarcam/zbarcam-gtk
 zbarcam_zbarcam_gtk_SOURCES = zbarcam/zbarcam-gtk.c zbarcam/scan_video.c
 zbarcam_zbarcam_gtk_CPPFLAGS = $(GTK_CFLAGS) $(AM_CPPFLAGS)
 zbarcam_zbarcam_gtk_LDADD = $(GTK_LIBS) gtk/libzbargtk.la zbar/libzbar.la \
 	$(AM_LDADD)
 endif
+endif
 
 if HAVE_QT
 bin_PROGRAMS += zbarcam/zbarcam-qt
-- 
2.4.0

