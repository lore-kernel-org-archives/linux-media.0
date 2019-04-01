Return-Path: <SRS0=Gl4L=SD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411EBC43381
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 13:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5A3206DD
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 13:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Z5RmUJGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfDANjI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:39:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44456 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbfDANjF (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 1 Apr 2019 09:39:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id y7so12065782wrn.11
        for <linux-media@vger.kernel.org>; Mon, 01 Apr 2019 06:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oc8x1HYekb0IdcZYL8hP6bRdzWN1baFooyKd73Kx4H8=;
        b=Z5RmUJGtmb7qTx76udQVB8fsHHD3DYHIusPgFoeTYXqPp9yzR2TwtHrsV07H7r8YYx
         0kUnoeBDJJZz9YPTYjc4P+5KHkCKwrPYU1YP4hlBDITChHHnPCW8Dh6j1x8cpDvrwdzg
         jpfdC/kFzzcQnyVVbSLHvXiKb9L2H00uWajZPFEdh6TeUesnWHoSLK3S4/W72P+hSSB9
         aFvZsZTqV5W7eTgtL1OFJvqCdR0A+QeLObXMTIy2SNBjn/niubTnO1jctg/fpAylo0nu
         LYXqM+jrci1hZR6vA2dthuXbS+wrEGlcB0fxUpMFT/5Upoc7hxK5Csgpam3t0gCy0HTZ
         8zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oc8x1HYekb0IdcZYL8hP6bRdzWN1baFooyKd73Kx4H8=;
        b=KBnbiqKhyAidlFnWZB3w7Is+BKW7nGhkhITDoEHYvntIA4hajbVRyZU9qZ0Qu5oiqr
         JDa3bTMNau16hy9ptKwZphHXmwvaoIbvoN0qlgnNVILWBky+T9Dv2R5XF/prDpyFgLjO
         hejtGbWA0lpIXgTQlTfjyHo31O2dw2ltw/AHlCHb2suNsodSVxAtjDWB7F617yruolIX
         mEF+MbIb8tyWmEByHa/BqJggNtJXvCvOvwQZp8yqB2IdL35Skybrlw+Rbl5wQ4Z7zRzd
         0NPq0az/zQzEyE6UZndHwiEk4Q3prq6/Qf2yNHhtmRSPUU+Ka3wHFpVIMTHnOsoGd9rF
         6yxA==
X-Gm-Message-State: APjAAAWl33trRzRkpoKTE1N0wkilJArJSxPOGTh0zOq7Qmh1cgG0ct0m
        JaaB5aRz8S/s1rObsN13kIOBIg+FwcI=
X-Google-Smtp-Source: APXvYqzUsqZsG1laQa0TLml/Rkq9W8sHJjpw0l4Nhdd4WKHmQSC94tg6gGk+/lY6cUNFHTeiQfbYwA==
X-Received: by 2002:adf:e78e:: with SMTP id n14mr36113663wrm.14.1554125944137;
        Mon, 01 Apr 2019 06:39:04 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id v184sm25205996wma.6.2019.04.01.06.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 06:39:03 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v5 4/4] MAINTAINERS: Add meson video decoder
Date:   Mon,  1 Apr 2019 15:38:45 +0200
Message-Id: <20190401133845.4171-5-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401133845.4171-1-mjourdan@baylibre.com>
References: <20190401133845.4171-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add an entry for the meson video decoder for amlogic SoCs.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf70b548..088db7d5c4ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10056,6 +10056,14 @@ S:	Maintained
 F:	drivers/mtd/nand/raw/meson_*
 F:	Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
 
+MESON VIDEO DECODER DRIVER FOR AMLOGIC SOCS
+M:	Maxime Jourdan <mjourdan@baylibre.com>
+L:	linux-media@lists.freedesktop.org
+L:	linux-amlogic@lists.infradead.org
+S:	Supported
+F:	drivers/media/platform/meson/vdec/
+T:	git git://linuxtv.org/media_tree.git
+
 METHODE UDPU SUPPORT
 M:	Vladimir Vid <vladimir.vid@sartura.hr>
 S:	Maintained
-- 
2.21.0

