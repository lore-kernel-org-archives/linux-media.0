Return-Path: <SRS0=r2j8=UK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FCFC43218
	for <linux-media@archiver.kernel.org>; Tue, 11 Jun 2019 12:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F5F21721
	for <linux-media@archiver.kernel.org>; Tue, 11 Jun 2019 12:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388904AbfFKMvF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 11 Jun 2019 08:51:05 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43943 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388214AbfFKMvF (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 11 Jun 2019 08:51:05 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hagEw-00077w-QG; Tue, 11 Jun 2019 14:51:02 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Jonas Karlman <jonas@kwiboo.se>, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v4 06/10] media: hantro: add support for separate control block
Date:   Tue, 11 Jun 2019 14:50:54 +0200
Message-Id: <20190611125058.13470-7-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611125058.13470-1-p.zabel@pengutronix.de>
References: <20190611125058.13470-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On i.MX8MQ/MM a separate control block contains registers for per-core
resets, clock gating, and fuse register control.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/staging/media/hantro/hantro.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/media/hantro/hantro.h b/drivers/staging/media/hantro/hantro.h
index e8eb747f22ef..5c2f87272ce2 100644
--- a/drivers/staging/media/hantro/hantro.h
+++ b/drivers/staging/media/hantro/hantro.h
@@ -167,6 +167,7 @@ hantro_vdev_to_func(struct video_device *vdev)
  * @reg_bases:		Mapped addresses of VPU registers.
  * @enc_base:		Mapped address of VPU encoder register for convenience.
  * @dec_base:		Mapped address of VPU decoder register for convenience.
+ * @ctrl_base:		Mapped address of VPU control block.
  * @vpu_mutex:		Mutex to synchronize V4L2 calls.
  * @irqlock:		Spinlock to synchronize access to data structures
  *			shared with interrupt handlers.
@@ -185,6 +186,7 @@ struct hantro_dev {
 	void __iomem **reg_bases;
 	void __iomem *enc_base;
 	void __iomem *dec_base;
+	void __iomem *ctrl_base;
 
 	struct mutex vpu_mutex;	/* video_device lock */
 	spinlock_t irqlock;
-- 
2.20.1

