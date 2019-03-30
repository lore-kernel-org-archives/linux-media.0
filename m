Return-Path: <SRS0=IMFm=SB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930DBC43381
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614092146F
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6fKQ4T+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbfC3Upz (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 30 Mar 2019 16:45:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33469 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730582AbfC3Upy (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 30 Mar 2019 16:45:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id z6so12323759wmi.0
        for <linux-media@vger.kernel.org>; Sat, 30 Mar 2019 13:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ipl0X4aaYv/pXuihFjKw94Dv3xhE72Uxyvxo+HMZb9k=;
        b=T6fKQ4T+GmEtgbtqCPbYWE+bS0qX4qP0+UZ7tPmNAKslp4ZMAABDUZCHiGvfoTdNdE
         +CBI3/ebdgZpFeLXu3fCOguxK1x0m+OINjgCCCONS95JVyVfMxdwuyn9q9B2bVcX3baj
         HWqBSJV7l2nO5R6Vd1bt7Ug/0WK19RhjjErW7tdLpP+yTG0EkPWvyMU/utPOf+gWuip5
         LUj/Ey+seX5mw3ZOTLiFQx2UR5HpaTh6mVZAbHKoeDBA6WJC35jrSVV1KZ6oY5VO+HzE
         ugjMDmRG77OKrhscqNEWNsD/NTrEa/cYyfgW31Cp58OkGQgE0zF/iBHC63fhil0lh4rO
         hmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ipl0X4aaYv/pXuihFjKw94Dv3xhE72Uxyvxo+HMZb9k=;
        b=MwY1GYJkHC3S1eyCTOsKQO2xZi5fYRgaG4lTrgT7+tHSjbpPbW1FtDOsjA0FcuwTUz
         bIo2mMK5k2hD0FhCM+EKwuui6o3p7sZX+4xY/yFYyDenHkSPrkE56AxlMlDAk05xzS9J
         FrL00dU70vVMYZPxgjeDOaPZbVchiN51JdEIASyBSw47tD8XnwXOCDSK5GH88d1STqkc
         QGdCaXfzj0KBOfkG/UnYeq90+Ytzk602Jw0sQw0wWm768L9dO4mHHzQvixZh7rUB5w+6
         LwrJkNlUwSWKQIDXm8RzLy/GgVuEyWg/NpQ0cBdhhtYxzTTrkqadt5g+8IhlEADrLG2y
         GUog==
X-Gm-Message-State: APjAAAXJVkqvsXCBO1tnhE1roCDGvouw2LyIzD0O5oIZZTgi/Wb9W7dX
        Bo8ldD3yfTXQ/zaZt1ZR975+aq0Xi3g=
X-Google-Smtp-Source: APXvYqzDzQfiTuB1s2sC9e3XR829vvmU4UWIipOdpApplp09tussVqgKtdQdX7X+hCvg2lo0NFr33A==
X-Received: by 2002:a1c:9c14:: with SMTP id f20mr7690284wme.16.1553978751934;
        Sat, 30 Mar 2019 13:45:51 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id a9sm5903671wmb.30.2019.03.30.13.45.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 13:45:51 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 08/14] vicodec: fix vicodec_buf_queue()
Date:   Sat, 30 Mar 2019 13:43:06 -0700
Message-Id: <20190330204311.107417-9-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190330204311.107417-1-dafna3@gmail.com>
References: <20190330204311.107417-1-dafna3@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Only set first_source_change_sent for decoders.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/platform/vicodec/vicodec-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index 7e4ac412cc38..ba327512e085 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -1521,7 +1521,8 @@ static void vicodec_buf_queue(struct vb2_buffer *vb)
 	 * handled in job_ready
 	 */
 	if (vb2_is_streaming(vq_cap) && vb2_is_streaming(vq_out)) {
-		ctx->first_source_change_sent = true;
+		if (!ctx->is_enc)
+			ctx->first_source_change_sent = true;
 		v4l2_m2m_buf_queue(ctx->fh.m2m_ctx, vbuf);
 		return;
 	}
-- 
2.17.1

