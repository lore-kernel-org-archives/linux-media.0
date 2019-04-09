Return-Path: <SRS0=ytLV=SL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A8FC10F0E
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 12:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3632084C
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 12:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tYOB4DgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfDIMjE (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:39:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34443 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfDIMjD (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 9 Apr 2019 08:39:03 -0400
Received: by mail-lj1-f196.google.com with SMTP id j89so14331739ljb.1
        for <linux-media@vger.kernel.org>; Tue, 09 Apr 2019 05:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4BnoWbgXHtvf1H91JDEte0uHKbOJFblYSgHxkNUsYso=;
        b=tYOB4DgYx6ERJ8ffZdcWV0lqi8oMGMTkOJDBZw+js3CsqzPIEkZ6DFr9U2PM+mbwm/
         MYuR5TeJe861gXihryNLEWt8eRFYp/GEQvLCCqQdA+CfYPLVGLY7AA6lJVskugRVPjuO
         3i5j5Z68hKVxCKvAd7nIN7c6KJ1JxtTLAUxuf5BzkxnQw6CzYnjJP5r33h9YnkBlY2Fn
         WT/8du56Xrh1mMxD/lLVnCHLZMogpzDcx4e/xRxYR6I6x/9qDLxKe5lLpa3OFzVDpde6
         L0nK9nidHU+lSqIz5MJnzQs55kbFGwUkT6Hk432NV4n/fMRD2f8jSKIoL0SgraIFJK4F
         POkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4BnoWbgXHtvf1H91JDEte0uHKbOJFblYSgHxkNUsYso=;
        b=MFITXZAmfTKVAF7YUiBUn5FLW8e2WwvVaqONQEx/SVgtIWcLmUnEJzdmc6O7IQNO+c
         6Kjcw+LtoFjPvCx1mL1f8BLXUx9FKbwL/mjhkFMjQ738fcNXADmRHXxlkwUKD2QlXPdX
         LqnTdjCesCXJMdwkin19akGwlZ3gArgnPFEwR+TNQHsTDVfG1faqjpFYm3nhWqpEvNzQ
         c6KoefP1R0AhYp9+cNSNQ80oeJbhodcg8RqRYQ1RSE57Yspy92WnsgUGros6TDqZBA4o
         qjMCTOvnPtSulu0mhmyhSOPJddUuxgeMC+YTJfrIdMp6cLzTibkHDxQjdo1rgJ+/kTHJ
         t3/Q==
X-Gm-Message-State: APjAAAVpU3hu902Z+LqbPF3W2iy2gqCRjlOIQnFxRV7UIslk/aMSnQEG
        UOuqvBQ9M/Bp1KkDFL0uUF1tuMk/
X-Google-Smtp-Source: APXvYqzCkfQ7fRuoqwVcO3j30k4jxWbFiQngQnCqxwKY9LoMCI+zGIMY2b8/3nK7ODug/rgbshzflQ==
X-Received: by 2002:a2e:8550:: with SMTP id u16mr13067978ljj.11.1554813540974;
        Tue, 09 Apr 2019 05:39:00 -0700 (PDT)
Received: from localhost.localdomain (broadband-95-84-200-6.ip.moscow.rt.ru. [95.84.200.6])
        by smtp.gmail.com with ESMTPSA id t23sm6749976ljc.13.2019.04.09.05.38.59
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 05:38:59 -0700 (PDT)
From:   =?UTF-8?q?=D0=A0=D1=83=D1=81=D0=BB=D0=B0=D0=BD=20=D0=98=D0=B6=D0=B1=D1=83=D0=BB=D0=B0=D1=82=D0=BE=D0=B2?= 
        <lrn1986@gmail.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 3/8] [PATCH for ZBar] Check for clock_gettime on pthread library as well
Date:   Tue,  9 Apr 2019 12:38:37 +0000
Message-Id: <20190409123842.19600-4-lrn1986@gmail.com>
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

On Windows that function might be in libpthread.

Signed-off-by: Руслан Ижбулатов <lrn1986@gmail.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 6e092e0..3224888 100644
--- a/configure.ac
+++ b/configure.ac
@@ -183,7 +183,7 @@ ZBAR_CHK_CODE([pdf417], [PDF417 symbology (incomplete)])
 
 dnl libraries
 
-AC_SEARCH_LIBS([clock_gettime], [rt])
+AC_SEARCH_LIBS([clock_gettime], [rt pthread])
 AM_ICONV()
 
 dnl libraries linkage
-- 
2.4.0

