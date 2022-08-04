Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB58C19F2B
	for <linux-media@archiver.kernel.org>; Thu,  4 Aug 2022 11:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239549AbiHDL6p (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 4 Aug 2022 07:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239503AbiHDL6o (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 4 Aug 2022 07:58:44 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7214730579;
        Thu,  4 Aug 2022 04:58:43 -0700 (PDT)
X-QQ-mid: bizesmtp90t1659614319tra4jpwu
Received: from localhost.localdomain ( [182.148.15.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 04 Aug 2022 19:58:38 +0800 (CST)
X-QQ-SSF: 01000000008000F0U000B00A0000020
X-QQ-FEAT: 5x8Sgf4S6/hVISr3YbkdX/AtRvK873GUHFgcxjQCA8lX94oCLEthTQztxiVxz
        niJ0urkLUeMHHXbDEemEZ/BdrKoJut915KZEGQhabPo0shtZH1yrqoBJgVTV2HnmxaBBwX/
        bbUxeleMVuUafRqwLgTq9UWTVIxFJGQG4vWmMFYQl28xb+rcfBlATCFWyHKwHcPCAYSZ2Tm
        i4flKod5LStYJB+wFzPOurSomV44qnWufmXvijCRi1NO3PFgsStg0NGm/Mln/j4IgiznqUa
        tH3bUnI2Aq/FBuZ/udjQenni7pwkUpIAXJL8M3/R/daRcYcbAHlOJYgMcwj0ra/ucQspgZw
        Ho+m2DwD7TvzymQ5HI1OCNxOH7b9CAnNRhpAMsQSrmRVxmv9Jp+3Xx5TNA9A8XcU81qdbM2
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] media: technisat-usb2: Fix comment typo
Date:   Thu,  4 Aug 2022 19:58:25 +0800
Message-Id: <20220804115825.53596-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The double `is' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/media/usb/dvb-usb/technisat-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb/technisat-usb2.c b/drivers/media/usb/dvb-usb/technisat-usb2.c
index 9c77911fcad4..df90c6c5f3b9 100644
--- a/drivers/media/usb/dvb-usb/technisat-usb2.c
+++ b/drivers/media/usb/dvb-usb/technisat-usb2.c
@@ -786,7 +786,7 @@ static void technisat_usb2_disconnect(struct usb_interface *intf)
 {
 	struct dvb_usb_device *dev = usb_get_intfdata(intf);
 
-	/* work and stuff was only created when the device is is hot-state */
+	/* work and stuff was only created when the device is hot-state */
 	if (dev != NULL) {
 		struct technisat_usb2_state *state = dev->priv;
 		if (state != NULL)
-- 
2.35.1

