Return-Path: <SRS0=djxu=SF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF79C10F06
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEEE20882
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgTSJc2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfDCWSZ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:18:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36749 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDCWSY (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 3 Apr 2019 18:18:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so685202wml.1
        for <linux-media@vger.kernel.org>; Wed, 03 Apr 2019 15:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RjtThrQrlanvTRGAnpBc2WBNTUw6DBZbSimhC1b0dKY=;
        b=mgTSJc2qr2GcHdvE4r+XoyFRYWccN5S+O6v4hqM72KvyTa0Lku9o+RMacaEnPip4BO
         ctQLMFQMbojweoUbvp7ncBl0UuU7VPuk2Ozy2pknH+raU6sNGVj8D+lEV/g8l4f0CFUP
         6oE+5x0gMtZA5VpGFX+qknm20EtpRTJUqjSuBQkuDQl0+eIpbpgwQp5TOg5+d2daRMUP
         YOKd43OXY2e5Xn67OG+27XjmCyBrSmF5SiOfN854D0GvGNzUij7L9DBDxNDtnYx41ZcA
         CDz7NmWzrCysl/m3/gVdamUdxbTpA1O2kLRXj8KXqJsK/rt8gJZISidx6ZdtS2/yBRP1
         sGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RjtThrQrlanvTRGAnpBc2WBNTUw6DBZbSimhC1b0dKY=;
        b=LumtQkO2xnwZ2RUOMTLgPQgI4GTuBZxo/1j96keExrZF3LDagyl/MgmPIY+2PU3RV2
         N+jSWwx7w0WA+tm+81xZDZ5wcct5HCXHRxdHncwdXj1VGxE4EnX41jmXj1XEHzkBauyn
         aqny2hVcJscUoUD7KAzyJSDhrmS5uUrxbj0uWHReWVDlcVtgG6tuneFxPv/tSkuxUkym
         7VLuULPy+3a1NokzYD21x9Hp/l2GMFuNyzEV0QFxV3svYzAWz7zTVKC8yW4YUkSpHI95
         jd0JTvoz0yx5Pxqn8KeXZCiVm+2cNAvvD1p0NTUqx5kqHqQLOeo0yJ7SBadpEDBi7bgA
         Cuqw==
X-Gm-Message-State: APjAAAWK+fWlFV2w3NShaSshwlf9p45TkoJAA1yXdDZ0qfJGdBfyd5aI
        MeFbitrCPv6KQMhjOZV4bsI=
X-Google-Smtp-Source: APXvYqxXpo0yowVQ63gOLc0EHdt4oFJUFeSFXu7y6AppDSTXu9wGg6tKZk2Ky4djcMyfEMWIYBKTdg==
X-Received: by 2002:a7b:c7d0:: with SMTP id z16mr1533559wmk.136.1554329902797;
        Wed, 03 Apr 2019 15:18:22 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id d6sm26019552wrx.62.2019.04.03.15.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 15:18:22 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     dafna3@gmail.com, linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com
Subject: [PATCH v2 12/16] media: vicodec: bugfix: release stateless dec m2m_dev in vicodec_remove
Date:   Wed,  3 Apr 2019 15:14:57 -0700
Message-Id: <20190403221501.32814-13-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403221501.32814-1-dafna3@gmail.com>
References: <20190403221501.32814-1-dafna3@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

add a call 'v4l2_m2m_release(dev->stateless_dec.m2m_dev)'
in vicodec_remove

Signed-off-by: Dafna Hirschfeld <dafna3@gmail.com>
---
 drivers/media/platform/vicodec/vicodec-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index 08073f914fd6..3e93e86041f7 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -2254,6 +2254,7 @@ static int vicodec_remove(struct platform_device *pdev)
 
 	v4l2_m2m_release(dev->stateful_enc.m2m_dev);
 	v4l2_m2m_release(dev->stateful_dec.m2m_dev);
+	v4l2_m2m_release(dev->stateless_dec.m2m_dev);
 	video_unregister_device(&dev->stateful_enc.vfd);
 	video_unregister_device(&dev->stateful_dec.vfd);
 	video_unregister_device(&dev->stateless_dec.vfd);
-- 
2.17.1

