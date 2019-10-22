Return-Path: <SRS0=kHRc=YP=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFE2CA9EA0
	for <linux-media@archiver.kernel.org>; Tue, 22 Oct 2019 12:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784E2214B2
	for <linux-media@archiver.kernel.org>; Tue, 22 Oct 2019 12:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388940AbfJVMHj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 22 Oct 2019 08:07:39 -0400
Received: from jpvw.nl ([80.127.100.2]:40206 "EHLO jpvw.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388106AbfJVMHj (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 22 Oct 2019 08:07:39 -0400
Received: from jp by jpvw.nl with local (Exim 4.92)
        (envelope-from <jp@jpvw.nl>)
        id 1iMswr-0008NZ-FW; Tue, 22 Oct 2019 14:07:37 +0200
Date:   Tue, 22 Oct 2019 14:07:37 +0200
From:   Jan Pieter van Woerkom <jp@jpvw.nl>
To:     linux-media@vger.kernel.org
Cc:     Sean Young <sean@mess.org>
Subject: [PATCH] media: dvbsky: remove unused code
Message-ID: <20191022120737.GA31677@jpvw.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

remove unused code

Signed-off-by: Jan Pieter van Woerkom <jp@jpvw.nl>
---
diff -ru a/drivers/media/usb/dvb-usb-v2/dvbsky.c b/drivers/media/usb/dvb-usb-v2/dvbsky.c
--- a/drivers/media/usb/dvb-usb-v2/dvbsky.c	2019-10-22 13:15:31.598029247 +0200
+++ b/drivers/media/usb/dvb-usb-v2/dvbsky.c	2019-10-22 12:57:19.841571173 +0200
@@ -592,16 +592,7 @@
 static int dvbsky_init(struct dvb_usb_device *d)
 {
 	struct dvbsky_state *state = d_to_priv(d);
-
-	/* use default interface */
-	/*
-	ret = usb_set_interface(d->udev, 0, 0);
-	if (ret)
-		return ret;
-	*/
-
 	state->last_lock = 0;
-
 	return 0;
 }
