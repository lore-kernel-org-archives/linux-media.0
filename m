Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DCBC433DB
	for <linux-media@archiver.kernel.org>; Thu, 21 Jan 2021 08:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7551223976
	for <linux-media@archiver.kernel.org>; Thu, 21 Jan 2021 08:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbhAUIaA (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 21 Jan 2021 03:30:00 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:56738 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726513AbhAUI3m (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 21 Jan 2021 03:29:42 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UMPTmlJ_1611217732;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UMPTmlJ_1611217732)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Jan 2021 16:29:00 +0800
From:   Yang Li <abaci-bugfix@linux.alibaba.com>
To:     mchehab@kernel.org
Cc:     sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Yang Li <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] media: atomisp: remove redundant NULL check
Date:   Thu, 21 Jan 2021 16:28:51 +0800
Message-Id: <1611217731-56866-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fix below warnings reported by coccicheck:
./drivers/staging/media/atomisp/pci/sh_css_params.c:1575:2-8: WARNING:
NULL check before some freeing functions is not needed.
./drivers/staging/media/atomisp/pci/sh_css_params.c:3006:2-8: WARNING:
NULL check before some freeing functions is not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <abaci-bugfix@linux.alibaba.com>
---
 drivers/staging/media/atomisp/pci/sh_css_params.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css_params.c b/drivers/staging/media/atomisp/pci/sh_css_params.c
index 24fc497..569473b9 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_params.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_params.c
@@ -1575,8 +1575,7 @@ struct ia_css_isp_3a_statistics_map *
 	return me;
 
 err:
-	if (me)
-		kvfree(me);
+	kvfree(me);
 	return NULL;
 }
 
@@ -3006,8 +3005,7 @@ static void free_map(struct sh_css_ddr_address_map *map)
 	}
 
 	kvfree(params);
-	if (per_frame_params)
-		kvfree(per_frame_params);
+	kvfree(per_frame_params);
 	stream->isp_params_configs = NULL;
 	stream->per_frame_isp_params_configs = NULL;
 
-- 
1.8.3.1

