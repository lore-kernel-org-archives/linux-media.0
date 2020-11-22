Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04911C5519F
	for <linux-media@archiver.kernel.org>; Sun, 22 Nov 2020 16:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB58120781
	for <linux-media@archiver.kernel.org>; Sun, 22 Nov 2020 16:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgKVQbI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 22 Nov 2020 11:31:08 -0500
Received: from bin-mail-out-06.binero.net ([195.74.38.229]:21854 "EHLO
        bin-mail-out-06.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727740AbgKVQbH (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 22 Nov 2020 11:31:07 -0500
X-Halon-ID: c35d29e1-2cdf-11eb-bcc0-005056917f90
Authorized-sender: niklas.soderlund@fsdn.se
Received: from bismarck.berto.se (p4fca2458.dip0.t-ipconnect.de [79.202.36.88])
        by bin-vsp-out-02.atm.binero.net (Halon) with ESMTPA
        id c35d29e1-2cdf-11eb-bcc0-005056917f90;
        Sun, 22 Nov 2020 17:28:37 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH] adv748x: Only set i2c addresses once during probe
Date:   Sun, 22 Nov 2020 17:30:48 +0100
Message-Id: <20201122163048.3587032-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

During probe the i2c slave addresses are set two times in a row, once in
adv748x_initialise_clients() and once directly after in adv748x_reset().
Remove the call to adv748x_set_slave_addresses() in
adv748x_initialise_clients() as it's only called during probe while
adv748x_reset() is called during probe and normal operation.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/media/i2c/adv748x/adv748x-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/adv748x/adv748x-core.c b/drivers/media/i2c/adv748x/adv748x-core.c
index ae8b7ebf3830aa1c..00966fe104881a14 100644
--- a/drivers/media/i2c/adv748x/adv748x-core.c
+++ b/drivers/media/i2c/adv748x/adv748x-core.c
@@ -198,7 +198,7 @@ static int adv748x_initialise_clients(struct adv748x_state *state)
 			return ret;
 	}
 
-	return adv748x_set_slave_addresses(state);
+	return 0;
 }
 
 /**
-- 
2.29.2

