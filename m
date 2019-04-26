Return-Path: <SRS0=gA2F=S4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A926C43219
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 19:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E22D2077B
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 19:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfDZTv6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:51:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40662 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfDZTv6 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 26 Apr 2019 15:51:58 -0400
Received: from localhost.localdomain (unknown [IPv6:2804:431:9718:9080:61b7:f4a4:2020:fc95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 353AD272EC0;
        Fri, 26 Apr 2019 20:51:52 +0100 (BST)
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, helen.koike@collabora.com,
        kernel@collabora.com, lucmaga@gmail.com,
        lkcamp@lists.libreplanetbr.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v5 03/14] media: vimc: cap: Dynamically define stream pixelformat
Date:   Fri, 26 Apr 2019 16:51:03 -0300
Message-Id: <20190426195114.5002-4-andrealmeid@collabora.com>
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

Define the pixelformat of the streamer depending to the
mode (single/multiplanar). Add a macro to help checking if the device is
in multilplanar mode.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
Acked-by: Helen Koike <helen.koike@collabora.com>
---
Change in v5: none
Change in v4: none

Change in v3:
- Replace if with triaste operator

Change in v2:
- Add a macro to check if device is in multiplanar mode. Now, this check
is done using the capture device capabilities, rather than using the
multiplanar module parameter

 drivers/media/platform/vimc/vimc-capture.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/vimc/vimc-capture.c b/drivers/media/platform/vimc/vimc-capture.c
index de52f20b5c85..ae703c52d3f8 100644
--- a/drivers/media/platform/vimc/vimc-capture.c
+++ b/drivers/media/platform/vimc/vimc-capture.c
@@ -28,6 +28,10 @@
 
 #define VIMC_CAP_DRV_NAME "vimc-capture"
 
+/* Checks if the device supports multiplanar capture */
+#define IS_MULTIPLANAR(vcap) \
+	(vcap->vdev.device_caps & V4L2_CAP_VIDEO_CAPTURE_MPLANE)
+
 static const u32 vimc_cap_supported_pixfmt[] = {
 	V4L2_PIX_FMT_BGR24,
 	V4L2_PIX_FMT_RGB24,
@@ -282,7 +286,9 @@ static int vimc_cap_start_streaming(struct vb2_queue *vq, unsigned int count)
 		return ret;
 	}
 
-	vcap->stream.producer_pixfmt = vcap->format.fmt.pix.pixelformat;
+	vcap->stream.producer_pixfmt = IS_MULTIPLANAR(vcap) ?
+		vcap->format.fmt.pix_mp.pixelformat :
+		vcap->format.fmt.pix.pixelformat;
 
 	ret = vimc_streamer_s_stream(&vcap->stream, &vcap->ved, 1);
 	if (ret) {
-- 
2.21.0

