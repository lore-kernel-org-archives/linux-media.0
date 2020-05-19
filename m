Return-Path: <SRS0=hmUh=7B=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD943C433E0
	for <linux-media@archiver.kernel.org>; Tue, 19 May 2020 08:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9275206C3
	for <linux-media@archiver.kernel.org>; Tue, 19 May 2020 08:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgESIv0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 19 May 2020 04:51:26 -0400
Received: from retiisi.org.uk ([95.216.213.190]:47012 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726333AbgESIv0 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 19 May 2020 04:51:26 -0400
Received: from lanttu.localdomain (lanttu.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::c1:2])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id 83494634C87;
        Tue, 19 May 2020 11:51:09 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com, hverkuil@xs4all.nl
Subject: [PATCH v2 1/1] Documentation: media: Refer to mbus code documentation from CSI-2 docs
Date:   Tue, 19 May 2020 11:50:14 +0300
Message-Id: <20200519085014.32163-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The media bus codes to be used on serial busses are documented but there
was no reference from CSI-2 documentation. Add that now.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 Documentation/driver-api/media/csi2.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/driver-api/media/csi2.rst b/Documentation/driver-api/media/csi2.rst
index da8b356389f0..1653a51d2a6e 100644
--- a/Documentation/driver-api/media/csi2.rst
+++ b/Documentation/driver-api/media/csi2.rst
@@ -10,6 +10,13 @@ the host SoC. It is defined by the `MIPI alliance`_.
 
 .. _`MIPI alliance`: http://www.mipi.org/
 
+Media bus formats
+-----------------
+
+Always use the media bus pixel code that describes a parallel format that
+transfers a sample on a single clock cycle. See :ref:`v4l2-mbus-format` for more
+information.
+
 Transmitter drivers
 -------------------
 
-- 
2.20.1

