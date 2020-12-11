Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19101C433FE
	for <linux-media@archiver.kernel.org>; Fri, 11 Dec 2020 08:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C899923C17
	for <linux-media@archiver.kernel.org>; Fri, 11 Dec 2020 08:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbgLKIb6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 11 Dec 2020 03:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgLKIbx (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 11 Dec 2020 03:31:53 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47A8C0613CF;
        Fri, 11 Dec 2020 00:31:12 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id l23so1971103pjg.1;
        Fri, 11 Dec 2020 00:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BvXfqmrNJagCH+GbSgfFYVoOHFPlLGvLrR6QFrYlfo0=;
        b=JREI7iGfFOa9A7qYLjV/3iCghgcy2ZGlfv2kndOL5KF3YExuqirtUbwP6dIyZgoGDW
         xEdsHJM4m3lLOOBBuyHeHmzJfeahQV8aU79qiUBmyh/XfunEzandeK5G3NUESt3AWFcD
         a3ezSMUd+nR4hOuPGZpjmPcOjFQCEE5g7xRh9Kp4CGmPYMDh8XXvH5YQcT1Lhcai3Y+4
         E7IoAbLXCh+ZKqcc2Am5URYpCPMSQWDUJBpD+lZwnbO4zZD1nwmlUqkP8kWFWCvZ/jcp
         2kyerygUYyukX490yhTeGKq7bs+4TmFxr4PYUBV7gvSe6zrBY93YjH+CHkmkZhhtPNf3
         TeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BvXfqmrNJagCH+GbSgfFYVoOHFPlLGvLrR6QFrYlfo0=;
        b=Suc5Qbo8Aner/rRZhx+qPI/RmHZCX2luVjUILGpnijHnegkj6c5jTkHn4Ze55H/HwV
         eY2jXN9TUMHiX3PalvkjfLXEL7MmWVHINO6nR/MIokkXBPo0gCQ+KUtV92tu2NBcZwR7
         rCmKv3DXn6yZRkpnBJp3EAZOCkOu7ce+W2rlEtWHNRfhSgEhN+j/JtIb70ntqe0f+A8V
         cVFfNgdA1Bw9acuVmlv8KD0YxhOzJFqjTgLASeEror2L6Ikvshwqt7vIM9wxkEKqSF3f
         ByRMUb7G5aLIMgjDqrp+p60r27SgjwLr3Jm/kejc7DN5MtWCZeASNOaCYlztTwj8GdFh
         HARA==
X-Gm-Message-State: AOAM533aKt+WgWYoS1/IJHkeYBzrbtWlg/IbZ66n6i1d4hIFni8bIKj5
        5zYPDfo50DjfC6sDL8JT2A==
X-Google-Smtp-Source: ABdhPJyOOAIrp8s+Q92SAtzPfWarGNJC7la9Thn+Qb4fkzGaURu9ZwsTmXIzBVaRMZF+WNorDPs2Fw==
X-Received: by 2002:a17:90b:8d8:: with SMTP id ds24mr11800440pjb.134.1607675472478;
        Fri, 11 Dec 2020 00:31:12 -0800 (PST)
Received: from localhost.localdomain (59-125-13-244.HINET-IP.hinet.net. [59.125.13.244])
        by smtp.gmail.com with ESMTPSA id l66sm8885410pgl.24.2020.12.11.00.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 00:31:11 -0800 (PST)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Young <sean@mess.org>, Brad Love <brad@nextdimension.cc>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH] media: dvbdev: Fix memory leak in dvb_media_device_free()
Date:   Fri, 11 Dec 2020 03:30:39 -0500
Message-Id: <20201211083039.521617-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

dvb_media_device_free() is leaking memory. Free `dvbdev->adapter->conn`
before setting it to NULL, as documented in include/media/media-device.h:
"The media_entity instance itself must be freed explicitly by the driver
if required."

Cc: stable@vger.kernel.org
Fixes: 0230d60e4661 ("[media] dvbdev: Add RF connector if needed")
Reported-by: syzbot+7f09440acc069a0d38ac@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=9bbe4b842c98f0ed05c5eed77a226e9de33bf298
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
 drivers/media/dvb-core/dvbdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index 959fa2820259..ec9ebff28552 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -241,6 +241,7 @@ static void dvb_media_device_free(struct dvb_device *dvbdev)
 
 	if (dvbdev->adapter->conn) {
 		media_device_unregister_entity(dvbdev->adapter->conn);
+		kfree(dvbdev->adapter->conn);
 		dvbdev->adapter->conn = NULL;
 		kfree(dvbdev->adapter->conn_pads);
 		dvbdev->adapter->conn_pads = NULL;
-- 
2.25.1

