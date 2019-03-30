Return-Path: <SRS0=IMFm=SB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D043AC43381
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95395218D8
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fg53jHje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbfC3Up6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 30 Mar 2019 16:45:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36280 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730769AbfC3Up5 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 30 Mar 2019 16:45:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id h18so6731298wml.1
        for <linux-media@vger.kernel.org>; Sat, 30 Mar 2019 13:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SRlv6fJfa9LOuhNVcyUe0Pf1m/Kl+Xr6Y/BT1TLitbk=;
        b=Fg53jHjex8BQykzb3QKrPMW2nab61C0Zf6dVBDNPA33kkjbZDXFbUCGAlRvsfBv94V
         l0CLU9DLPIYL+rlCXnfaSGe4F0RNMPQfHjY+DEPXfKIfM9VP5cavbiI7zUqKwZm+NXPC
         23mjNqHbKANDsQYPCGr2/l19DLTsFy1FgAxhcHz9lKH28RH0nB8onmSsmKLnq+06/lIS
         nhg7n9xD3cpv5A7mLRiPEyg/yVdWph5T5ejTtUC6OQ6rEFCe5uq6GJW02oJlJxbZQ/aE
         enIfo24+oBdD0mrazSg+Zw7wzGZA7ZDLYxMEhutA9aQctfo5PFslI2zshpgk8IOnng8T
         7FIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SRlv6fJfa9LOuhNVcyUe0Pf1m/Kl+Xr6Y/BT1TLitbk=;
        b=dg2tqrKqFglIevaBikebxrUxf4h36qiX+bb1/c4Cc7XYkD9AHkgyTKlCL58WqqeXLc
         U/nfNhK7sQ+gJHW+VJvJUZPOfpmId7akiDEufNFRUOpUudWHZ4GZ75EyGZxlnxKCkT4v
         uL3BYuZ5bVQIp1CkX/TsILup/byAJaswg5vQHDzEGl9vgZ3hPbIGrGdnivyypsmZsA5x
         IwrkavsM5e1SmFv/uSZB9j9QQAi9mgrEYLGJQJGJLCTDTKiNxED8IAV3zhg5I2bsdpz9
         MRTe9WL5E+CQzYo+Ye2NEGMhZy0Ic5ky42Bv5UdON8JRoV7bNP1XGRDZRHfn8jLSICo4
         Xt0w==
X-Gm-Message-State: APjAAAX2bK4Ew/B8C37uoeHULhCVx71rW010ezbMIuOgfwe734vfwauP
        WR6LC7O80lkh1CCzIvRCgb5gthFTxqM=
X-Google-Smtp-Source: APXvYqxSAcJIMmrtrWOUH7ABHzSfdbasYogNEJsmIwYXEbmszBj+BsspkQQaB8Byb74O+RF+UGfcVg==
X-Received: by 2002:a1c:c910:: with SMTP id f16mr7320855wmb.47.1553978754982;
        Sat, 30 Mar 2019 13:45:54 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id a9sm5903671wmb.30.2019.03.30.13.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 13:45:54 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Dafna Hirschfeld <dafna3@gmail.com>
Subject: [PATCH 11/14] media: vicodec: Register another node for stateless encoder
Date:   Sat, 30 Mar 2019 13:43:09 -0700
Message-Id: <20190330204311.107417-12-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190330204311.107417-1-dafna3@gmail.com>
References: <20190330204311.107417-1-dafna3@gmail.com>
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
 drivers/media/platform/vicodec/vicodec-core.c | 42 +++++++++++++++----
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index a701afd7cecb..6bfcd266ffc4 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -105,6 +105,7 @@ struct vicodec_dev {
 	struct vicodec_dev_instance stateful_enc;
 	struct vicodec_dev_instance stateful_dec;
 	struct vicodec_dev_instance stateless_dec;
+	struct vicodec_dev_instance stateless_enc;
 #ifdef CONFIG_MEDIA_CONTROLLER
 	struct media_device	mdev;
 #endif
@@ -1887,16 +1888,20 @@ static int vicodec_open(struct file *file)
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
@@ -2150,6 +2155,9 @@ static int vicodec_probe(struct platform_device *pdev)
 			      "stateless-decoder", false))
 		goto unreg_sf_dec;
 
