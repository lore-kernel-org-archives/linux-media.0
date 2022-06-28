Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A11C43334
	for <linux-media@archiver.kernel.org>; Tue, 28 Jun 2022 03:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbiF1DaC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 27 Jun 2022 23:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiF1DaA (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 27 Jun 2022 23:30:00 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BF021B;
        Mon, 27 Jun 2022 20:30:00 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b2so2897685plx.7;
        Mon, 27 Jun 2022 20:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PLLLntBRKNP/TR5HdmPuN09W5k0TVn71VC7Vx2rA/LU=;
        b=KvKi1qTcuRRJLbkS03z74pvwZe7LPQzrUIsZJFXadp/BT/OlBXTrYnYGrZhPADpL/n
         g7kiTviOwmYpj5yNGa4dRShD9cbijz3I2qEmOsfbNNkffc58ouvv6ZqURQ6gHiCnCYIu
         MsZRjulzoSv21HCTFh5Imt4AmDz9QZfOkgjNBPA9luMRxWxoiQepeLQCnFcB2TBnewLZ
         kbndcx4jA46vTChBvr3sCwU4jvtTwqxGu/67NtsnLw4OGtSO33GmC1/vcKUAWKwxoBiT
         Ysn/6OpdTvxQpG61quaODdhBEXHbyVCOetWVpitOg/ztF+wHikM8JJEYwVft/UqtQULX
         +FHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PLLLntBRKNP/TR5HdmPuN09W5k0TVn71VC7Vx2rA/LU=;
        b=xb7S857mRGtgtLYQmSw9ezG8vxvam+iyiJNHppp3CeW+IYDI1dWTOuR4pJOF9+GlIV
         2JrM0KvDWZRrTRuAVU3KubNxTup9UMrPcFcCzXBm350Ar15ZRgFtxgLTDgaCuUiZROHP
         aLhOnMp797oBSd9uIBUKho12XhNkmmVHlpjiJNu5j1du2rDCB3knb6AlEepfGijDla0m
         zT+CU4/7DIiJVHByoVpXXaxobaGjjTVpW6CvpNfMdTbMUxFsegGQjtglmqvK8UX8C6Vz
         mcKQllJU4dzEcyx6iz5mPzdMMDPZWaNZXxJKXxkTk8Q6swAI0qi6V7lL6bAID1W/Qv2m
         FOlQ==
X-Gm-Message-State: AJIora9nTzFLK1FCk1exR9obDQaLfJv3JXou9qLNSP1NIkkToL5qsoEd
        vIOTKTNrkR1X2CW4nqQcWpw=
X-Google-Smtp-Source: AGRyM1vfnwL3x1TcjB2cio5SucnRAbUcBMG7vp6Lbnjm18qx0qb9Z2lLsk9d40rRwz/FMH09rWWqug==
X-Received: by 2002:a17:90a:dc82:b0:1ea:c77d:c9a4 with SMTP id j2-20020a17090adc8200b001eac77dc9a4mr25478601pjv.197.1656386999558;
        Mon, 27 Jun 2022 20:29:59 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id c26-20020a62e81a000000b0050dc762816dsm8091160pfi.71.2022.06.27.20.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 20:29:59 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [RESEND PATCH v4 1/5] arm: dts: Add node for NPCM Video Capture/Encode Engine
Date:   Tue, 28 Jun 2022 11:29:41 +0800
Message-Id: <20220628032945.15410-2-milkfafa@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220628032945.15410-1-milkfafa@gmail.com>
References: <20220628032945.15410-1-milkfafa@gmail.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add node for Video Capture/Differentiation Engine (VCD) and Encoding
Compression Engine (ECE) present on Nuvoton NPCM SoCs. Tested with Nuvoton
NPCM750 evaluation board.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
index 3696980a3da1..0d2df74974bf 100644
--- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
@@ -178,6 +178,19 @@
 			status = "disabled";
 		};
 
+		video: video@f0810000 {
+			compatible = "nuvoton,npcm750-video";
+			reg = <0xf0810000 0x10000>, <0xf0820000 0x2000>;
+			reg-names = "vcd", "ece";
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_VCD>,
+				 <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_ECE>;
+			reset-names = "vcd", "ece";
+			nuvoton,syscon-gcr = <&gcr>;
+			nuvoton,syscon-gfxi = <&gfxi>;
+			status = "disabled";
+		};
+
 		apb {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -553,6 +566,12 @@
 				pinctrl-0 = <&smb15_pins>;
 				status = "disabled";
 			};
+
+			gfxi: gfxi@e000 {
+				compatible = "nuvoton,npcm750-gfxi", "syscon",
+					     "simple-mfd";
+				reg = <0xe000 0x100>;
+			};
 		};
 	};
 
-- 
2.17.1

