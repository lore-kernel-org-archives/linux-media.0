Return-Path: <SRS0=gA2F=S4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AC3C43219
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 01:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFAF206A3
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 01:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbfDZBYx (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Apr 2019 21:24:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36680 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfDZBYw (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Apr 2019 21:24:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id B28CA28193C
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, helen.koike@collabora.com,
        kernel@collabora.com, lucmaga@gmail.com,
        lkcamp@lists.libreplanetbr.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v4 13/14] media: vimc: cap: Add support for multiplanar formats
Date:   Thu, 25 Apr 2019 22:22:22 -0300
Message-Id: <20190426012223.17826-14-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426012223.17826-1-andrealmeid@collabora.com>
References: <20190426012223.17826-1-andrealmeid@collabora.com>
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
Change in v4:
- Move variables to inside the for loop
- Change `plane_size` type from `unsigned int` to `size_t`

Change in v3:
- Adapt to new vimc_frame

Change in v2: none

 drivers/media/platform/vimc/vimc-capture.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/vimc/vimc-capture.c b/drivers/media/platform/vimc/vimc-capture.c
index d9dae5b3a0bf..932d622d56ca 100644
--- a/drivers/media/platform/vimc/vimc-capture.c
+++ b/drivers/media/platform/vimc/vimc-capture.c
@@ -523,7 +523,7 @@ static struct vimc_frame *vimc_cap_process_frame(struct vimc_ent_device *ved,
 	struct vimc_cap_device *vcap = container_of(ved, struct vimc_cap_device,
 						    ved);
 	struct vimc_cap_buffer *vimc_buf;
-	void *vbuf;
+	unsigned int i;
 
 	spin_lock(&vcap->qlock);
 
@@ -545,13 +545,17 @@ static struct vimc_frame *vimc_cap_process_frame(struct vimc_ent_device *ved,
 	vimc_buf->vb2.sequence = vcap->sequence++;
 	vimc_buf->vb2.field = vcap->format.fmt.pix.field;
 
-	vbuf = vb2_plane_vaddr(&vimc_buf->vb2.vb2_buf, 0);
+	/* For each plane, copy the pixels */
+	for (i = 0; i < vimc_buf->vb2.vb2_buf.num_planes; i++) {
+		void *vbuf = vb2_plane_vaddr(&vimc_buf->vb2.vb2_buf, i);
+		size_t plane_size = frame->fmt.plane_fmt[i].sizeimage;
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

