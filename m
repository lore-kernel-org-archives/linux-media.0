Return-Path: <SRS0=eNRI=IE=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4935C433DB
	for <linux-media@archiver.kernel.org>; Sat,  6 Mar 2021 13:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB6C65024
	for <linux-media@archiver.kernel.org>; Sat,  6 Mar 2021 13:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhCFN5B (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 6 Mar 2021 08:57:01 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:10943 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230481AbhCFN4k (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 6 Mar 2021 08:56:40 -0500
X-IronPort-AV: E=Sophos;i="5.81,228,1610406000"; 
   d="scan'208";a="496488757"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Mar 2021 14:56:38 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: flexcop-usb: delete unneeded return
Date:   Sat,  6 Mar 2021 14:42:25 +0100
Message-Id: <20210306134225.1659307-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

No need for a return after a break;

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/media/usb/b2c2/flexcop-usb.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/usb/b2c2/flexcop-usb.c b/drivers/media/usb/b2c2/flexcop-usb.c
index e731243267e4..01d22834f4ac 100644
--- a/drivers/media/usb/b2c2/flexcop-usb.c
+++ b/drivers/media/usb/b2c2/flexcop-usb.c
@@ -195,7 +195,6 @@ static int flexcop_usb_memory_req(struct flexcop_usb *fc_usb,
 		break;
 	default:
 		return -EINVAL;
-		break;
 	}
 	for (i = 0; i < len;) {
 		pagechunk =

