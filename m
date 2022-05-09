Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD85C433EF
	for <linux-media@archiver.kernel.org>; Mon,  9 May 2022 09:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiEIJvS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 9 May 2022 05:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbiEIJUK (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 9 May 2022 05:20:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D1A1A5
        for <linux-media@vger.kernel.org>; Mon,  9 May 2022 02:16:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94194B810AD
        for <linux-media@vger.kernel.org>; Mon,  9 May 2022 09:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60007C385AC;
        Mon,  9 May 2022 09:16:00 +0000 (UTC)
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 4/7] cx25821: request_irq -> devm_request_irq
Date:   Mon,  9 May 2022 11:15:50 +0200
Message-Id: <20220509091553.2637089-5-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220509091553.2637089-1-hverkuil-cisco@xs4all.nl>
References: <20220509091553.2637089-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fixes smatch warning:

drivers/media/pci/cx25821/cx25821-alsa.c:768 cx25821_audio_initdev() warn: 'dev->pci->irq' from request_irq() not released on lines: 768.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/pci/cx25821/cx25821-alsa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/cx25821/cx25821-alsa.c b/drivers/media/pci/cx25821/cx25821-alsa.c
index 438fdcec6eac..a42f0c03a7ca 100644
--- a/drivers/media/pci/cx25821/cx25821-alsa.c
+++ b/drivers/media/pci/cx25821/cx25821-alsa.c
@@ -728,8 +728,8 @@ static int cx25821_audio_initdev(struct cx25821_dev *dev)
 
 	chip->irq = dev->pci->irq;
 
-	err = request_irq(dev->pci->irq, cx25821_irq,
-			  IRQF_SHARED, chip->dev->name, chip);
+	err = devm_request_irq(&dev->pci->dev, dev->pci->irq, cx25821_irq,
+			       IRQF_SHARED, chip->dev->name, chip);
 
 	if (err < 0) {
 		pr_err("ERROR %s: can't get IRQ %d for ALSA\n", chip->dev->name,
-- 
2.34.1

