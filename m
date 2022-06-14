Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2394C433EF
	for <linux-media@archiver.kernel.org>; Tue, 14 Jun 2022 19:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345473AbiFNTNK (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 14 Jun 2022 15:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357228AbiFNTNH (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 14 Jun 2022 15:13:07 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45435167E1
        for <linux-media@vger.kernel.org>; Tue, 14 Jun 2022 12:13:07 -0700 (PDT)
Received: from pyrite.rasen.tech (softbank036240126034.bbtec.net [36.240.126.34])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A2D22825;
        Tue, 14 Jun 2022 21:13:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1655233986;
        bh=eSmCMdUtxHqbgRDuGNxkbYgoA5HVwiupuRMK0U0lEW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AAKigp01AQ9Qpy0H5Afbl6B52sZ2askUtzATYvZSvTsKya/a/e3UVnEAHqTg+9Vmw
         U60DaSpK5cws2Bv8bhuCQYAEKoMzf2pqCCHEH+Na/o1ZfCLkcQtyGMG01WZCvz5eOh
         5nNXIw46JEZYzotaLddFhNIBAvYhmOui4q95IL2A=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dafna@fastmail.com, heiko@sntech.de,
        jeanmichel.hautbois@ideasonboard.com, jacopo@jmondi.org,
        djrscally@gmail.com, helen.koike@collabora.com,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 19/55] media: rkisp1: isp: Start CSI-2 receiver before ISP
Date:   Wed, 15 Jun 2022 04:10:51 +0900
Message-Id: <20220614191127.3420492-20-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614191127.3420492-1-paul.elder@ideasonboard.com>
References: <20220614191127.3420492-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Make sure the ISP is ready to receive data before starting the CSI-2
receiver by starting it first. Similarly, stop the CSI-2 receiver before
the ISP when stopping streaming.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
index 5eabb321e320..0e68c8d53404 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
@@ -771,8 +771,9 @@ static int rkisp1_isp_s_stream(struct v4l2_subdev *sd, int enable)
 		v4l2_subdev_call(rkisp1->active_sensor->sd, video, s_stream,
 				 false);
 
-		rkisp1_isp_stop(rkisp1);
 		rkisp1_mipi_csi2_stop(&rkisp1->csi);
+		rkisp1_isp_stop(rkisp1);
+
 		return 0;
 	}
 
@@ -794,11 +795,13 @@ static int rkisp1_isp_s_stream(struct v4l2_subdev *sd, int enable)
 	if (ret)
 		goto mutex_unlock;
 
+	rkisp1_isp_start(rkisp1);
+
 	ret = rkisp1_mipi_csi2_start(&rkisp1->csi, rkisp1->active_sensor);
-	if (ret)
+	if (ret) {
+		rkisp1_isp_stop(rkisp1);
 		goto mutex_unlock;
-
-	rkisp1_isp_start(rkisp1);
+	}
 
 	ret = v4l2_subdev_call(rkisp1->active_sensor->sd, video, s_stream,
 			       true);
-- 
2.30.2

