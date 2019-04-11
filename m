Return-Path: <SRS0=hW3k=SN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50277C10F13
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 16:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1210421850
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 16:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="syEDNl+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfDKQNE (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:13:04 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:35638 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfDKQNE (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 11 Apr 2019 12:13:04 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EEFD21A4B;
        Thu, 11 Apr 2019 18:13:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1554999181;
        bh=2c1wobSbz2WZ7agRjzEAWAPxeWgKbX1redv4gIs+v78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=syEDNl+wtirbUiWWBzIOCB/tSGODGdy2d4il7WoRk71XKoRQRQ9gC5qqFtv+1ogm5
         Cf5cmjH2/l5GuPpI2R8lc8nzRs0nMyC0jFKZhLRou+v4v3XHP7WdqlI/6P9BIhquN7
         67et8smmLRIYK3Eyt7wTKY8vCVuS41chtuqSAD4Y=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH v3 3/5] media: vsp1: Document partition algorithm in code header
Date:   Thu, 11 Apr 2019 17:12:54 +0100
Message-Id: <20190411161256.19607-4-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190411161256.19607-1-kieran.bingham+renesas@ideasonboard.com>
References: <20190411161256.19607-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The image partition algorithm operates on the image dimensions as input
into the WPF entity. Document this in the code block header.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_video.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/platform/vsp1/vsp1_video.c b/drivers/media/platform/vsp1/vsp1_video.c
index 563f9a02c373..d1ecc3d91290 100644
--- a/drivers/media/platform/vsp1/vsp1_video.c
+++ b/drivers/media/platform/vsp1/vsp1_video.c
@@ -173,6 +173,14 @@ static int __vsp1_video_try_format(struct vsp1_video *video,
 
 /* -----------------------------------------------------------------------------
  * VSP1 Partition Algorithm support
+ *
+ * VSP hardware can have restrictions on image width dependent on the hardware
+ * configuration of the pipeline. Adapting for these restrictions is implemented
+ * via the partition algorithm.
+ *
+ * The partition windows and sizes are based on the output size of the WPF
+ * before rotation, which is represented by the input parameters to the WPF
+ * entity in our pipeline.
  */
 
 /**
-- 
2.19.1

