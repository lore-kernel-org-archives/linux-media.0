Return-Path: <SRS0=iZ/e=73=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4D0C433DF
	for <linux-media@archiver.kernel.org>; Sun, 14 Jun 2020 02:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 389912074D
	for <linux-media@archiver.kernel.org>; Sun, 14 Jun 2020 02:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Hj+qKjLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgFNChK (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 13 Jun 2020 22:37:10 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:55306 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgFNChI (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 13 Jun 2020 22:37:08 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49kzBW1bxrz9vKMc
        for <linux-media@vger.kernel.org>; Sun, 14 Jun 2020 02:37:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WL9_dbBPZwgV for <linux-media@vger.kernel.org>;
        Sat, 13 Jun 2020 21:37:07 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49kzBV6sRjz9vKMJ
        for <linux-media@vger.kernel.org>; Sat, 13 Jun 2020 21:37:06 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49kzBV6sRjz9vKMJ
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49kzBV6sRjz9vKMJ
Received: by mail-io1-f69.google.com with SMTP id n123so8915282iod.17
        for <linux-media@vger.kernel.org>; Sat, 13 Jun 2020 19:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RQEF7X2he2CIvCAF0xeze50vGbmiUj8obcSj3YpGnsc=;
        b=Hj+qKjLqwxKZdFHcqhGL4RCVKHV6fP3Oer7rzrgPPWYbv35lGkAst5QgPc8y3nLRCp
         vKVaxl7tk1u8PZMNFAetQYQ6NwzqplGIsXILrLiVUysqIKuvbFEb3y0fL7NeZDA6eBqI
         pO96/Au+eO/frA1E4LLC+lPvS8hR2UvICjeKU9R3le1ae4tglEaeUVDybiZKisk2cU69
         JZ8sbETmJsW/DFxNKzIkJXdJ9tsV1lNSfpS/+4EkCHBrpLSK44iXq7e4QFYuFza1Hz8M
         Zi+3fmlSvQPyovl/+DtnyRguBKLN0yPRjqYUnqP4JoEqzyj84WdoVHPHGf9oZzOLGrVX
         3bdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RQEF7X2he2CIvCAF0xeze50vGbmiUj8obcSj3YpGnsc=;
        b=cwRVfu3U44QljqiD3pgwa3NUbaDNQ/Olgzb9VVQNO+0/Kg57LKkkcZLQaVGB14crk9
         zrvcw7db2Y73EpE4EUTB4aGkp7Bxqiz1uMVok2sX9o42Ez2F7oDY50BT3wVJ4crx5unq
         gd1zqllzDE8+jPVTxU4efIjzXz9KnHQ/o+xtxETyxJIr2HsbbS9uXDPD0h4dQ7KoK3k5
         N9stuufeZaLWNEz7sHSkoi/4RjH0zxzwZyYyLAEzBwL7gnQdDrYk3z4aITYOrI4G+mNw
         d2ul56cMQC2uwJ6UtkhxYPzc2Bvh5bC9SSsFY7ikS+pjZ5d0Z6rY5iy0Lh1ARxbAooZ2
         fGGQ==
X-Gm-Message-State: AOAM5313rLYq6aGLwtGnUNDbNJMN4pbYb68iQtSXcKsTlycAEvNrP71X
        i5vYiO+xaUm0GQ45E5wpkWTuohvFt5y6EDCaJ4zmwH4F4biaLeKRJ3d8sjlR1MgAHdfcIIS3Pm5
        KsuKGoF4rihUhLsY2lShglF30Ags=
X-Received: by 2002:a92:cf09:: with SMTP id c9mr19732352ilo.143.1592102226322;
        Sat, 13 Jun 2020 19:37:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZ86ckYqx5vk+JKvHiE51xf49YXvXEFvQYRO/7UldKAKo+GnZzsRu2IiSnX8jxysU/4zFyPw==
X-Received: by 2002:a92:cf09:: with SMTP id c9mr19732342ilo.143.1592102226008;
        Sat, 13 Jun 2020 19:37:06 -0700 (PDT)
Received: from qiushi.cs.umn.edu ([2607:ea00:101:3c74:4874:45:bcb4:df60])
        by smtp.gmail.com with ESMTPSA id 18sm5499967ion.17.2020.06.13.19.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 19:37:05 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Hugues Fruchet <hugues.fruchet@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: stm32-dcmi: Fix a reference count leak
Date:   Sat, 13 Jun 2020 21:36:59 -0500
Message-Id: <20200614023659.25979-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

Calling pm_runtime_get_sync increments the counter even in case of
failure, causing incorrect ref count if pm_runtime_put is not
called in error handling paths. Thus replace the jump target
"err_release_buffers" by "err_pm_putw".

Fixes: 152e0bf60219 ("media: stm32-dcmi: add power saving support")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index b8931490b83b..fd1c41cba52f 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -733,7 +733,7 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
 	if (ret < 0) {
 		dev_err(dcmi->dev, "%s: Failed to start streaming, cannot get sync (%d)\n",
 			__func__, ret);
-		goto err_release_buffers;
+		goto err_pm_put;
 	}
 
 	ret = media_pipeline_start(&dcmi->vdev->entity, &dcmi->pipeline);
@@ -837,8 +837,6 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
 
 err_pm_put:
 	pm_runtime_put(dcmi->dev);
-
-err_release_buffers:
 	spin_lock_irq(&dcmi->irqlock);
 	/*
 	 * Return all buffers to vb2 in QUEUED state.
-- 
2.17.1

