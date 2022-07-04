Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391E6C43334
	for <linux-media@archiver.kernel.org>; Mon,  4 Jul 2022 02:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiGDCYd (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 3 Jul 2022 22:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiGDCYc (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sun, 3 Jul 2022 22:24:32 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 492E95593;
        Sun,  3 Jul 2022 19:24:31 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id BBA941E80C90;
        Mon,  4 Jul 2022 10:22:32 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9ZLW950-QA4D; Mon,  4 Jul 2022 10:22:30 +0800 (CST)
Received: from node1.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 2BAA61E80C96;
        Mon,  4 Jul 2022 10:22:30 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     mchehab@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] staging/media/av7110/av7110: Fix typo in string
Date:   Mon,  4 Jul 2022 10:24:10 +0800
Message-Id: <20220704022410.3022-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Remove the repeated ',' from string

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 drivers/staging/media/av7110/av7110_av.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/av7110/av7110_av.c b/drivers/staging/media/av7110/av7110_av.c
index ab7cf496b454..0bf513c26b6b 100644
--- a/drivers/staging/media/av7110/av7110_av.c
+++ b/drivers/staging/media/av7110/av7110_av.c
@@ -106,7 +106,7 @@ int av7110_av_start_record(struct av7110 *av7110, int av,
 	int ret = 0;
 	struct dvb_demux *dvbdmx = dvbdmxfeed->demux;
 
-	dprintk(2, "av7110:%p, , dvb_demux_feed:%p\n", av7110, dvbdmxfeed);
+	dprintk(2, "av7110:%p, dvb_demux_feed:%p\n", av7110, dvbdmxfeed);
 
 	if (av7110->playing || (av7110->rec_mode & av))
 		return -EBUSY;
-- 
2.18.2

