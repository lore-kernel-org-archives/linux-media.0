Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4DDC388F7
	for <linux-media@archiver.kernel.org>; Fri, 13 Nov 2020 16:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44115208D5
	for <linux-media@archiver.kernel.org>; Fri, 13 Nov 2020 16:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgKMQNU (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 13 Nov 2020 11:13:20 -0500
Received: from mail.ispras.ru ([83.149.199.84]:50102 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgKMQNT (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 13 Nov 2020 11:13:19 -0500
Received: from localhost.localdomain (unknown [80.240.223.29])
        by mail.ispras.ru (Postfix) with ESMTPSA id A616A40A2041;
        Fri, 13 Nov 2020 16:06:31 +0000 (UTC)
From:   Baskov Evgeiny <baskov@ispras.ru>
To:     Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
Cc:     Baskov Evgeiny <baskov@ispras.ru>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] s5p-jpeg: hangle error condition in s5p_jpeg_probe
Date:   Fri, 13 Nov 2020 19:06:25 +0300
Message-Id: <20201113160625.1281-1-baskov@ispras.ru>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

If an error happens in jpeg_get_drv_data(), i.e. match fails,
jpeg->variant field is NULL, so we cannot access it.

Consider device probe failed if jpeg->variant is NULL.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Baskov Evgeiny <baskov@ispras.ru>
---
 drivers/media/platform/s5p-jpeg/jpeg-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/s5p-jpeg/jpeg-core.c b/drivers/media/platform/s5p-jpeg/jpeg-core.c
index 9b22dd8e34f4..026111505f5a 100644
--- a/drivers/media/platform/s5p-jpeg/jpeg-core.c
+++ b/drivers/media/platform/s5p-jpeg/jpeg-core.c
@@ -2862,6 +2862,8 @@ static int s5p_jpeg_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	jpeg->variant = jpeg_get_drv_data(&pdev->dev);
+	if (!jpeg->variant)
+		return -ENODEV;
 
 	mutex_init(&jpeg->lock);
 	spin_lock_init(&jpeg->slock);
-- 
2.29.2

