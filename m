Return-Path: <SRS0=EymB=74=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33D0C433DF
	for <linux-media@archiver.kernel.org>; Mon, 15 Jun 2020 00:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9209020768
	for <linux-media@archiver.kernel.org>; Mon, 15 Jun 2020 00:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lRQma3fh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgFOAAV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 14 Jun 2020 20:00:21 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33340 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbgFOAAT (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 14 Jun 2020 20:00:19 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 47F7E1226;
        Mon, 15 Jun 2020 02:00:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1592179213;
        bh=BhModmrEoSPbfADhsttAl114ypV2e9RFHamaQXx6vLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRQma3fhF8xoNSJSPsqJuaNuymTS69lRup1CC1YoYLgfGL33n8KuHVMgubcjNaTbJ
         nKJXGY40GPKufOFbhottTfWQrpK/kY5cWClzWs6nJz7cp1Y6JyyMowVt9x4ADD5opK
         eF1Omhms7x2zld/N6rh0RQmV6TSbXog0OnjzG50E=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Benoit Parrot <bparrot@ti.com>
Subject: [PATCH v1 007/107] media: ti-vpe: cal: Inline CAL_VERSION macro in its only user
Date:   Mon, 15 Jun 2020 02:58:04 +0300
Message-Id: <20200614235944.17716-8-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200614235944.17716-1-laurent.pinchart@ideasonboard.com>
References: <20200614235944.17716-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The CAL_VERSION macro is used once only, in MODULE_VERSION(). This
doesn't improve readability, inline it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/ti-vpe/cal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index 0a5fb81223da..fa86a53882cc 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -39,12 +39,10 @@
 #define MAX_WIDTH_BYTES (8192 * 8)
 #define MAX_HEIGHT_LINES 16383
 
-#define CAL_VERSION "0.1.0"
-
 MODULE_DESCRIPTION("TI CAL driver");
 MODULE_AUTHOR("Benoit Parrot, <bparrot@ti.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_VERSION(CAL_VERSION);
+MODULE_VERSION("0.1.0");
 
 static unsigned video_nr = -1;
 module_param(video_nr, uint, 0644);
-- 
Regards,

Laurent Pinchart

