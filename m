Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B76C433E6
	for <linux-media@archiver.kernel.org>; Wed, 10 Feb 2021 17:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C869A64E79
	for <linux-media@archiver.kernel.org>; Wed, 10 Feb 2021 17:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhBJRsP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Feb 2021 12:48:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51186 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbhBJRra (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Feb 2021 12:47:30 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1l9tYp-0002MG-H3; Wed, 10 Feb 2021 17:46:41 +0000
From:   Colin King <colin.king@canonical.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] media: uvcvideo: remove duplicated dma_dev assignment
Date:   Wed, 10 Feb 2021 17:45:55 +0000
Message-Id: <20210210174555.144128-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The assignment to dma_dev has been performed twice in one
statement. Fix this by removing the extraneous assignment.

Addresses-Coverity: ("Evaluation order violation")
Fixes: fdcd02a641e2 ("media: uvcvideo: Use dma_alloc_noncontiguos API")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/media/usb/uvc/uvc_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index dc81f9a86eca..edf451a956d8 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1105,7 +1105,7 @@ static inline struct device *stream_to_dmadev(struct uvc_streaming *stream)
 
 static void uvc_urb_dma_sync(struct uvc_urb *uvc_urb, bool for_device)
 {
-	struct device *dma_dev = dma_dev = stream_to_dmadev(uvc_urb->stream);
+	struct device *dma_dev = stream_to_dmadev(uvc_urb->stream);
 
 	if (for_device) {
 		dma_sync_sgtable_for_device(dma_dev, uvc_urb->sgt,
-- 
2.30.0

