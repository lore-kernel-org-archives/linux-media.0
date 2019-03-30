Return-Path: <SRS0=IMFm=SB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D92C43381
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 21:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FDE21773
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 21:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qT/M5hh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbfC3Vgd (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 30 Mar 2019 17:36:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45069 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730395AbfC3Vgc (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 30 Mar 2019 17:36:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so6908161wra.12
        for <linux-media@vger.kernel.org>; Sat, 30 Mar 2019 14:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QPC/0lED49+IBZ6vO8lGlkFuv2ulajJkH3L3H4F5Ytc=;
        b=qT/M5hh+TThR1LzcFFnLS0hn8uwFClYfoMpFlg4NYWTzWW+LkTThvxo9yOJ6RjLJE8
         fqy+9g+9yH34L+qDisRyrfwik21uS4AK92o9whYxhjcO8kHEXEIHYV9Q7QgaZmodKQDp
         rIx5m1utYwA8wGdm4btFUoWxLcg1lNLPiRywmJQxONjoTOLu87kyWz1KxFmpjoUG42+h
         TQuKeFlngSh6Bdga4Y20iPRrP94MY5LgjIajFcHrHctZR/Mel2tuHLYNdyHvkFLWU1pk
         2ZScqTr+U9+iQKB7R4g2sfIVeVNfK3Uf3slHqfY8yNye639/3COLQaHNCWD4X3NFPi5V
         fnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QPC/0lED49+IBZ6vO8lGlkFuv2ulajJkH3L3H4F5Ytc=;
        b=pMBGF9phAm5dmYbuxhxlZg52/xEpLlq6yG/BUi0iYFmXcSF1ln2+Dtm+iUH6xotbt0
         cprbSpALU/2aIKs8szg7GSgMFUGBc9y9fCrXYPx7tBoCRAU8FNE7SM1HC0gUdI0Dd7Yg
         meA8OkDy4GZmnDDiHfnqVMZ8yQ4PmNrm5sr3smaPY2wDzlti/ip2TWy7zHb7+IXmUB/U
         MSHeI0SDJ3UwsYAqozY+eXYFC/uC+j8U6nW4fZFoUtrrV391T/hyUvi+62JcTxRnov7G
         BxVlQnHIkNTscbtmMc/qX/K/YzC+ijDKfClJBJb3A1DmzGUsK0H+IofZUcPm7tfPYMX3
         r9kg==
X-Gm-Message-State: APjAAAUrNihurTTQKY+mO5uObjgfJods0ZquzQpSGeCFasTPeQ8SM+Pg
        Yz8xupw84QdGnP4K+U62FT2Cr7S31fw=
X-Google-Smtp-Source: APXvYqzQtutaRGUGaW041w4IPvi7oP4vmjKw3GLhPWZdlPU7sJO8P5xERAAMBfsP97zM9SxWEheC8Q==
X-Received: by 2002:a5d:6b43:: with SMTP id x3mr38503858wrw.76.1553981790843;
        Sat, 30 Mar 2019 14:36:30 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id s10sm6066144wmh.0.2019.03.30.14.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 14:36:29 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Dafna Hirschfeld <dafna3@gmail.com>
Subject: [PATCH v4l-utils 1/3] v4l2-ctl: declare hdr variable as const
Date:   Sat, 30 Mar 2019 14:33:39 -0700
Message-Id: <20190330213341.107939-1-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

declare the hdr param with 'const' in
functions that use fwht header in order
to set the fwht stateless params.

Signed-off-by: Dafna Hirschfeld <dafna3@gmail.com>
---
 utils/v4l2-ctl/v4l2-ctl-streaming.cpp | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/utils/v4l2-ctl/v4l2-ctl-streaming.cpp b/utils/v4l2-ctl/v4l2-ctl-streaming.cpp
index 85f97722..28bc8c68 100644
--- a/utils/v4l2-ctl/v4l2-ctl-streaming.cpp
+++ b/utils/v4l2-ctl/v4l2-ctl-streaming.cpp
@@ -837,7 +837,7 @@ static int alloc_fwht_req(int media_fd, unsigned index)
 	return 0;
 }
 
-static void set_fwht_req_by_idx(unsigned idx, struct fwht_cframe_hdr *hdr,
+static void set_fwht_req_by_idx(unsigned idx, const struct fwht_cframe_hdr *hdr,
 				__u64 last_bf_ts, __u64 ts)
 {
 	struct v4l2_ctrl_fwht_params fwht_params;
@@ -857,7 +857,7 @@ static int get_fwht_req_by_ts(__u64 ts)
 	return -1;
 }
 
-static bool set_fwht_req_by_fd(struct fwht_cframe_hdr *hdr,
+static bool set_fwht_req_by_fd(const struct fwht_cframe_hdr *hdr,
 			       int req_fd, __u64 last_bf_ts, __u64 ts)
 {
 	struct v4l2_ctrl_fwht_params fwht_params;
@@ -874,7 +874,7 @@ static bool set_fwht_req_by_fd(struct fwht_cframe_hdr *hdr,
 	return false;
 }
 
-static int set_fwht_ext_ctrl(cv4l_fd &fd, struct fwht_cframe_hdr *hdr,
+static int set_fwht_ext_ctrl(cv4l_fd &fd, const struct fwht_cframe_hdr *hdr,
 			     __u64 last_bf_ts, int req_fd)
 {
 	v4l2_ext_controls controls;
-- 
2.17.1

