Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A895C54EED
	for <linux-media@archiver.kernel.org>; Thu, 26 Jan 2023 15:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjAZPHO (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 26 Jan 2023 10:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjAZPHL (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 26 Jan 2023 10:07:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785156B9A6
        for <linux-media@vger.kernel.org>; Thu, 26 Jan 2023 07:07:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1637E61886
        for <linux-media@vger.kernel.org>; Thu, 26 Jan 2023 15:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC396C4339E;
        Thu, 26 Jan 2023 15:07:08 +0000 (UTC)
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 08/17] media: dvb-frontends: drx39xyj: replace return with goto for proper unwind
Date:   Thu, 26 Jan 2023 16:06:48 +0100
Message-Id: <20230126150657.367921-9-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230126150657.367921-1-hverkuil-cisco@xs4all.nl>
References: <20230126150657.367921-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

In three places there was a return instead of a goto to the unwind
code.

This fixes three smatch warnings:

drxj.c:9542 ctrl_get_qam_sig_quality() warn: missing unwind goto?
drxj.c:10919 ctrl_set_standard() warn: missing unwind goto?
drxj.c:11466 drxj_open() warn: missing unwind goto?

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/dvb-frontends/drx39xyj/drxj.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb-frontends/drx39xyj/drxj.c b/drivers/media/dvb-frontends/drx39xyj/drxj.c
index 1dff59ca21a1..6bf6559b127f 100644
--- a/drivers/media/dvb-frontends/drx39xyj/drxj.c
+++ b/drivers/media/dvb-frontends/drx39xyj/drxj.c
@@ -9539,7 +9539,8 @@ ctrl_get_qam_sig_quality(struct drx_demod_instance *demod)
 		qam_sl_sig_power = DRXJ_QAM_SL_SIG_POWER_QAM256 << 2;
 		break;
 	default:
-		return -EIO;
+		rc = -EIO;
+		goto rw_error;
 	}
 
 	/* ------------------------------ */
@@ -10916,7 +10917,8 @@ ctrl_set_standard(struct drx_demod_instance *demod, enum drx_standard *standard)
 		break;
 	case DRX_STANDARD_AUTO:
 	default:
-		return -EINVAL;
+		rc = -EINVAL;
+		goto rw_error;
 	}
 
 	/*
@@ -11463,7 +11465,8 @@ static int drxj_open(struct drx_demod_instance *demod)
 
 		if (DRX_ISPOWERDOWNMODE(demod->my_common_attr->current_power_mode)) {
 			pr_err("Should powerup before loading the firmware.");
-			return -EINVAL;
+			rc = -EINVAL;
+			goto rw_error;
 		}
 
 		rc = drx_ctrl_u_code(demod, &ucode_info, UCODE_UPLOAD);
-- 
2.39.0

