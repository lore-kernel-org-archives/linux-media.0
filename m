Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05C8C433EF
	for <linux-media@archiver.kernel.org>; Fri, 15 Jul 2022 15:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiGOPGo (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 15 Jul 2022 11:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbiGOPGK (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 15 Jul 2022 11:06:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9328B7CB56
        for <linux-media@vger.kernel.org>; Fri, 15 Jul 2022 08:06:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CCF5B82D10
        for <linux-media@vger.kernel.org>; Fri, 15 Jul 2022 15:06:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849E9C34115;
        Fri, 15 Jul 2022 15:06:06 +0000 (UTC)
Message-ID: <4fd23b1c-8a0a-1691-a4f9-526ec99bd193@xs4all.nl>
Date:   Fri, 15 Jul 2022 17:06:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH] vimc: wrong pointer is used with PTR_ERR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fix smatch warning:

drivers/media/test-drivers/vimc/vimc-core.c:214 vimc_create_links() warn: passing a valid pointer to 'PTR_ERR'

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
diff --git a/drivers/media/test-drivers/vimc/vimc-core.c b/drivers/media/test-drivers/vimc/vimc-core.c
index c73f91947f44..2ae7a0f11ebf 100644
--- a/drivers/media/test-drivers/vimc/vimc-core.c
+++ b/drivers/media/test-drivers/vimc/vimc-core.c
@@ -211,7 +211,7 @@ static int vimc_create_links(struct vimc_device *vimc)
 			media_create_ancillary_link(ved_primary->ent, ved_ancillary->ent);
 
 		if (IS_ERR(ret_link)) {
-			ret = PTR_ERR(link);
+			ret = PTR_ERR(ret_link);
 			goto err_rm_links;
 		}
 	}
