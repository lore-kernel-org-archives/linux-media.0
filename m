Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713A2C3526E
	for <linux-media@archiver.kernel.org>; Sat, 19 Dec 2020 11:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 544D7233CE
	for <linux-media@archiver.kernel.org>; Sat, 19 Dec 2020 11:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgLSL1p (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 19 Dec 2020 06:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgLSL1o (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 19 Dec 2020 06:27:44 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858FEC061285;
        Sat, 19 Dec 2020 03:27:04 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id 6so6955646ejz.5;
        Sat, 19 Dec 2020 03:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d/tBQPaeyOF9shnc/RRcovxcYh335vYdWfJpYP/ETgc=;
        b=I1zV8UbUdmldwa7jTgSI91IBNorED+SuLPvgGA6ZIpuuSuhRKYW1wl7hWZAPrtWkOU
         /XZs0eN5h/N/f5bZlZeqLMTfiBC37DxVbsJ+kkwLlFNy7oJtZ7b6xTWtVYxFSng1tmvO
         oWPez7s4mEFZ8wAuEx4RYcOYLHbrtdH/7N0Si9lSycceCSC8MCFxcXBXmBtDMa0my9gr
         O0wmxFqikUMm9KgD/pZnAmkNlq1+GLsddJYmMITC55cHcsMXYEjV7noVY6FeE9Xy3pnv
         lZGhyyPcRPGDCTfQsiwA5Bq5nZeRa8gEleF5Cv2ZYws7r73ZF1XVzAn5KVWJRXWqbfUu
         Fkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d/tBQPaeyOF9shnc/RRcovxcYh335vYdWfJpYP/ETgc=;
        b=eczzbqNy7bGuI4NWjGmq0B6gl2O9f08KngvOempjxVZr46+mLmcpz81hSUiJCgYa8l
         ImxfyBm+EofGpPus2X3IhojI4msUY9dCm7NuC5CDY2u7tk6GMhstxrP7YzNbBnaElfcx
         PO+WlxWZbdBz054/p/Zeh8ywFn0E9ZrXDo/iDAk/8sd2DRBTA8LeJe/nKnhZziHLojB6
         hnSiChuauiIOibAEPglPXuXSpxMyRePjhGuujDY04BxNL/RP0DCxp2DxpFToF8TZheTq
         FekHWeYzz69lTWP8XjRdNF6hNE3mt4dPh4xEjC+pxMFdUpGaRsBZS8fmFmSZ5FXL6LQN
         AezQ==
X-Gm-Message-State: AOAM530gBFkn9sQDUmqqnDHfNvvF/HqxlyS7DC71sS27wuc1pNj5EuzK
        L+dlxpI+uy6N+GbjXK6L5DQ=
X-Google-Smtp-Source: ABdhPJziwc1eitsvgGqX0C3zrwr0S4aksv6we0tEu/L3DP2JfUYyWt0QVxKb7TBtjZENEbeb/IdmHA==
X-Received: by 2002:a17:906:8617:: with SMTP id o23mr8068807ejx.274.1608377223349;
        Sat, 19 Dec 2020 03:27:03 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id n17sm6651785ejh.49.2020.12.19.03.27.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Dec 2020 03:27:02 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mchehab@kernel.org, jacob-chen@iotwrt.com,
        ezequiel@collabora.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 4/4] arm64: dts: rockchip: add rga node to rk3368.dtsi
Date:   Sat, 19 Dec 2020 12:26:53 +0100
Message-Id: <20201219112653.10705-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201219112653.10705-1-jbx6244@gmail.com>
References: <20201219112653.10705-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add rga node to the rk3368.dtsi file.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 3746f23dc..dad1a00e6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -738,6 +738,16 @@
 		status = "disabled";
 	};
 
+	rga: rga@ff920000 {
+		compatible = "rockchip,rk3368-rga", "rockchip,rk3288-rga";
+		reg = <0x0 0xff920000 0x0 0x1000>;
+		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_RGA>, <&cru HCLK_RGA>, <&cru SCLK_RGA>;
+		clock-names = "aclk", "hclk", "sclk";
+		resets = <&cru SRST_RGA_CORE>, <&cru SRST_RGA_AXI>, <&cru SRST_RGA_AHB>;
+		reset-names = "core", "axi", "ahb";
+	};
+
 	vop_mmu: iommu@ff930300 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff930300 0x0 0x100>;
-- 
2.11.0

