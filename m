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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FB9C282DA
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 12:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252962084F
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 12:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuf2tZui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfDIMjC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:39:02 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:42710 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfDIMjC (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 9 Apr 2019 08:39:02 -0400
Received: by mail-lj1-f182.google.com with SMTP id v22so14294493lje.9
        for <linux-media@vger.kernel.org>; Tue, 09 Apr 2019 05:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vphQ1KAW5FgX4Y5LZCSEo1skpeCR2AiQicekma3GEkE=;
        b=iuf2tZuiiCLpr/BJtzdVdJpgQXDysx9G7dhVSVn+0F4KTxzJjazSoA+3ek5IQe+A0L
         wSeOu04C1SuLcy0uPnTgKhyP5lxXCa6LFhjVTjseZpiNcXggT2kPHppn7l7CFsNHarPR
         2vTNNkO/XctWRUTpJ+Q9xQBCYE9vMMfYfMDZz3RKJhwauYHX++mmWpB/Kw9aX49iI5Df
         oM6s+kphcymycNhoK+64BgBkQK8Ke8xugn39+S3Hn657oBw+BEYHdW2tDzu/aiPd064S
         YdV4A0+OFy1stxNgrfT200wWX9tyUYjZzsVy/Nfg+9hIR5XSWI4zz/Ut/zSIYjHaa4rb
         Juog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vphQ1KAW5FgX4Y5LZCSEo1skpeCR2AiQicekma3GEkE=;
        b=TisCf6R6Lw/kQS/mmqzh5e9FHgcYlTBgrF9VEtHEW2cBix5IwUZmAioH6/eFN/3hed
         CT2Yux26dmKxahj7UOO+fUv3v4jXWLyfLG0MvrR1xw6O1ipYOFa6/gy1hfsX4W0RKqsV
         cDc4n/g8LyXuQgL+75L+PoxoXDZkd0nqIABrwj1B400tI94zeCpqCJuFuL2CRo2HsPpq
         /8HZ5xgxBOxiMtsWze/9zWc/YYU5MHElkVjZuazNe7vTklI540gkCeskPSDOL5svd/11
         ro3I47610opI3oD9kt1PCIWA43PCVH+K71lKOrmMB9Q9P55yJeeC48bCis+U8uD8w+4G
         ciHQ==
X-Gm-Message-State: APjAAAWGWOnCJd+onRxasCRLInmEETNTBi+jJXahsxGDg4DJo1Z6cbuY
        w0qhOLejJCLoDNAwtqFQefPKtBbi
X-Google-Smtp-Source: APXvYqxQFeCZuIJtXgcl8GZtaxJ2u40DrOUkhcDz/fB+Tg1YUF8Iehs2MxaUR1C4BciY5371miZBWQ==
X-Received: by 2002:a2e:380c:: with SMTP id f12mr20609868lja.116.1554813539648;
        Tue, 09 Apr 2019 05:38:59 -0700 (PDT)
Received: from localhost.localdomain (broadband-95-84-200-6.ip.moscow.rt.ru. [95.84.200.6])
        by smtp.gmail.com with ESMTPSA id t23sm6749976ljc.13.2019.04.09.05.38.58
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 05:38:58 -0700 (PDT)
From:   =?UTF-8?q?=D0=A0=D1=83=D1=81=D0=BB=D0=B0=D0=BD=20=D0=98=D0=B6=D0=B1=D1=83=D0=BB=D0=B0=D1=82=D0=BE=D0=B2?= 
        <lrn1986@gmail.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 2/8] [PATCH for ZBar] Specify correct path to barcode.png
Date:   Tue,  9 Apr 2019 12:38:36 +0000
Message-Id: <20190409123842.19600-3-lrn1986@gmail.com>
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

$(srcdir)/examples/barcode.png does not exist anymore.

Signed-off-by: Руслан Ижбулатов <lrn1986@gmail.com>
---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index c767d15..a9367b3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -73,7 +73,7 @@ EXTRA_DIST += perl/MANIFEST perl/README perl/Changes perl/COPYING.LIB \
 
 if WIN32
 dist_doc_DATA += README.windows
-pkgdata_DATA = $(srcdir)/examples/barcode.png \
+pkgdata_DATA = $(srcdir)/python/test/barcode.png \
     $(srcdir)/examples/scan_image.cpp $(srcdir)/examples/scan_image.vcproj
 
 %-rc.o: %.rc
-- 
2.4.0

