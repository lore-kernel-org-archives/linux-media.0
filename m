Return-Path: <SRS0=tLen=TO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD971C04AB7
	for <linux-media@archiver.kernel.org>; Tue, 14 May 2019 13:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F70621537
	for <linux-media@archiver.kernel.org>; Tue, 14 May 2019 13:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0/8LCAaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfENN4k (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 14 May 2019 09:56:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40755 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfENN4W (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 14 May 2019 09:56:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id h11so2898591wmb.5
        for <linux-media@vger.kernel.org>; Tue, 14 May 2019 06:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86654d179AmYQd0W155rp/5r8oXi5m1uO9ZO93VNkFk=;
        b=0/8LCAaGJNktegVp5hvXEJKrCJyGBEztPbgPxBjNprn70liAooiXylCnf9NmSqffJu
         6FdNYMu0hUEVzlblwjLVxsyZ8sqmvPUCzZw++tMu1JOPxtF4KZKCFxkf0vly9g9zOMmA
         muv/ksRVk1QZN3Oq8Q7wcRclQveCNtgDCG2ImYKhGbPoICiZBtNnXzsVLpyeoVTKYAIC
         v/j5fNPYfuosfBhVnuYHWpR/K5uzQehrOSM97xnq4XlAnUZpZbKxAqOn/gB6Px/arZV0
         eHECJ4cl9S8YY0QpVdpchL31zC9aGTuWDlThXekNtMU9yvVq9wXfZTdoqVLpz1bkp97L
         tzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86654d179AmYQd0W155rp/5r8oXi5m1uO9ZO93VNkFk=;
        b=knIrLkyymy/iS1nJqny19nkFpRmUyU4MzSs2P0UA/i3HqC4rKxVmWYa1PC8XwShh4e
         buHcHj/e7W8MJ/e3a0umH6QCrkMrYjpdUdEU7ANj9TSYVpAOYiniE8K40lFbkECo/0cr
         /NYxDIh2J/EIdB51/cS+zYU0qC7qQJ4UMQqqOWl7stSB9+M9iwMVErRP5Kv1ziQlWaqt
         LP20+ybvBQ9OyZxkyZ/uRH+po/I6hyAk0Iq44DcRYJpwxsPyxtyHkEtgG4wCNxvB9hKZ
         yYMIeAcLbA/O9wLiJibWQI1pPq9PZ1wRIqjUY9eppcaQHaOJFyH4r/P23LW7U/+mqp6M
         IdNw==
X-Gm-Message-State: APjAAAWOU6DN88qtl1NoH/YCV5n01hxgW4Wo5+7UblJ56aG2DK/iwscn
        1nxzqrZqqCpiz4UcjUnAqiCABA==
X-Google-Smtp-Source: APXvYqwb3bU1jO/QwSVdfeHhtnBJGUvDAKBhKSKwgt+bw0bfGUlasyzQ02SmuLaRek4uISPMHzwBng==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr18652009wmj.32.1557842181297;
        Tue, 14 May 2019 06:56:21 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id d72sm1375764wmd.12.2019.05.14.06.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 06:56:20 -0700 (PDT)
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
Subject: [PATCH v6 4/4] MAINTAINERS: Add meson video decoder
Date:   Tue, 14 May 2019 15:56:12 +0200
Message-Id: <20190514135612.30822-5-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514135612.30822-1-mjourdan@baylibre.com>
References: <20190514135612.30822-1-mjourdan@baylibre.com>
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
index 878588cfb453..87c1e469ed63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10057,6 +10057,14 @@ S:	Maintained
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

