Return-Path: <SRS0=WE7C=CV=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47443C43461
	for <linux-media@archiver.kernel.org>; Sat, 12 Sep 2020 09:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0F80214F1
	for <linux-media@archiver.kernel.org>; Sat, 12 Sep 2020 09:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599901513;
	bh=h332aqwhjT3i19kg1+fjgVYyFutF+KieRzVuzn/JuFU=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=PBC1SHTBaxry3ehqHoUaWrmYYkFLc7KrHztBBahwyPiv711IRLzaiiGT5rNjKaZh5
	 xnytiCDdR/V5DaH/E5uEK5j04jEP1i3C+BVNXygfdo918tMu1HWFjkOMDntMDApaRY
	 sW6Dt233VgN+1slSBgaYTGjFQ8ddKVNkF39jfGgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgILJFG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 12 Sep 2020 05:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgILJFF (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sat, 12 Sep 2020 05:05:05 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BDED214F1;
        Sat, 12 Sep 2020 09:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599901505;
        bh=h332aqwhjT3i19kg1+fjgVYyFutF+KieRzVuzn/JuFU=;
        h=From:To:Cc:Subject:Date:From;
        b=yAaoJ1U2FWOlkZjjx5N4SDcqh64NPbRiADE4ChIbbVXKkcKdB2hxJvHtMceSqdQXL
         eS+JIdUATtqY162fQoeSBkR4WAJz1wWtuAoG64MRX1SfT+gwj1qGHiF1vw/KblNExP
         3RkfXNJc/gF4TZiq59kLac3cucx0/M4G5bwWu6TU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kH1Sw-001RHE-E0; Sat, 12 Sep 2020 11:05:02 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH] media: vidtv: add modaliases for the bridge driver
Date:   Sat, 12 Sep 2020 11:05:01 +0200
Message-Id: <fccf254e33bdd169dde6bdd6f941cf773c82a1c0.1599901499.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

As this virtual driver is probed manually, add modaliases
for this driver.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/test-drivers/vidtv/vidtv_bridge.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_bridge.c b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
index 82e375048b99..9f0e53e9fe69 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_bridge.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
@@ -530,3 +530,5 @@ module_exit(vidtv_bridge_exit);
 MODULE_DESCRIPTION("Virtual Digital TV Test Driver");
 MODULE_AUTHOR("Daniel W. S. Almeida");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("vidtv");
+MODULE_ALIAS("dvb_vidtv");
-- 
2.26.2

