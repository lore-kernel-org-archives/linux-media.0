Return-Path: <SRS0=rHfj=S2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DE7C282CE
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 13:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26AA821900
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 13:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbfDXN7K (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:59:10 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57102 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfDXN7K (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 24 Apr 2019 09:59:10 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id D0283282C19
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, helen.koike@collabora.com,
        kernel@collabora.com, lucmaga@gmail.com,
        lkcamp@lists.libreplanetbr.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v3 13/14] media: vimc: cap: Add support for multiplanar formats
Date:   Wed, 24 Apr 2019 10:56:41 -0300
Message-Id: <20190424135642.31973-14-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424135642.31973-1-andrealmeid@collabora.com>
References: <20190424135642.31973-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Adapt vimc-capture to support multiplanar formats, copying
each plane to the correct buffer.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
Change in v3:
- Adapt to new vimc_frame

Change in v2: none

 drivers/media/platform/vimc/vimc-capture.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/vimc/vimc-capture.c b/drivers/media/platform/vimc/vimc-capture.c
index d5b72c858af7..2592ea982ff8 100644
--- a/drivers/media/platform/vimc/vimc-capture.c
+++ b/drivers/media/platform/vimc/vimc-capture.c
@@ -485,6 +485,8 @@ static struct vimc_frame *vimc_cap_process_frame(struct vimc_ent_device *ved,
 	struct vimc_cap_device *vcap = container_of(ved, struct vimc_cap_device,
 						    ved);
 	struct vimc_cap_buffer *vimc_buf;
+	unsigned long plane_size;
+	unsigned int i;
 	void *vbuf;
 
 	spin_lock(&vcap->qlock);
@@ -507,13 +509,17 @@ static struct vimc_frame *vimc_cap_process_frame(struct vimc_ent_device *ved,
 	vimc_buf->vb2.sequence = vcap->sequence++;
 	vimc_buf->vb2.field = vcap->format.fmt.pix.field;
 
-	vbuf = vb2_plane_vaddr(&vimc_buf->vb2.vb2_buf, 0);
+	/* For each plane, copy the pixels */
+	for (i = 0; i < vimc_buf->vb2.vb2_buf.num_planes; i++) {
+		vbuf = vb2_plane_vaddr(&vimc_buf->vb2.vb2_buf, i);
+		plane_size = frame->fmt.plane_fmt[i].sizeimage;
+
+		memcpy(vbuf, frame->plane_addr[i], plane_size);
 
-	memcpy(vbuf, frame->plane_addr[0], vcap->format.fmt.pix.sizeimage);
+		/* Set it as ready */
+		vb2_set_plane_payload(&vimc_buf->vb2.vb2_buf, i, plane_size);
+	}
 
-	/* Set it as ready */
-	vb2_set_plane_payload(&vimc_buf->vb2.vb2_buf, 0,
-			      vcap->format.fmt.pix.sizeimage);
 	vb2_buffer_done(&vimc_buf->vb2.vb2_buf, VB2_BUF_STATE_DONE);
 	return NULL;
 }
-- 
2.21.0

