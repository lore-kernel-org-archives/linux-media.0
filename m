Return-Path: <SRS0=iZD8=AR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D732EC433E1
	for <linux-media@archiver.kernel.org>; Mon,  6 Jul 2020 18:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B27D8206DF
	for <linux-media@archiver.kernel.org>; Mon,  6 Jul 2020 18:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="M7c49Umt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbgGFShi (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:37:38 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45198 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbgGFShf (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 6 Jul 2020 14:37:35 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DD06F1942;
        Mon,  6 Jul 2020 20:37:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594060651;
        bh=WkhsRClnatKxgddnJ6HOKKArxl2llLqIcmosbw/fSjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7c49UmtsJOuXhk+iicT4RvAD3gVopjYaLQwH0zUbafqBDsoe44NFovMjHWLBmV5S
         Y2ihRBj6jhKL3tnm+W6ok1hiwasuWu76+MJprS4TicY8vpFfns14j221NiXa4dA496
         Cgl7CsBly+evkV5FnjNIZFdJ9R2ShfxnfrzNk8vs=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Benoit Parrot <bparrot@ti.com>
Subject: [PATCH v2 007/108] media: ti-vpe: cal: Inline CAL_VERSION macro in its only user
Date:   Mon,  6 Jul 2020 21:35:28 +0300
Message-Id: <20200706183709.12238-8-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200706183709.12238-1-laurent.pinchart@ideasonboard.com>
References: <20200706183709.12238-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The CAL_VERSION macro is used once only, in MODULE_VERSION(). This
doesn't improve readability, inline it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/media/platform/ti-vpe/cal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index 2aa28af7cad3..9b5ad48538c1 100644
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

