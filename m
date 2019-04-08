Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBB1C282CE
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 09:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4C6208E3
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 09:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="igOy7Q2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfDHJYR (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:24:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52519 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfDHJYH (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 05:24:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id a184so13436792wma.2
        for <linux-media@vger.kernel.org>; Mon, 08 Apr 2019 02:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RNAd7GNGVbL6BOuK6iIVW4N9neq3YiGA4nYoCz6Ftyo=;
        b=igOy7Q2dpvKN3sfq2ja6omcK9ZG2O5qGTV7U2DTiQOixKvjEvGJyz2D0qbZvg1Sh4p
         e6tyItsrWAKuK/SN/L62C+4sNzS8EwKe2giCFZIGEkFg0b3WrZaYhX95bcOIB+q+htvJ
         V6gK5BgX9ubYPr4FyOZKcmW4a4kZliccm2dFi3TlLO6/0hxvMVMlkNfOZ3ffKXcTYkuc
         zw1MHJptTfhI3b8cK1ppuaivkvEfF+Ijxuk1GGv0nVOIRdN0bb7pNo+ovK3RNw8If8iB
         HJ9VaLRzE+CefsJfBatvYpe02OQbeLWAUTQIiynGGspLaW8KveHXMmuYJdlCFh2o7grR
         s3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RNAd7GNGVbL6BOuK6iIVW4N9neq3YiGA4nYoCz6Ftyo=;
        b=NVlVxoXU5uUOD9WQoqSDP60pWRUZsFX1EFaMEIWY4OQ8LjbvgQbV/VI2/Ognu58wYG
         JWMt6Al4ufEC7ZGZPrOKIFn1v/RJugjZnkYhepsg6RBSLLZqUFu7dUsQsUOGkyNd3qyl
         y+FPe6VnB65cqOy+Xfc70y4MaswOx6c22IHtPw1PXwfO2cNuO/daVo7Zp4Yi+jVzSg72
         HaZcgdEAOQFBP8JwWMcPj6Qtg7IljeDvQP9epaaJ4pe6SCdn0pNcLV1EZVmqZ/FaQES/
         yFErWt0c+GWfWyVIBA0Om2XTtoaXrhvzW6ig+ZngMwPGatbhb2kVorU3wMyoEjKXXl9r
         sPCg==
X-Gm-Message-State: APjAAAVnJs5hscYgv1NAzk7ETuY85Pf5lTk7YnOclvPzB/5ILfoRWvur
        IIIs4OZfBWzc4TtB3UouTEj8Sg==
X-Google-Smtp-Source: APXvYqy5P43LrY52iJMHXYQOyOfLaViayaROtbwr3a32IS8Hy3XwaevXx8MzqKi7Ms+pVd5zEvC+VA==
X-Received: by 2002:a1c:1c5:: with SMTP id 188mr17348890wmb.52.1554715446128;
        Mon, 08 Apr 2019 02:24:06 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j3sm70528221wre.51.2019.04.08.02.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Apr 2019 02:24:05 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] MAINTAINERS: Update AO CEC with ao-cec-g12a driver
Date:   Mon,  8 Apr 2019 11:23:58 +0200
Message-Id: <20190408092358.25894-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408092358.25894-1-narmstrong@baylibre.com>
References: <20190408092358.25894-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Update the MAINTAINERS entry with the new AO-CEC driver for G12A.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf70b548..bbad8f3ee3e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10046,6 +10046,7 @@ L:	linux-amlogic@lists.infradead.org
 W:	http://linux-meson.com/
 S:	Supported
 F:	drivers/media/platform/meson/ao-cec.c
+F:	drivers/media/platform/meson/ao-cec-g12a.c
 F:	Documentation/devicetree/bindings/media/meson-ao-cec.txt
 T:	git git://linuxtv.org/media_tree.git
 
-- 
2.21.0

