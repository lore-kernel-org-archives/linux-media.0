Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D26FC2B9F4
	for <linux-media@archiver.kernel.org>; Mon, 14 Jun 2021 11:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FA8A610A0
	for <linux-media@archiver.kernel.org>; Mon, 14 Jun 2021 11:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbhFNLde (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 14 Jun 2021 07:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbhFNLbc (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 14 Jun 2021 07:31:32 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EA6C061149
        for <linux-media@vger.kernel.org>; Mon, 14 Jun 2021 04:26:05 -0700 (PDT)
Received: from deskari.lan (91-158-153-130.elisa-laajakaista.fi [91.158.153.130])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1C849119F;
        Mon, 14 Jun 2021 13:24:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1623669842;
        bh=dcuk+dN0LQ0zVj1fXv059e5i+OcoKgnHLaj0CzabEEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SneFFLpMSeSCxa/d42GAg8KK4kRU8y8k1QmcSbWzvkq+OizfJIx7FVmoilQAucnp+
         MbN8pHJjoSsCiPP9rgR1Ex6oyFaKVBTFeeZTwjImRSO3ERVT2zqfZzlbghMiVnj7cb
         SGb3IMEoVoR7Zbj/LLTXQCIPMV2FHmChlOpsirXE=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     linux-media@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v4 02/35] media: ti-vpe: cal: fix error handling in cal_camerarx_create
Date:   Mon, 14 Jun 2021 14:23:12 +0300
Message-Id: <20210614112345.2032435-3-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614112345.2032435-1-tomi.valkeinen@ideasonboard.com>
References: <20210614112345.2032435-1-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

cal_camerarx_create() doesn't handle error returned from
cal_camerarx_sd_init_cfg(). Fix this.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/ti-vpe/cal-camerarx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti-vpe/cal-camerarx.c b/drivers/media/platform/ti-vpe/cal-camerarx.c
index 124a4e2bdefe..e2e384a887ac 100644
--- a/drivers/media/platform/ti-vpe/cal-camerarx.c
+++ b/drivers/media/platform/ti-vpe/cal-camerarx.c
@@ -845,7 +845,9 @@ struct cal_camerarx *cal_camerarx_create(struct cal_dev *cal,
 	if (ret)
 		goto error;
 
-	cal_camerarx_sd_init_cfg(sd, NULL);
+	ret = cal_camerarx_sd_init_cfg(sd, NULL);
+	if (ret)
+		goto error;
 
 	ret = v4l2_device_register_subdev(&cal->v4l2_dev, sd);
 	if (ret)
-- 
2.25.1

