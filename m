Return-Path: <SRS0=cr3f=WD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0042CC433FF
	for <linux-media@archiver.kernel.org>; Wed,  7 Aug 2019 08:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B732238C
	for <linux-media@archiver.kernel.org>; Wed,  7 Aug 2019 08:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387533AbfHGInf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:43:35 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:44147 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387517AbfHGInf (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 7 Aug 2019 04:43:35 -0400
Received: from [IPv6:2001:983:e9a7:1:9c05:4bbc:890e:7747] ([IPv6:2001:983:e9a7:1:9c05:4bbc:890e:7747])
        by smtp-cloud9.xs4all.net with ESMTPA
        id vHXghjsD9AffAvHXhh7MDS; Wed, 07 Aug 2019 10:43:33 +0200
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH] adv7511/cobalt: rename driver name to adv7511-v4l2
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Message-ID: <2d1cc240-30c3-c0b4-d99b-faedbb509367@xs4all.nl>
Date:   Wed, 7 Aug 2019 10:43:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLcCzVzq3c5AGK3O4dwKEcaMbeH//3QYb3ifpvyvRRWqUfMKEAZvAyd388Iyw9hXabTMk5Yl2K/dqXD/r7SaRHpppXoLItPtT3K0Ti2YTmb4Fjxc2VZB
 p/lbbRMUjq9lxOfeB0k9KqytyzjEaLBWTcKHt/9bl7boRet4vRygXHvh922Mp7rQSLkoUTrGlFy6QMFXWP4aJg0pmcbcMp80zUkq5w7RlAkVCecdhOirK7hP
 hUzdnQD+MG9Jcb6zKnDf5Is3r/U0uKlz76UBb1xd1lYIRPt+fyO4P3+JrloO3Bny
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Commit b2ce5617dad2 ("media: i2c: fix warning same module names")
renamed the adv7511 module in the media tree to adv7511-v4l2.

This patch does the same rename for the driver name and device id to
keep the naming consistent.

Since the cobalt driver loads this module, it had to be renamed there
as well.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
diff --git a/drivers/media/i2c/adv7511-v4l2.c b/drivers/media/i2c/adv7511-v4l2.c
index 2ad6bdf1a9fc..45cc5a4c2de5 100644
--- a/drivers/media/i2c/adv7511-v4l2.c
+++ b/drivers/media/i2c/adv7511-v4l2.c
@@ -1980,14 +1980,14 @@ static int adv7511_remove(struct i2c_client *client)
 /* ----------------------------------------------------------------------- */

 static const struct i2c_device_id adv7511_id[] = {
-	{ "adv7511", 0 },
+	{ "adv7511-v4l2", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adv7511_id);

 static struct i2c_driver adv7511_driver = {
 	.driver = {
-		.name = "adv7511",
+		.name = "adv7511-v4l2",
 	},
 	.probe = adv7511_probe,
 	.remove = adv7511_remove,
diff --git a/drivers/media/pci/cobalt/cobalt-driver.c b/drivers/media/pci/cobalt/cobalt-driver.c
index b92833f3d464..0695078ef812 100644
--- a/drivers/media/pci/cobalt/cobalt-driver.c
+++ b/drivers/media/pci/cobalt/cobalt-driver.c
@@ -584,7 +584,7 @@ static int cobalt_subdevs_hsma_init(struct cobalt *cobalt)
 		.cec_clk = 12000000,
 	};
 	static struct i2c_board_info adv7511_info = {
-		.type = "adv7511",
+		.type = "adv7511-v4l2",
 		.addr = 0x39, /* 0x39 or 0x3d */
 		.platform_data = &adv7511_pdata,
 	};
