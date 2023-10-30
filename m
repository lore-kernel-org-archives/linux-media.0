Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B03C4332F
	for <linux-media@archiver.kernel.org>; Mon, 30 Oct 2023 07:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjJ3HVC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 30 Oct 2023 03:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjJ3HUl (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 30 Oct 2023 03:20:41 -0400
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81347D7E
        for <linux-media@vger.kernel.org>; Mon, 30 Oct 2023 00:20:31 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id xMZXqGw8VIsudxMZXqcmOd; Mon, 30 Oct 2023 08:20:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698650428;
        bh=7XgPRehCSAWCRbDjmZl/84CZ6/WWxMs6uaboa+ApIJw=;
        h=From:To:Cc:Subject:Date;
        b=BpQwBHoE2T3irox9hMtwFlrsmiWk6BjqE45Zz12TX3diF9APEZ5rKQFCektaKsfTi
         +gOggw3fke5Z48pTjDYUQeQyHSyBCXu4+Euh4p3ujAjSAylJpOVYnWTLYUKWl6RrJU
         kZx0ek7fJ5nwV/Omem0GvSH6x1pj01Plg6ypzoxmUfeaMOdulGs8O9USdP5MZd4MBt
         +l1QsIBE5Mzx0hkIh0MYSE5xmRbcjzhOzgCr7QtJwLm8zH+W7SoYMAlRe1ryjL8TlW
         8GyU6IXR82HxyP2n8iIJiSErPFEgPUreA3NujAEXJcftwe1yrWQnDuhj3Tn6epi2Uj
         LM5DMbYOkBfZA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 30 Oct 2023 08:20:28 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Brad Love <brad@nextdimension.cc>, Sean Young <sean@mess.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: dvb-frontends: m88ds3103: Fix a memory leak in an error handling path of m88ds3103_probe()
Date:   Mon, 30 Oct 2023 08:20:26 +0100
Message-Id: <1b254cae201809f85e9884ed33ae72ff6338017d.1698650397.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

If an error occurs after a successful i2c_mux_add_adapter(), then
i2c_mux_del_adapters() should be called to free some resources, as
already done in the remove function.

Fixes: e6089feca460 ("media: m88ds3103: Add support for ds3103b demod")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/media/dvb-frontends/m88ds3103.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/m88ds3103.c b/drivers/media/dvb-frontends/m88ds3103.c
index 26c67ef05d13..e0272054fca5 100644
--- a/drivers/media/dvb-frontends/m88ds3103.c
+++ b/drivers/media/dvb-frontends/m88ds3103.c
@@ -1894,7 +1894,7 @@ static int m88ds3103_probe(struct i2c_client *client)
 		/* get frontend address */
 		ret = regmap_read(dev->regmap, 0x29, &utmp);
 		if (ret)
-			goto err_kfree;
+			goto err_del_adapters;
 		dev->dt_addr = ((utmp & 0x80) == 0) ? 0x42 >> 1 : 0x40 >> 1;
 		dev_dbg(&client->dev, "dt addr is 0x%02x\n", dev->dt_addr);
 
@@ -1902,11 +1902,14 @@ static int m88ds3103_probe(struct i2c_client *client)
 						      dev->dt_addr);
 		if (IS_ERR(dev->dt_client)) {
 			ret = PTR_ERR(dev->dt_client);
-			goto err_kfree;
+			goto err_del_adapters;
 		}
 	}
 
 	return 0;
+
+err_del_adapters:
+	i2c_mux_del_adapters(dev->muxc);
 err_kfree:
 	kfree(dev);
 err:
-- 
2.34.1

