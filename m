Return-Path: <SRS0=tLen=TO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF582C04AB4
	for <linux-media@archiver.kernel.org>; Tue, 14 May 2019 13:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFEE521537
	for <linux-media@archiver.kernel.org>; Tue, 14 May 2019 13:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="srwoGdM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfENN4p (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 14 May 2019 09:56:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38573 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfENN4T (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 14 May 2019 09:56:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id v11so1508096wru.5
        for <linux-media@vger.kernel.org>; Tue, 14 May 2019 06:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Z3XkroftFEOZ+oKRERn/ytHnCEs/zdgDA4cYGSY7DY=;
        b=srwoGdM2pi3FUKVWb1bVPrzv+PX1GFaTRXsw3dRT8fB5USvGoV1sYMg53QdODFcxno
         Q0dQocvYEG5gARTTaO4iSMlbRUw5ZFHdIjykqvm/sK+VgDNWhBLVYrpWGt/VpfiSU7L1
         feo74fD6wjwCBdVYIDgvTwfDVDbfS02dmUaA8PZUv2D2A5SxpCtrd2ZsTJlhZs0E71C4
         XjYy9KGfSI+p2m6BHcAB5HvvtmMu81IckC0kmMmOvOB7mANygS4KrcrekKkjs4bJjqyW
         agiikBfaeI4Ee70Qu7YqT5BhX02BPGcNvWkzxUtuRfIr5n9xl+YCHs4tWyp5Vv/xUCxJ
         uOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Z3XkroftFEOZ+oKRERn/ytHnCEs/zdgDA4cYGSY7DY=;
        b=o4SjYwo97PcrH9vaD5Kfk/Wj7EBsJx5uYs9LK3ToVvNVsqWkN68e+56Y5mfLFX6pID
         lOCsxEwPrAq75O/qZpR8+xg4qaVywGAtsjBn24v/7pzeKaNMgZvxV0b2leIl9d5laZNa
         tZ8ZldCNtCBvT+I1vlS0fdeSnCdeJT0uXHU2fQXm0xeQ8E9aomhYjYyvJmWNcJ5a9vsN
         4kraGgyvJfHj1FJ4Uqp2gXvNSqvVwmtwLT344/U6nQsgANjdieAoxZsUtRmeFlI24Qy1
         95RCibIeIHPUWwzTq207cFSjs+UyjofuhNIv+zc3arz4NiWVOyXj50euUxNUmIwrc8nP
         +c3Q==
X-Gm-Message-State: APjAAAVRTmDvL3DGeCuo01TEtvTYKdFS7ArB1oFB9hrS/SzEuZk+jBCZ
        xqsdevBSaIu8Y1Iu/TW1Ehxu4Q==
X-Google-Smtp-Source: APXvYqyzK4kQnCJQWuc1QqSsGoqGq9pNNeIqQotMC679d3W+STr2oaNTyTLUAtjUp3koLKbf/YLfPA==
X-Received: by 2002:adf:ebd2:: with SMTP id v18mr3451395wrn.108.1557842177761;
        Tue, 14 May 2019 06:56:17 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id d72sm1375764wmd.12.2019.05.14.06.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 06:56:17 -0700 (PDT)
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
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/4] dt-bindings: media: add Amlogic Video Decoder Bindings
Date:   Tue, 14 May 2019 15:56:09 +0200
Message-Id: <20190514135612.30822-2-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514135612.30822-1-mjourdan@baylibre.com>
References: <20190514135612.30822-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add documentation for the meson vdec dts node.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 .../bindings/media/amlogic,vdec.txt           | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/amlogic,vdec.txt

diff --git a/Documentation/devicetree/bindings/media/amlogic,vdec.txt b/Documentation/devicetree/bindings/media/amlogic,vdec.txt
new file mode 100644
index 000000000000..aabdd01bcf32
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/amlogic,vdec.txt
@@ -0,0 +1,71 @@
+Amlogic Video Decoder
+================================
+
+The video decoding IP lies within the DOS memory region,
+except for the hardware bitstream parser that makes use of an undocumented
+region.
+
+It makes use of the following blocks:
+
+- ESPARSER is a bitstream parser that outputs to a VIFIFO. Further VDEC blocks
+then feed from this VIFIFO.
+- VDEC_1 can decode MPEG-1, MPEG-2, MPEG-4 part 2, MJPEG, H.263, H.264, VC-1.
+- VDEC_HEVC can decode HEVC and VP9.
+
+Both VDEC_1 and VDEC_HEVC share the "vdec" IRQ and as such cannot run
+concurrently.
+
+Device Tree Bindings:
+---------------------
+
+VDEC: Video Decoder
+--------------------------
+
+Required properties:
+- compatible: value should be different for each SoC family as :
+	- GXBB (S905) : "amlogic,gxbb-vdec"
+	- GXL (S905X, S905D) : "amlogic,gxl-vdec"
+	- GXM (S912) : "amlogic,gxm-vdec"
+- reg: base address and size of he following memory-mapped regions :
+	- dos
+	- esparser
+- reg-names: should contain the names of the previous memory regions
+- interrupts: should contain the following IRQs:
+	- vdec
+	- esparser
+- interrupt-names: should contain the names of the previous interrupts
+- amlogic,ao-sysctrl: should point to the AOBUS sysctrl node
+- amlogic,canvas: should point to a canvas provider node
+- clocks: should contain the following clocks :
+	- dos_parser
+	- dos
+	- vdec_1
+	- vdec_hevc
+- clock-names: should contain the names of the previous clocks
+- resets: should contain the parser reset
+- reset-names: should be "esparser"
+
+Example:
+
+vdec: video-decoder@c8820000 {
+	compatible = "amlogic,gxbb-vdec";
+	reg = <0x0 0xc8820000 0x0 0x10000>,
+	      <0x0 0xc110a580 0x0 0xe4>;
+	reg-names = "dos", "esparser";
+
+	interrupts = <GIC_SPI 44 IRQ_TYPE_EDGE_RISING>,
+		     <GIC_SPI 32 IRQ_TYPE_EDGE_RISING>;
+	interrupt-names = "vdec", "esparser";
+
+	amlogic,ao-sysctrl = <&sysctrl_AO>;
+	amlogic,canvas = <&canvas>;
+
+	clocks = <&clkc CLKID_DOS_PARSER>,
+		 <&clkc CLKID_DOS>,
+		 <&clkc CLKID_VDEC_1>,
+		 <&clkc CLKID_VDEC_HEVC>;
+	clock-names = "dos_parser", "dos", "vdec_1", "vdec_hevc";
+
+	resets = <&reset RESET_PARSER>;
+	reset-names = "esparser";
+};
-- 
2.21.0

