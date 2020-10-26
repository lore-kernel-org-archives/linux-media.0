Return-Path: <SRS0=Zg/f=EC=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3200C4363A
	for <linux-media@archiver.kernel.org>; Tue, 27 Oct 2020 00:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E08920882
	for <linux-media@archiver.kernel.org>; Tue, 27 Oct 2020 00:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603758525;
	bh=S2MHAPoe+Fmcjs3Mdb0IAiTXN/hDS47FXlvqopW9HD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=laShjHm0QsEfG5abP7My3rvDbx1HqaS9Drc7DLul8IlVYGFyP4vO85xljAildkBSm
	 zWjbaYflI0VwK3lWvMKHAlGsUhTezseVp8Z8nyyUKeanUbOPSPdlnR4h1wOUyXV/cR
	 ScUyCyYDFXRLPd+o0VZCLB5ENgJIzOwqdmYi5bco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411553AbgJ0A2b (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 26 Oct 2020 20:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409900AbgJZXwy (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 26 Oct 2020 19:52:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21C072225C;
        Mon, 26 Oct 2020 23:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603756374;
        bh=S2MHAPoe+Fmcjs3Mdb0IAiTXN/hDS47FXlvqopW9HD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1xKyEYVirbm7Ag3hcuWiQPfmGmLwfYyk9UiUmOkpuhygRORheZqjrhOuFyg9XfETl
         p9YqOQGdcN/v6j6/6NINk1A6WLFjcDbNyydC8KrW9XoYJ+TRK5SVPE7IDbrXFGUC8H
         8k0DFf8Se4yADUH/Y7BxpPx/FQHlnmyeFf6K2utE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xia Jiang <xia.jiang@mediatek.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 5.8 040/132] media: platform: Improve queue set up flow for bug fixing
Date:   Mon, 26 Oct 2020 19:50:32 -0400
Message-Id: <20201026235205.1023962-40-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026235205.1023962-1-sashal@kernel.org>
References: <20201026235205.1023962-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Xia Jiang <xia.jiang@mediatek.com>

[ Upstream commit 5095a6413a0cf896ab468009b6142cb0fe617e66 ]

Add checking created buffer size follow in mtk_jpeg_queue_setup().

Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Xia Jiang <xia.jiang@mediatek.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
index f82a81a3bdee2..c4b16dc2c0161 100644
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
@@ -571,6 +571,13 @@ static int mtk_jpeg_queue_setup(struct vb2_queue *q,
 	if (!q_data)
 		return -EINVAL;
 
+	if (*num_planes) {
+		for (i = 0; i < *num_planes; i++)
+			if (sizes[i] < q_data->sizeimage[i])
+				return -EINVAL;
+		return 0;
+	}
+
 	*num_planes = q_data->fmt->colplanes;
 	for (i = 0; i < q_data->fmt->colplanes; i++) {
 		sizes[i] = q_data->sizeimage[i];
-- 
2.25.1

