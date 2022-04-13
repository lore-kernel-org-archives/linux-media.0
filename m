Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81387C433EF
	for <linux-media@archiver.kernel.org>; Wed, 13 Apr 2022 02:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbiDMCzv (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 12 Apr 2022 22:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiDMCzv (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 12 Apr 2022 22:55:51 -0400
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1516.securemx.jp [210.130.202.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B5C506E1;
        Tue, 12 Apr 2022 19:53:30 -0700 (PDT)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1516) id 23D2cMd0009658; Wed, 13 Apr 2022 11:38:22 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 23D2c1WL014315; Wed, 13 Apr 2022 11:38:01 +0900
X-Iguazu-Qid: 34trhY1ImnHWYiuqOd
X-Iguazu-QSIG: v=2; s=0; t=1649817481; q=34trhY1ImnHWYiuqOd; m=UBigd8VW37nIylWtwyNAP1iScEww5didpBPsosnJJYk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1512) id 23D2c1Qv012527
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Apr 2022 11:38:01 +0900
X-SA-MID: 35919150
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, yuji2.ishikawa@toshiba.co.jp
Subject: [PATCH 3/3] MAINTAINERS: Add entries for Toshiba Visconti Video Input Interface
Date:   Wed, 13 Apr 2022 11:32:34 +0900
X-TSB-HOP2: ON
Message-Id: <20220413023234.19526-4-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220413023234.19526-1-yuji2.ishikawa@toshiba.co.jp>
References: <20220413023234.19526-1-yuji2.ishikawa@toshiba.co.jp>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd36acc87..30b0fcd0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2792,12 +2792,14 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iwamatsu/linux-visconti.git
 F:	Documentation/devicetree/bindings/arm/toshiba.yaml
+F:  Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
 F:	Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.yaml
 F:	Documentation/devicetree/bindings/gpio/toshiba,gpio-visconti.yaml
 F:	Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
 F:	Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
 F:	arch/arm64/boot/dts/toshiba/
+F:  drivers/media/platform/visconti/
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
 F:	drivers/gpio/gpio-visconti.c
 F:	drivers/pci/controller/dwc/pcie-visconti.c
-- 
2.17.1


