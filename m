Return-Path: <SRS0=IMFm=SB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0806C43381
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 21:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB6B21773
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 21:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCK8jzR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbfC3Vgf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 30 Mar 2019 17:36:35 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:32797 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730395AbfC3Vgf (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 30 Mar 2019 17:36:35 -0400
Received: by mail-wr1-f48.google.com with SMTP id q1so6949880wrp.0
        for <linux-media@vger.kernel.org>; Sat, 30 Mar 2019 14:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gg0RoNdHzgiz8shIEh3iitwCcykj9Z0AcA1mVIWiVfs=;
        b=pCK8jzR2/N304y/hjmub6sXlMOUzJCLTffbywAXdYaVyymY5ZbZm7UPdmenE3r7FMl
         GCFcOmtddkt8MPjDXcl86RgK3ScbE4uQQdAW8JkFKYpH75pAwYOC8lVoREHfVwSeL4fy
         gsoz/NWala9bmk+5a3w3yaEUnI4woENnxGThzBWMZXpjKjn+5W6I1W8/dOwV8iyvAdXC
         ogweyHdDWT2HsfwLMG+l4jnj+yxVoXmFuW/RRa93Vo5fCxDnji6bhDCW5QtrCxDl86Vv
         QE2z1Hng5Es+5gOR+uVV2aZ0DBUNGC8ow2Cr5EoXYQQ2UYe2+Qu24uQka7iWOcNTi7dK
         6QhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gg0RoNdHzgiz8shIEh3iitwCcykj9Z0AcA1mVIWiVfs=;
        b=KfKfpazdli8hqbNjUtWLW7HAEhuoHtgOddC6x80iemTbr4xTRQT3E63WxQNpDPwHJG
         Hc4WPFM0NIwD+QLAkg983Y8EEexhjAlf8xxK7wPJ5V7VyxAdlyk51GnCamKUCup7WLE5
         0yvgP9+G/IhLlw7sdROhazN2ZaAh0OoYl497Grj+sB0S+lskGaVLPg+M3WsFbf4goG/K
         rRUJnKjVwxyTyggsJbE3HmTJFL48Y483DaVjBKSLqwELCTbW0iWQQI9q2gFhBI9f2Uwr
         I1X6nzGHYUFvcqzdhoX5QAJjZM0WqL14hmJy9uVZIRXX6UPRRF3PZe2Bct9DtDANnKoT
         IEQA==
X-Gm-Message-State: APjAAAUle702bHpbSW9/ENfbqE57FT5iYynCOTD6GK3SrABKYQvgpfiX
        N5ZAhkRhhTsUIOIFb+cL8TlhAv5Usa8=
X-Google-Smtp-Source: APXvYqyibO2BbuPfjVGrALjzsG9qf2j/BI/bsvMHZc0Zo8QfeBqkiUE/SMXtYSOtcAnjL9it3vwekA==
X-Received: by 2002:adf:c7c8:: with SMTP id y8mr38855589wrg.149.1553981792944;
        Sat, 30 Mar 2019 14:36:32 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id s10sm6066144wmh.0.2019.03.30.14.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 14:36:32 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Dafna Hirschfeld <dafna3@gmail.com>
Subject: [PATCH v4l-utils 3/3] v4l2-ctl: add support for fwht stateless decoder
Date:   Sat, 30 Mar 2019 14:33:41 -0700
Message-Id: <20190330213341.107939-3-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190330213341.107939-1-dafna3@gmail.com>
References: <20190330213341.107939-1-dafna3@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

adjust the code to support both encoder and decoder
for stateless fwht

Signed-off-by: Dafna Hirschfeld <dafna3@gmail.com>
---
 utils/v4l2-ctl/v4l2-ctl-streaming.cpp | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/utils/v4l2-ctl/v4l2-ctl-streaming.cpp b/utils/v4l2-ctl/v4l2-ctl-streaming.cpp
index daa93968..0d3c89ef 100644
--- a/utils/v4l2-ctl/v4l2-ctl-streaming.cpp
+++ b/utils/v4l2-ctl/v4l2-ctl-streaming.cpp
@@ -82,6 +82,7 @@ static unsigned int composed_height;
 static bool support_cap_compose;
 static bool support_out_crop;
 static bool in_source_change_event;
+static bool is_stateless;
 
 static __u64 last_fwht_bf_ts;
 static fwht_cframe_hdr last_fwht_hdr;
@@ -1234,7 +1235,7 @@ static int do_setup_out_buffers(cv4l_fd &fd, cv4l_queue &q, FILE *fin, bool qbuf
 		if (fin && !fill_buffer_from_file(fd, q, buf, fmt, fin))
 			return QUEUE_STOPPED;
 
-		if (fmt.g_pixelformat() == V4L2_PIX_FMT_FWHT_STATELESS) {
+		if (is_stateless) {
 			int media_fd = mi_get_media_fd(fd.g_fd());
 
 			if (media_fd < 0) {
@@ -1268,7 +1269,7 @@ static int do_setup_out_buffers(cv4l_fd &fd, cv4l_queue &q, FILE *fin, bool qbuf
 				if (!--stream_count)
 					return QUEUE_STOPPED;
 		}
-		if (fmt.g_pixelformat() == V4L2_PIX_FMT_FWHT_STATELESS) {
+		if (is_stateless) {
 			set_fwht_req_by_idx(i, &last_fwht_hdr,
 					    last_fwht_bf_ts, buf.g_timestamp_ns());
 			last_fwht_bf_ts = buf.g_timestamp_ns();
@@ -1530,7 +1531,7 @@ static int do_handle_out(cv4l_fd &fd, cv4l_queue &q, FILE *fin, cv4l_buffer *cap
 				       (u8 *)q.g_dataptr(buf.g_index(), j));
 	}
 
-	if (fmt.g_pixelformat() == V4L2_PIX_FMT_FWHT_STATELESS) {
+	if (is_stateless) {
 		if (ioctl(buf.g_request_fd(), MEDIA_REQUEST_IOC_REINIT, NULL)) {
 			fprintf(stderr, "Unable to reinit media request: %s\n",
 				strerror(errno));
@@ -1551,7 +1552,7 @@ static int do_handle_out(cv4l_fd &fd, cv4l_queue &q, FILE *fin, cv4l_buffer *cap
 		fprintf(stderr, "%s: failed: %s\n", "VIDIOC_QBUF", strerror(errno));
 		return QUEUE_ERROR;
 	}
-	if (fmt.g_pixelformat() == V4L2_PIX_FMT_FWHT_STATELESS) {
+	if (is_stateless) {
 		if (!set_fwht_req_by_fd(&last_fwht_hdr, buf.g_request_fd(), last_fwht_bf_ts,
 					buf.g_timestamp_ns())) {
 			fprintf(stderr, "%s: request for fd %d does not exist\n",
@@ -2392,7 +2393,12 @@ static void stateless_m2m(cv4l_fd &fd, cv4l_queue &in, cv4l_queue &out,
 	unsigned count[2] = { 0, 0 };
 	int fd_flags = fcntl(fd.g_fd(), F_GETFL);
 	bool stopped = false;
+	enum codec_type codec_type = get_codec_type(fd);
 
+	if (codec_type == ENCODER) {
+		last_fwht_hdr.width = htonl(cropped_width);
+		last_fwht_hdr.height = htonl(cropped_height);
+	}
 	if (out.reqbufs(&fd, reqbufs_count_out)) {
 		fprintf(stderr, "%s: out.reqbufs failed\n", __func__);
 		return;
@@ -2576,7 +2582,9 @@ static void streaming_set_m2m(cv4l_fd &fd, cv4l_fd &exp_fd)
 		if (out.export_bufs(&exp_fd, exp_fd.g_type()))
 			goto done;
 	}
-	if (fmt[OUT].g_pixelformat() == V4L2_PIX_FMT_FWHT_STATELESS)
+	is_stateless = fmt[OUT].g_pixelformat() == V4L2_PIX_FMT_FWHT_STATELESS ||
+		       fmt[CAP].g_pixelformat() == V4L2_PIX_FMT_FWHT_STATELESS;
+	if (is_stateless)
 		stateless_m2m(fd, in, out, file[CAP], file[OUT], fmt[CAP], fmt[OUT], exp_fd_p);
 	else
 		stateful_m2m(fd, in, out, file[CAP], file[OUT], fmt[CAP], fmt[OUT], exp_fd_p);
-- 
2.17.1

