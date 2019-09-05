Return-Path: <SRS0=7WK4=XA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69EBC3A5A5
	for <linux-media@archiver.kernel.org>; Thu,  5 Sep 2019 11:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE6521848
	for <linux-media@archiver.kernel.org>; Thu,  5 Sep 2019 11:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbfIELmP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 5 Sep 2019 07:42:15 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47029 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbfIELmP (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 5 Sep 2019 07:42:15 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1i5q9V-0004nt-4s; Thu, 05 Sep 2019 13:42:13 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        kernel@pengutronix.de
Subject: [PATCH] media: uapi: h264: clarify num_ref_idx_l[01]_(default_)active fields
Date:   Thu,  5 Sep 2019 13:42:10 +0200
Message-Id: <20190905114210.9232-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

To explain why num_ref_idx_active_override_flag is not part of the API,
describe how the num_ref_idx_l[01]_active_minus1 fields and the
num_ref_idx_l[01]_default_active_minus1 fields are used, depending on
whether the decoder parses slice headers itself or not.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 Documentation/media/uapi/v4l/ext-ctrls-codec.rst | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
index bc5dd8e76567..b9834625a939 100644
--- a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
+++ b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
@@ -1630,10 +1630,10 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type -
       -
     * - __u8
       - ``num_ref_idx_l0_default_active_minus1``
-      -
+      - This field is only used by decoders that parse slices themselves.
     * - __u8
       - ``num_ref_idx_l1_default_active_minus1``
-      -
+      - This field is only used by decoders that parse slices themselves.
     * - __u8
       - ``weighted_bipred_idc``
       -
@@ -1820,10 +1820,14 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type -
       -
     * - __u8
       - ``num_ref_idx_l0_active_minus1``
-      -
+      - This field is used by decoders that do not parse slices themselves.
+        If num_ref_idx_active_override_flag is not set, this field must be
+        set to the value of num_ref_idx_l0_default_active_minus1.
     * - __u8
       - ``num_ref_idx_l1_active_minus1``
-      -
+      - This field is used by decoders that do not parse slices themselves.
+        If num_ref_idx_active_override_flag is not set, this field must be
+        set to the value of num_ref_idx_l1_default_active_minus1.
     * - __u32
       - ``slice_group_change_cycle``
       -
-- 
2.20.1

