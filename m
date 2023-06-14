Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D687BEB64D8
	for <linux-media@archiver.kernel.org>; Wed, 14 Jun 2023 12:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244688AbjFNMxK (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 14 Jun 2023 08:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241026AbjFNMxG (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 14 Jun 2023 08:53:06 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Jun 2023 05:53:05 PDT
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE7310DA
        for <linux-media@vger.kernel.org>; Wed, 14 Jun 2023 05:53:05 -0700 (PDT)
Received: from fedori.lan (softdnserr [::ffff:81.182.137.62])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000071386.000000006489B700.003B4B55; Wed, 14 Jun 2023 14:48:00 +0200
From:   Gergo Koteles <soyer@irl.hu>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     Gergo Koteles <soyer@irl.hu>
Subject: [PATCH] media: uvcvideo: uvc_ctrl_get_rel_speed: use 0 as default
Date:   Wed, 14 Jun 2023 14:47:49 +0200
Message-Id: <eb4f7f29a94231c5fa404f7492dba8e7fd9fbb23.1686746422.git.soyer@irl.hu>
X-Mailer: git-send-email 2.40.1
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The Logitech BCC950 incorrectly reports 1 (the max value)
for the default values of V4L2_CID_PAN_SPEED,
V4L2_CID_TILT_SPEED.

This patch sets them to 0, which is the stop value.

Previous discussion
Link: https://lore.kernel.org/all/CAP_ceTy6XVmvTTAmvCp1YU2wxHwXqnarm69Yaz8K4FmpJqYxAg@mail.gmail.com/

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 5e9d3da862dd..e131958c0930 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -444,9 +444,10 @@ static s32 uvc_ctrl_get_rel_speed(struct uvc_control_mapping *mapping,
 		return -data[first+1];
 	case UVC_GET_MAX:
 	case UVC_GET_RES:
+		return data[first+1];
 	case UVC_GET_DEF:
 	default:
-		return data[first+1];
+		return 0;
 	}
 }
 

base-commit: be9aac187433af6abba5fcc2e73d91d0794ba360
-- 
2.40.1

