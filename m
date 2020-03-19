Return-Path: <SRS0=S52y=5E=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B13C4332B
	for <linux-media@archiver.kernel.org>; Thu, 19 Mar 2020 07:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613A820724
	for <linux-media@archiver.kernel.org>; Thu, 19 Mar 2020 07:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ldsKJl9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgCSHvL (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 19 Mar 2020 03:51:11 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33334 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgCSHvK (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 19 Mar 2020 03:51:10 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02J7p8Ru114236;
        Thu, 19 Mar 2020 02:51:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584604268;
        bh=jdWXGCtwSJlVPHlp6NdT3+malgYS6cXlA0SFsXGKnXc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ldsKJl9PNtg70IorETpnqdEKZLfetOLJtfYrDLNg2LPjkT7QQmwTq88F8/UmYfdGv
         PiHHEF9Nkpw4PkEShl0hZJI2ak+Rhm9OyVM+Bbqd6BNAx0vETiYfe1JcPelJdwkPHZ
         OqZ3r1nLNgOeIWfJQo9qXvDWJIa5ZirXJS9CppgU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02J7p7Ks130385
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Mar 2020 02:51:08 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Mar 2020 02:51:07 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Mar 2020 02:51:07 -0500
Received: from deskari.lan (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02J7oXqv047151;
        Thu, 19 Mar 2020 02:51:06 -0500
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
To:     <linux-media@vger.kernel.org>, Benoit Parrot <bparrot@ti.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH v2 18/19] media: ti-vpe: cal: improve wait for stop-state
Date:   Thu, 19 Mar 2020 09:50:22 +0200
Message-ID: <20200319075023.22151-19-tomi.valkeinen@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319075023.22151-1-tomi.valkeinen@ti.com>
References: <20200319075023.22151-1-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Sometimes there is a timeout when waiting for the Stop-State.  Testing
shows that sometimes we need to wait more than what the current code
does. It is not clear how long this wait can be, but it is based on how
quickly the sensor provides a valid clock, and how quickly CAL syncs to
it.

Change the code to make it more obvious how long we'll wait, and set a
wider range for usleep_range. Increase the timeout to 750ms.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Tested-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/media/platform/ti-vpe/cal.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index 0dc7892881e7..0f90078ee8c2 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -846,19 +846,16 @@ static void csi2_wait_complexio_reset(struct cal_ctx *ctx)
 
 static void csi2_wait_stop_state(struct cal_ctx *ctx)
 {
-	int i;
+	unsigned long timeout;
 
-	for (i = 0; i < 10; i++) {
+	timeout = jiffies + msecs_to_jiffies(750);
+	while (time_before(jiffies, timeout)) {
 		if (reg_read_field(ctx->dev,
 				   CAL_CSI2_TIMING(ctx->csi2_port),
 				   CAL_CSI2_TIMING_FORCE_RX_MODE_IO1_MASK) == 0)
 			break;
-		usleep_range(1000, 1100);
+		usleep_range(500, 5000);
 	}
-	ctx_dbg(3, ctx, "CAL_CSI2_TIMING(%d) = 0x%08x Stop State Reached %s\n",
-		ctx->csi2_port,
-		reg_read(ctx->dev, CAL_CSI2_TIMING(ctx->csi2_port)),
-		(i >= 10) ? "(timeout)" : "");
 
 	if (reg_read_field(ctx->dev, CAL_CSI2_TIMING(ctx->csi2_port),
 			   CAL_CSI2_TIMING_FORCE_RX_MODE_IO1_MASK) != 0)
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

