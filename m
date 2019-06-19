Return-Path: <SRS0=8QUH=US=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DA7C31E5E
	for <linux-media@archiver.kernel.org>; Wed, 19 Jun 2019 09:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5219120B1F
	for <linux-media@archiver.kernel.org>; Wed, 19 Jun 2019 09:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbfFSJVj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 19 Jun 2019 05:21:39 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39208 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730996AbfFSJVj (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 19 Jun 2019 05:21:39 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B2ABC2614E9;
        Wed, 19 Jun 2019 10:21:37 +0100 (BST)
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>, linux-media@vger.kernel.org
Cc:     kernel@collabora.com,
        Boris Brezillon <boris.brezillon@collabora.com>,
        stable@vger.kernel.org
Subject: [PATCH] media: v4l2: Test type instead of cfg->type in v4l2_ctrl_new_custom()
Date:   Wed, 19 Jun 2019 11:21:33 +0200
Message-Id: <20190619092133.28977-1-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

cfg->type can be overridden by v4l2_ctrl_fill() and the new value is
stored in the local type var. Fix the tests to use this local var.

Fixes: 0996517cf8ea ("V4L/DVB: v4l2: Add new control handling framework")
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/media/v4l2-core/v4l2-ctrls.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index c342385baec3..1acc249aaeed 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -2470,16 +2470,15 @@ struct v4l2_ctrl *v4l2_ctrl_new_custom(struct v4l2_ctrl_handler *hdl,
 		v4l2_ctrl_fill(cfg->id, &name, &type, &min, &max, &step,
 								&def, &flags);
 
-	is_menu = (cfg->type == V4L2_CTRL_TYPE_MENU ||
-		   cfg->type == V4L2_CTRL_TYPE_INTEGER_MENU);
+	is_menu = (type == V4L2_CTRL_TYPE_MENU ||
+		   type == V4L2_CTRL_TYPE_INTEGER_MENU);
 	if (is_menu)
 		WARN_ON(step);
 	else
 		WARN_ON(cfg->menu_skip_mask);
-	if (cfg->type == V4L2_CTRL_TYPE_MENU && qmenu == NULL)
+	if (type == V4L2_CTRL_TYPE_MENU && qmenu == NULL) {
 		qmenu = v4l2_ctrl_get_menu(cfg->id);
-	else if (cfg->type == V4L2_CTRL_TYPE_INTEGER_MENU &&
-		 qmenu_int == NULL) {
+	} else if (type == V4L2_CTRL_TYPE_INTEGER_MENU && qmenu_int == NULL) {
 		handler_set_err(hdl, -EINVAL);
 		return NULL;
 	}
-- 
2.20.1

