Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB76EB64D8
	for <linux-media@archiver.kernel.org>; Wed, 14 Jun 2023 22:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbjFNWVB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 14 Jun 2023 18:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjFNWVA (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 14 Jun 2023 18:21:00 -0400
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B0F2689
        for <linux-media@vger.kernel.org>; Wed, 14 Jun 2023 15:20:51 -0700 (PDT)
Received: from fedori.lan (51b6893e.dsl.pool.telekom.hu [::ffff:81.182.137.62])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006B6CC.00000000648A3D41.003B59DF; Thu, 15 Jun 2023 00:20:49 +0200
From:   Gergo Koteles <soyer@irl.hu>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ricardo Ribalda <ribalda@chromium.org>
Cc:     linux-media@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v2] media: uvcvideo: uvc_ctrl_get_rel_speed: use 0 as default
Date:   Thu, 15 Jun 2023 00:19:53 +0200
Message-Id: <088902f67634fb0931da7b045e05afe5c8197cdc.1686780782.git.soyer@irl.hu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8e2956b31fb0bab802b1a5cbcfae2c0fd2aca4b8.camel@irl.hu>
References: <8e2956b31fb0bab802b1a5cbcfae2c0fd2aca4b8.camel@irl.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Devices with pan/tilt controls but without pan/tilt speed controls
return 1 for the default value of V4L2_CID_PAN_SPEED or
V4L2_CID_TILT_SPEED. For these controls, the value of 1 means a
move and that's not a good default.

Currently, for these controls the UVC_GET_DEF query returns
bPanSpeed or bTiltSpeed of CT_PANTILT_RELATIVE_CONTROL.

According to the UVC 1.5 specification, the default value of bPanSpeed
or bTiltSpeed should be 1 if the pan/tilt control doesn't support
speed control.

"If the control does not support speed control for the Tilt control,
it will return the value 1 in this field for all these requests."

This patch modifies the uvc_ctrl_get_rel_speed to return hardcoded 0
for UVC_GET_DEF query, because that's the stop or don't move value
for these V4L2 controls.

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

