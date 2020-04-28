Return-Path: <SRS0=SSLR=6M=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D300C83008
	for <linux-media@archiver.kernel.org>; Tue, 28 Apr 2020 21:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B9B52137B
	for <linux-media@archiver.kernel.org>; Tue, 28 Apr 2020 21:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgD1VDJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:03:09 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:43851 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgD1VDI (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 28 Apr 2020 17:03:08 -0400
Received: from uno.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id BC3A220000A;
        Tue, 28 Apr 2020 21:03:04 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     linux-media@vger.kernel.org, libcamera-devel@lists.libcamera.org
Cc:     Jacopo Mondi <jacopo@jmondi.org>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org, laurent.pinchart@ideasonboard.com
Subject: [PATCH v5 1/6] Documentation: media: Update sub-device API intro
Date:   Tue, 28 Apr 2020 23:06:04 +0200
Message-Id: <20200428210609.6793-2-jacopo@jmondi.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200428210609.6793-1-jacopo@jmondi.org>
References: <20200428210609.6793-1-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Update the V4L2 sub-device userspace API introduction to provide more
details on why complex devices might want to register devnodes for the
connected subdevices.

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
---
 Documentation/driver-api/media/v4l2-subdev.rst | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/media/v4l2-subdev.rst b/Documentation/driver-api/media/v4l2-subdev.rst
index 29e07e23f888..41ccb3e5c707 100644
--- a/Documentation/driver-api/media/v4l2-subdev.rst
+++ b/Documentation/driver-api/media/v4l2-subdev.rst
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
2.26.1

