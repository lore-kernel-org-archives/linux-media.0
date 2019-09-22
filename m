Return-Path: <SRS0=gF/f=XR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD37C3A5A6
	for <linux-media@archiver.kernel.org>; Sun, 22 Sep 2019 18:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D90C21D7C
	for <linux-media@archiver.kernel.org>; Sun, 22 Sep 2019 18:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569178655;
	bh=nE9nz5evbkAO8wmG0ixscqvwNdd1KDUNZZz1Dyjbub8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qLQ1EqBWDljXjMdsQkmROUPJLPu9QNSWKba0B+/q6fe2RQvoKDhgTS2OnTaowJZ2d
	 tL77Mh1N2WKm6dgBDmhUJyWdncSnYZA6iFHvdriAZSyqiJk8obTAyw4YCHKf4k5jBF
	 13fm1cynJpRH8lzFblpBOWSjeLItJGTI0XNi5yLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438495AbfIVS5d (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394850AbfIVS5c (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sun, 22 Sep 2019 14:57:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAF322186A;
        Sun, 22 Sep 2019 18:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178651;
        bh=nE9nz5evbkAO8wmG0ixscqvwNdd1KDUNZZz1Dyjbub8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdhtEGc0kKueewHy1hSq5zc0i5gV83SGPLLnSVVMs9Ve6fVO5OLmNsbhZNpxRMfyQ
         wmvyTdxte6CgFqTwHVBNTKZYpRxVr5GiIJPcynuLI7CGzwu/Fuxhc3L0INq5coUWwt
         WmyKpdrlCFb8feCG9bouEesaaBS3cLS7IKTRi5HA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Young <sean@mess.org>, Sean Wang <sean.wang@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 07/89] media: mtk-cir: lower de-glitch counter for rc-mm protocol
Date:   Sun, 22 Sep 2019 14:55:55 -0400
Message-Id: <20190922185717.3412-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185717.3412-1-sashal@kernel.org>
References: <20190922185717.3412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Sean Young <sean@mess.org>

[ Upstream commit 5dd4b89dc098bf22cd13e82a308f42a02c102b2b ]

The rc-mm protocol can't be decoded by the mtk-cir since the de-glitch
filter removes pulses/spaces shorter than 294 microseconds.

Tested on a BananaPi R2.

Signed-off-by: Sean Young <sean@mess.org>
Acked-by: Sean Wang <sean.wang@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/mtk-cir.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/rc/mtk-cir.c b/drivers/media/rc/mtk-cir.c
index e88eb64e8e693..00a4a0dfcab87 100644
--- a/drivers/media/rc/mtk-cir.c
+++ b/drivers/media/rc/mtk-cir.c
@@ -44,6 +44,11 @@
 /* Fields containing pulse width data */
 #define MTK_WIDTH_MASK		  (GENMASK(7, 0))
 
+/* IR threshold */
+#define MTK_IRTHD		 0x14
+#define MTK_DG_CNT_MASK		 (GENMASK(12, 8))
+#define MTK_DG_CNT(x)		 ((x) << 8)
+
 /* Bit to enable interrupt */
 #define MTK_IRINT_EN		  BIT(0)
 
@@ -411,6 +416,9 @@ static int mtk_ir_probe(struct platform_device *pdev)
 	mtk_w32_mask(ir, val, ir->data->fields[MTK_HW_PERIOD].mask,
 		     ir->data->fields[MTK_HW_PERIOD].reg);
 
+	/* Set de-glitch counter */
+	mtk_w32_mask(ir, MTK_DG_CNT(1), MTK_DG_CNT_MASK, MTK_IRTHD);
+
 	/* Enable IR and PWM */
 	val = mtk_r32(ir, MTK_CONFIG_HIGH_REG);
 	val |= MTK_OK_COUNT(ir->data->ok_count) |  MTK_PWM_EN | MTK_IR_EN;
-- 
2.20.1

