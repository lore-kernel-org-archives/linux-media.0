Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6F2C433EF
	for <linux-media@archiver.kernel.org>; Mon, 11 Jul 2022 12:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiGKMpq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 11 Jul 2022 08:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiGKMpJ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 11 Jul 2022 08:45:09 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C726320BDF
        for <linux-media@vger.kernel.org>; Mon, 11 Jul 2022 05:44:42 -0700 (PDT)
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D13B12B64;
        Mon, 11 Jul 2022 14:43:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1657543422;
        bh=N3hccJTZaKwLIucsH11uAzhxQ0X+ZEraF0MdIfMal/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sZ0Qzm2yWyxUpjkK4m5a3ltcFchO0PvnwqKUvqBrIr+uIzLiqWS0dszVfqfX//sHV
         msY0ZCHEFYbvwBCOZ/KOI8QLF+R80wWN/Sg3KJleZZ4xK7pVeLl1LOcs9HGNTsnVqb
         RZo2+cGvaJu/AjD/y2bKX8ZbIg4f5Y7d8TWec9qA=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        Paul Elder <paul.elder@ideasonboard.com>
Subject: [PATCH v3 37/46] media: rkisp1: isp: Rename rkisp1_get_remote_source()
Date:   Mon, 11 Jul 2022 15:42:39 +0300
Message-Id: <20220711124248.2683-38-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220711124248.2683-1-laurent.pinchart@ideasonboard.com>
References: <20220711124248.2683-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Rename the rkisp1_get_remote_source() function to
rkisp1_isp_get_source() to use a consistent rkisp1_isp_* prefix for all
ISP functions, and drop the "remote" as the source can't be local.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Dafna Hirschfeld <dafna@fastmail.com>
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
index 2ba227b2f6a1..37623b73b1d9 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
@@ -58,7 +58,7 @@
  * Helpers
  */
 
-static struct v4l2_subdev *rkisp1_get_remote_source(struct v4l2_subdev *sd)
+static struct v4l2_subdev *rkisp1_isp_get_source(struct v4l2_subdev *sd)
 {
 	struct media_pad *local, *remote;
 	struct media_entity *sensor_me;
@@ -754,7 +754,7 @@ static int rkisp1_isp_s_stream(struct v4l2_subdev *sd, int enable)
 		return 0;
 	}
 
-	rkisp1->source = rkisp1_get_remote_source(sd);
+	rkisp1->source = rkisp1_isp_get_source(sd);
 	if (!rkisp1->source) {
 		dev_warn(rkisp1->dev, "No link between isp and source\n");
 		return -ENODEV;
-- 
Regards,

Laurent Pinchart

