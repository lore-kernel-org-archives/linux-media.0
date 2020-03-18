Return-Path: <SRS0=m313=5D=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2C9C4332B
	for <linux-media@archiver.kernel.org>; Wed, 18 Mar 2020 20:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC44A2071C
	for <linux-media@archiver.kernel.org>; Wed, 18 Mar 2020 20:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgCRUsJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:48:09 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:33065 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgCRUsJ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 18 Mar 2020 16:48:09 -0400
X-Originating-IP: 2.224.242.101
Received: from localhost.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 2B70E20007;
        Wed, 18 Mar 2020 20:48:04 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        tfiga@google.com, pavel@ucw.cz
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)), libcamera-devel@lists.libcamera.org
Subject: [PATCH v7 07/11] include: v4l2-ctrl: Sort forward declarations
Date:   Wed, 18 Mar 2020 21:50:30 +0100
Message-Id: <20200318205034.949531-8-jacopo@jmondi.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200318205034.949531-1-jacopo@jmondi.org>
References: <20200318205034.949531-1-jacopo@jmondi.org>
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
index 7db9e719a583..cf59abafb0d9 100644
--- a/include/media/v4l2-ctrls.h
+++ b/include/media/v4l2-ctrls.h
@@ -25,14 +25,14 @@
 
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
2.25.1

