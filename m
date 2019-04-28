Return-Path: <SRS0=wpjx=S6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63F5C43218
	for <linux-media@archiver.kernel.org>; Sun, 28 Apr 2019 06:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88679206E0
	for <linux-media@archiver.kernel.org>; Sun, 28 Apr 2019 06:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfD1GSk (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 28 Apr 2019 02:18:40 -0400
Received: from web11.sircon.net ([178.164.11.111]:47530 "EHLO web11.sircon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfD1GSj (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sun, 28 Apr 2019 02:18:39 -0400
X-Greylist: delayed 3361 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Apr 2019 02:18:39 EDT
Received: from ti0001a400-0886.bb.online.no ([80.212.34.122]:43742 helo=localhost.localdomain)
        by web11.sircon.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <torleiv@huddly.com>)
        id 1hKcGo-0005lN-7U; Sun, 28 Apr 2019 07:22:34 +0200
From:   Torleiv Sundre <torleiv@huddly.com>
To:     linux-media@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com,
        Torleiv Sundre <torleiv@huddly.com>
Subject: [PATCH] media: uvcvido: Include streaming interface number in debugfs dir name
Date:   Sun, 28 Apr 2019 07:21:13 +0200
Message-Id: <20190428052113.32650-1-torleiv@huddly.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - web11.sircon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - huddly.com
X-Get-Message-Sender-Via: web11.sircon.net: authenticated_id: torleiv@sundre.no
X-Authenticated-Sender: web11.sircon.net: torleiv@sundre.no
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

uvcvideo creates a debugfs directory based on the device bus number and
device number. If a device contains more than one uvc function, the
creation of the second and following debugfs directories will fail and
print an info message like this:
  "uvcvideo: Unable to create debugfs 3-2 directory."

This patch includes the uvc streaming interface number in the debugfs
directory name, to make sure it is unique. The directory name format is
changed from "<busnum>-<devnum>" to "<busnum>-<devnum>-<intfnum>"

Signed-off-by: Torleiv Sundre <torleiv@huddly.com>
---
 drivers/media/usb/uvc/uvc_debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_debugfs.c b/drivers/media/usb/uvc/uvc_debugfs.c
index 77e7c2419b9b..6e244acb80ab 100644
--- a/drivers/media/usb/uvc/uvc_debugfs.c
+++ b/drivers/media/usb/uvc/uvc_debugfs.c
@@ -84,7 +84,8 @@ void uvc_debugfs_init_stream(struct uvc_streaming *stream)
 	if (uvc_debugfs_root_dir == NULL)
 		return;
 
-	sprintf(dir_name, "%u-%u", udev->bus->busnum, udev->devnum);
+	sprintf(dir_name, "%u-%u-%d", udev->bus->busnum, udev->devnum,
+		stream->intfnum);
 
 	dent = debugfs_create_dir(dir_name, uvc_debugfs_root_dir);
 	if (IS_ERR_OR_NULL(dent)) {
-- 
2.19.1

