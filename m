Return-Path: <SRS0=VKxf=3Y=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA06C33CAC
	for <linux-media@archiver.kernel.org>; Tue,  4 Feb 2020 02:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030432166E
	for <linux-media@archiver.kernel.org>; Tue,  4 Feb 2020 02:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j3Fq0i83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgBDC5R (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 3 Feb 2020 21:57:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41407 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbgBDC5P (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 3 Feb 2020 21:57:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id l3so4804100pgi.8
        for <linux-media@vger.kernel.org>; Mon, 03 Feb 2020 18:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3NyRU2xy1z/nYwBRLVUPtO+ZHRnpI9P9k60fSC2X+DE=;
        b=j3Fq0i83ztEE46oH9dTHoPUFBJ9tpWElVSi0sKJRUZcsRbsxCRK+bWgt1i6ZdvjhO8
         ZV7hTIydDJatMj68kNoBQQ/DWG5kqPpCeiEGZheluT9CfCXmnX4rmfk92P97gjhc1IzM
         EFAdrs3PsNDg1PIBW0b1qc0dRsThBCU7KFkmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3NyRU2xy1z/nYwBRLVUPtO+ZHRnpI9P9k60fSC2X+DE=;
        b=dxCwMTFOQIhdqK6+3DGx7osu1Qe5xsQHZSaXAXHrrL+ysy7bkssvEIoEsVS+BYXpKM
         oDig09Q81qYfqfjr9065bTIF1VdO8tG125zHBaiOuruX6c3DI8PG8TcSDcBvRFeaaNOy
         2xOAKrXGc3grTiFmoiOI5pyPK6V731mAr5Fa1G/4GibvLwLJKwATWgbDtpUJG/iPWVp4
         TQ2IYpOaHlOceg9MOy9Wy/vTJwBQyBlmRb3DS9IMLg6ZrGBzcqP+mUzyplNjulUHSJ9y
         fa4pmNnL/7yOSiCCDuxBBfFo9KqFYs48NxO3C8ympn0qUr7aQVgOO2c8gYJQd5uV2tHx
         SKPA==
X-Gm-Message-State: APjAAAUc4+61+hUkM9E7m0yC+20UmqUEDpMp/m0zeYzsRQQp1T+JyygN
        JigOonjBZNqKWp+yglZ9+xjLPA==
X-Google-Smtp-Source: APXvYqwFBek9VnVsgN4EGGqi1nNxFt8Z4wI/xHpJb1NQ4wxHusH5uLLX8YW9xr/VCW1sE1Muy5gUqg==
X-Received: by 2002:a63:ed4a:: with SMTP id m10mr25299793pgk.99.1580785034064;
        Mon, 03 Feb 2020 18:57:14 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id e1sm22491971pfl.98.2020.02.03.18.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 18:57:13 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC][PATCHv2 07/12] videobuf2: do not sync caches when we are allowed not to
Date:   Tue,  4 Feb 2020 11:56:36 +0900
Message-Id: <20200204025641.218376-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200204025641.218376-1-senozhatsky@chromium.org>
References: <20200204025641.218376-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Skip ->prepare() or/and ->finish() cache synchronisation if
user-space requested us to do so (or when queue dma direction
permits us to skip cache syncs).

Change-Id: I37c89d666542ed8d536eac329953d921bb1c94b6
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 46be9c790ff6..c3637ca0c65b 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -304,8 +304,11 @@ static void __vb2_buf_mem_prepare(struct vb2_buffer *vb)
 {
 	unsigned int plane;
 
-	for (plane = 0; plane < vb->num_planes; ++plane)
-		call_void_memop(vb, prepare, vb->planes[plane].mem_priv);
+	if (vb->need_cache_sync_on_prepare) {
+		for (plane = 0; plane < vb->num_planes; ++plane)
+			call_void_memop(vb, prepare,
+					vb->planes[plane].mem_priv);
+	}
 	vb->synced = 1;
 }
 
@@ -317,8 +320,11 @@ static void __vb2_buf_mem_finish(struct vb2_buffer *vb)
 {
 	unsigned int plane;
 
-	for (plane = 0; plane < vb->num_planes; ++plane)
-		call_void_memop(vb, finish, vb->planes[plane].mem_priv);
+	if (vb->need_cache_sync_on_finish) {
+		for (plane = 0; plane < vb->num_planes; ++plane)
+			call_void_memop(vb, finish,
+					vb->planes[plane].mem_priv);
+	}
 	vb->synced = 0;
 }
 
-- 
2.25.0.341.g760bfbb309-goog

