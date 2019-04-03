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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFA2C4360F
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B7A20882
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqz5WkD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfDCWSO (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:18:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40986 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfDCWSN (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 3 Apr 2019 18:18:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so870410wrq.8
        for <linux-media@vger.kernel.org>; Wed, 03 Apr 2019 15:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fy2qFD74zdUbAe78wnfHfXfNlPMXRBU6r8h3CmVtLrU=;
        b=pqz5WkD8g5g2FdE2jB5RERZkQu26xUyXOqEnvRxWNFNh93CPao2vhBykn6LQNAbzFo
         LU+MHz3KuZmrVIwcKDsJLduaDwGWo1+bt7cmjpMqOuUTrXydf8Ny1nJOwEkq5shSZZQ6
         NwkvBNC9LjBHIcL4m0+cerjgLpv44/2xIZqe6j1/FoGW85m6fqE+JD/IzzQabRsAUC67
         85Wj5mmyx6eazuKPGSQOQ6Fgkhqfgu/dLXNn6W8r8/xu7vwigbBG98uCjTjDl5LFqkwO
         raUvCxaRL5oj9MGlEGHiDb3Iylh+NIf+NjY+GfS1gqcA8nC6xF1AqDwWklCB13Dbqz8J
         jUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fy2qFD74zdUbAe78wnfHfXfNlPMXRBU6r8h3CmVtLrU=;
        b=Y+cGiOqFR1ThW3rrleYQ3TGRcVaTwWdQQuRakvX4H+99//3jYUDcKieL9oWCmeCekn
         DYMjTcYJU3zSdiCMhmIqbeqZcR4Y++XmOfMrDIIMAZB4K+zl3KS5jQt/QCDWcUYwSn8O
         0que6H6M9aQQ+6h6+kCxUKoTAif9BZ+TwnsCHAFI/dDeYvZK1TUT43yNxkUS7VK32pS/
         KrZ/f6kJlDbUsqKGrQbhSqRNxVRw/XSEf/pG37SBHP0pggxXX2Qp8Bzh5txRrMiy1LkB
         V6dZ8mhG7+41srk2Ekc+24hAA/P2QeoNcK3+BbzoucR3eqP1AtxfMMtbxp8j2Dx1vaHv
         dtcw==
X-Gm-Message-State: APjAAAWKMYugllWfSEimfppauMNJqbh1+C0grW3Q22XpHHO2w2l11Ohm
        OtYDXB1stMij9vro60rYKRY=
X-Google-Smtp-Source: APXvYqzVZjSRK5PDXpaiN0MmF76uXXpIrZD0AUxuutDYzm0Q//lni8jLjcFTXN+A4SxZO3fjJ5vCqQ==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr1281609wrw.301.1554329891578;
        Wed, 03 Apr 2019 15:18:11 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id d6sm26019552wrx.62.2019.04.03.15.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 15:18:10 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     dafna3@gmail.com, linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH v2 03/16] vicodec: always return a valid format.
Date:   Wed,  3 Apr 2019 15:14:48 -0700
Message-Id: <20190403221501.32814-4-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403221501.32814-1-dafna3@gmail.com>
References: <20190403221501.32814-1-dafna3@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Rather than returning width/height values of 0, just default to
a format. Formats in V4L2 are always supposed to be valid, there
is no concept of an invalid format.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/platform/vicodec/vicodec-core.c | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index 92647f02fc49..aa3af796929b 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -1771,11 +1771,13 @@ static const struct v4l2_ctrl_config vicodec_ctrl_stateless_state = {
  */
 static int vicodec_open(struct file *file)
 {
+	const struct v4l2_fwht_pixfmt_info *info = v4l2_fwht_get_pixfmt(0);
 	struct video_device *vfd = video_devdata(file);
 	struct vicodec_dev *dev = video_drvdata(file);
 	struct vicodec_ctx *ctx = NULL;
 	struct v4l2_ctrl_handler *hdl;
-	unsigned int size;
+	unsigned int raw_size;
+	unsigned int comp_size;
 	int rc = 0;
 
 	if (mutex_lock_interruptible(vfd->lock))
@@ -1814,7 +1816,7 @@ static int vicodec_open(struct file *file)
 	v4l2_ctrl_handler_setup(hdl);
 
 	if (ctx->is_enc)
-		ctx->q_data[V4L2_M2M_SRC].info = v4l2_fwht_get_pixfmt(0);
+		ctx->q_data[V4L2_M2M_SRC].info = info;
 	else if (ctx->is_stateless)
 		ctx->q_data[V4L2_M2M_SRC].info = &pixfmt_stateless_fwht;
 	else
@@ -1823,22 +1825,22 @@ static int vicodec_open(struct file *file)
 	ctx->q_data[V4L2_M2M_SRC].coded_height = 720;
 	ctx->q_data[V4L2_M2M_SRC].visible_width = 1280;
 	ctx->q_data[V4L2_M2M_SRC].visible_height = 720;
-	size = 1280 * 720 * ctx->q_data[V4L2_M2M_SRC].info->sizeimage_mult /
-		ctx->q_data[V4L2_M2M_SRC].info->sizeimage_div;
+	raw_size = 1280 * 720 * info->sizeimage_mult / info->sizeimage_div;
+	comp_size = 1280 * 720 * pixfmt_fwht.sizeimage_mult /
+				 pixfmt_fwht.sizeimage_div;
 	if (ctx->is_enc || ctx->is_stateless)
-		ctx->q_data[V4L2_M2M_SRC].sizeimage = size;
+		ctx->q_data[V4L2_M2M_SRC].sizeimage = raw_size;
 	else
 		ctx->q_data[V4L2_M2M_SRC].sizeimage =
-			size + sizeof(struct fwht_cframe_hdr);
+			comp_size + sizeof(struct fwht_cframe_hdr);
+	ctx->q_data[V4L2_M2M_DST] = ctx->q_data[V4L2_M2M_SRC];
 	if (ctx->is_enc) {
-		ctx->q_data[V4L2_M2M_DST] = ctx->q_data[V4L2_M2M_SRC];
 		ctx->q_data[V4L2_M2M_DST].info = &pixfmt_fwht;
-		ctx->q_data[V4L2_M2M_DST].sizeimage = 1280 * 720 *
-			ctx->q_data[V4L2_M2M_DST].info->sizeimage_mult /
-			ctx->q_data[V4L2_M2M_DST].info->sizeimage_div +
-			sizeof(struct fwht_cframe_hdr);
+		ctx->q_data[V4L2_M2M_DST].sizeimage =
+			comp_size + sizeof(struct fwht_cframe_hdr);
 	} else {
-		ctx->q_data[V4L2_M2M_DST].info = NULL;
+		ctx->q_data[V4L2_M2M_DST].info = info;
+		ctx->q_data[V4L2_M2M_DST].sizeimage = raw_size;
 	}
 
 	ctx->state.colorspace = V4L2_COLORSPACE_REC709;
-- 
2.17.1

