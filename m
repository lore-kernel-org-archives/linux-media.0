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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C38C4360F
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E582133D
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OR7/2a2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfDCWSK (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:18:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34558 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfDCWSK (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 3 Apr 2019 18:18:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id r186so5819418wmf.1
        for <linux-media@vger.kernel.org>; Wed, 03 Apr 2019 15:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SQGF3TuNF5KQ0AO+rkzzO1v78UFk3o3QLb/PiuS736c=;
        b=OR7/2a2Bg+GdNhtJ5Xww2FfSGIiMFFmv95n3XYZitoT7iQc4/S406G9CJGvmYb2hLI
         VxB2l1RLQjcRN3Vyyz6YOhb6YuAaz/Hm/oepOFtE7OoYgcbv3iJP9XEZoMwYNOSBPiZL
         tlE2gsFyCj7o51j392++sJBqs9kxluo+tapJ9KI6Z3MbaH1N7rsqNovl9dt8v/1hkHGL
         tjrwVX60u9EDOcAGtn47Zz9kKJLl+oXKcDfgMjfkc/nPJBuF2WZF2PiYJE3f8cACSi9J
         NewI8w689b495oOYAMnFyQMJ7aSqA+fGvdbqAMCMXvMw9ngoTdzavqKO3+E3vl7JB5ZE
         g/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SQGF3TuNF5KQ0AO+rkzzO1v78UFk3o3QLb/PiuS736c=;
        b=Wls/X7Od6gOt+5M6Y6aY7keD2DZ8wAEZUynJ+i77TL9Od70Phcxj2Cr95xEd9NG8SB
         5JLkfA8MQ+eXrQtI0kJWKfgtGx/wXoAmoUt17ksGkkQO1kuJReb3HAlVgQVBl+9GcaAj
         cGWGxo84+Lx6Sb/BO6aN99oVKeDdlblWqsuDn8EjWdBg5EO4G+uANgSTrMnXX2DPnKcq
         UWAUTFML6XFSnoqHZ2ot5lgxpBwOm/FwBLVae0rRD7LHB6dRhlhV/0Z3/tuyck4F+N+S
         llrgmVDOHBHTOybj6QZ9CQdEwdiXp+uuRrOLJXaQOIiDpCqEcfzkMEKwxFyz5EL7eCXB
         0d8Q==
X-Gm-Message-State: APjAAAWRIqqmmmk9TjvZ4dvqSiWWNAKeuMQpREQSke7owOI3TnHfdEbP
        VyUUfQSVl/Q9tfFih5s2+iU=
X-Google-Smtp-Source: APXvYqxIOBa8FHBEABikwi1OVgv/83p6eKeiAM6qx3ow84u8ZhxHZABt+/peayl/dJBIjFMOySsGfw==
X-Received: by 2002:a1c:804c:: with SMTP id b73mr1536949wmd.116.1554329889070;
        Wed, 03 Apr 2019 15:18:09 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id d6sm26019552wrx.62.2019.04.03.15.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 15:18:08 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     dafna3@gmail.com, linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH v2 01/16] videobuf2-v4l2: set last_buffer_dequeued in dqbuf
Date:   Wed,  3 Apr 2019 15:14:46 -0700
Message-Id: <20190403221501.32814-2-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403221501.32814-1-dafna3@gmail.com>
References: <20190403221501.32814-1-dafna3@gmail.com>
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

