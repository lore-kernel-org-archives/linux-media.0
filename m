Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0605C433EF
	for <linux-media@archiver.kernel.org>; Mon,  9 May 2022 09:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiEIJvs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 9 May 2022 05:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237228AbiEIJUe (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 9 May 2022 05:20:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B8814A25C
        for <linux-media@vger.kernel.org>; Mon,  9 May 2022 02:16:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0690B810A5
        for <linux-media@vger.kernel.org>; Mon,  9 May 2022 09:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB27C385AC;
        Mon,  9 May 2022 09:15:57 +0000 (UTC)
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 2/7] v4l2-ctls-core.c: kvmalloc_array -> kvcalloc
Date:   Mon,  9 May 2022 11:15:48 +0200
Message-Id: <20220509091553.2637089-3-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220509091553.2637089-1-hverkuil-cisco@xs4all.nl>
References: <20220509091553.2637089-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fixes smatch warning:

drivers/media/v4l2-core/v4l2-ctrls-core.c:1143 v4l2_ctrl_handler_init_class() warn: Please consider using kvcalloc instead

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/v4l2-core/v4l2-ctrls-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index 8968cec8454e..949c1884d9c1 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -1140,9 +1140,8 @@ int v4l2_ctrl_handler_init_class(struct v4l2_ctrl_handler *hdl,
 	INIT_LIST_HEAD(&hdl->ctrls);
 	INIT_LIST_HEAD(&hdl->ctrl_refs);
 	hdl->nr_of_buckets = 1 + nr_of_controls_hint / 8;
-	hdl->buckets = kvmalloc_array(hdl->nr_of_buckets,
-				      sizeof(hdl->buckets[0]),
-				      GFP_KERNEL | __GFP_ZERO);
+	hdl->buckets = kvcalloc(hdl->nr_of_buckets, sizeof(hdl->buckets[0]),
+				GFP_KERNEL);
 	hdl->error = hdl->buckets ? 0 : -ENOMEM;
 	v4l2_ctrl_handler_init_request(hdl);
 	return hdl->error;
-- 
2.34.1

