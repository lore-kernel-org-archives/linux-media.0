Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE999C77B78
	for <linux-media@archiver.kernel.org>; Fri, 14 Apr 2023 11:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjDNL1v (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 14 Apr 2023 07:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjDNL1t (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 14 Apr 2023 07:27:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBABB1FDA
        for <linux-media@vger.kernel.org>; Fri, 14 Apr 2023 04:27:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7789C646D9
        for <linux-media@vger.kernel.org>; Fri, 14 Apr 2023 11:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CF8C433EF;
        Fri, 14 Apr 2023 11:27:47 +0000 (UTC)
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCHv3 03/18] media: pci: saa7146: hexium_orion: initialize input 0
Date:   Fri, 14 Apr 2023 13:27:27 +0200
Message-Id: <20230414112742.27749-4-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230414112742.27749-1-hverkuil-cisco@xs4all.nl>
References: <20230414112742.27749-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

When this driver is loaded for the first time, input 0 is
not initialized. In order to capture from that input you would
have to switch to input 1, then back to 0.

Properly initialize the input when the driver is loaded.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/pci/saa7146/hexium_orion.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/pci/saa7146/hexium_orion.c b/drivers/media/pci/saa7146/hexium_orion.c
index 2eb4bee16b71..6207f0861bb0 100644
--- a/drivers/media/pci/saa7146/hexium_orion.c
+++ b/drivers/media/pci/saa7146/hexium_orion.c
@@ -379,6 +379,7 @@ static int hexium_attach(struct saa7146_dev *dev, struct saa7146_pci_extension_d
 	/* the rest */
 	hexium->cur_input = 0;
 	hexium_init_done(dev);
+	hexium_set_input(hexium, 0);
 
 	return 0;
 }
-- 
2.39.2

