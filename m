Return-Path: <SRS0=Gl4L=SD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B289C43381
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 13:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F6A206DD
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 13:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eIPaW3Ah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfDANjD (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:39:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39593 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbfDANjC (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 1 Apr 2019 09:39:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so11492291wmk.4
        for <linux-media@vger.kernel.org>; Mon, 01 Apr 2019 06:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Z3XkroftFEOZ+oKRERn/ytHnCEs/zdgDA4cYGSY7DY=;
        b=eIPaW3AhGstj48p5E8VufgaCSExLZ2GXmlZZvTXR9ULIGxQVvxPHxtgqmwGCrIeAq+
         RV8QlRvJlm8EXyOWBCB+onpIV1i1xmODEckDYcEXHHtMLugPoITawuE5FBw3xyxjsIcg
         6Swx4aOUBS0DSkdWbebbA0cS+YHx9bcNONAhVge5fh3U35mU9h93cJJQaIoc12rkAF+K
         Bbouln78t4NI9220mnFwfJwGgoWuBukMcOImiK38TVP7cakOiLUkMH9mg1y6efmDQe7B
         UAjgKW/PkDK9w281bm969lijO0M64K5Nk8YHr7YpKnfVbvOuJ+vRj8XEHssW4LFiDY6E
         J7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Z3XkroftFEOZ+oKRERn/ytHnCEs/zdgDA4cYGSY7DY=;
        b=j2Z7KV67MCACOoUcoP/BS7oItKQczjZShHCtecCQBSiYYWlvtn4gCWa7g+JUoB4oWC
         /bXZOU5TxTSVOAnLkgaQiG+iF4mOuJchKYheXzDFDgiAIXTUXC4Ac9vMCTbdMeApm4EH
         8yJvqnMXSvDi0d5qWVdzkDWu4CRBTV/CSWdKBXllknobXIFo7D5bmS0N78pB1j5+WVuu
         Op8KEcRgCZzwYfFvnhLRUZ66wMORrgRKNXC12PuyjtyBYBYqP7oY0mpl5Hvf6b75oy4d
         vC190Gbx0fbYd9UP0KPY1iC37q77Ss8SoCX54W21iKAdRyDApBS3yHGEF34OZoEJKEAW
         kQVA==
X-Gm-Message-State: APjAAAVw4VpZXqcGGRGjKW+I45KB6gucaCu+9iyyViy9k4doeF9eUZNG
        Wv82DLTgsev+yRN4DVf1Kh4B6Q==
X-Google-Smtp-Source: APXvYqyeHEv0rTN2wKOsMuZTuRwwa8N7lhGDMCngE1lzgn6On26UIBktvwJmkCLQjYS7ly3qUC04dA==
X-Received: by 2002:a1c:f014:: with SMTP id a20mr12278697wmb.122.1554125940162;
        Mon, 01 Apr 2019 06:39:00 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id v184sm25205996wma.6.2019.04.01.06.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 06:38:59 -0700 (PDT)
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
Subject: [PATCH v5 1/4] dt-bindings: media: add Amlogic Video Decoder Bindings
Date:   Mon,  1 Apr 2019 15:38:42 +0200
Message-Id: <20190401133845.4171-2-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401133845.4171-1-mjourdan@baylibre.com>
References: <20190401133845.4171-1-mjourdan@baylibre.com>
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

