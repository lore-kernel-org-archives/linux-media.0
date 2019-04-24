Return-Path: <SRS0=rHfj=S2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F52C10F11
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 13:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B9321901
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 13:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbfDXN6v (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:58:51 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57062 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbfDXN6v (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 24 Apr 2019 09:58:51 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 4B6FF282C1F
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, helen.koike@collabora.com,
        kernel@collabora.com, lucmaga@gmail.com,
        lkcamp@lists.libreplanetbr.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v3 09/14] media: vimc: Propagate multiplanar state in the stream
Date:   Wed, 24 Apr 2019 10:56:37 -0300
Message-Id: <20190424135642.31973-10-andrealmeid@collabora.com>
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

Add a multiplanar flag in vimc_stream in order to propagate the
state (singleplanar/multiplanar) to subdevices at the stream.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
Change in v3:
- Use ternary operator to get code more simple

Change in v2:
- New commit

 drivers/media/platform/vimc/vimc-capture.c  | 4 +++-
 drivers/media/platform/vimc/vimc-streamer.h | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/vimc/vimc-capture.c b/drivers/media/platform/vimc/vimc-capture.c
index 415dbab63ec5..e1805cf0140d 100644
--- a/drivers/media/platform/vimc/vimc-capture.c
+++ b/drivers/media/platform/vimc/vimc-capture.c
@@ -337,7 +337,9 @@ static int vimc_cap_start_streaming(struct vb2_queue *vq, unsigned int count)
 		return ret;
 	}
 
-	vcap->stream.producer_pixfmt = IS_MULTIPLANAR(vcap) ?
+	vcap->stream.multiplanar = IS_MULTIPLANAR(vcap);
+
+	vcap->stream.producer_pixfmt = vcap->stream.multiplanar ?
 		vcap->format.fmt.pix_mp.pixelformat :
 		vcap->format.fmt.pix.pixelformat;
 
diff --git a/drivers/media/platform/vimc/vimc-streamer.h b/drivers/media/platform/vimc/vimc-streamer.h
index 2b3667408794..4878e0b72ea7 100644
--- a/drivers/media/platform/vimc/vimc-streamer.h
+++ b/drivers/media/platform/vimc/vimc-streamer.h
@@ -25,6 +25,8 @@
  * processed in the pipeline.
  * @pipe_size:		size of @ved_pipeline
  * @kthread:		thread that generates the frames of the stream.
+ * @multiplanar:	sets if the stream is running in multiplanar or
+ * singleplanar format mode
  * @producer_pixfmt:	the pixel format requested from the pipeline. This must
  * be set just before calling vimc_streamer_s_stream(ent, 1). This value is
  * propagated up to the source of the base image (usually a sensor node) and
@@ -40,6 +42,7 @@ struct vimc_stream {
 	struct vimc_ent_device *ved_pipeline[VIMC_STREAMER_PIPELINE_MAX_SIZE];
 	unsigned int pipe_size;
 	struct task_struct *kthread;
+	bool multiplanar;
 	u32 producer_pixfmt;
 };
 
-- 
2.21.0

