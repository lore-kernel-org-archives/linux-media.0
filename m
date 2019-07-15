Return-Path: <SRS0=PKt4=VM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C77CC7618F
	for <linux-media@archiver.kernel.org>; Mon, 15 Jul 2019 13:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BAC020C01
	for <linux-media@archiver.kernel.org>; Mon, 15 Jul 2019 13:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563198044;
	bh=VRgrytHTVCFlT5csoh3aKEF0uzbhluzYmPoRtKfok/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q4Pt035FyagA94ifgqKNmh+GQxEiAz7PlSbVxPffnMk+hRYySt5Op6IZFvhqEcfJv
	 U58jGtMGlRu8nxoLCV6k/FefDEznPgU7CqO0OI2POLLtG3BbBc5Y7eiIYZUJiRhKZ8
	 ixim5l7LZ+gquVRD2rskbpv9NHzhtAuBXtMidEZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbfGONkn (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:40:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731348AbfGONkA (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Jul 2019 09:40:00 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E494D2086C;
        Mon, 15 Jul 2019 13:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563197999;
        bh=VRgrytHTVCFlT5csoh3aKEF0uzbhluzYmPoRtKfok/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c7uWon3+pWhilGqw9YpvRuD9U8I6GwYV8kN3Rv3Zs2aZDjjtpP8Tje0gQX+91gLtZ
         JhzCTmfBU77XRsUDcQqGzBMCa/RL0QHffet1j506dAAwi7hgOQ31v3bbt3+JbDUDNe
         lLa/4g+dpHAS4eHi0sJXDVqp1frpLrisY7QE6paQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Gomez <dagmcr@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 012/158] media: spi: IR LED: add missing of table registration
Date:   Mon, 15 Jul 2019 09:36:57 -0400
Message-Id: <20190715133923.2890-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715133923.2890-1-sashal@kernel.org>
References: <20190715133923.2890-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Daniel Gomez <dagmcr@gmail.com>

[ Upstream commit 24e4cf770371df6ad49ed873f21618d9878f64c8 ]

MODULE_DEVICE_TABLE(of, <of_match_table> should be called to complete DT
OF mathing mechanism and register it.

Before this patch:
modinfo drivers/media/rc/ir-spi.ko  | grep alias

After this patch:
modinfo drivers/media/rc/ir-spi.ko  | grep alias
alias:          of:N*T*Cir-spi-ledC*
alias:          of:N*T*Cir-spi-led

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/ir-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/rc/ir-spi.c b/drivers/media/rc/ir-spi.c
index 66334e8d63ba..c58f2d38a458 100644
--- a/drivers/media/rc/ir-spi.c
+++ b/drivers/media/rc/ir-spi.c
@@ -161,6 +161,7 @@ static const struct of_device_id ir_spi_of_match[] = {
 	{ .compatible = "ir-spi-led" },
 	{},
 };
+MODULE_DEVICE_TABLE(of, ir_spi_of_match);
 
 static struct spi_driver ir_spi_driver = {
 	.probe = ir_spi_probe,
-- 
2.20.1

