Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2171FC4361B
	for <linux-media@archiver.kernel.org>; Wed, 16 Dec 2020 13:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C40D32339E
	for <linux-media@archiver.kernel.org>; Wed, 16 Dec 2020 13:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgLPN0J (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 16 Dec 2020 08:26:09 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10049 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgLPN0J (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 16 Dec 2020 08:26:09 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CwwpC4l9QzM46d;
        Wed, 16 Dec 2020 21:24:35 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Wed, 16 Dec 2020 21:25:16 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] usb: em28xx: convert comma to semicolon
Date:   Wed, 16 Dec 2020 21:25:48 +0800
Message-ID: <20201216132548.15475-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/media/usb/em28xx/em28xx-audio.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/usb/em28xx/em28xx-audio.c b/drivers/media/usb/em28xx/em28xx-audio.c
index dc968fd5ace9..4d5ab1433b44 100644
--- a/drivers/media/usb/em28xx/em28xx-audio.c
+++ b/drivers/media/usb/em28xx/em28xx-audio.c
@@ -583,9 +583,9 @@ static int em28xx_cvol_new(struct snd_card *card, struct em28xx *dev,
 	struct snd_kcontrol_new tmp;
 
 	memset(&tmp, 0, sizeof(tmp));
-	tmp.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	tmp.private_value = id,
-	tmp.name  = ctl_name,
+	tmp.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	tmp.private_value = id;
+	tmp.name  = ctl_name;
 
 	/* Add Mute Control */
 	sprintf(ctl_name, "%s Switch", name);
@@ -600,16 +600,16 @@ static int em28xx_cvol_new(struct snd_card *card, struct em28xx *dev,
 		ctl_name, id);
 
 	memset(&tmp, 0, sizeof(tmp));
-	tmp.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	tmp.private_value = id,
-	tmp.name  = ctl_name,
+	tmp.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	tmp.private_value = id;
+	tmp.name  = ctl_name;
 
 	/* Add Volume Control */
 	sprintf(ctl_name, "%s Volume", name);
 	tmp.get   = em28xx_vol_get;
 	tmp.put   = em28xx_vol_put;
 	tmp.info  = em28xx_vol_info;
-	tmp.tlv.p = em28xx_db_scale,
+	tmp.tlv.p = em28xx_db_scale;
 	kctl = snd_ctl_new1(&tmp, dev);
 	err = snd_ctl_add(card, kctl);
 	if (err < 0)
-- 
2.22.0

