Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CF4C2B9F7
	for <linux-media@archiver.kernel.org>; Mon, 24 May 2021 11:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AB99611CE
	for <linux-media@archiver.kernel.org>; Mon, 24 May 2021 11:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhEXLLK (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 24 May 2021 07:11:10 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33754 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbhEXLLG (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 24 May 2021 07:11:06 -0400
Received: from deskari.lan (91-157-208-71.elisa-laajakaista.fi [91.157.208.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 31D3C1C41;
        Mon, 24 May 2021 13:09:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1621854569;
        bh=o0ln9d8Cx4a5rBX/eEMlHFBmansWsqO/bPdyKCrOGUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BYG0BQ8GpRYBd6shFcoL0gwyPK+VcyigosZj6zOe17m5K2b+hbqgt8WsgjO5JetJ9
         PYXMsP2DOrTZwtVLTPox5wB127DDUtgcJ4JqWSXJYRXR7jR7ZCMl1VGbnXBNcieUS9
         R9XMDOtBsWmaWaRiBZ+AwJXmqUCaxLCBu1DW2rbM=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v3 23/38] media: ti-vpe: cal: fix typo in a comment
Date:   Mon, 24 May 2021 14:08:54 +0300
Message-Id: <20210524110909.672432-24-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210524110909.672432-1-tomi.valkeinen@ideasonboard.com>
References: <20210524110909.672432-1-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fix a typo in a comment in cal_camerarx_sd_set_fmt().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/ti-vpe/cal-camerarx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti-vpe/cal-camerarx.c b/drivers/media/platform/ti-vpe/cal-camerarx.c
index f2ea2bdb9ea3..7940e47964af 100644
--- a/drivers/media/platform/ti-vpe/cal-camerarx.c
+++ b/drivers/media/platform/ti-vpe/cal-camerarx.c
@@ -698,7 +698,7 @@ static int cal_camerarx_sd_set_fmt(struct v4l2_subdev *sd,
 		return cal_camerarx_sd_get_fmt(sd, sd_state, format);
 
 	/*
-	 * Default to the first format is the requested media bus code isn't
+	 * Default to the first format if the requested media bus code isn't
 	 * supported.
 	 */
 	fmtinfo = cal_format_by_code(format->format.code);
-- 
2.25.1

