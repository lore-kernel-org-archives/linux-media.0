Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1643CC11F87
	for <linux-media@archiver.kernel.org>; Mon, 12 Jul 2021 08:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED38E6113C
	for <linux-media@archiver.kernel.org>; Mon, 12 Jul 2021 08:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240902AbhGLIxa (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 12 Jul 2021 04:53:30 -0400
Received: from comms.puri.sm ([159.203.221.185]:50312 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232981AbhGLIrG (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 12 Jul 2021 04:47:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 97D22DF9DC;
        Mon, 12 Jul 2021 01:42:33 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OmMjepUM9FEl; Mon, 12 Jul 2021 01:42:33 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     martin.kepplinger@puri.sm, sakari.ailus@iki.fi,
        krzysztof.kozlowski@canonical.com,
        laurent.pinchart@ideasonboard.com
Cc:     devicetree@vger.kernel.org, kernel@puri.sm,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, paul.kocialkowski@bootlin.com, pavel@ucw.cz,
        phone-devel@vger.kernel.org, robh@kernel.org, shawnx.tu@intel.com
Subject: [PATCH v7 5/5] arm64: defconfig: enable VIDEO_HI846
Date:   Mon, 12 Jul 2021 10:41:37 +0200
Message-Id: <20210712084137.3779628-6-martin.kepplinger@puri.sm>
In-Reply-To: <20210712084137.3779628-1-martin.kepplinger@puri.sm>
References: <20210712084137.3779628-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Build the driver for the Hi-846 camera by default on arm64 where it's
going to be used on at least the imx8mq-librem5 board.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f423d08b9a71..bf27d9cfbdd5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -666,6 +666,7 @@ CONFIG_VIDEO_RENESAS_VSP1=m
 CONFIG_VIDEO_QCOM_VENUS=m
 CONFIG_SDR_PLATFORM_DRIVERS=y
 CONFIG_VIDEO_RCAR_DRIF=m
+CONFIG_VIDEO_HI846=m
 CONFIG_VIDEO_IMX219=m
 CONFIG_VIDEO_OV5645=m
 CONFIG_VIDEO_QCOM_CAMSS=m
-- 
2.30.2

