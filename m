Return-Path: <SRS0=Cf27=CL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EB4C433E7
	for <linux-media@archiver.kernel.org>; Wed,  2 Sep 2020 16:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B54A620639
	for <linux-media@archiver.kernel.org>; Wed,  2 Sep 2020 16:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599063454;
	bh=zqQVmwBJFUyvG7NUGiAocdFONJNzYAoPsK4CmSnBlQA=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=sfJ7Y+cQGXQeUEr+dEUotwMVfh80EQ8cMiLvBHb4ChLIrTsL3wb5Ju6g5pOJoriJe
	 FMqlrxKDb2nGGcLxObvjErSR9RWrArIHsU8Ay44MRiimXsDxUjAb+kabfT6CNl7TV8
	 rjA6Hq3Rlz+kirU0FNFEJDPCfNSQn9XJ/T8UpIlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgIBQRb (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:17:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728078AbgIBQKu (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 2 Sep 2020 12:10:50 -0400
Received: from mail.kernel.org (ip5f5ad5c3.dynamic.kabel-deutschland.de [95.90.213.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC395214D8;
        Wed,  2 Sep 2020 16:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599063046;
        bh=zqQVmwBJFUyvG7NUGiAocdFONJNzYAoPsK4CmSnBlQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PZ8sJlOWtVhPnAEFoqiJYvBe9fsgsyCGzubxafXZQos6UeL9Ja3TpeqF/AOU54zeQ
         4QyWQZ6HGf9bkRGXDkakUJWhhHWWeBcugUYX3PpP/Y1uknULcDEGdU2gaBk9AEPVZ2
         bTdr82Qdb4Qcq/q9vvmkyE0tr4r6OCC4fzQhsueQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kDVLP-000t9y-RD; Wed, 02 Sep 2020 18:10:43 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/38] media: serial_ir: use the right type for a dma address
Date:   Wed,  2 Sep 2020 18:10:11 +0200
Message-Id: <e5ddb27c93563c7aa903d0c05fae9982c0c20bf9.1599062230.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599062230.git.mchehab+huawei@kernel.org>
References: <cover.1599062230.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

As warned by smatch:
	drivers/media/rc/serial_ir.c:550 serial_ir_probe() warn: should '8 << ioshift' be a 64 bit type?

the "8" constant should be unsigned long.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/rc/serial_ir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/serial_ir.c b/drivers/media/rc/serial_ir.c
index d77507ba0fb5..5b5b3203f5a0 100644
--- a/drivers/media/rc/serial_ir.c
+++ b/drivers/media/rc/serial_ir.c
@@ -547,7 +547,7 @@ static int serial_ir_probe(struct platform_device *dev)
 
 	/* Reserve io region. */
 	if ((iommap &&
-	     (devm_request_mem_region(&dev->dev, iommap, 8 << ioshift,
+	     (devm_request_mem_region(&dev->dev, iommap, 8UL << ioshift,
 				      KBUILD_MODNAME) == NULL)) ||
 	     (!iommap && (devm_request_region(&dev->dev, io, 8,
 			  KBUILD_MODNAME) == NULL))) {
-- 
2.26.2

