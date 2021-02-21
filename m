Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE75FC433DB
	for <linux-media@archiver.kernel.org>; Sun, 21 Feb 2021 21:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 998D264E4B
	for <linux-media@archiver.kernel.org>; Sun, 21 Feb 2021 21:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhBUVOP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 21 Feb 2021 16:14:15 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:53106 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhBUVOP (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 21 Feb 2021 16:14:15 -0500
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C2BA1E9
        for <linux-media@vger.kernel.org>; Sun, 21 Feb 2021 22:13:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1613942013;
        bh=nUwJljfzym7/3wJhff4vgneOrVQDeDzKf6fxgmktgp8=;
        h=From:To:Subject:Date:From;
        b=OnfH0t+QPijPJJMUq0dONkFECfNg/VXBURZcsW9vk+All5+5p6Btx7QgVPkaGQKdY
         31r++8dFj5YoQC1WJcYNildqDd2xOdZlBEDhieMgju1h8x0elYDWZKJs9az5ceva1+
         tQ7SHkUKSWJFAe4p0O/77itf832MOhGybQFL5+L4=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH] media: uvcvideo: Fix XU id print in forward scan
Date:   Sun, 21 Feb 2021 23:13:01 +0200
Message-Id: <20210221211301.21193-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

An error message in the forward scan code incorrectly prints the ID of
the source entity instead of the XU entity being scanned. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/usb/uvc/uvc_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 30ef2a3110f7..e55cf02baad6 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1712,7 +1712,7 @@ static int uvc_scan_chain_forward(struct uvc_video_chain *chain,
 			if (forward->bNrInPins != 1) {
 				uvc_dbg(chain->dev, DESCR,
 					"Extension unit %d has more than 1 input pin\n",
-					entity->id);
+					forward->id);
 				return -EINVAL;
 			}
 
-- 
Regards,

Laurent Pinchart

