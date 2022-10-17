Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552B6C433FE
	for <linux-media@archiver.kernel.org>; Mon, 17 Oct 2022 14:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiJQOqn (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 17 Oct 2022 10:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiJQOqi (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 17 Oct 2022 10:46:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B0029C9F;
        Mon, 17 Oct 2022 07:46:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8FC2B81637;
        Mon, 17 Oct 2022 14:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB063C433B5;
        Mon, 17 Oct 2022 14:46:34 +0000 (UTC)
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH for 6.1 4/4] videodev2.h: V4L2_DV_BT_BLANKING_HEIGHT should check 'interlaced'
Date:   Mon, 17 Oct 2022 16:46:28 +0200
Message-Id: <20221017144628.489271-5-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017144628.489271-1-hverkuil-cisco@xs4all.nl>
References: <20221017144628.489271-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

If it is a progressive (non-interlaced) format, then ignore the
interlaced timing values.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Fixes: 7f68127fa11f ([media] videodev2.h: defines to calculate blanking and frame sizes)
---
 include/uapi/linux/videodev2.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 86cae23cc446..29da1f4b4578 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -1601,7 +1601,8 @@ struct v4l2_bt_timings {
 	((bt)->width + V4L2_DV_BT_BLANKING_WIDTH(bt))
 #define V4L2_DV_BT_BLANKING_HEIGHT(bt) \
 	((bt)->vfrontporch + (bt)->vsync + (bt)->vbackporch + \
-	 (bt)->il_vfrontporch + (bt)->il_vsync + (bt)->il_vbackporch)
+	 ((bt)->interlaced ? \
+	  ((bt)->il_vfrontporch + (bt)->il_vsync + (bt)->il_vbackporch) : 0))
 #define V4L2_DV_BT_FRAME_HEIGHT(bt) \
 	((bt)->height + V4L2_DV_BT_BLANKING_HEIGHT(bt))
 
-- 
2.35.1

