Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB90C7EE23
	for <linux-media@archiver.kernel.org>; Wed, 24 May 2023 12:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjEXMMB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 24 May 2023 08:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjEXML7 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 24 May 2023 08:11:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3B5139
        for <linux-media@vger.kernel.org>; Wed, 24 May 2023 05:11:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B98C6632DF
        for <linux-media@vger.kernel.org>; Wed, 24 May 2023 12:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D3CC433D2;
        Wed, 24 May 2023 12:11:55 +0000 (UTC)
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 3/8] media: usb: as102: drop as102_dev NULL check
Date:   Wed, 24 May 2023 14:11:45 +0200
Message-Id: <20230524121150.435736-4-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524121150.435736-1-hverkuil-cisco@xs4all.nl>
References: <20230524121150.435736-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fixes this smatch warning:

drivers/media/usb/as102/as102_usb_drv.c:306 as102_usb_release() warn: can 'as102_dev' even be NULL?

And indeed, as102_dev can never be NULL, so just drop the NULL check.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/usb/as102/as102_usb_drv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/as102/as102_usb_drv.c b/drivers/media/usb/as102/as102_usb_drv.c
index 50419e8ae56c..6b380144d6c2 100644
--- a/drivers/media/usb/as102/as102_usb_drv.c
+++ b/drivers/media/usb/as102/as102_usb_drv.c
@@ -303,10 +303,8 @@ static void as102_usb_release(struct kref *kref)
 	struct as102_dev_t *as102_dev;
 
 	as102_dev = container_of(kref, struct as102_dev_t, kref);
-	if (as102_dev != NULL) {
-		usb_put_dev(as102_dev->bus_adap.usb_dev);
-		kfree(as102_dev);
-	}
+	usb_put_dev(as102_dev->bus_adap.usb_dev);
+	kfree(as102_dev);
 }
 
 static void as102_usb_disconnect(struct usb_interface *intf)
-- 
2.39.2

