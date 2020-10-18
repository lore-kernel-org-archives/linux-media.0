Return-Path: <SRS0=tdip=DZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DD3C433DF
	for <linux-media@archiver.kernel.org>; Sun, 18 Oct 2020 19:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B5C7207DE
	for <linux-media@archiver.kernel.org>; Sun, 18 Oct 2020 19:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603049970;
	bh=IM4R2jkcH/ab5xP+juABRDNyOLsIs9Nn0nnzMjGRMvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ry+11SqEAlQoAxFPnSVC2+MCOOlTEY3+9zUvJsnmzKz4LmTQ4Q+Nara9xvejeOkR9
	 Q004gpLuExp5UKa9p/bsH0cRTboiX42yIBVv7/AZAfZMS1UBFTQJlPeRzf4jJ8+N96
	 NAFq3NqaO+/5aU0woZ5GpwuN9poqvjjatJ8wa9GA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbgJRTj3 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 18 Oct 2020 15:39:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730870AbgJRTYl (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sun, 18 Oct 2020 15:24:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C230222C8;
        Sun, 18 Oct 2020 19:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603049080;
        bh=IM4R2jkcH/ab5xP+juABRDNyOLsIs9Nn0nnzMjGRMvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JGrTwQBbpzmt5ZHRowXc9mzhTIyPDCamMKGO3XRKUsUc5HlgT+QhskpuV8hn++WHk
         7flo8b/BE/aC2jmweceEyDjnow36r6/eyLqhIoOgIjtR8ZA5ar+TTWMVrCo8GjpdV6
         33k4wDUtE1ZRm4m0/CrW5zzTP1eA3+187ostpMSM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 18/56] media: saa7134: avoid a shift overflow
Date:   Sun, 18 Oct 2020 15:23:39 -0400
Message-Id: <20201018192417.4055228-18-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201018192417.4055228-1-sashal@kernel.org>
References: <20201018192417.4055228-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

[ Upstream commit 15a36aae1ec1c1f17149b6113b92631791830740 ]

As reported by smatch:
	drivers/media/pci/saa7134//saa7134-tvaudio.c:686 saa_dsp_writel() warn: should 'reg << 2' be a 64 bit type?

On a 64-bits Kernel, the shift might be bigger than 32 bits.

In real, this should never happen, but let's shut up the warning.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/saa7134/saa7134-tvaudio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/pci/saa7134/saa7134-tvaudio.c b/drivers/media/pci/saa7134/saa7134-tvaudio.c
index 68d400e1e240e..8c3da6f7a60f1 100644
--- a/drivers/media/pci/saa7134/saa7134-tvaudio.c
+++ b/drivers/media/pci/saa7134/saa7134-tvaudio.c
@@ -693,7 +693,8 @@ int saa_dsp_writel(struct saa7134_dev *dev, int reg, u32 value)
 {
 	int err;
 
-	audio_dbg(2, "dsp write reg 0x%x = 0x%06x\n", reg << 2, value);
+	audio_dbg(2, "dsp write reg 0x%x = 0x%06x\n",
+		  (reg << 2) & 0xffffffff, value);
 	err = saa_dsp_wait_bit(dev,SAA7135_DSP_RWSTATE_WRR);
 	if (err < 0)
 		return err;
-- 
2.25.1

