Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5118AC433FE
	for <linux-media@archiver.kernel.org>; Sun,  6 Dec 2020 23:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A83A206FC
	for <linux-media@archiver.kernel.org>; Sun,  6 Dec 2020 23:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgLFXzm (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 6 Dec 2020 18:55:42 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:60444 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbgLFXzm (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sun, 6 Dec 2020 18:55:42 -0500
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7B0AB5B0;
        Mon,  7 Dec 2020 00:54:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1607298841;
        bh=9MlnoAZtJ+Qpn4SOYDiulmN1AGhGk3w0WLJpplDZJ0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TWQpt+avKQLldOkeMvC7S58sxiJCakCARXqJlsJnsfEUiJ2FpEcVpYhDwIFfaQeTt
         u9J9Z34gfvRklXmvpCgUf6LWQfFHmFAf7oQ0kXC3a+tFF6vwyxET1TvFSFjMiVtBAn
         fDctUblQoDT6rxA4GW66NwlB4Pj/tjbXMedWdtnE=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Benoit Parrot <bparrot@ti.com>
Subject: [PATCH v3 05/24] media: ti-vpe: cal: Replace hardcoded BIT() value with macro
Date:   Mon,  7 Dec 2020 01:53:34 +0200
Message-Id: <20201206235353.26968-6-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201206235353.26968-1-laurent.pinchart@ideasonboard.com>
References: <20201206235353.26968-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Replace the hardcoded BIT(3) value with CAL_CSI2_PPI_CTRL_FRAME_MASK to
increase readability.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/media/platform/ti-vpe/cal-camerarx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti-vpe/cal-camerarx.c b/drivers/media/platform/ti-vpe/cal-camerarx.c
index 1c9ce30eb7af..6af09d4c0049 100644
--- a/drivers/media/platform/ti-vpe/cal-camerarx.c
+++ b/drivers/media/platform/ti-vpe/cal-camerarx.c
@@ -485,7 +485,8 @@ void cal_camerarx_disable_irqs(struct cal_camerarx *phy)
 
 void cal_camerarx_ppi_enable(struct cal_camerarx *phy)
 {
-	cal_write(phy->cal, CAL_CSI2_PPI_CTRL(phy->instance), BIT(3));
+	cal_write(phy->cal, CAL_CSI2_PPI_CTRL(phy->instance),
+		  CAL_CSI2_PPI_CTRL_FRAME_MASK);
 	cal_write_field(phy->cal, CAL_CSI2_PPI_CTRL(phy->instance),
 			1, CAL_CSI2_PPI_CTRL_IF_EN_MASK);
 }
-- 
Regards,

Laurent Pinchart

