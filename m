Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8077AC433B4
	for <linux-media@archiver.kernel.org>; Tue,  4 May 2021 12:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 512A3613BC
	for <linux-media@archiver.kernel.org>; Tue,  4 May 2021 12:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhEDM1s (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 4 May 2021 08:27:48 -0400
Received: from www.zeus03.de ([194.117.254.33]:39834 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230133AbhEDM1r (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 4 May 2021 08:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=IJoVgc0rDjC9hvmw012JfGzIlDq
        CXupqMVtab30co9g=; b=OgnOFkRA1LxROgnyeHkyOvdHkjmmzZ8nzZG72/DqHak
        cE9lRyCOLD3azVoCOKDU5EhaZC8aC8A4htidBtPz+5Ayy4x11kpRzS+LSl6ZHTef
        ebOFyWTOpZM5VVZoP0P3Mu8z9gfhFQx7j0h9TG3lBsnyhINshencTSQXFXwyz1CI
        =
Received: (qmail 1356275 invoked from network); 4 May 2021 14:26:51 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 May 2021 14:26:51 +0200
X-UD-Smtp-Session: l3s3148p1@FH5VMYDBuIsgAwDPXxOMAJUzfx/HAvHg
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: coda: set debugfs blobs to read only
Date:   Tue,  4 May 2021 14:26:48 +0200
Message-Id: <20210504122649.44870-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Those blobs can only be read. So, don't confuse users with 'writable'
flags.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Found while working with blobs myself. I don't have coda HW.

 drivers/media/platform/coda/coda-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index 995e95272e51..294dfe7e1d33 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -1935,7 +1935,7 @@ int coda_alloc_aux_buf(struct coda_dev *dev, struct coda_aux_buf *buf,
 	if (name && parent) {
 		buf->blob.data = buf->vaddr;
 		buf->blob.size = size;
-		buf->dentry = debugfs_create_blob(name, 0644, parent,
+		buf->dentry = debugfs_create_blob(name, 0444, parent,
 						  &buf->blob);
 	}
 
@@ -3230,7 +3230,7 @@ static int coda_probe(struct platform_device *pdev)
 		memset(dev->iram.vaddr, 0, dev->iram.size);
 		dev->iram.blob.data = dev->iram.vaddr;
 		dev->iram.blob.size = dev->iram.size;
-		dev->iram.dentry = debugfs_create_blob("iram", 0644,
+		dev->iram.dentry = debugfs_create_blob("iram", 0444,
 						       dev->debugfs_root,
 						       &dev->iram.blob);
 	}
-- 
2.30.0

