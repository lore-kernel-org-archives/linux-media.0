Return-Path: <SRS0=IMFm=SB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57032C43381
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 21:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8802082C
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 21:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFaYLXsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbfC3VoL (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 30 Mar 2019 17:44:11 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:33122 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730582AbfC3VoL (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 30 Mar 2019 17:44:11 -0400
Received: by mail-wr1-f54.google.com with SMTP id q1so6962998wrp.0
        for <linux-media@vger.kernel.org>; Sat, 30 Mar 2019 14:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gg0RoNdHzgiz8shIEh3iitwCcykj9Z0AcA1mVIWiVfs=;
        b=SFaYLXsue6G96cgOmb60/8N0QCzdPsqPTA/js9wLwokRaJrYXodmlzgv/kNkmHjrQN
         RN5kjrn1v5xQBuPqFbeqa5DHgIXacC4z1JG1aJjLa3wTyIox/zLjbH+A+hlNmqYsNPiX
         Av2PiyGJbFEUJKGwZBnXKOzQb3Vzye1/rNii/6l8nd0dGkhU048EAK876nUzlBmdN3T7
         WYISMlxNIzSlduoeHzkQo3mGJTMQ/UikWLUjV39Awcx9e44Ji7bQ9cLvJ39mJuYzktyf
         zn6+h0yxOP213s40lsUrbqjw9kewu1wOCR5QHD7Gy2MccZxRUuyw2QZpP7sYADphtu/q
         u8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gg0RoNdHzgiz8shIEh3iitwCcykj9Z0AcA1mVIWiVfs=;
        b=GtoxmlvnSz30207TYvWaMvDotOVLcev0iPyOlhrMPdMJOBifZAgEEA/8x9TiWmxLk2
         QeMw7+kqPSoChbeB0ebi7Gd9u5vLUamDTMs0SnUOUHNHZZvjk3Ec6GcqpnYTVinpbmfE
         gn5Myz3pR3vGUBSTllJOqM96ITN8zSpsEPfQduCD5gLFfBFuCAofm27sTuNoeVR/jPvR
         n1pQegSC0Bx9I/FL2+Bwb2BuXbb2frAlIFqJIzUG1AyoXHxQgD+7vOynArJys2rnpIC/
         sS0YLQdHLkD1Jl3iXSh230j2MvRHq09brK3rRLIkkRJPoVyWktYr7oTM7kKZEmDp0SZa
         NkgA==
X-Gm-Message-State: APjAAAV1NDih26UKI9iGsCFHI0Sczt3K/w491eRopOmoedgf8RerE46D
        IpdW7nos3ZsnK0sGwPUOyZL4Gr4r7gM=
X-Google-Smtp-Source: APXvYqzJozfEXG4rvZP95ZVNGIlNMhSz3deVv2Db4xnw9KC12u6FLkYMP77yB22xH5zNTvJlzdc8aA==
X-Received: by 2002:a5d:6a12:: with SMTP id m18mr17733975wru.325.1553982248606;
        Sat, 30 Mar 2019 14:44:08 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id o10sm8564254wru.54.2019.03.30.14.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 14:44:07 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Dafna Hirschfeld <dafna3@gmail.com>
Subject: [PATCH v4l-utils v2] v4l2-ctl: add support for fwht stateless encoder
Date:   Sat, 30 Mar 2019 14:41:58 -0700
Message-Id: <20190330214158.108447-1-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
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

