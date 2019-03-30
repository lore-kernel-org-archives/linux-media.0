Return-Path: <SRS0=IMFm=SB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68754C43381
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3131E218EA
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7ZhUAF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbfC3Upu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 30 Mar 2019 16:45:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33763 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730638AbfC3Upt (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 30 Mar 2019 16:45:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so6863703wrp.0
        for <linux-media@vger.kernel.org>; Sat, 30 Mar 2019 13:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bayHuOHVijRq9U7RUSlwkjRfnmoMGM8I+vgGhlExcdo=;
        b=T7ZhUAF6VETuK9EeG3ChAUeTQS0pvkxo+ulOJ9W5jrJYb7CW6bWtKYwBpNbjf6vQ3o
         5iePV4gBkV7n49k3tm5OhLmwe+JNPzBInDohkIzz+ii6wytG5t2b8o3UDfuxNsBXfIfb
         pTaFSwSfSFMZZRGlkB06N4G13LlGuACuvVBnEr31ODgp5Qb1WjgzZEpiV5FSPogxAEPZ
         7rJP2M4mC3u52wpoJXTbgJqdzC0jSSeyO51UPiMEasOkeEwbi4xgcYJw6IdP++m4FD/c
         q+idnm+lJOC/PRoLIN7g2YA1kqcfdCuXQMHUuOqq37098mEuGAFUEyxBfFiSQG+IPhme
         iriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bayHuOHVijRq9U7RUSlwkjRfnmoMGM8I+vgGhlExcdo=;
        b=SCtdBSKgCA175rWPaCKLAHVMB930Lk8T5AkmFSO73ov8xKZt3quVgIYn5l8XNdqSxS
         Ct4Oqj4rzxcivN9AUiOsg4+f/4fgCpfcuvzxbDJCNktMjXBPXufU65N6cquh2uxcXGsE
         vx/CXSA8v9G0RvCjkO/enwq+qsULrO6zOhTj6oTEu+Z6Ap9ukzu5x4HERNOqy8xumZw4
         pmyofufUTAITLacg5oXNxUjpzdY+wUMPU55rvR0gRG4PB+Z4yGgSheV9fXIea1nUNKlM
         cGNBzbKT6wwUD61hUZ6dD5eSi4EObLqkUwV3QZqcqYb/jenNj/xYUcCoU+zIbgkIMKiG
         uQHw==
X-Gm-Message-State: APjAAAU3EdyqqryjoiNDGHsZbP0M7dg2+R+gkfJKVE5LCAL3x/+8L9GU
        Mohsh+x9BGfxRMiMGYT5qpguHFT/HA0=
X-Google-Smtp-Source: APXvYqzJ3UQ8rWxn5uQTcc5eFxXczBSUGhaj7X3iS5DjWqH33h3Q6ffp1SHFgRYuPUSo2WkTgpKCIQ==
X-Received: by 2002:adf:ea43:: with SMTP id j3mr33921317wrn.210.1553978747702;
        Sat, 30 Mar 2019 13:45:47 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id a9sm5903671wmb.30.2019.03.30.13.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 13:45:47 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 04/14] vicodec: add V4L2_CID_MIN_BUFFERS_FOR_OUTPUT
Date:   Sat, 30 Mar 2019 13:43:02 -0700
Message-Id: <20190330204311.107417-5-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190330204311.107417-1-dafna3@gmail.com>
References: <20190330204311.107417-1-dafna3@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

The stateful encoder requires the presence of this control.
Since a single buffer is sufficient for vicodec, we just
set this control to 1.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/platform/vicodec/vicodec-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index 3b5124838f15..b0c1d7cd1db6 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -1841,13 +1841,16 @@ static int vicodec_open(struct file *file)
 	file->private_data = &ctx->fh;
 	ctx->dev = dev;
 	hdl = &ctx->hdl;
-	v4l2_ctrl_handler_init(hdl, 4);
+	v4l2_ctrl_handler_init(hdl, 5);
 	v4l2_ctrl_new_std(hdl, &vicodec_ctrl_ops, V4L2_CID_MPEG_VIDEO_GOP_SIZE,
 			  1, 16, 1, 10);
 	v4l2_ctrl_new_std(hdl, &vicodec_ctrl_ops, V4L2_CID_FWHT_I_FRAME_QP,
 			  1, 31, 1, 20);
 	v4l2_ctrl_new_std(hdl, &vicodec_ctrl_ops, V4L2_CID_FWHT_P_FRAME_QP,
 			  1, 31, 1, 20);
+	if (ctx->is_enc)
+		v4l2_ctrl_new_std(hdl, &vicodec_ctrl_ops,
+				  V4L2_CID_MIN_BUFFERS_FOR_OUTPUT, 1, 1, 1, 1);
 	if (ctx->is_stateless)
 		v4l2_ctrl_new_custom(hdl, &vicodec_ctrl_stateless_state, NULL);
 	if (hdl->error) {
-- 
2.17.1

