Return-Path: <SRS0=lba3=7W=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86222C433DF
	for <linux-media@archiver.kernel.org>; Tue,  9 Jun 2020 15:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 671682072F
	for <linux-media@archiver.kernel.org>; Tue,  9 Jun 2020 15:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgFIP3I (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:29:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49936 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgFIP3H (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 9 Jun 2020 11:29:07 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id D90722A3B20
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com
Cc:     dafna.hirschfeld@collabora.com, helen.koike@collabora.com,
        ezequiel@collabora.com, hverkuil@xs4all.nl, kernel@collabora.com,
        dafna3@gmail.com, sakari.ailus@linux.intel.com,
        linux-rockchip@lists.infradead.org, mchehab@kernel.org,
        tfiga@chromium.org
Subject: [PATCH v2 1/4] media: staging: rkisp1: rsz: supported formats are the isp's src formats, not sink formats
Date:   Tue,  9 Jun 2020 17:28:22 +0200
Message-Id: <20200609152825.24772-2-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609152825.24772-1-dafna.hirschfeld@collabora.com>
References: <20200609152825.24772-1-dafna.hirschfeld@collabora.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The rkisp1_resizer's enum callback 'rkisp1_rsz_enum_mbus_code'
calls the enum callback of the 'rkisp1_isp' on it's video sink pad.
This is a bug, the resizer should support the same formats
supported by the 'rkisp1_isp' on the source pad (not the sink pad).

Fixes: 56e3b29f9f6b "media: staging: rkisp1: add streaming paths"

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Acked-by: Helen Koike <helen.koike@collabora.com>
---
 drivers/staging/media/rkisp1/rkisp1-resizer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/rkisp1/rkisp1-resizer.c b/drivers/staging/media/rkisp1/rkisp1-resizer.c
index d049374413dc..d64c064bdb1d 100644
--- a/drivers/staging/media/rkisp1/rkisp1-resizer.c
+++ b/drivers/staging/media/rkisp1/rkisp1-resizer.c
@@ -437,8 +437,8 @@ static int rkisp1_rsz_enum_mbus_code(struct v4l2_subdev *sd,
 	u32 pad = code->pad;
 	int ret;
 
-	/* supported mbus codes are the same in isp sink pad */
-	code->pad = RKISP1_ISP_PAD_SINK_VIDEO;
+	/* supported mbus codes are the same in isp video src pad */
+	code->pad = RKISP1_ISP_PAD_SOURCE_VIDEO;
 	ret = v4l2_subdev_call(&rsz->rkisp1->isp.sd, pad, enum_mbus_code,
 			       &dummy_cfg, code);
 
-- 
2.17.1

