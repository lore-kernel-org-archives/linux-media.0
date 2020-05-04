Return-Path: <SRS0=C6Fs=6S=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6F1C47259
	for <linux-media@archiver.kernel.org>; Mon,  4 May 2020 09:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD81206B9
	for <linux-media@archiver.kernel.org>; Mon,  4 May 2020 09:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="V9lef/1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgEDJ0p (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 4 May 2020 05:26:45 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:56720 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgEDJ0n (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 4 May 2020 05:26:43 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B6B8F121D;
        Mon,  4 May 2020 11:26:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1588584398;
        bh=+brpwA1vXJHBDGowRYRV7Rb1SchHJJF7/qPiIvA6OVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V9lef/1mAFk2Dd/QWwTecbXV+vUcn99+EETHDTawj6VzAKu3NqeTIusk1M4R908Fs
         zF3BjSA6+4NSSGAAqYh4Jx/yTfZTAkXN0//R1CTa0HIbRibYnlPfJIDHMKG9OTu/HE
         NvuySW4SrH5ickFiCV3owI/MiMWHevSsfXYcbos0=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Naushir Patuck <naush@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>
Subject: [PATCH v2 20/34] staging: mmal-vchiq: Fix handling of VB2_MEMORY_DMABUF buffers
Date:   Mon,  4 May 2020 12:25:57 +0300
Message-Id: <20200504092611.9798-21-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504092611.9798-1-laurent.pinchart@ideasonboard.com>
References: <20200504092611.9798-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.org>

If the queue is configured as VB2_MEMORY_DMABUF then vb2_core_expbuf
fails as it ensures the queue is defined as VB2_MEMORY_MMAP.

Correct the handling so that we unmap the buffer from vcsm and the
VPU on cleanup, and then correctly get the dma buf of the new buffer.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
---
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     | 21 +++++++++++++------
 .../vc04_services/vchiq-mmal/mmal-vchiq.h     |  2 ++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 4e559f88d828..9fc1a29f9f1a 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -1779,13 +1779,9 @@ int mmal_vchi_buffer_init(struct vchiq_mmal_instance *instance,
 }
 EXPORT_SYMBOL_GPL(mmal_vchi_buffer_init);
 
-int mmal_vchi_buffer_cleanup(struct mmal_buffer *buf)
+int mmal_vchi_buffer_unmap(struct mmal_buffer *buf)
 {
-	struct mmal_msg_context *msg_context = buf->msg_context;
-
-	if (msg_context)
-		release_msg_context(msg_context);
-	buf->msg_context = NULL;
+	int ret = 0;
 
 	if (buf->vcsm_handle) {
 		int ret;
@@ -1797,6 +1793,19 @@ int mmal_vchi_buffer_cleanup(struct mmal_buffer *buf)
 			pr_err("%s: vcsm_free failed, ret %d\n", __func__, ret);
 		buf->vcsm_handle = 0;
 	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mmal_vchi_buffer_unmap);
+
+int mmal_vchi_buffer_cleanup(struct mmal_buffer *buf)
+{
+	struct mmal_msg_context *msg_context = buf->msg_context;
+
+	if (msg_context)
+		release_msg_context(msg_context);
+	buf->msg_context = NULL;
+
+	mmal_vchi_buffer_unmap(buf);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mmal_vchi_buffer_cleanup);
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
index 247521fbcc1d..0a75c96f6d58 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
@@ -167,6 +167,8 @@ int vchiq_mmal_submit_buffer(struct vchiq_mmal_instance *instance,
 			     struct vchiq_mmal_port *port,
 			     struct mmal_buffer *buf);
 
+int mmal_vchi_buffer_unmap(struct mmal_buffer *buf);
+
 int mmal_vchi_buffer_init(struct vchiq_mmal_instance *instance,
 			  struct mmal_buffer *buf);
 int mmal_vchi_buffer_cleanup(struct mmal_buffer *buf);
-- 
Regards,

Laurent Pinchart

