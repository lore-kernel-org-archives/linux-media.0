Return-Path: <SRS0=pHRl=B4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2929BC433E1
	for <linux-media@archiver.kernel.org>; Tue, 18 Aug 2020 13:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA6520738
	for <linux-media@archiver.kernel.org>; Tue, 18 Aug 2020 13:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597757799;
	bh=qKMe8yvEZAbay72M2tJtP0TdwY4VnJuiqPFS8BMNa0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nn+QnlZmQ7CwE0vq23lpgXR38RHBBIq0rP/ctuj91ercxzd6pStvY+ObUnokiiL8R
	 xIzVmrbLAT6S3Kd6hovFTigaiZKSzVFGb69AW//DIiKJ3u0RjnMmbNn6oYhc1Lj7yH
	 u1/C2O2yScdvpKFxQxLheZqFMJIzhvkfYTNq58qY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHRNgd (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 18 Aug 2020 09:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbgHRNgJ (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 18 Aug 2020 09:36:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD6D22076D;
        Tue, 18 Aug 2020 13:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597757769;
        bh=qKMe8yvEZAbay72M2tJtP0TdwY4VnJuiqPFS8BMNa0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0/CpW8GIgXJ+2e+UUMPBIshWolNDL2nz14zrE9S5cvkhP5srhs5CEWVWhY3nV5XHv
         Yk2FF9E1kWK/QPZWhzfCzdhVj2RhcDvXD2OSz1K3LfHOZdt9GyvFh+Ns6ZPRtPXgai
         jby3SMBKDzcyew0UrS65uiFTfpNE7q59jTNi4MXk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-media@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] media: usb: uvc: no need to check return value of debugfs_create functions
Date:   Tue, 18 Aug 2020 15:36:08 +0200
Message-Id: <20200818133608.462514-7-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818133608.462514-1-gregkh@linuxfoundation.org>
References: <20200818133608.462514-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/uvc/uvc_debugfs.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_debugfs.c b/drivers/media/usb/uvc/uvc_debugfs.c
index 2b8af4b54117..1a1258d4ffca 100644
--- a/drivers/media/usb/uvc/uvc_debugfs.c
+++ b/drivers/media/usb/uvc/uvc_debugfs.c
@@ -73,7 +73,6 @@ static struct dentry *uvc_debugfs_root_dir;
 void uvc_debugfs_init_stream(struct uvc_streaming *stream)
 {
 	struct usb_device *udev = stream->dev->udev;
-	struct dentry *dent;
 	char dir_name[33];
 
 	if (uvc_debugfs_root_dir == NULL)
@@ -82,22 +81,11 @@ void uvc_debugfs_init_stream(struct uvc_streaming *stream)
 	snprintf(dir_name, sizeof(dir_name), "%u-%u-%u", udev->bus->busnum,
 		 udev->devnum, stream->intfnum);
 
-	dent = debugfs_create_dir(dir_name, uvc_debugfs_root_dir);
-	if (IS_ERR_OR_NULL(dent)) {
-		uvc_printk(KERN_INFO, "Unable to create debugfs %s "
-			   "directory.\n", dir_name);
-		return;
-	}
-
-	stream->debugfs_dir = dent;
+	stream->debugfs_dir = debugfs_create_dir(dir_name,
+						 uvc_debugfs_root_dir);
 
-	dent = debugfs_create_file("stats", 0444, stream->debugfs_dir,
-				   stream, &uvc_debugfs_stats_fops);
-	if (IS_ERR_OR_NULL(dent)) {
-		uvc_printk(KERN_INFO, "Unable to create debugfs stats file.\n");
-		uvc_debugfs_cleanup_stream(stream);
-		return;
-	}
+	debugfs_create_file("stats", 0444, stream->debugfs_dir, stream,
+			    &uvc_debugfs_stats_fops);
 }
 
 void uvc_debugfs_cleanup_stream(struct uvc_streaming *stream)
-- 
2.28.0

