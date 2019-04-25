Return-Path: <SRS0=19ZY=S3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847DFC43218
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 18:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0095F2067C
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 18:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfDYShF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:37:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35426 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfDYShF (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Apr 2019 14:37:05 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 7A0E928259F
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com, Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 5/5] media: coda: Clear the interrupt reason
Date:   Thu, 25 Apr 2019 15:35:46 -0300
Message-Id: <20190425183546.16244-6-ezequiel@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425183546.16244-1-ezequiel@collabora.com>
References: <20190425183546.16244-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This commit clears the interrupt reason (INT_REASON) register
on the interrupt handler. Without this clearing, the CODA hardware
has been observed to get completely stalled on CODA980 variants,
requiring a pretty deep hardware reset.

The datasheet specifies that the INT_REASON register is set
by the CODA hardware, and should be cleared by the host.

While the CODA versions that are currently supported by this driver
don't seem to need this change, it's a really small change,
so it seems a wise thing to do to avoid hitting some
rare race-condition in the hardware.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/media/platform/coda/coda-bit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/coda/coda-bit.c b/drivers/media/platform/coda/coda-bit.c
index bddd2f5c8c2b..a653aaa3ca15 100644
--- a/drivers/media/platform/coda/coda-bit.c
+++ b/drivers/media/platform/coda/coda-bit.c
@@ -2301,6 +2301,7 @@ irqreturn_t coda_irq_handler(int irq, void *data)
 
 	/* read status register to attend the IRQ */
 	coda_read(dev, CODA_REG_BIT_INT_STATUS);
+	coda_write(dev, 0, CODA_REG_BIT_INT_REASON);
 	coda_write(dev, CODA_REG_BIT_INT_CLEAR_SET,
 		      CODA_REG_BIT_INT_CLEAR);
 
-- 
2.20.1

