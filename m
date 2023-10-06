Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A98E81E01
	for <linux-media@archiver.kernel.org>; Fri,  6 Oct 2023 14:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjJFOeV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 6 Oct 2023 10:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjJFOeV (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 6 Oct 2023 10:34:21 -0400
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E7FA6
        for <linux-media@vger.kernel.org>; Fri,  6 Oct 2023 07:34:18 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 53BEA1000B8; Fri,  6 Oct 2023 15:34:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1696602857; bh=6MQyua/A8Pu67wl7+niUz9Tb+hYFpwItaPFQwLp8yNU=;
        h=From:To:Cc:Subject:Date:From;
        b=kfxRefP7kDqIV3UXJuqAZ99GFTXjwfH7HvRoi11AslTP66vvLPDIF3keXUvwqzuWf
         tp/UyewjVsZKMlw/CsMUjY3Wls/fm+TrwMrwU4ujGOA8NA7OnOevFyT3HYm0dc+zzj
         Jez3yZXWK9L8naYvXWqljgd7XFq5M+1MXbnRY8SceJpm9lzvYk7W4mEVoHn3X08H2B
         Q8exGED9gDLoTxMMw3RAxQVegIXY4rAfpYYxYyGGVKghykqppev0BhDCWc+49R2y1f
         QSwWMwbBtLDrjaylP2i3vImRDbpqC2OYzz7r9L8bEOq02zE/a7kT3cwQ+WKGU/NR1v
         r7l+2vuYpNdig==
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Cc:     Joe Ferner <joe.m.ferner@gmail.com>
Subject: [PATCH v4l-utils] ir-ctl: fix sharp encoding
Date:   Fri,  6 Oct 2023 15:34:17 +0100
Message-Id: <20231006143417.3376-1-sean@mess.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The Sharp protocol[1] encoding has incorrect timings for bit space.

[1] https://www.sbprojects.net/knowledge/ir/sharp.php

Reported-by: Joe Ferner <joe.m.ferner@gmail.com>
Closes: https://sourceforge.net/p/lirc/mailman/message/38604507/
Signed-off-by: Sean Young <sean@mess.org>
---
 utils/common/ir-encode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/utils/common/ir-encode.c b/utils/common/ir-encode.c
index b3757e12..4d43eb9d 100644
--- a/utils/common/ir-encode.c
+++ b/utils/common/ir-encode.c
@@ -144,9 +144,9 @@ static void sharp_add_bits(unsigned **buf, int bits, int count)
 		*(*buf)++ = NS_TO_US(sharp_unit * 8);
 
 		if (bits & (1 << i))
-			*(*buf)++ = NS_TO_US(sharp_unit * 50);
+			*(*buf)++ = NS_TO_US(sharp_unit * 42);
 		else
-			*(*buf)++ = NS_TO_US(sharp_unit * 25);
+			*(*buf)++ = NS_TO_US(sharp_unit * 17);
 	}
 }
 
-- 
2.42.0

