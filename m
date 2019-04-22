Return-Path: <SRS0=+FiN=SY=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF21C282E3
	for <linux-media@archiver.kernel.org>; Mon, 22 Apr 2019 08:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56D5218A6
	for <linux-media@archiver.kernel.org>; Mon, 22 Apr 2019 08:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfDVIIZ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:08:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46446 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfDVIIY (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 22 Apr 2019 04:08:24 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id CAAF5281970;
        Mon, 22 Apr 2019 09:08:22 +0100 (BST)
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>, linux-media@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>, kernel@collabora.com,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v3 02/15] rockchip/vpu: Use v4l2_m2m_buf_copy_metadata
Date:   Mon, 22 Apr 2019 10:08:05 +0200
Message-Id: <20190422080818.29130-3-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190422080818.29130-1-boris.brezillon@collabora.com>
References: <20190422080818.29130-1-boris.brezillon@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Ezequiel Garcia <ezequiel@collabora.com>

Use the recently introduced v4l2_m2m_buf_copy_metadata helper
and get rid of some code.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
Changes from v2:
- None
---
 drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
index 58721c46fba4..3638aa1fd25d 100644
--- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
+++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
@@ -58,14 +58,7 @@ static void rockchip_vpu_job_finish(struct rockchip_vpu_dev *vpu,
 	src->sequence = ctx->sequence_out++;
 	dst->sequence = ctx->sequence_cap++;
 
-	dst->field = src->field;
-	if (src->flags & V4L2_BUF_FLAG_TIMECODE)
-		dst->timecode = src->timecode;
-	dst->vb2_buf.timestamp = src->vb2_buf.timestamp;
-	dst->flags &= ~(V4L2_BUF_FLAG_TSTAMP_SRC_MASK |
-			V4L2_BUF_FLAG_TIMECODE);
-	dst->flags |= src->flags & (V4L2_BUF_FLAG_TSTAMP_SRC_MASK |
-				    V4L2_BUF_FLAG_TIMECODE);
+	v4l2_m2m_buf_copy_metadata(src, dst, true);
 
 	avail_size = vb2_plane_size(&dst->vb2_buf, 0) -
 		     ctx->vpu_dst_fmt->header_size;
-- 
2.20.1

