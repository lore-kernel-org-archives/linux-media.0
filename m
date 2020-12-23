Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CD9C432C3
	for <linux-media@archiver.kernel.org>; Wed, 23 Dec 2020 02:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3D882256F
	for <linux-media@archiver.kernel.org>; Wed, 23 Dec 2020 02:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbgLWCu0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 22 Dec 2020 21:50:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:49842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729516AbgLWCV4 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 22 Dec 2020 21:21:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFFDD22AAF;
        Wed, 23 Dec 2020 02:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608690100;
        bh=HBFKJRUNnuRB3+JHTHYEaqddBshl2Ypix3QmFmjnWHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QtT8ljVGhI3wsoJ301a7f8Re+Ivo2Kn/CXik4Gw1BOvDOOJbfaNYnFFXszgKeEPc1
         oZTJj5zKh/HG3/kjPrxeIgNRyjOprctbjqrXGo1/og+j2gFokz2xs0jkuUeIVQB34d
         B5skUwyNJta+L0WB4bqBtj/SOenweOE4Nzfle5P+pHj//klR/6CLoB0LVhLRzvvBvj
         9LtPUMkZjfTR4t4iVNsPdZxzae/Ht3FopUYjdXsunry5X2mw9bVpB8TtTWh1HM5WBT
         nxEU8d9Ov9WVlF4ky1SH2PP/6P23oe/PvWMIA7sK5kpJPIGXnGqpPZKbmf35paGWRE
         m+jbZxtfeidbA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qinglang Miao <miaoqinglang@huawei.com>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 30/87] media: usb: dvb-usb-v2: zd1301: fix missing platform_device_unregister()
Date:   Tue, 22 Dec 2020 21:20:06 -0500
Message-Id: <20201223022103.2792705-30-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223022103.2792705-1-sashal@kernel.org>
References: <20201223022103.2792705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Qinglang Miao <miaoqinglang@huawei.com>

[ Upstream commit ee50d6e60d9a8e110e984cdd9e788d93eff540ba ]

Add the missing platform_device_unregister() before return
from zd1301_frontend_attach in the error handling case when
pdev->dev.driver is empty.

There's an error handling route named err_platform_device_unregister,
so just reuse it.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb-v2/zd1301.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb-v2/zd1301.c b/drivers/media/usb/dvb-usb-v2/zd1301.c
index d1eb4b7bc0519..563d11fb6c18c 100644
--- a/drivers/media/usb/dvb-usb-v2/zd1301.c
+++ b/drivers/media/usb/dvb-usb-v2/zd1301.c
@@ -159,7 +159,7 @@ static int zd1301_frontend_attach(struct dvb_usb_adapter *adap)
 	}
 	if (!pdev->dev.driver) {
 		ret = -ENODEV;
-		goto err;
+		goto err_platform_device_unregister;
 	}
 	if (!try_module_get(pdev->dev.driver->owner)) {
 		ret = -ENODEV;
-- 
2.27.0

