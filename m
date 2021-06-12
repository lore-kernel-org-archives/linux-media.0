Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8208AC48BCF
	for <linux-media@archiver.kernel.org>; Sat, 12 Jun 2021 09:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36FC261078
	for <linux-media@archiver.kernel.org>; Sat, 12 Jun 2021 09:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhFLJQA (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 12 Jun 2021 05:16:00 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:43880 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhFLJQA (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 12 Jun 2021 05:16:00 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 77C09BC9B1A; Sat, 12 Jun 2021 11:13:59 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Tomasz Maciej Nowak <tmn505@gmail.com>, Sean Young <sean@mess.org>,
        Gon Solo <gonsolo@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-media@vger.kernel.org
Subject: [PATCH 1/2] media: usb: dvb-usb-v2: af9035: report if i2c client isn't bound
Date:   Sat, 12 Jun 2021 11:13:50 +0200
Message-Id: <20210612091351.7169-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

If a sub device doesn't immediately bind after it was added, emit an
error indication to the kernel log to help debugging. This happens for
example if the needed driver isn't available at all.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/media/usb/dvb-usb-v2/af9035.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/usb/dvb-usb-v2/af9035.c b/drivers/media/usb/dvb-usb-v2/af9035.c
index 22fda53e219a..6b7db903a365 100644
--- a/drivers/media/usb/dvb-usb-v2/af9035.c
+++ b/drivers/media/usb/dvb-usb-v2/af9035.c
@@ -210,6 +210,7 @@ static int af9035_add_i2c_dev(struct dvb_usb_device *d, const char *type,
 	/* register I2C device */
 	client = i2c_new_client_device(adapter, &board_info);
 	if (!i2c_client_has_driver(client)) {
+		dev_err(&intf->dev, "failed to bind i2c device to %s driver\n", type);
 		ret = -ENODEV;
 		goto err;
 	}
-- 
2.30.2

