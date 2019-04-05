Return-Path: <SRS0=Dnes=SH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55638C4360F
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 09:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC6021850
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 09:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfDEJlc (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:41:32 -0400
Received: from retiisi.org.uk ([95.216.213.190]:40218 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729833AbfDEJlb (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 5 Apr 2019 05:41:31 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1001])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id 868E7634C8B;
        Fri,  5 Apr 2019 12:40:46 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, niklas.soderlund@ragnatech.se,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH 8/9] ipu3-cio2: Proceed with notifier init even if there are no subdevs
Date:   Fri,  5 Apr 2019 12:41:26 +0300
Message-Id: <20190405094127.18975-10-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190405094127.18975-1-sakari.ailus@linux.intel.com>
References: <20190405094127.18975-1-sakari.ailus@linux.intel.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The notifier may be registered even if there are no subdevs. Do that to
simplify the code.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/pci/intel/ipu3/ipu3-cio2.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
index 0b7428b10dfb..6fa995687314 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
@@ -1506,9 +1506,10 @@ static int cio2_notifier_init(struct cio2_device *cio2)
 	if (ret < 0)
 		goto out;
 
-	if (list_empty(&cio2->notifier.asd_list))
-		return -ENODEV;	/* no endpoint */
-
+	/*
+	 * Proceed even without sensors connected to allow the device to
+	 * suspend.
+	 */
 	cio2->notifier.ops = &cio2_async_ops;
 	ret = v4l2_async_notifier_register(&cio2->v4l2_dev, &cio2->notifier);
 	if (ret) {
@@ -1815,8 +1816,7 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 
 	/* Register notifier for subdevices we care */
 	r = cio2_notifier_init(cio2);
-	/* Proceed without sensors connected to allow the device to suspend. */
-	if (r && r != -ENODEV)
+	if (r)
 		goto fail_cio2_queue_exit;
 
 	r = devm_request_irq(&pci_dev->dev, pci_dev->irq, cio2_irq,
-- 
2.11.0

