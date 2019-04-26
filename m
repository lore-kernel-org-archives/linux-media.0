Return-Path: <SRS0=gA2F=S4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9142C43218
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 19:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D26420675
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 19:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfDZTwo (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:52:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40764 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfDZTwo (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 26 Apr 2019 15:52:44 -0400
Received: from localhost.localdomain (unknown [IPv6:2804:431:9718:9080:61b7:f4a4:2020:fc95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id ADC37272EC0;
        Fri, 26 Apr 2019 20:52:38 +0100 (BST)
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, helen.koike@collabora.com,
        kernel@collabora.com, lucmaga@gmail.com,
        lkcamp@lists.libreplanetbr.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v5 13/14] media: vimc: cap: Add support for multiplanar formats
Date:   Fri, 26 Apr 2019 16:51:13 -0300
Message-Id: <20190426195114.5002-14-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426195114.5002-1-andrealmeid@collabora.com>
References: <20190426195114.5002-1-andrealmeid@collabora.com>
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
Acked-by: Helen Koike <helen.koike@collabora.com>
---
Change in v5: none

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

