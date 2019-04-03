Return-Path: <SRS0=djxu=SF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC16AC10F06
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7935320882
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIYFKvnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfDCWSM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:18:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40376 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfDCWSM (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 3 Apr 2019 18:18:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so664208wmi.5
        for <linux-media@vger.kernel.org>; Wed, 03 Apr 2019 15:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/mdSvbwVZIpZIZzlf5bj5jBFsCqVjD3mBJ1uu40zFq0=;
        b=cIYFKvnOf1XhWwc/iSILDJOb6JW0i748qGDvuMbdXwQnwXDZCNsB699ShbvNUy1Xzo
         qyg5GNZWhLm0OqMLdpTfN7DT0hdAtCwSh7lxx0wWnYgnK/06EyJMDpn78Ip7gzrOkMwG
         2FRj3p14F5E7EdHshK4qEXeesWtlpBvABIKNXZ7m5PQAU3QB0E2SmGwhKyCXUVgbgZ9N
         KHSyNfQzhCUHLX2LNl4F9NUt+n5kHjwa2qIhW8KIZ7i71gN4z/KtaAxyUMRiF4fC1WDC
         3X8U4vUy+XNQtI4ma9L/QgYac1E7IYTD5BwdAjzaFkxecEH+9oYzCytTjGCtEdmpTIG8
         lPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/mdSvbwVZIpZIZzlf5bj5jBFsCqVjD3mBJ1uu40zFq0=;
        b=QpFAeht9St3xzE/h9XA9XosCf3XLaIcDZx7i+pxBaar96gRZdxtGT5XKrWPBruK3vI
         yrAomoTOv4dupHFDEjJqrLqPCb3l9J2UCtU6/rFv/tj4VFv8V2K7M/uJhZ+a/smp9bn1
         gRSifFJgC1xOb5Xwp75O448pSSVGgHDquvWjwzb/WqoabRZrHQtK353lN1m94MGdkkdy
         ax/yMhe6JVenLfawdfxpWHu2deMjxj97sDVWBFDOfP7Rs0Vua/aJIslxBCQtAQyMf2Sv
         ix7Rc4/enjZBn4SzOteDjalPnwbAJnyV7MUl1BIrRJ8Vy2mPkRjRd8M90MSm4DEll3Fw
         xtvA==
X-Gm-Message-State: APjAAAVT24rvB9rqyvR5YEOp+6n+g1zZjyDRMQLefVjbbSAJDEWetYsz
        +GmBKpM8eGhqg0NZu8TgxNY=
X-Google-Smtp-Source: APXvYqwomsLMXoOnpLmC5lPXUGi52B7mLyYDSl3UntpZXrZeH5lXvKQLHwh6onMj38fLtu9Zdmaoxg==
X-Received: by 2002:a1c:f10f:: with SMTP id p15mr1598400wmh.27.1554329890278;
        Wed, 03 Apr 2019 15:18:10 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id d6sm26019552wrx.62.2019.04.03.15.18.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 15:18:09 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     dafna3@gmail.com, linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH v2 02/16] vicodec: move v4l2_ctrl_request_complete after spin_unlock
Date:   Wed,  3 Apr 2019 15:14:47 -0700
Message-Id: <20190403221501.32814-3-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403221501.32814-1-dafna3@gmail.com>
References: <20190403221501.32814-1-dafna3@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

v4l2_ctrl_request_complete can sleep, so can't be called while
a spinlock is held.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/platform/vicodec/vicodec-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index bd01a9206aa6..92647f02fc49 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -442,14 +442,14 @@ static void device_run(void *priv)
 		ctx->comp_has_next_frame = false;
 	}
 	v4l2_m2m_buf_done(dst_buf, state);
-	if (ctx->is_stateless && src_req)
-		v4l2_ctrl_request_complete(src_req, &ctx->hdl);
 
 	ctx->comp_size = 0;
 	ctx->header_size = 0;
 	ctx->comp_magic_cnt = 0;
 	ctx->comp_has_frame = false;
 	spin_unlock(ctx->lock);
+	if (ctx->is_stateless && src_req)
+		v4l2_ctrl_request_complete(src_req, &ctx->hdl);
 
 	if (ctx->is_enc)
 		v4l2_m2m_job_finish(dev->stateful_enc.m2m_dev, ctx->fh.m2m_ctx);
-- 
2.17.1

