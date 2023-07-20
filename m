Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBD9EB64DD
	for <linux-media@archiver.kernel.org>; Thu, 20 Jul 2023 06:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjGTGU6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 20 Jul 2023 02:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjGTGU5 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 20 Jul 2023 02:20:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C8C1BC0
        for <linux-media@vger.kernel.org>; Wed, 19 Jul 2023 23:20:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57D8C618B6
        for <linux-media@vger.kernel.org>; Thu, 20 Jul 2023 06:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103FDC433C8;
        Thu, 20 Jul 2023 06:20:53 +0000 (UTC)
Message-ID: <8a5f4d72-7a94-5bd7-e3f9-9ce5bd6a8390@xs4all.nl>
Date:   Thu, 20 Jul 2023 08:20:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Antti Palosaari <crope@iki.fi>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH] media: tuners: qt1010: replace BUG_ON with a regular error
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

BUG_ON is unnecessary here, and in addition it confuses smatch.
Replacing this with an error return help resolve this smatch
warning:

drivers/media/tuners/qt1010.c:350 qt1010_init() error: buffer overflow 'i2c_data' 34 <= 34

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/tuners/qt1010.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/media/tuners/qt1010.c b/drivers/media/tuners/qt1010.c
index 3853a3d43d4f..a7b19863f489 100644
--- a/drivers/media/tuners/qt1010.c
+++ b/drivers/media/tuners/qt1010.c
@@ -345,11 +345,12 @@ static int qt1010_init(struct dvb_frontend *fe)
 			else
 				valptr = &tmpval;

-			BUG_ON(i >= ARRAY_SIZE(i2c_data) - 1);
-
-			err = qt1010_init_meas1(priv, i2c_data[i+1].reg,
-						i2c_data[i].reg,
-						i2c_data[i].val, valptr);
+			if (i >= ARRAY_SIZE(i2c_data) - 1)
+				err = -EIO;
+			else
+				err = qt1010_init_meas1(priv, i2c_data[i + 1].reg,
+							i2c_data[i].reg,
+							i2c_data[i].val, valptr);
 			i++;
 			break;
 		}
-- 
2.40.1

