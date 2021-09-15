Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70660C433FE
	for <linux-media@archiver.kernel.org>; Wed, 15 Sep 2021 16:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58EAE61244
	for <linux-media@archiver.kernel.org>; Wed, 15 Sep 2021 16:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhIOQZj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 15 Sep 2021 12:25:39 -0400
Received: from gofer.mess.org ([88.97.38.141]:55335 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230368AbhIOQZd (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 15 Sep 2021 12:25:33 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 72356C66BC; Wed, 15 Sep 2021 17:24:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1631723052; bh=P/AsyzmcgTKLSxvBEDO8t7dL3rkEQ0tOcHVXgQ1PSZU=;
        h=From:To:Cc:Subject:Date:From;
        b=WkKDp3IOqlUGiH0h6fZJ8wrOsBU7aG2GQOzuKgkIRt8z6R0qV1s2e2ziHkCeEhDFl
         QAm/P9w856Yc2OwpBMNkMpo51EDpYwaU5jglQFCIIZdnPOK6Rv5QgL9VYIP7IG+hQq
         YhkDZfhu8X8GEB15BxQPSaKa2JtDXj+PWqqDNopz2rWJHbq/6eZDWxXsA2cGHvl4HL
         HquihXT1GOJ13QryW18Avq9+tt0gcAeexscbyWQJDTWaOH0lqpihfBxEbfS3H1afzs
         TpBTuHYfuUhOxfo2X9N9xouppijpFpWAhzM1RwiwVaa53M3wIkQKg1EHmdpiXC3+wI
         P7W6+w0wU859w==
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Cc:     stable@vger.kernel.org,
        =?UTF-8?q?Joaqu=C3=ADn=20Alberto=20Calder=C3=B3n=20Pozo?= 
        <kini_calderon@hotmail.com>
Subject: [PATCH] media: ir-kbd-i2c: improve responsiveness of hauppauge zilog receivers
Date:   Wed, 15 Sep 2021 17:24:12 +0100
Message-Id: <20210915162412.17993-1-sean@mess.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The IR receiver has two issues:

 - Sometimes there is no response to a button press
 - Sometimes a button press is repeated when it should not have been

Hanging the polling interval fixes this behaviour.

Cc: stable@vger.kernel.org
Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=994050
Suggested-by: Joaquín Alberto Calderón Pozo <kini_calderon@hotmail.com>
Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/i2c/ir-kbd-i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/ir-kbd-i2c.c b/drivers/media/i2c/ir-kbd-i2c.c
index 92376592455e..56674173524f 100644
--- a/drivers/media/i2c/ir-kbd-i2c.c
+++ b/drivers/media/i2c/ir-kbd-i2c.c
@@ -791,6 +791,7 @@ static int ir_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		rc_proto    = RC_PROTO_BIT_RC5 | RC_PROTO_BIT_RC6_MCE |
 							RC_PROTO_BIT_RC6_6A_32;
 		ir_codes    = RC_MAP_HAUPPAUGE;
+		ir->polling_interval = 125;
 		probe_tx = true;
 		break;
 	}
-- 
2.31.1

