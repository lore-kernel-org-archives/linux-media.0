Return-Path: <SRS0=wt4+=TI=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD56AC04A6B
	for <linux-media@archiver.kernel.org>; Wed,  8 May 2019 15:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7068208C3
	for <linux-media@archiver.kernel.org>; Wed,  8 May 2019 15:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfEHPMZ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 8 May 2019 11:12:25 -0400
Received: from www.osadl.org ([62.245.132.105]:53986 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbfEHPMZ (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 8 May 2019 11:12:25 -0400
Received: from localhost.localdomain (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x48FBwe2028805;
        Wed, 8 May 2019 17:11:59 +0200
From:   Nicholas Mc Guire <hofrat@opentech.at>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@opentech.at>
Subject: [PATCH V2] media: smiapp: core: add small range to usleep_range
Date:   Wed,  8 May 2019 17:11:53 +0200
Message-Id: <1557328313-97997-1-git-send-email-hofrat@opentech.at>
X-Mailer: git-send-email 2.1.4
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

No need for a high-accuracy delay here as long as it is more than 2
milliseconds this should be ok - as it is non-atomic context it will
be not be precise 2 milliseconds so giving the hrtimer subsystem 50
microseconds to merge timers and reduce interrupts.

Signed-off-by: Nicholas Mc Guire <hofrat@opentech.at>
---

Problem located by an experimental coccinelle script

V2: As Sakari Ailus <sakari.ailus@iki.fi> noted that the delays would be
    noticeable for the user but a range in the 50 microseconds range would
    be acceptable - the range is reduced from 2 millisecond to 50 microseconds
    which still gives the hrtimer subsystem some room for reducing interrupt
    load.

Patch was compile tested with: x86_64_defconfig + MEDIA_SUPPORT=m,
MEDIA_CAMERA_SUPPORT=y, MEDIA_CONTROLLER=y, VIDEO_V4L2_SUBDEV_API=y,
VIDEO_SMIAPP=m

Patch is against 5.1 (localversion-next is next-20190508)

 drivers/media/i2c/smiapp/smiapp-quirk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/smiapp/smiapp-quirk.c b/drivers/media/i2c/smiapp/smiapp-quirk.c
index 95c0272..59cb2a5 100644
--- a/drivers/media/i2c/smiapp/smiapp-quirk.c
+++ b/drivers/media/i2c/smiapp/smiapp-quirk.c
@@ -202,7 +202,7 @@ static int jt8ev1_post_streamoff(struct smiapp_sensor *sensor)
 		return rval;
 
 	/* Wait for 1 ms + one line => 2 ms is likely enough */
-	usleep_range(2000, 2000);
+	usleep_range(2000, 2050);
 
 	/* Restore it */
 	rval = smiapp_write_8(sensor, 0x3205, 0x00);
-- 
2.1.4

