Return-Path: <SRS0=jTma=54=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A599C2BB85
	for <linux-media@archiver.kernel.org>; Sun, 12 Apr 2020 12:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D26B20708
	for <linux-media@archiver.kernel.org>; Sun, 12 Apr 2020 12:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgDLMFP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 12 Apr 2020 08:05:15 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37290 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgDLMFO (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 12 Apr 2020 08:05:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id A2F682A0713
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org, dafna.hirschfeld@collabora.com,
        helen.koike@collabora.com, ezequiel@collabora.com,
        hverkuil@xs4all.nl, kernel@collabora.com, dafna3@gmail.com,
        laurent.pinchart@ideasonboard.com,
        linux-rockchip@lists.infradead.org, sakari.ailus@linux.intel.com
Subject: [PATCH v2 1/4] media: staging: rkisp1: rsz: get the capture format info from the capture struct
Date:   Sun, 12 Apr 2020 14:05:01 +0200
Message-Id: <20200412120504.6536-2-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200412120504.6536-1-dafna.hirschfeld@collabora.com>
References: <20200412120504.6536-1-dafna.hirschfeld@collabora.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Currently the format info of the capture is retrieved by calling
the function  v4l2_format_info. This is not needed since it is
already save in the capture object.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/staging/media/rkisp1/rkisp1-resizer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/rkisp1/rkisp1-resizer.c b/drivers/staging/media/rkisp1/rkisp1-resizer.c
index 7b6b7ddd4169..84f23a91b0a0 100644
--- a/drivers/staging/media/rkisp1/rkisp1-resizer.c
+++ b/drivers/staging/media/rkisp1/rkisp1-resizer.c
@@ -387,11 +387,9 @@ static void rkisp1_rsz_config(struct rkisp1_resizer *rsz,
 	if (rsz->pixel_enc == V4L2_PIXEL_ENC_YUV) {
 		struct rkisp1_capture *cap =
 			&rsz->rkisp1->capture_devs[rsz->id];
-		const struct v4l2_format_info *pixfmt_info =
-			v4l2_format_info(cap->pix.fmt.pixelformat);
 
-		hdiv = pixfmt_info->hdiv;
-		vdiv = pixfmt_info->vdiv;
+		hdiv = cap->pix.info->hdiv;
+		vdiv = cap->pix.info->vdiv;
 	}
 	src_c.width = src_y.width / hdiv;
 	src_c.height = src_y.height / vdiv;
-- 
2.17.1

