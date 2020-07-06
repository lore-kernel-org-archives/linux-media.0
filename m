Return-Path: <SRS0=iZD8=AR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C74BC433E0
	for <linux-media@archiver.kernel.org>; Mon,  6 Jul 2020 18:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E4A520773
	for <linux-media@archiver.kernel.org>; Mon,  6 Jul 2020 18:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hHKBTNhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbgGFShl (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:37:41 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45202 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbgGFShj (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 6 Jul 2020 14:37:39 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5B0F2E37;
        Mon,  6 Jul 2020 20:37:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594060654;
        bh=ZmK7dL+8s3SLxPhFJMVMCU0qxcakA5Hz5eYkwm0Frcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hHKBTNhmMrpvtjlL/hmlmhq6gAQ4aYcgKU+kTmLQN06zgYIx1bZCm4JpVKik1ZOmc
         qGKzcaMGSOSRAoIE8roh1pkXDIXcfAeArcb9j1wKntvfsBe3KjyG8oQya3R1q22yYF
         OtdMtsI5w1e6nu8IK+F5Z2Vjz0nhXKzvmEEdJj4w=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Benoit Parrot <bparrot@ti.com>
Subject: [PATCH v2 012/108] media: ti-vpe: cal: Turn boolean variable into bool
Date:   Mon,  6 Jul 2020 21:35:33 +0300
Message-Id: <20200706183709.12238-13-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200706183709.12238-1-laurent.pinchart@ideasonboard.com>
References: <20200706183709.12238-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The found_port variable contains a boolean value, make it a bool.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/media/platform/ti-vpe/cal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index ee6f700ad190..edb1034f3b04 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -2074,7 +2074,8 @@ static int of_cal_create_instance(struct cal_ctx *ctx, int inst)
 	struct v4l2_fwnode_endpoint *endpoint;
 	struct v4l2_async_subdev *asd;
 	u32 regval = 0;
-	int ret, index, found_port = 0, lane;
+	int ret, index, lane;
+	bool found_port = false;
 
 	parent = pdev->dev.of_node;
 
@@ -2099,7 +2100,7 @@ static int of_cal_create_instance(struct cal_ctx *ctx, int inst)
 		ctx_dbg(3, ctx, "port:%d inst:%d <reg>:%d\n",
 			index, inst, regval);
 		if ((regval == inst) && (index == inst)) {
-			found_port = 1;
+			found_port = true;
 			break;
 		}
 	}
-- 
Regards,

Laurent Pinchart

