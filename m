Return-Path: <SRS0=hW3k=SN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA16C10F14
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 16:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7C7217F4
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 16:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="e0NnIabi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfDKQNC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:13:02 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:35626 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfDKQNC (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 11 Apr 2019 12:13:02 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 33BD31987;
        Thu, 11 Apr 2019 18:13:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1554999180;
        bh=KPQvMQNMlTWgebekcI6Wk/JVOuDQprHQp2ryQLCfewQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e0NnIabilR+BDw6LtCm8Na7f5XrID//SK+e3VO2kNonNhqMflSjUFfdSUvx5Zy9If
         TBsMQVcqO3Q4d7nDC3qwL53d5sFHszK5ozZPq12YUIJEiQPVinxCsLK1lSGP43jSCB
         LxoGcCBLDQHw6oIxarqCr3dBiVlkaoRy51OLNVBk=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH v3 1/5] media: vsp1: Define partition algorithm helper
Date:   Thu, 11 Apr 2019 17:12:52 +0100
Message-Id: <20190411161256.19607-2-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190411161256.19607-1-kieran.bingham+renesas@ideasonboard.com>
References: <20190411161256.19607-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Provide a helper to describe when the partition algorithm is in use on a
given pipeline.  This improves readability to the purpose of the code,
rather than obtusely checking the number of partitions.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_pipe.c  | 8 ++++++++
 drivers/media/platform/vsp1/vsp1_pipe.h  | 1 +
 drivers/media/platform/vsp1/vsp1_rpf.c   | 2 +-
 drivers/media/platform/vsp1/vsp1_video.c | 2 +-
 drivers/media/platform/vsp1/vsp1_wpf.c   | 2 +-
 5 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_pipe.c b/drivers/media/platform/vsp1/vsp1_pipe.c
index 54ff539ffea0..f1bd21a01bcd 100644
--- a/drivers/media/platform/vsp1/vsp1_pipe.c
+++ b/drivers/media/platform/vsp1/vsp1_pipe.c
@@ -364,6 +364,14 @@ void vsp1_pipeline_propagate_alpha(struct vsp1_pipeline *pipe,
 	vsp1_uds_set_alpha(pipe->uds, dlb, alpha);
 }
 
+/*
+ * Identify if the partition algorithm is in use or not
+ */
+bool vsp1_pipeline_partitioned(struct vsp1_pipeline *pipe)
+{
+	return pipe->partitions > 1;
+}
+
 /*
  * Propagate the partition calculations through the pipeline
  *
diff --git a/drivers/media/platform/vsp1/vsp1_pipe.h b/drivers/media/platform/vsp1/vsp1_pipe.h
index ae646c9ef337..dd8b2cdc6452 100644
--- a/drivers/media/platform/vsp1/vsp1_pipe.h
+++ b/drivers/media/platform/vsp1/vsp1_pipe.h
@@ -164,6 +164,7 @@ void vsp1_pipeline_propagate_alpha(struct vsp1_pipeline *pipe,
 				   struct vsp1_dl_body *dlb,
 				   unsigned int alpha);
 
+bool vsp1_pipeline_partitioned(struct vsp1_pipeline *pipe);
 void vsp1_pipeline_propagate_partition(struct vsp1_pipeline *pipe,
 				       struct vsp1_partition *partition,
 				       unsigned int index,
diff --git a/drivers/media/platform/vsp1/vsp1_rpf.c b/drivers/media/platform/vsp1/vsp1_rpf.c
index 616afa7e165f..ef9bf5dd55a0 100644
--- a/drivers/media/platform/vsp1/vsp1_rpf.c
+++ b/drivers/media/platform/vsp1/vsp1_rpf.c
@@ -269,7 +269,7 @@ static void rpf_configure_partition(struct vsp1_entity *entity,
 	 * matching the expected partition window. Only 'left' and
 	 * 'width' need to be adjusted.
 	 */
-	if (pipe->partitions > 1) {
+	if (vsp1_pipeline_partitioned(pipe)) {
 		crop.width = pipe->partition->rpf.width;
 		crop.left += pipe->partition->rpf.left;
 	}
diff --git a/drivers/media/platform/vsp1/vsp1_video.c b/drivers/media/platform/vsp1/vsp1_video.c
index 7ceaf3222145..ee2fb8261a6a 100644
--- a/drivers/media/platform/vsp1/vsp1_video.c
+++ b/drivers/media/platform/vsp1/vsp1_video.c
@@ -201,7 +201,7 @@ static void vsp1_video_calculate_partition(struct vsp1_pipeline *pipe,
 					    RWPF_PAD_SINK);
 
 	/* A single partition simply processes the output size in full. */
-	if (pipe->partitions <= 1) {
+	if (!vsp1_pipeline_partitioned(pipe)) {
 		window.left = 0;
 		window.width = format->width;
 
diff --git a/drivers/media/platform/vsp1/vsp1_wpf.c b/drivers/media/platform/vsp1/vsp1_wpf.c
index 32bb207b2007..9e8dbf99878b 100644
--- a/drivers/media/platform/vsp1/vsp1_wpf.c
+++ b/drivers/media/platform/vsp1/vsp1_wpf.c
@@ -376,7 +376,7 @@ static void wpf_configure_partition(struct vsp1_entity *entity,
 	 * Cropping. The partition algorithm can split the image into
 	 * multiple slices.
 	 */
-	if (pipe->partitions > 1)
+	if (vsp1_pipeline_partitioned(pipe))
 		width = pipe->partition->wpf.width;
 
 	vsp1_wpf_write(wpf, dlb, VI6_WPF_HSZCLIP, VI6_WPF_SZCLIP_EN |
-- 
2.19.1

