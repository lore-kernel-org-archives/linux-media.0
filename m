Return-Path: <SRS0=hgCd=XH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA00C4CEC6
	for <linux-media@archiver.kernel.org>; Thu, 12 Sep 2019 20:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AEB121479
	for <linux-media@archiver.kernel.org>; Thu, 12 Sep 2019 20:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfILUJ4 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 12 Sep 2019 16:09:56 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:51265 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfILUJz (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 12 Sep 2019 16:09:55 -0400
X-Originating-IP: 85.243.204.24
Received: from uno.lan (bl10-204-24.dsl.telepac.pt [85.243.204.24])
        (Authenticated sender: jacopo@jmondi.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 872322000A;
        Thu, 12 Sep 2019 20:09:52 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        tfiga@google.com, pavel@ucw.cz
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB))
Subject: [PATCH v3 07/11] include: v4l2-ctrl: Sort forward declarations
Date:   Thu, 12 Sep 2019 22:10:51 +0200
Message-Id: <20190912201055.13964-8-jacopo@jmondi.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190912201055.13964-1-jacopo@jmondi.org>
References: <20190912201055.13964-1-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Before adding a new forward declaration to the v4l2-ctrls.h header file,
sort the existing ones alphabetically.

Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
---
 include/media/v4l2-ctrls.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
index 570ff4b0205a..95b4fa6243d1 100644
--- a/include/media/v4l2-ctrls.h
+++ b/include/media/v4l2-ctrls.h
@@ -24,14 +24,14 @@
 
 /* forward references */
 struct file;
+struct poll_table_struct;
+struct v4l2_ctrl;
 struct v4l2_ctrl_handler;
 struct v4l2_ctrl_helper;
-struct v4l2_ctrl;
-struct video_device;
+struct v4l2_fh;
 struct v4l2_subdev;
 struct v4l2_subscribed_event;
-struct v4l2_fh;
-struct poll_table_struct;
+struct video_device;
 
 /**
  * union v4l2_ctrl_ptr - A pointer to a control value.
-- 
2.23.0

