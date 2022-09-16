Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D03C54EE9
	for <linux-media@archiver.kernel.org>; Fri, 16 Sep 2022 11:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiIPLmG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 16 Sep 2022 07:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiIPLmE (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 16 Sep 2022 07:42:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B659530E
        for <linux-media@vger.kernel.org>; Fri, 16 Sep 2022 04:42:03 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bq9so35614319wrb.4
        for <linux-media@vger.kernel.org>; Fri, 16 Sep 2022 04:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=fbzru9oHx+TSiEWcFp9fwWwozXKgV6W0npBCadl+J1g=;
        b=Ejrsy+9lIaUA+qm8DjWAbq3S2+Q9a1WDr96qLnv8boxXDLxt7EIyP+16PJJVOZhxQW
         X6/90B8plL4Eb5W5tn64iJHBmeVlAALlXZvSPI4r+2QuaUh8BhU5pNc1ro07vM2kcMZq
         2I9BfRj4B+Kbum1PrfjkQCi1FxOXkOOKlV0tcOlpOGAnu9084a2D4IoIzKPeYWAiARx4
         Gf2PPLZ1eVG7IuCqKxy4hXLI2WUbH5K6r70lSa5jO9MGjRwtqwOqvN1jxOLAIP/6b80+
         41x9sOiaO++6DbfDl3obVOIN/ZjaQOixbahSQTLy2AiKfKcLFyCqqo6DopKBRzGp06ES
         zkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=fbzru9oHx+TSiEWcFp9fwWwozXKgV6W0npBCadl+J1g=;
        b=Mn1UXYUJCmu5TBiLkhFwHHP3c1L4A/OS9nXqW0wTttD6qKQuxp4L4TSpuMB8vIti79
         TbwcxQ8XuYaxs5E7VkFu2ISUwJsly09Fa/e+NwGIqRwcsgK3vT0j8zCzQfIrJAl+LEXz
         iOZgWQb3tzlTaokiy2UYRYBkxocTS9xtPISkrhlilCst0pYtrLXwdYFO2usKYHaQLDeX
         oZfiahD9BoHxqubYI8LxWYuD4wMX+BMfC28G6BllIYPJfFaUWExF5ic3PoaJrUU0zEpR
         t01AAYbOc2h6REClccDtSC5OOAKQo1bwiZXh/qV1xTb/BHm7IbUGuzP+wGIiUxe0XkfA
         YcYQ==
X-Gm-Message-State: ACrzQf14FIO0NRLVRfbJSuiJkjE5vZJuDJDfxfK1yLHbabR9v4xtVdkv
        5mI8WFkqIgZuPCdLygINrDA=
X-Google-Smtp-Source: AMsMyM6UknjgktM0D2TTi3h6bBytobpcf5izrZirHXjgyjHzRW07O+0m+lmv7ERYSUYwIFmxFi5XiA==
X-Received: by 2002:a5d:6808:0:b0:22a:c437:5b36 with SMTP id w8-20020a5d6808000000b0022ac4375b36mr2581813wru.459.1663328522170;
        Fri, 16 Sep 2022 04:42:02 -0700 (PDT)
Received: from morpheus.home.roving-it.com (3.e.2.0.0.0.0.0.0.0.0.0.0.0.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:fb11:2681::2e3])
        by smtp.googlemail.com with ESMTPSA id a2-20020a05600c348200b003b492b30822sm1987864wmq.2.2022.09.16.04.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 04:42:00 -0700 (PDT)
From:   Peter Robinson <pbrobinson@gmail.com>
To:     Eddie James <eajames@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-media@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Cc:     Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] Add dependency on ARCH_ASPEED
Date:   Fri, 16 Sep 2022 12:41:57 +0100
Message-Id: <20220916114157.367094-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The VIDEO_ASPEED is part of the Aspeed silicon so it makes
sense to depend on ARCH_ASPEED and for compile testing.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/media/platform/aspeed/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/aspeed/Kconfig b/drivers/media/platform/aspeed/Kconfig
index c871eda33570..16c5d8913488 100644
--- a/drivers/media/platform/aspeed/Kconfig
+++ b/drivers/media/platform/aspeed/Kconfig
@@ -4,6 +4,7 @@ comment "Aspeed media platform drivers"
 
 config VIDEO_ASPEED
 	tristate "Aspeed AST2400 and AST2500 Video Engine driver"
+	depends on ARCH_ASPEED || COMPILE_TEST
 	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_DEV
 	select VIDEOBUF2_DMA_CONTIG
-- 
2.37.3

