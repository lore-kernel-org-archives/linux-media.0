Return-Path: <SRS0=GRoN=24=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258BFC33C9B
	for <linux-media@archiver.kernel.org>; Tue,  7 Jan 2020 14:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4AF222D9
	for <linux-media@archiver.kernel.org>; Tue,  7 Jan 2020 14:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ylxjn1iF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgAGOe2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:34:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46806 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbgAGOe1 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 7 Jan 2020 09:34:27 -0500
Received: by mail-pf1-f194.google.com with SMTP id n9so20822796pff.13
        for <linux-media@vger.kernel.org>; Tue, 07 Jan 2020 06:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oyhzAHfoljmVmjnkI9lNRmSbLeJffd7zCPcm12fwKsY=;
        b=Ylxjn1iFB6Nsv1iNzIrG39vSWDowFcpsxBInwnIrBFTeoOmWvlZ05SEwLKIEfxAv78
         Wf76kEVdIZIdWo1+aJjvrOwwCe7aPRrm4gJUVlA7fmqYMbd44+qb9oNsDlJzGZelIGod
         m8/j8ZamcQuywlsabrSQvqsGXU/2I4gn4l8q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oyhzAHfoljmVmjnkI9lNRmSbLeJffd7zCPcm12fwKsY=;
        b=e0Tnmkpts+GeiYExzNN76F7Zql8Y/tPgYAoa5NesZKI0jdu9VcTdMgcfsZsHMR2Bsx
         romfj2jg9aKb+nK7hkwwI6QUOGwCsMOl+lD4nhXdq16/cmaVs0xxkax8LZ+I4LCgf2Q+
         rhbNtTB3Z/tPyFv5fqYK1BH5LSaUVbInrqRQp8lRSDEQgNNg6OWoh/2qBp55Vtj/RhuS
         cNCdtSZ6pWNwEDGGVx13r7wZBl63QebNowsl0gprQETvJZ3aTGBiQkV6nnTgXWoNfvTE
         UMtnsyHrul9+Ngv6hnTRhFbpXpIYVdeASyFPmYsZveqS9C4XtI8tXV1W6b44jOj09M+3
         fnBQ==
X-Gm-Message-State: APjAAAUD+ha8ihDTGyo6Oc57T9YjBmeW2W3yEr0PDq1EJMdpSW0urupf
        fDRdTlaIWp74iFVIgbDzjyKLZQ==
X-Google-Smtp-Source: APXvYqzNSykcM6yoTNp/9hwi45skb77ZtLlkW7Napf7i3caLd9iZ2+B/ZPvi2kG2lFbcs84V3l7Mew==
X-Received: by 2002:a62:1552:: with SMTP id 79mr114424104pfv.156.1578407667283;
        Tue, 07 Jan 2020 06:34:27 -0800 (PST)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:93d9:de4d:e834:3086])
        by smtp.gmail.com with ESMTPSA id a19sm28594808pju.11.2020.01.07.06.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 06:34:26 -0800 (PST)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH] arm64: dts: qcom: add Venus firmware node on Cheza
Date:   Tue,  7 Jan 2020 23:34:02 +0900
Message-Id: <20200107143402.122455-1-acourbot@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Cheza boards require this node to probe, so add it.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 6 ++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi       | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index 9a4ff57fc877..35ba65cd9822 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -1279,3 +1279,9 @@ config {
 		};
 	};
 };
+
+&venus_codec {
+	video-firmware {
+		iommus = <&apps_smmu 0x10b2 0x0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index ddb1f23c936f..7b913688cc6d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2567,7 +2567,7 @@ usb_2_dwc3: dwc3@a800000 {
 			};
 		};
 
-		video-codec@aa00000 {
+		venus_codec: video-codec@aa00000 {
 			compatible = "qcom,sdm845-venus";
 			reg = <0 0x0aa00000 0 0xff000>;
 			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.24.1.735.g03f4e72817-goog

