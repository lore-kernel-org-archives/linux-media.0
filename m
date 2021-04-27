Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66033C433B4
	for <linux-media@archiver.kernel.org>; Tue, 27 Apr 2021 11:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A51613CA
	for <linux-media@archiver.kernel.org>; Tue, 27 Apr 2021 11:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbhD0LQt (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 27 Apr 2021 07:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbhD0LQm (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 27 Apr 2021 07:16:42 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6115DC061763
        for <linux-media@vger.kernel.org>; Tue, 27 Apr 2021 04:15:59 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gc22-20020a17090b3116b02901558435aec1so3294645pjb.4
        for <linux-media@vger.kernel.org>; Tue, 27 Apr 2021 04:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=po7QYMX2bjP6lmDmZxPgPCLAaN+WesS3W5xew9880lo=;
        b=Ofb4NdEX3S2iytgtS3/pPlP1K99zNiG+f8OLW8mkhYjYDGZz/hzd/XxTQ0h8To6ezU
         VQTSTTXKkTfKAenI3j6SvdSEPj5FT1ax9kcmCUzO1URw+894GTp83c3LCv8ZfazowJDO
         kggiebZoWJX0/NWqlDyl7MRgc7kRa+3cLS6pA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=po7QYMX2bjP6lmDmZxPgPCLAaN+WesS3W5xew9880lo=;
        b=GzJC2d8DhaaRKwysFKM5M8ke8KVk5WfdPOOWtjkoowOnexLuy09TOaZX77l454XKO+
         xWkclRy0YDGwPZIJHuzCfARcdzFB+099fjPikJsxI5yhJJk9lY5LmCQR/1R1WeCsdzZK
         M02r2mhod7yiXSCMzq2I2gZvHNXvuCzoOT3b5VpeHfTE7M16EpCm8OOohBbXPjCpYBrc
         sxJlip+FqYekNWcxq5y8DKCOl7rCJcyhb2Diq5Ik5bbBYFhg1ZOK5/dXJteLGeJ23bxo
         GKt2K3KgkWpZfeVTw/gRhCY9q8ip6hZxzJiGzGC40wALB24JO76hIgJnmYsBRuE1P/qo
         AYfA==
X-Gm-Message-State: AOAM531ktawnbhB+jRE4mDWzMPRnBCcNqa+9gKdOkD4YNcTFK3FBOiz7
        4AemPZdbgaAQOFy0+GZkx6MWKQ==
X-Google-Smtp-Source: ABdhPJyXeuIoiIttCVmVyb9b58xtxgJ5aD/gCgZSHhItF1eClG5XVDPSa2tdqRuGiCSwTCqpRJoSAQ==
X-Received: by 2002:a17:902:9685:b029:e9:abc1:7226 with SMTP id n5-20020a1709029685b02900e9abc17226mr24369400plp.64.1619522159035;
        Tue, 27 Apr 2021 04:15:59 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:b182:d363:32d0:53a2])
        by smtp.gmail.com with ESMTPSA id c21sm2347210pfc.165.2021.04.27.04.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 04:15:58 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v4 08/15] dt-bindings: media: document mediatek,mt8183-vcodec-dec
Date:   Tue, 27 Apr 2021 20:15:19 +0900
Message-Id: <20210427111526.1772293-9-acourbot@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210427111526.1772293-1-acourbot@chromium.org>
References: <20210427111526.1772293-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

MT8183's decoder is instantiated similarly to MT8173's.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 Documentation/devicetree/bindings/media/mediatek-vcodec.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
index 06db6837cefd..a2a2a9e2ade3 100644
--- a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
+++ b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
@@ -9,6 +9,7 @@ Required properties:
   "mediatek,mt8173-vcodec-enc" for mt8173 avc encoder.
   "mediatek,mt8183-vcodec-enc" for MT8183 encoder.
   "mediatek,mt8173-vcodec-dec" for MT8173 decoder.
+  "mediatek,mt8183-vcodec-dec" for MT8183 decoder.
 - reg : Physical base address of the video codec registers and length of
   memory mapped region.
 - interrupts : interrupt number to the cpu.
-- 
2.31.1.498.g6c1eba8ee3d-goog

