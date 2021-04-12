Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6987DC433B4
	for <linux-media@archiver.kernel.org>; Mon, 12 Apr 2021 11:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4435C61261
	for <linux-media@archiver.kernel.org>; Mon, 12 Apr 2021 11:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240594AbhDLLf4 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:35:56 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:52640 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240569AbhDLLfx (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 12 Apr 2021 07:35:53 -0400
Received: from deskari.lan (91-157-208-71.elisa-laajakaista.fi [91.157.208.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BACC5DBC;
        Mon, 12 Apr 2021 13:35:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1618227335;
        bh=xX9LbsW7pyHbx/l3uIVk9MgK3eWkh/AChl+wzpO9VD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BW7GYLVwTEFi6OYsJ6CQtdZCHO/Fc9pKX7WV0ra4bWNJW6wadwudoEu/MJZO4qJWg
         ympg0qEL8TiIIMpzbtZC3Ni7XBPaAowP8ge6ZtcenwxBJXiqQBOnRJ6ESw0G3JWSsn
         VTLlvzUAhaOJ/+Exrgz5FVozjJa2v/Z6j0OcdlA0=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     Benoit Parrot <bparrot@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 22/28] media: ti-vpe: cal: set field always to V4L2_FIELD_NONE
Date:   Mon, 12 Apr 2021 14:34:51 +0300
Message-Id: <20210412113457.328012-23-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412113457.328012-1-tomi.valkeinen@ideasonboard.com>
References: <20210412113457.328012-1-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

cal_camerarx_sd_set_fmt() accepts any value for the format field, but
there should be no reason to have any other value accepted than
V4L2_FIELD_NONE. So set the field always to V4L2_FIELD_NONE.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/platform/ti-vpe/cal-camerarx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal-camerarx.c b/drivers/media/platform/ti-vpe/cal-camerarx.c
index 245c601b992c..880261d53a1d 100644
--- a/drivers/media/platform/ti-vpe/cal-camerarx.c
+++ b/drivers/media/platform/ti-vpe/cal-camerarx.c
@@ -702,10 +702,7 @@ static int cal_camerarx_sd_set_fmt(struct v4l2_subdev *sd,
 	if (!fmtinfo)
 		fmtinfo = &cal_formats[0];
 
-	/*
-	 * Clamp the size, update the code. The field and colorspace are
-	 * accepted as-is.
-	 */
+	/* Clamp the size, update the code. The colorspace is accepted as-is. */
 	bpp = ALIGN(fmtinfo->bpp, 8);
 
 	format->format.width = clamp_t(unsigned int, format->format.width,
@@ -715,6 +712,7 @@ static int cal_camerarx_sd_set_fmt(struct v4l2_subdev *sd,
 					CAL_MIN_HEIGHT_LINES,
 					CAL_MAX_HEIGHT_LINES);
 	format->format.code = fmtinfo->code;
+	format->format.field = V4L2_FIELD_NONE;
 
 	/* Store the format and propagate it to the source pad. */
 	fmt = cal_camerarx_get_pad_format(phy, cfg, CAL_CAMERARX_PAD_SINK,
-- 
2.25.1

