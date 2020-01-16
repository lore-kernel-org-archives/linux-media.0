Return-Path: <SRS0=OtTt=3F=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554B9C33CAF
	for <linux-media@archiver.kernel.org>; Thu, 16 Jan 2020 18:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32443206D7
	for <linux-media@archiver.kernel.org>; Thu, 16 Jan 2020 18:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199374;
	bh=9lFcSaXVFg63NRWGeDrv05C73dAUr2huwxo00KwwHQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Uv6Jju+vzyPy9E0KSxlLd6ie29FF/5oV8iYb7Rk/o7xEEYmmeadw8Jb19gqAt6B68
	 QdbzBc/mX9dMUpLJktBlpKrTb5533b7wQ8gFfH5rHzjinjWNFV9FkyRQUk3Y0vwAI4
	 tacwqWS5VX+Xbz04NgqMpT5h4rOgpk0yy7tt5aZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392067AbgAPRZu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:25:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:34020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392024AbgAPRZt (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 16 Jan 2020 12:25:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 230E5207E0;
        Thu, 16 Jan 2020 17:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195548;
        bh=9lFcSaXVFg63NRWGeDrv05C73dAUr2huwxo00KwwHQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ILoDX4Cuu/pnA2naHsUkAcgcDBs54TbdKsGGqcjNbUDpw2Bk9rIzUniGp/6SxRi9u
         5lXa/vnya0akNVBqm+31XiWPGk6uRmJxxodtRda07NlaYs5TmxLsfj0+9TUvtwaZSQ
         RfFKsJ1fieg9pnQ+N6qhm7pDcEy2pNMBTMWZojsU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Mc Guire <hofrat@osadl.org>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 140/371] media: cx23885: check allocation return
Date:   Thu, 16 Jan 2020 12:20:12 -0500
Message-Id: <20200116172403.18149-83-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit a3d7f22ef34ec4206b50ee121384d5c8bebd5591 ]

Checking of kmalloc() seems to have been committed - as
cx23885_dvb_register() is checking for != 0 return, returning
-ENOMEM should be fine here.  While at it address the coccicheck
suggestion to move to kmemdup rather than using kmalloc+memcpy.

Fixes: 46b21bbaa8a8 ("[media] Add support for DViCO FusionHDTV DVB-T Dual Express2")

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/cx23885/cx23885-dvb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/cx23885/cx23885-dvb.c b/drivers/media/pci/cx23885/cx23885-dvb.c
index e795ddeb7fe2..60f122edaefb 100644
--- a/drivers/media/pci/cx23885/cx23885-dvb.c
+++ b/drivers/media/pci/cx23885/cx23885-dvb.c
@@ -1460,8 +1460,9 @@ static int dvb_register(struct cx23885_tsport *port)
 		if (fe0->dvb.frontend != NULL) {
 			struct i2c_adapter *tun_i2c;
 
-			fe0->dvb.frontend->sec_priv = kmalloc(sizeof(dib7000p_ops), GFP_KERNEL);
-			memcpy(fe0->dvb.frontend->sec_priv, &dib7000p_ops, sizeof(dib7000p_ops));
+			fe0->dvb.frontend->sec_priv = kmemdup(&dib7000p_ops, sizeof(dib7000p_ops), GFP_KERNEL);
+			if (!fe0->dvb.frontend->sec_priv)
+				return -ENOMEM;
 			tun_i2c = dib7000p_ops.get_i2c_master(fe0->dvb.frontend, DIBX000_I2C_INTERFACE_TUNER, 1);
 			if (!dvb_attach(dib0070_attach, fe0->dvb.frontend, tun_i2c, &dib7070p_dib0070_config))
 				return -ENODEV;
-- 
2.20.1

