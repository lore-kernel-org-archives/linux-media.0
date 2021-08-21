Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A4DC4320A
	for <linux-media@archiver.kernel.org>; Sat, 21 Aug 2021 11:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E1636120F
	for <linux-media@archiver.kernel.org>; Sat, 21 Aug 2021 11:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbhHULNj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 21 Aug 2021 07:13:39 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:17544 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233859AbhHULNi (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 21 Aug 2021 07:13:38 -0400
Received: from pop-os.home ([90.126.253.178])
        by mwinf5d73 with ME
        id kBCu250093riaq203BCvsi; Sat, 21 Aug 2021 13:12:58 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 21 Aug 2021 13:12:58 +0200
X-ME-IP: 90.126.253.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mirela.rabulea@nxp.com, linux-imx@nxp.com, mchehab@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] media: imx-jpeg: Fix the error handling path of 'mxc_jpeg_probe()'
Date:   Sat, 21 Aug 2021 13:12:53 +0200
Message-Id: <925bbb0c4c7d7b197ade5bb282d7be8a44921845.1629544232.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

A successful 'mxc_jpeg_attach_pm_domains()' call should be balanced by a
corresponding 'mxc_jpeg_detach_pm_domains()' call in the error handling
path of the probe, as already done in the remove function.

Update the error handling path accordingly.

Fixes: 2db16c6ed72c ("media: imx-jpeg: Add V4L2 driver for i.MX8 JPEG Encoder/Decoder")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/media/platform/imx-jpeg/mxc-jpeg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
index 755138063ee6..a0c520678c6d 100644
--- a/drivers/media/platform/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
@@ -2088,6 +2088,8 @@ static int mxc_jpeg_probe(struct platform_device *pdev)
 	v4l2_device_unregister(&jpeg->v4l2_dev);
 
 err_register:
+	mxc_jpeg_detach_pm_domains(jpeg);
+
 err_irq:
 	return ret;
 }
-- 
2.30.2

