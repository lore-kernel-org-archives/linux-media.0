Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F08C43611
	for <linux-media@archiver.kernel.org>; Wed, 28 Apr 2021 14:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56D5F6143E
	for <linux-media@archiver.kernel.org>; Wed, 28 Apr 2021 14:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239917AbhD1OzZ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 28 Apr 2021 10:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240396AbhD1Oxs (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 28 Apr 2021 10:53:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AACE16193B;
        Wed, 28 Apr 2021 14:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619621564;
        bh=WMp2TYCwNpx5gqoBY3FxSLCFIcbo/CZW59R5D62z+MU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IxXpDz+CdCt1mZpDcdCdZrrhZUD/ZFbK8bTF7rQd883tbsYbmuCFtp52Ipc6enqb2
         S0DB5fye6/xQasoozfCuTigx5jynVfXN0/Y89Jjbc54+5+jbDKIfate3zZzvftoazf
         srgmI9i+ugpW1BsYt1NMmpowJQrKLcJBvQAQQJmNzplU2GeFLDJlMfMKqxnPTykrhM
         oNx7tnwTM3r5DhGXgIBX9lJZvU0TJf9K35gGra4QWXK2ICFfcFztIGUT9wYLu3CXE5
         5ssY+DUlxd/o1APTtN7IrUr2oVdB3Rlpx9FNUpTilVu10Ua2gCcdEBPuy5+VQTHLbE
         2GmwXtC3yYYzQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lblYR-001DsU-AG; Wed, 28 Apr 2021 16:52:43 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Dan Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Yong Zhi <yong.zhi@intel.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v4 60/79] media: ipu3: use pm_runtime_resume_and_get()
Date:   Wed, 28 Apr 2021 16:52:21 +0200
Message-Id: <d4582829ac01f26ce1c9b9bcbcaaacc4c6f71631.1619621413.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619621413.git.mchehab+huawei@kernel.org>
References: <cover.1619621413.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to deal with usage counter")
added pm_runtime_resume_and_get() in order to automatically handle
dev->power.usage_count decrement on errors.

Use the new API, in order to cleanup the error check logic.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
index fecef85bd62e..ca8040d1a725 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
@@ -975,10 +975,9 @@ static int cio2_vb2_start_streaming(struct vb2_queue *vq, unsigned int count)
 	cio2->cur_queue = q;
 	atomic_set(&q->frame_sequence, 0);
 
-	r = pm_runtime_get_sync(&cio2->pci_dev->dev);
+	r = pm_runtime_resume_and_get(&cio2->pci_dev->dev);
 	if (r < 0) {
 		dev_info(&cio2->pci_dev->dev, "failed to set power %d\n", r);
-		pm_runtime_put_noidle(&cio2->pci_dev->dev);
 		return r;
 	}
 
-- 
2.30.2

