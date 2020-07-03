Return-Path: <SRS0=uRfZ=AO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AACC433E0
	for <linux-media@archiver.kernel.org>; Fri,  3 Jul 2020 17:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEE0E214DB
	for <linux-media@archiver.kernel.org>; Fri,  3 Jul 2020 17:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgGCRKf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:10:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46106 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgGCRKe (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 3 Jul 2020 13:10:34 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id 47FC12A65C2
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com
Cc:     dafna.hirschfeld@collabora.com, helen.koike@collabora.com,
        ezequiel@collabora.com, hverkuil@xs4all.nl, kernel@collabora.com,
        dafna3@gmail.com, sakari.ailus@linux.intel.com,
        linux-rockchip@lists.infradead.org, mchehab@kernel.org,
        tfiga@chromium.org
Subject: [PATCH v5 7/7] media: staging: rkisp1: rsz: set flags to 0 in enum_mbus_code cb
Date:   Fri,  3 Jul 2020 19:10:19 +0200
Message-Id: <20200703171019.19270-8-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200703171019.19270-1-dafna.hirschfeld@collabora.com>
References: <20200703171019.19270-1-dafna.hirschfeld@collabora.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The resizer calls the enum_mbus_code cb on the source pad of
the isp entity since they support the same formats.
The only difference is that the isp entity allows setting the
quantization and sets the flag V4L2_SUBDEV_MBUS_CODE_CSC_QUANTIZATION.
The resizer should therefore set the flags to 0.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/staging/media/rkisp1/rkisp1-resizer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/media/rkisp1/rkisp1-resizer.c b/drivers/staging/media/rkisp1/rkisp1-resizer.c
index 8bc907ffa09b..31b5ac1f27a9 100644
--- a/drivers/staging/media/rkisp1/rkisp1-resizer.c
+++ b/drivers/staging/media/rkisp1/rkisp1-resizer.c
@@ -444,6 +444,7 @@ static int rkisp1_rsz_enum_mbus_code(struct v4l2_subdev *sd,
 
 	/* restore pad */
 	code->pad = pad;
+	code->flags = 0;
 	return ret;
 }
 
-- 
2.17.1

