Return-Path: <SRS0=3PrV=5M=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37D4C2D0EC
	for <linux-media@archiver.kernel.org>; Fri, 27 Mar 2020 22:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7357E2074A
	for <linux-media@archiver.kernel.org>; Fri, 27 Mar 2020 22:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgC0Wch (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:32:37 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:53551 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgC0Wcg (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 27 Mar 2020 18:32:36 -0400
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 7DD6E100007;
        Fri, 27 Mar 2020 22:32:34 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     linux-media@vger.kernel.org, libcamera-devel@lists.libcamera.org
Cc:     Jacopo Mondi <jacopo@jmondi.org>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org, laurent.pinchart@ideasonboard.com
Subject: [v2 1/3] Documentation: media: Update sub-device API intro
Date:   Fri, 27 Mar 2020 23:35:20 +0100
Message-Id: <20200327223522.506832-2-jacopo@jmondi.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327223522.506832-1-jacopo@jmondi.org>
References: <20200327223522.506832-1-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Update the V4L2 sub-device userspace API introduction to provide more
details on why complex devices might want to register devnodes for the
connected subdevices.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
---
 Documentation/media/kapi/v4l2-subdev.rst | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/media/kapi/v4l2-subdev.rst b/Documentation/media/kapi/v4l2-subdev.rst
index 29e07e23f888..41ccb3e5c707 100644
--- a/Documentation/media/kapi/v4l2-subdev.rst
+++ b/Documentation/media/kapi/v4l2-subdev.rst
@@ -275,8 +275,13 @@ system the .unbind() method is called. All three callbacks are optional.
 V4L2 sub-device userspace API
 -----------------------------
 
-Beside exposing a kernel API through the :c:type:`v4l2_subdev_ops` structure,
-V4L2 sub-devices can also be controlled directly by userspace applications.
+Bridge drivers traditionally expose one or multiple video nodes to userspace,
+and control subdevices through the :c:type:`v4l2_subdev_ops` operations in
+response to video node operations. This hides the complexity of the underlying
+hardware from applications. For complex devices, finer-grained control of the
+device than what the video nodes offer may be required. In those cases, bridge
+drivers that implement :ref:`the media controller API <media_controller>` may
+opt for making the subdevice operations directly accessible from userpace.
 
 Device nodes named ``v4l-subdev``\ *X* can be created in ``/dev`` to access
 sub-devices directly. If a sub-device supports direct userspace configuration
-- 
2.25.1

