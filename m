Return-Path: <SRS0=nGM0=2A=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1FAC2D0BF
	for <linux-media@archiver.kernel.org>; Tue, 10 Dec 2019 21:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3687C20828
	for <linux-media@archiver.kernel.org>; Tue, 10 Dec 2019 21:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576014059;
	bh=ZwpzM8Y0sqnzkQFfcAOhYlxqY7bdpTFSVMrrVZOOfqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VOlSUv82nWpivWwlXIl2WDgSnompOSu2fnaPsDoiWN18GvTZm7Vfymj1z+LUJ53ax
	 +9MGNK2MQJoiw0wBIjBvXhooM45j7DSXJ24k92DexUTgJnvMMjWOXh4YBnLCLhocNr
	 i2pCJDPLqcuoofBdjmH3dSebn2yGvN9DjHGdSuYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbfLJVk6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:40:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:39462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730023AbfLJVeX (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 10 Dec 2019 16:34:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C35AF24654;
        Tue, 10 Dec 2019 21:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576013662;
        bh=ZwpzM8Y0sqnzkQFfcAOhYlxqY7bdpTFSVMrrVZOOfqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uzf72vEfpyg+IvBraPH57fgOh1dwULjIo9/zAGx6VblOG7+IXIfrv6YYZBavY2GEN
         NvQXfqta1PThL/T2WkJ0nRwbSu8t4RHoHFbjYHAi60Zz+bvTqj7vqXTfmRCne86eKK
         hs9lNY1pSbkDdHCGf/4udGP9hv7eeeS/7skjlcIw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 100/177] media: rcar_drif: fix a memory disclosure
Date:   Tue, 10 Dec 2019 16:31:04 -0500
Message-Id: <20191210213221.11921-100-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210213221.11921-1-sashal@kernel.org>
References: <20191210213221.11921-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit d39083234c60519724c6ed59509a2129fd2aed41 ]

"f->fmt.sdr.reserved" is uninitialized. As other peer drivers
like msi2500 and airspy do, the fix initializes it to avoid
memory disclosures.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rcar_drif.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/rcar_drif.c b/drivers/media/platform/rcar_drif.c
index 81413ab52475d..b677d014e7bab 100644
--- a/drivers/media/platform/rcar_drif.c
+++ b/drivers/media/platform/rcar_drif.c
@@ -912,6 +912,7 @@ static int rcar_drif_g_fmt_sdr_cap(struct file *file, void *priv,
 {
 	struct rcar_drif_sdr *sdr = video_drvdata(file);
 
+	memset(f->fmt.sdr.reserved, 0, sizeof(f->fmt.sdr.reserved));
 	f->fmt.sdr.pixelformat = sdr->fmt->pixelformat;
 	f->fmt.sdr.buffersize = sdr->fmt->buffersize;
 
-- 
2.20.1

