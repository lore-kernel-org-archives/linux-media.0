Return-Path: <SRS0=w9vA=2H=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B664C43603
	for <linux-media@archiver.kernel.org>; Tue, 17 Dec 2019 03:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41762176D
	for <linux-media@archiver.kernel.org>; Tue, 17 Dec 2019 03:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oZeCVq/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfLQDVa (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 16 Dec 2019 22:21:30 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37212 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbfLQDV3 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 16 Dec 2019 22:21:29 -0500
Received: by mail-pj1-f67.google.com with SMTP id ep17so3907006pjb.4
        for <linux-media@vger.kernel.org>; Mon, 16 Dec 2019 19:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gLtgY/i7b05+S0YBZciCIKSTFFVYN6319xkmCCskTpQ=;
        b=oZeCVq/hPIb3xxcfajQ5UCYzJhDjrTKoI88hT6q9n5jtZhfAczWwh2b87k3RDH/L7x
         VtpK3IlBurnJzyYXucvjKhimVHVfjHzNnAP2J7W5g1XoMGLLsLf2tr5vWsanGgKjQSVN
         ZVeIy69+i79n+vQdHPu0kw/MSdgWwPmQd+yGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gLtgY/i7b05+S0YBZciCIKSTFFVYN6319xkmCCskTpQ=;
        b=EbwX1GmSDkwpDCW7ojf6f18TymoSF+uqyXZjEbTX+lwErNDdf7X9yflEf/ZklWd9Pm
         fYO9d4z4G0jxF4Qy9cZf7Dc6H+/S/FZDnTq4sg1a/N0yPgfUwfvLxWzzOcUL9jpWeelI
         bS2rrw11XpJrv5b6q+mCkbig2oQDmOjjvK96zAGO1qmNcM5scAHshPxxMylKI1V9L8Lz
         BVaS6008D13q26w36EryuhOievS0GsGTrv88bJIO5odDg/FlHNgl4gNGd0pznWCMTLdx
         Uk+Yt9hkLNe01CTCQvb+jnShBSLI7NoRjXBBSeuI28efQNzmL6B48GxaNS+rSkObtU3V
         l4yA==
X-Gm-Message-State: APjAAAWzgh1bPzUYBXIQ+8G8BpEIwjy3u53QX8lClxG4u5fvBT2iL8kv
        E+PJZ4EYHoZWgT1N2uqd2O4zHQ==
X-Google-Smtp-Source: APXvYqy9neE00p2QbLZnLgRtVcCyK+YWY7iVQlwytjfc2kPnP1pU+M0e4nObBdie3cLEqsIJ7ZArgw==
X-Received: by 2002:a17:902:fe05:: with SMTP id g5mr20418282plj.3.1576552889059;
        Mon, 16 Dec 2019 19:21:29 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id j3sm24387455pfi.8.2019.12.16.19.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 19:21:28 -0800 (PST)
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
Subject: [RFC][PATCH 13/15] videobuf2: do not sync buffers for DMABUF queues
Date:   Tue, 17 Dec 2019 12:20:32 +0900
Message-Id: <20191217032034.54897-14-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191217032034.54897-1-senozhatsky@chromium.org>
References: <20191217032034.54897-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

DMA-exporter is supposed to handle cache syncs, so we can
avoid ->prepare()/->finish() syncs from videobuf2 core for
DMABUF buffers.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/media/common/videobuf2/videobuf2-v4l2.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index 1762849288ae..2b9d3318e6fb 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -341,8 +341,22 @@ static void set_buffer_cache_hints(struct vb2_queue *q,
 				   struct vb2_buffer *vb,
 				   struct v4l2_buffer *b)
 {
-	vb->need_cache_sync_on_prepare = 1;
+	/*
+	 * DMA exporter should take care of cache syncs, so we can avoid
+	 * explicit ->prepare()/->finish() syncs.
+	 */
+	if (q->memory == VB2_MEMORY_DMABUF) {
+		vb->need_cache_sync_on_finish = 0;
+		vb->need_cache_sync_on_prepare = 0;
+		return;
+	}
 
+	/*
+	 * For other ->memory types we always need ->prepare() cache
+	 * sync. ->finish() cache sync, however, can be avoided when queue
+	 * direction is TO_DEVICE.
+	 */
+	vb->need_cache_sync_on_prepare = 1;
 	if (q->dma_dir != DMA_TO_DEVICE)
 		vb->need_cache_sync_on_finish = 1;
 	else
-- 
2.24.1.735.g03f4e72817-goog

