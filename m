Return-Path: <SRS0=KukI=SG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC94C4360F
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 14:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BDD20855
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 14:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Amb59a4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfDDO4w (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:56:52 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:35202 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbfDDO4w (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 4 Apr 2019 10:56:52 -0400
Received: by mail-yw1-f74.google.com with SMTP id w6so2160934ywd.2
        for <linux-media@vger.kernel.org>; Thu, 04 Apr 2019 07:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Pr94i6yTF3Wq8OIE6rzOEsnknSKW6XtOUOJJcL/bBes=;
        b=Amb59a4wSxvwz/dj3jUYSFVdXLHyILy+IOD7sBWKebOkN3vj/G+Hlcp2QUfz9D7+VG
         bxnRGNPLva9icDs7W3NBYtdShwNAVrd50/42KKI7rNzPAt1x1fx95Fqu0dd+6DaL4h5Z
         +m7IRXIUsusvZ0CpdpT0/yKoiPCQ7jow5KptTQ2NVPNMkE6/Q+rK6WH0EuSmaKHpX0Rf
         q8cXDsPzQghC1lMT16Jb/lwHGSoElK0vX63wTCHVDRjaw+Etnlp96WJEV7QW6J63GyT2
         CJ7Lk9HGPeWv9QZdPjQ8WYXlKTwQ+lbQLqFQKXarVdSdZLe25TWklMiri3P7wb4By+Dk
         fHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Pr94i6yTF3Wq8OIE6rzOEsnknSKW6XtOUOJJcL/bBes=;
        b=WAg552YATO0Ruddj+cJIM+ISbPsRGXHNPpsbFycvnhHvtOX7HPAsYVrhYKyMqg8OnO
         ItVB7EaYIltG4J2uC8DfwWIFe04b5R/ARgMgIkshbLUZ4tYZFoJGgHE1pBKZI6Ylu/r7
         XtqVazXBEtRpRrVnNxODw5F3Evp4ItAlcFHvAWRVdg4+/zHVkHmdRi7ZPZ9JBP2zDXsd
         xegQc3aT7p55ItRcRmb6FRnlu5++rH+Vlo0W7gFx9baUjqI8jlCdsNCxAdiZXn9a3bI3
         sDm9TDqk4VgMUPdHAjS66IP/o46k1VItLhFy+b0Sau/nt+WAEafeOZGq0SGLltQ30baW
         tQaA==
X-Gm-Message-State: APjAAAUZhzIkMFQmzuGpiGsqZnObHJnUSlqx7lv+XfHX4sEfJtzwwps2
        bQJB7xyCs2FIpQCJSl/DZr9/wpAwyLo=
X-Google-Smtp-Source: APXvYqwEArvZu+NjxLMZdNlGgzvVG2/uv+aUsYDtZ89PrgRIiiJ2aaQo2xFab8oEZKsGlo4ouPQxjmCZQdQ=
X-Received: by 2002:a81:574a:: with SMTP id l71mr1359637ywb.23.1554389811321;
 Thu, 04 Apr 2019 07:56:51 -0700 (PDT)
Date:   Thu,  4 Apr 2019 16:56:46 +0200
Message-Id: <20190404145646.107022-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] media: vivid: use vfree() instead of kfree() for dev->bitmap_cap
From:   Alexander Potapenko <glider@google.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

syzkaller reported crashes on kfree() called from
vivid_vid_cap_s_selection(). This looks like a simple typo, as
dev->bitmap_cap is allocated with vzalloc() throughout the file.

Signed-off-by: Alexander Potapenko <glider@google.com>
Tested-by: Alexander Potapenko <glider@google.com>
Reported-by: syzbot+6c0effb5877f6b0344e2@syzkaller.appspotmail.com
Fixes: ef834f7836ec0 ("[media] vivid: add the video capture and output
parts")
---
 drivers/media/platform/vivid/vivid-vid-cap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/vivid/vivid-vid-cap.c b/drivers/media/platform/vivid/vivid-vid-cap.c
index 52eeda624d7e..530ac8decb25 100644
--- a/drivers/media/platform/vivid/vivid-vid-cap.c
+++ b/drivers/media/platform/vivid/vivid-vid-cap.c
@@ -1007,7 +1007,7 @@ int vivid_vid_cap_s_selection(struct file *file, void *fh, struct v4l2_selection
 		v4l2_rect_map_inside(&s->r, &dev->fmt_cap_rect);
 		if (dev->bitmap_cap && (compose->width != s->r.width ||
 					compose->height != s->r.height)) {
-			kfree(dev->bitmap_cap);
+			vfree(dev->bitmap_cap);
 			dev->bitmap_cap = NULL;
 		}
 		*compose = s->r;
-- 
2.21.0.392.gf8f6787159e-goog

