Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81520C49EB7
	for <linux-media@archiver.kernel.org>; Mon, 14 Jun 2021 11:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A85C61241
	for <linux-media@archiver.kernel.org>; Mon, 14 Jun 2021 11:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbhFNLmI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 14 Jun 2021 07:42:08 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58306 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237132AbhFNLk6 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 14 Jun 2021 07:40:58 -0400
Received: from deskari.lan (91-158-153-130.elisa-laajakaista.fi [91.158.153.130])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D9E4A5EAD;
        Mon, 14 Jun 2021 13:24:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1623669852;
        bh=o0ln9d8Cx4a5rBX/eEMlHFBmansWsqO/bPdyKCrOGUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pBcaFI1riGrrfH8rXIocgwZGXiOPL/reUWLHOOP6iZCiv7VvW3NTKJsNTlSTp4Dc3
         vUUMozdpsQySrlbm+8UO1qesDae30UWljyp3wWdfAB1tCIqFIR9gwjV6CZuRD80GqB
         SQ/YJJJ7bsNhsX86y1PO44rzlttCYp0KIxUiW3vA=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     linux-media@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v4 23/35] media: ti-vpe: cal: fix typo in a comment
Date:   Mon, 14 Jun 2021 14:23:33 +0300
Message-Id: <20210614112345.2032435-24-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614112345.2032435-1-tomi.valkeinen@ideasonboard.com>
References: <20210614112345.2032435-1-tomi.valkeinen@ideasonboard.com>
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

