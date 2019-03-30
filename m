Return-Path: <SRS0=IMFm=SB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3F8C43381
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7952146F
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxfJocJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbfC3Upw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 30 Mar 2019 16:45:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42871 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730582AbfC3Upu (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 30 Mar 2019 16:45:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so6823378wrx.9
        for <linux-media@vger.kernel.org>; Sat, 30 Mar 2019 13:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SQGF3TuNF5KQ0AO+rkzzO1v78UFk3o3QLb/PiuS736c=;
        b=jxfJocJMqPX1mzHtguNTQxeul156g22WVeAXg7DP7Ib5aLQ6HVGG5OX/0Y0KsTReX5
         yZuldt3BN7RhYpWB8Ko4ICIS4QbNuGwx1J2DL774W4COVU34/urstzHiF2LGsRrLQ82n
         RNOusI7AAKNeHOIH2EcCHDiVQedWcv47RizLNZpWMoezDzXO9r2cjZA423Lv5YyPvWwL
         EQyubqT2vyoxki7xMUiDO08EXdCcHZu8e29eGHoC3ki4FvzpTKb6QckQRWkJjppN5c8/
         ZWdX/ubXGxtcnPWbzXIvDTdXp/HXZUvuuOAAmVTaEcLjZBWCGbOpOkD4StXLESsaAwPJ
         QInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SQGF3TuNF5KQ0AO+rkzzO1v78UFk3o3QLb/PiuS736c=;
        b=kq0hWWyQrkcIUqQu+trpLssxzsT2NGWATM5AcTkl7VcFKMEMD4rAG8BO7T8nAL9eub
         JExx4mJyO2GyvURtuN2HI7nXbilbE3GdgWrD5pLoXjCqE03OgXZzbECkerO5OsWSLAyq
         KNSbmYPHq34mY3nR9CyxTFXUl31NqTc8/vnE/FSAOS5uuO65oqxpuruk1q2Yv33/HImH
         YopIMLaFc8dwhcsixdXSLEAbtkbjFGiOTjN22nHQ94vCYbHCaX2iFVOQPGGEaDzJr1Ai
         zvLmWL7CNdCdvXGqZhDYgVSsKsSAIjABJLb/KdF0e9M5RwNBk3CRcAMXXyJ+wZ59Wo/K
         D1XQ==
X-Gm-Message-State: APjAAAVs9voAucF39ZbaCl10iDQ4BpcIXF211gEmn1RqlYYM0/YjPjSc
        9iJ52CZozCR9tsMdxH6IkaNUZ3OtL4E=
X-Google-Smtp-Source: APXvYqzb+okw8sadgN3FWZMPo1DoaP/5OH1++0p/7RqrMp2xrMVe8O1wc94KbGoGemZLs4mSTEILEQ==
X-Received: by 2002:a5d:54c4:: with SMTP id x4mr34409813wrv.296.1553978748771;
        Sat, 30 Mar 2019 13:45:48 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id a9sm5903671wmb.30.2019.03.30.13.45.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 13:45:48 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 05/14] videobuf2-v4l2: set last_buffer_dequeued in dqbuf
Date:   Sat, 30 Mar 2019 13:43:03 -0700
Message-Id: <20190330204311.107417-6-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190330204311.107417-1-dafna3@gmail.com>
References: <20190330204311.107417-1-dafna3@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

last_buffer_dequeued was set to true in __fill_v4l2_buffer, but this
is called for qbuf as well. Move it to vb2_dqbuf.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/common/videobuf2/videobuf2-v4l2.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index b11a779e97b0..379738372651 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -562,11 +562,6 @@ static void __fill_v4l2_buffer(struct vb2_buffer *vb, void *pb)
 		b->flags |= V4L2_BUF_FLAG_REQUEST_FD;
 		b->request_fd = vbuf->request_fd;
 	}
-
-	if (!q->is_output &&
-		b->flags & V4L2_BUF_FLAG_DONE &&
-		b->flags & V4L2_BUF_FLAG_LAST)
-		q->last_buffer_dequeued = true;
 }
 
 /*
@@ -785,6 +780,11 @@ int vb2_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking)
 
 	ret = vb2_core_dqbuf(q, NULL, b, nonblocking);
 
+	if (!q->is_output &&
+	    b->flags & V4L2_BUF_FLAG_DONE &&
+	    b->flags & V4L2_BUF_FLAG_LAST)
+		q->last_buffer_dequeued = true;
+
 	/*
 	 *  After calling the VIDIOC_DQBUF V4L2_BUF_FLAG_DONE must be
 	 *  cleared.
-- 
2.17.1

