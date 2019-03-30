Return-Path: <SRS0=IMFm=SB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5277C4360F
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 21:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B325D21773
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 21:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2HQ+W6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbfC3Vge (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 30 Mar 2019 17:36:34 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:46336 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730563AbfC3Vgd (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 30 Mar 2019 17:36:33 -0400
Received: by mail-wr1-f51.google.com with SMTP id t17so6887456wrw.13
        for <linux-media@vger.kernel.org>; Sat, 30 Mar 2019 14:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aFvF0Q4D0PukKPG4/XfOrovojL53MxWzXeQyHZKZkVo=;
        b=d2HQ+W6skQ44Ua6xNlKENMqJXrRxBl3XzaHJfuWWGx3g/DKyuSkRMZYkvHl9VgQGjC
         6VTu32uUf1VAsrUiCOVNVB8aQS0g9G2AWh+wCzoHFHILfo6Ia5oSaxTDDS44FSeDBVUB
         lwvlICVk6aCyvHn4POHOZ4khWnHC1tCV4di52JzNKUGsL6vYyaB3HSl6XzqkKawwt45e
         guJbP5dkf1oxei2pcpkIhClLsJLlENvLQUqwjF28H+CnHMTmUsxGhGkmCrkP7jtaXRYV
         VfDuFLerZRz5CJ5F7ubzTBIH3w/VvqtIR9ECQI9V2xFlRD4sqXTEbKi9qF+0FtKcuXfL
         v29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aFvF0Q4D0PukKPG4/XfOrovojL53MxWzXeQyHZKZkVo=;
        b=Du9bT8uRLi3enXyJk29Xa1H1O8N5djL149N9GXzCd5gpqUWKYTNQFGM7wxmqwwp8tq
         yHZRVvZqimsizBRtE+/c+qbiRZX+TqjGeGNo5vBN5IxAVGkLQhnv3tjLwynI9ayyHhUh
         Nq7ZyI72jb8Y09+jMCAPasBHcSSxXpknfEcu3Et99pL15JtNAdd6L2gSzlbKkF1uwMH4
         lDQE0FD0EGTLHFusHSwBTN4vohtgIrSFEAD2zs2gW6eWp5vKnC1MrlMu0C3YeGFwVpks
         r5HCBQMsY60UmpiyuRoEELaQNqFcLcIz+UyF0ue8UTToSeaLEKQHuAQhuW4uTky42HmM
         1KLg==
X-Gm-Message-State: APjAAAVLD+yoI0vhW+YIymQoSsoGiW34iG/pxlhE18t+Y/wFb70pnpal
        /tRaOI3iyUPGFeVUyw9XFyZ5fjuexJ4=
X-Google-Smtp-Source: APXvYqymnSDtIviVxxJ/vscpd6r+JQivreGHeYvxorWFtyM9cNLy28BSSnV1/D8NmfrO/H+Qa6YMow==
X-Received: by 2002:a5d:4d42:: with SMTP id a2mr38327832wru.130.1553981791894;
        Sat, 30 Mar 2019 14:36:31 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id s10sm6066144wmh.0.2019.03.30.14.36.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 14:36:31 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Dafna Hirschfeld <dafna3@gmail.com>
Subject: [PATCH v4l-utils 2/3] v4l2-ctl: fix debug prints
Date:   Sat, 30 Mar 2019 14:33:40 -0700
Message-Id: <20190330213341.107939-2-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190330213341.107939-1-dafna3@gmail.com>
References: <20190330213341.107939-1-dafna3@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

replace 'set_fwht_ext_ctrls' with 'set_fwht_ext_ctrl'
in debug prints

Signed-off-by: Dafna Hirschfeld <dafna3@gmail.com>
---
 utils/v4l2-ctl/v4l2-ctl-streaming.cpp | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/utils/v4l2-ctl/v4l2-ctl-streaming.cpp b/utils/v4l2-ctl/v4l2-ctl-streaming.cpp
index 28bc8c68..daa93968 100644
--- a/utils/v4l2-ctl/v4l2-ctl-streaming.cpp
+++ b/utils/v4l2-ctl/v4l2-ctl-streaming.cpp
@@ -1249,7 +1249,7 @@ static int do_setup_out_buffers(cv4l_fd &fd, cv4l_queue &q, FILE *fin, bool qbuf
 
 			if (set_fwht_ext_ctrl(fd, &last_fwht_hdr, last_fwht_bf_ts,
 					      buf.g_request_fd())) {
-				fprintf(stderr, "%s: set_fwht_ext_ctrls failed on %dth buf: %s\n",
+				fprintf(stderr, "%s: set_fwht_ext_ctrl failed on %dth buf: %s\n",
 					__func__, i, strerror(errno));
 				return QUEUE_ERROR;
 			}
@@ -1539,7 +1539,7 @@ static int do_handle_out(cv4l_fd &fd, cv4l_queue &q, FILE *fin, cv4l_buffer *cap
 
 		if (set_fwht_ext_ctrl(fd, &last_fwht_hdr, last_fwht_bf_ts,
 				      buf.g_request_fd())) {
-			fprintf(stderr, "%s: set_fwht_ext_ctrls failed: %s\n",
+			fprintf(stderr, "%s: set_fwht_ext_ctrl failed: %s\n",
 				__func__, strerror(errno));
 			return QUEUE_ERROR;
 		}
-- 
2.17.1

