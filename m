Return-Path: <SRS0=djxu=SF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06ADCC4360F
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8BF20882
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ko34ZPay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfDCWS2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:18:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37545 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDCWS1 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 3 Apr 2019 18:18:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so902915wrm.4
        for <linux-media@vger.kernel.org>; Wed, 03 Apr 2019 15:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Iu/Dkly6zfXuj2CvLdACm3Z+rO003CO1txCsJMayGpQ=;
        b=Ko34ZPayzju9nuNPkKe+CssP+q2vONJbXK+d/yIq97Tkh+oc6qkGO6+/8iwcmaBjtj
         C4xaqQ09vD/rQ04ZJqUg9B0FzaMyHwnjNT524SyohdPUjsC9UmsKavQShe/ZMLvcQZFY
         XZ/46HakvZfisemERqQsSMHqHapR2aS6R3P2EqRmvSPDrjisqHJ+CNVgncaTFSjN6aFV
         ViT1+7/AKMI3N3QHMjSBJ5LMAb9YdMuboKMEs7qcqLL59PTtYrx4UVGP/0md9b6neLka
         LqyeQAMkmbl+oY+WBqhC9jS1poBdG50YeSTtf0zGJcaoBl7MmH03cSdw/e/elYnK5Z/P
         rwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Iu/Dkly6zfXuj2CvLdACm3Z+rO003CO1txCsJMayGpQ=;
        b=jeO+U31HiJ59OHExQmcjcueM4TMcpIEw92KwLmX8MSUC5pu11f6CEwc60qbDV/fTjt
         pbycbZ2zLz21lr5f68uMuTIU33ZwqBW/mGzIzHnTMQgdUtw/n7RpiwOkQYsZSZ+WTTkx
         0OTtSJCgqIsaTvlOA5IT80TorrJZa4wLk1Svw02s4K+7f4OszWd56pGxeNza99a4sM37
         wJX2FLhI4YtbPSHCOiA1Td7YgP9ob3bPyQXT6QIGpC2cZEeC9N7SMrRRnHYrSUW69rIz
         aUG5X+6oQ+2dmWYQ0DGEXZJchjWHqIiOL2YWc9AAWEyD235cQNcDOWEeBb/GqNvHILk+
         tHMA==
X-Gm-Message-State: APjAAAWPcvuWypTXLDfzu8hUxoX9W1/l/TYpHBr4LFVWhCpt8S4AWVAx
        +wUWD9CoIBcBYuXwPJmMzRA=
X-Google-Smtp-Source: APXvYqx5q2HYVGqniUm+nRNJVhKT7jk8/madMAvRxQ81tLnBAY5sCnXHHNcplCWpsUmWS5T8woPPFQ==
X-Received: by 2002:adf:fe03:: with SMTP id n3mr1259232wrr.59.1554329905082;
        Wed, 03 Apr 2019 15:18:25 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id d6sm26019552wrx.62.2019.04.03.15.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 15:18:24 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     dafna3@gmail.com, linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com
Subject: [PATCH v2 14/16] media: vicodec: Register another node for stateless encoder
Date:   Wed,  3 Apr 2019 15:14:59 -0700
Message-Id: <20190403221501.32814-15-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403221501.32814-1-dafna3@gmail.com>
References: <20190403221501.32814-1-dafna3@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add stateless encoder instance field to the dev struct and
register another node for the stateless encoder.
The stateless API for the node will be implemented in further
patches.

Signed-off-by: Dafna Hirschfeld <dafna3@gmail.com>
---
 drivers/media/platform/vicodec/vicodec-core.c | 44 +++++++++++++++----
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index 73661bc96671..8780df73a41f 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -104,6 +104,7 @@ struct vicodec_dev {
 	struct v4l2_device	v4l2_dev;
 	struct vicodec_dev_instance stateful_enc;
 	struct vicodec_dev_instance stateful_dec;
+	struct vicodec_dev_instance stateless_enc;
 	struct vicodec_dev_instance stateless_dec;
 #ifdef CONFIG_MEDIA_CONTROLLER
 	struct media_device	mdev;
@@ -1903,16 +1904,20 @@ static int vicodec_open(struct file *file)
 		rc = -ENOMEM;
 		goto open_unlock;
 	}
+	ctx->is_enc = (vfd == &dev->stateful_enc.vfd ||
+		       vfd == &dev->stateless_enc.vfd);
 
-	if (vfd == &dev->stateful_enc.vfd) {
-		ctx->is_enc = true;
+	ctx->is_stateless = (vfd == &dev->stateless_dec.vfd ||
+			     vfd == &dev->stateless_enc.vfd);
+
+	if (vfd == &dev->stateful_enc.vfd)
 		ctx->dev_inst = &dev->stateful_enc;
-	} else if (vfd == &dev->stateless_dec.vfd) {
-		ctx->is_stateless = true;
-		ctx->dev_inst = &dev->stateless_dec;
-	} else {
+	else if (vfd == &dev->stateful_dec.vfd)
 		ctx->dev_inst = &dev->stateful_dec;
-	}
+	else if (vfd == &dev->stateless_enc.vfd)
+		ctx->dev_inst = &dev->stateless_enc;
+	else
+		ctx->dev_inst = &dev->stateless_dec;
 
 	v4l2_fh_init(&ctx->fh, video_devdata(file));
 	file->private_data = &ctx->fh;
