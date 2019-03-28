Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EACC43381
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 10:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69E020700
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 10:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfC1KtS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:49:18 -0400
Received: from mail.it-technology.at ([62.99.145.147]:34221 "EHLO
        mail.it-technology.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfC1KtR (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 06:49:17 -0400
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Mar 2019 06:49:17 EDT
Received: from webmail.it-technology.at (localhost [127.0.0.1])
        by mail.it-technology.at (Postfix) with ESMTP id E77B24642D6
        for <linux-media@vger.kernel.org>; Thu, 28 Mar 2019 11:44:00 +0100 (CET)
Received: from 192.168.1.2
        (SquirrelMail authenticated user holik)
        by webmail.it-technology.at with HTTP;
        Thu, 28 Mar 2019 11:44:00 +0100
Message-ID: <847c358871c711d2e8735a928cff1095.squirrel@webmail.it-technology.at>
Date:   Thu, 28 Mar 2019 11:44:00 +0100
Subject: print frequency debug only if dvb_frontend_debug is enables
From:   "Peter Holik" <peter@holik.at>
To:     linux-media@vger.kernel.org
User-Agent: SquirrelMail/1.4.23 [SVN]
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20190328114400_13912"
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

------=_20190328114400_13912
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi!

Every transponder switch from my vdr causes this debug message "frequency interval: tuner: ..., frontend: ..." in syslog.

I think this should only happen if dvb_frontend_debug parameter is set.

cu Peter
------=_20190328114400_13912
Content-Type: text/x-patch; name="dvb_frontend.c.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="dvb_frontend.c.diff"

--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -917,8 +917,9 @@
 			 "DVB: adapter %i frontend %u frequency limits undefined - fix the driver\n",
 			 fe->dvb->num, fe->id);
 
-	dprintk("frequency interval: tuner: %u...%u, frontend: %u...%u",
-		tuner_min, tuner_max, frontend_min, frontend_max);
+	if (dvb_frontend_debug)
+		dprintk("frequency interval: tuner: %u...%u, frontend: %u...%u",
+			tuner_min, tuner_max, frontend_min, frontend_max);
 
 	/* If the standard is for satellite, convert frequencies to kHz */
 	switch (c->delivery_system) {
------=_20190328114400_13912--


