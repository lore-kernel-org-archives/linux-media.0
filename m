Return-Path: <SRS0=VKxf=3Y=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AA6C3524D
	for <linux-media@archiver.kernel.org>; Tue,  4 Feb 2020 02:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312FA2084E
	for <linux-media@archiver.kernel.org>; Tue,  4 Feb 2020 02:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bvNna1e6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgBDC5V (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 3 Feb 2020 21:57:21 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36837 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgBDC5S (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 3 Feb 2020 21:57:18 -0500
Received: by mail-pl1-f195.google.com with SMTP id a6so6651006plm.3
        for <linux-media@vger.kernel.org>; Mon, 03 Feb 2020 18:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1pXTWkZoMBIf1iKBkXLSAWapvVeX9VPPX3FIrIBSBVo=;
        b=bvNna1e6NxD9FZJneV6BaVLd7xK66kO+n4o1HRdkwGa/lOtkLP8+vWFybesFggnBPz
         /QZc+YoCBP0xZDz/bpxih4eEIOQbA2H/ivUeH+ZcgGaVzXMp6G2/ILwOuPksAR5X/Sgf
         gAf5jCoAkm+1nZN19uQ+hRL4PbJ19Rzk6nTYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1pXTWkZoMBIf1iKBkXLSAWapvVeX9VPPX3FIrIBSBVo=;
        b=re/CoRB/jzvb3RAWhtPMgA4/HkwUNNzzgrkwxze+YXKMmheR300vKUpe9Vgp1ZeEJN
         bV6HVOgyFE8G0BQZFNXIxnwn8qC8qZfPBOKHxIzEAHyhvw/HvuFtPLcduaRofT5XhH84
         fmOig09llenHbHPSeva63RKYujEY/eKhSHRboOoUvXyMjoR0h7Yn2ISdDgbhngzkunVf
         43c8OpLKNrNxqJmFesnGXqpDoGamIkYvnErKgU+rgjAM+mmC8FKlKr2JQTHJAiJ0ar2r
         thVDBIJPgEgQaRpB8CAK2SXOTAZ0cOqLBbMjYjaSB8+KVlwj6Cr5hOGqWH39inUKW34I
         1wOg==
X-Gm-Message-State: APjAAAW5MQWGw0qAmfdo6X3dxPI6+cu+nbOuDc+Zw9oA+ihnErtEwQL3
        ExGBJCrhI7Z0X1cPyxOq3lE2GEjwkiMM1w==
X-Google-Smtp-Source: APXvYqzDTARrYg6qPArxaStR0lWXrAEmWXTgHZRpYxBMYcpQMiClm40tAMEKMl7YxvXoCxGbDUKgRQ==
X-Received: by 2002:a17:902:8545:: with SMTP id d5mr25714862plo.116.1580785037637;
        Mon, 03 Feb 2020 18:57:17 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id e1sm22491971pfl.98.2020.02.03.18.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 18:57:17 -0800 (PST)
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
Subject: [RFC][PATCHv2 08/12] videobuf2: check ->synced flag in prepare() and finish()
Date:   Tue,  4 Feb 2020 11:56:37 +0900
Message-Id: <20200204025641.218376-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200204025641.218376-1-senozhatsky@chromium.org>
References: <20200204025641.218376-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This simplifies the code a tiny bit and let's us to avoid
unneeded ->prepare()/->finish() calls.

Change-Id: Ia7c8b4d75a72d0fe1bf37382780e173f6dd9b7ff
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index c3637ca0c65b..631667db7094 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -304,6 +304,9 @@ static void __vb2_buf_mem_prepare(struct vb2_buffer *vb)
 {
 	unsigned int plane;
 
+	if (vb->synced)
+		return;
+
 	if (vb->need_cache_sync_on_prepare) {
 		for (plane = 0; plane < vb->num_planes; ++plane)
 			call_void_memop(vb, prepare,
@@ -320,6 +323,9 @@ static void __vb2_buf_mem_finish(struct vb2_buffer *vb)
 {
 	unsigned int plane;
 
+	if (!vb->synced)
+		return;
+
 	if (vb->need_cache_sync_on_finish) {
 		for (plane = 0; plane < vb->num_planes; ++plane)
 			call_void_memop(vb, finish,
@@ -1991,8 +1997,7 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
 				call_void_vb_qop(vb, buf_request_complete, vb);
 		}
 
-		if (vb->synced)
-			__vb2_buf_mem_finish(vb);
+		__vb2_buf_mem_finish(vb);
 
 		if (vb->prepared) {
 			call_void_vb_qop(vb, buf_finish, vb);
-- 
2.25.0.341.g760bfbb309-goog