@@ -2162,9 +2167,13 @@ static int vicodec_probe(struct platform_device *pdev)
 			      "stateful-decoder", false))
 		goto unreg_sf_enc;
 
+	if (register_instance(dev, &dev->stateless_enc,
+			      "stateless-encoder", false))
+		goto unreg_sf_dec;
+
 	if (register_instance(dev, &dev->stateless_dec,
 			      "stateless-decoder", false))
-		goto unreg_sf_dec;
+		goto unreg_sl_enc;
 
 #ifdef CONFIG_MEDIA_CONTROLLER
 	ret = v4l2_m2m_register_media_controller(dev->stateful_enc.m2m_dev,
@@ -2183,14 +2192,23 @@ static int vicodec_probe(struct platform_device *pdev)
 		goto unreg_m2m_sf_enc_mc;
 	}
 
+	ret = v4l2_m2m_register_media_controller(dev->stateless_enc.m2m_dev,
+						 &dev->stateless_enc.vfd,
+						 MEDIA_ENT_F_PROC_VIDEO_ENCODER);
+	if (ret) {
+		v4l2_err(&dev->v4l2_dev, "Failed to init mem2mem media controller for stateless enc\n");
+		goto unreg_m2m_sf_dec_mc;
+	}
+
 	ret = v4l2_m2m_register_media_controller(dev->stateless_dec.m2m_dev,
 						 &dev->stateless_dec.vfd,
 						 MEDIA_ENT_F_PROC_VIDEO_DECODER);
 	if (ret) {
 		v4l2_err(&dev->v4l2_dev, "Failed to init mem2mem media controller for stateless dec\n");
-		goto unreg_m2m_sf_dec_mc;
+		goto unreg_m2m_sl_enc_mc;
 	}
 
+
 	ret = media_device_register(&dev->mdev);
 	if (ret) {
 		v4l2_err(&dev->v4l2_dev, "Failed to register mem2mem media device\n");
@@ -2202,6 +2220,8 @@ static int vicodec_probe(struct platform_device *pdev)
 #ifdef CONFIG_MEDIA_CONTROLLER
 unreg_m2m_sl_dec_mc:
 	v4l2_m2m_unregister_media_controller(dev->stateless_dec.m2m_dev);
+unreg_m2m_sl_enc_mc:
+	v4l2_m2m_unregister_media_controller(dev->stateless_enc.m2m_dev);
 unreg_m2m_sf_dec_mc:
 	v4l2_m2m_unregister_media_controller(dev->stateful_dec.m2m_dev);
 unreg_m2m_sf_enc_mc:
@@ -2210,6 +2230,9 @@ static int vicodec_probe(struct platform_device *pdev)
 	video_unregister_device(&dev->stateless_dec.vfd);
 	v4l2_m2m_release(dev->stateless_dec.m2m_dev);
 #endif
+unreg_sl_enc:
+	video_unregister_device(&dev->stateless_enc.vfd);
+	v4l2_m2m_release(dev->stateless_enc.m2m_dev);
 unreg_sf_dec:
 	video_unregister_device(&dev->stateful_dec.vfd);
 	v4l2_m2m_release(dev->stateful_dec.m2m_dev);
@@ -2232,15 +2255,18 @@ static int vicodec_remove(struct platform_device *pdev)
 	media_device_unregister(&dev->mdev);
 	v4l2_m2m_unregister_media_controller(dev->stateful_enc.m2m_dev);
 	v4l2_m2m_unregister_media_controller(dev->stateful_dec.m2m_dev);
+	v4l2_m2m_unregister_media_controller(dev->stateless_enc.m2m_dev);
 	v4l2_m2m_unregister_media_controller(dev->stateless_dec.m2m_dev);
 	media_device_cleanup(&dev->mdev);
 #endif
 
 	v4l2_m2m_release(dev->stateful_enc.m2m_dev);
 	v4l2_m2m_release(dev->stateful_dec.m2m_dev);
+	v4l2_m2m_release(dev->stateless_enc.m2m_dev);
 	v4l2_m2m_release(dev->stateless_dec.m2m_dev);
 	video_unregister_device(&dev->stateful_enc.vfd);
 	video_unregister_device(&dev->stateful_dec.vfd);
+	video_unregister_device(&dev->stateless_enc.vfd);
 	video_unregister_device(&dev->stateless_dec.vfd);
 	v4l2_device_unregister(&dev->v4l2_dev);
 
-- 
2.17.1

