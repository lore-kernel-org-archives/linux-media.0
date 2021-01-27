Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10F7C433E6
	for <linux-media@archiver.kernel.org>; Wed, 27 Jan 2021 18:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F64964DAC
	for <linux-media@archiver.kernel.org>; Wed, 27 Jan 2021 18:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344115AbhA0SCk (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 27 Jan 2021 13:02:40 -0500
Received: from mail.v3.sk ([167.172.186.51]:48220 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344098AbhA0SCi (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 27 Jan 2021 13:02:38 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0D0D8DF5E5;
        Wed, 27 Jan 2021 17:57:49 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gvktt2hGF6tH; Wed, 27 Jan 2021 17:57:48 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9A24FE0AE3;
        Wed, 27 Jan 2021 17:57:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hr2dETXlABTL; Wed, 27 Jan 2021 17:57:48 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 5FC65DF5E5;
        Wed, 27 Jan 2021 17:57:48 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>, stable@vger.kernel.org
Subject: [PATCH] media: marvell-ccic: power up the device on mclk enable
Date:   Wed, 27 Jan 2021 19:01:43 +0100
Message-Id: <20210127180143.43437-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Writing to REG_CLKCTRL with the power off causes a hang. Enable the
device first.

Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/media/platform/marvell-ccic/mcam-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/marvell-ccic/mcam-core.c b/drivers/me=
dia/platform/marvell-ccic/mcam-core.c
index c012fd2e1d291..34266fba824f2 100644
--- a/drivers/media/platform/marvell-ccic/mcam-core.c
+++ b/drivers/media/platform/marvell-ccic/mcam-core.c
@@ -931,6 +931,7 @@ static int mclk_enable(struct clk_hw *hw)
 		mclk_div =3D 2;
 	}
=20
+	pm_runtime_get_sync(cam->dev);
 	clk_enable(cam->clk[0]);
 	mcam_reg_write(cam, REG_CLKCTRL, (mclk_src << 29) | mclk_div);
 	mcam_ctlr_power_up(cam);
@@ -944,6 +945,7 @@ static void mclk_disable(struct clk_hw *hw)
=20
 	mcam_ctlr_power_down(cam);
 	clk_disable(cam->clk[0]);
+	pm_runtime_put(cam->dev);
 }
=20
 static unsigned long mclk_recalc_rate(struct clk_hw *hw,
--=20
2.29.2