+	if (register_instance(dev, &dev->stateless_enc,
+			      "stateless-encoder", false))
+		goto unreg_sl_dec;
 #ifdef CONFIG_MEDIA_CONTROLLER
 	ret = v4l2_m2m_register_media_controller(dev->stateful_enc.m2m_dev,
 						 &dev->stateful_enc.vfd,
@@ -2175,15 +2183,26 @@ static int vicodec_probe(struct platform_device *pdev)
 		goto unreg_m2m_sf_dec_mc;
 	}
 
+	ret = v4l2_m2m_register_media_controller(dev->stateless_enc.m2m_dev,
+						 &dev->stateless_enc.vfd,
+						 MEDIA_ENT_F_PROC_VIDEO_ENCODER);
+	if (ret) {
+		v4l2_err(&dev->v4l2_dev, "Failed to init mem2mem media controller for stateless enc\n");
+		goto unreg_m2m_sl_dec_mc;
+	}
+
+
 	ret = media_device_register(&dev->mdev);
 	if (ret) {
 		v4l2_err(&dev->v4l2_dev, "Failed to register mem2mem media device\n");
-		goto unreg_m2m_sl_dec_mc;
+		goto unreg_m2m_sl_enc_mc;
 	}
 #endif
 	return 0;
 
 #ifdef CONFIG_MEDIA_CONTROLLER
+unreg_m2m_sl_enc_mc:
+	v4l2_m2m_unregister_media_controller(dev->stateless_enc.m2m_dev);
 unreg_m2m_sl_dec_mc:
 	v4l2_m2m_unregister_media_controller(dev->stateless_dec.m2m_dev);
 unreg_m2m_sf_dec_mc:
@@ -2191,9 +2210,12 @@ static int vicodec_probe(struct platform_device *pdev)
 unreg_m2m_sf_enc_mc:
 	v4l2_m2m_unregister_media_controller(dev->stateful_enc.m2m_dev);
 unreg_m2m:
+	video_unregister_device(&dev->stateless_enc.vfd);
+	v4l2_m2m_release(dev->stateless_enc.m2m_dev);
+#endif
+unreg_sl_dec:
 	video_unregister_device(&dev->stateless_dec.vfd);
 	v4l2_m2m_release(dev->stateless_dec.m2m_dev);
-#endif
 unreg_sf_dec:
 	video_unregister_device(&dev->stateful_dec.vfd);
 	v4l2_m2m_release(dev->stateful_dec.m2m_dev);
@@ -2217,6 +2239,7 @@ static int vicodec_remove(struct platform_device *pdev)
 	v4l2_m2m_unregister_media_controller(dev->stateful_enc.m2m_dev);
 	v4l2_m2m_unregister_media_controller(dev->stateful_dec.m2m_dev);
 	v4l2_m2m_unregister_media_controller(dev->stateless_dec.m2m_dev);
+	v4l2_m2m_unregister_media_controller(dev->stateless_enc.m2m_dev);
 	media_device_cleanup(&dev->mdev);
 #endif
 
@@ -2225,6 +2248,7 @@ static int vicodec_remove(struct platform_device *pdev)
 	video_unregister_device(&dev->stateful_enc.vfd);
 	video_unregister_device(&dev->stateful_dec.vfd);
 	video_unregister_device(&dev->stateless_dec.vfd);
+	video_unregister_device(&dev->stateless_enc.vfd);
 	v4l2_device_unregister(&dev->v4l2_dev);
 
 	return 0;
-- 
2.17.1

