Return-Path: <SRS0=7IOK=UF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9114C28D1D
	for <linux-media@archiver.kernel.org>; Thu,  6 Jun 2019 13:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2B0208CA
	for <linux-media@archiver.kernel.org>; Thu,  6 Jun 2019 13:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfFFNCd (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 6 Jun 2019 09:02:33 -0400
Received: from retiisi.org.uk ([95.216.213.190]:49878 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728166AbfFFNCa (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 6 Jun 2019 09:02:30 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1001])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id 68FBE634C87;
        Thu,  6 Jun 2019 16:02:18 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        jacopo@jmondi.org, niklas.soderlund@ragnatech.se
Subject: [PATCH v2 8/9] ipu3-cio2: Proceed with notifier init even if there are no subdevs
Date:   Thu,  6 Jun 2019 16:02:24 +0300
Message-Id: <20190606130225.10751-9-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190606130225.10751-1-sakari.ailus@linux.intel.com>
References: <20190606130225.10751-1-sakari.ailus@linux.intel.com>
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
index 373970f812f4..690d3bd08ddd 100644
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

