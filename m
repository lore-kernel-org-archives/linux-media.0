Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E7DC64E75
	for <linux-media@archiver.kernel.org>; Thu, 26 Nov 2020 13:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A027721D40
	for <linux-media@archiver.kernel.org>; Thu, 26 Nov 2020 13:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="sLz3lJk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390010AbgKZN1c (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 26 Nov 2020 08:27:32 -0500
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:49345 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390001AbgKZN1b (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 26 Nov 2020 08:27:31 -0500
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud7.xs4all.net with ESMTPA
        id iHIrkPCQhN7XgiHJ4kYrYC; Thu, 26 Nov 2020 14:27:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1606397250; bh=HpCfFEos28LAs4hZY3HW0XKINloJ+6iSC+ihD6qkhxQ=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=sLz3lJk8AXEnpwELMYlH2v7YbaHk04mduXaxA/YoeS3QB2c073glCCo4cASu8bad6
         nHX+HsggLPJjT0meu1a98pb0SSLyq0HpgIB6PuZnGtVHvNnFwozjwMmgvfQaH4eNKz
         0ZMMNRIKIxPKk1Om22XAePe0JbPjh1jOkaK8Syh0HpTkxfwf9a803YBvIYhTasZHcG
         kP/H7oAJTHOpEMeoTpLnmjFjZ0x0/ZGZ+LZ+ZLru3zwil5ya0XN3qZDa1DAh380Cd6
         rxC23ABMGVAQOmO6XfGlyTfApv0kgquKiuZwd6Zc4ngjqgy2TMIH6sWSfXeSm1dDW5
         LY1uXRauGAR3A==
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 4/6] pixfmt-compressed.rst: fix 'bullet' formatting
Date:   Thu, 26 Nov 2020 14:27:15 +0100
Message-Id: <20201126132717.1216907-5-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126132717.1216907-1-hverkuil-cisco@xs4all.nl>
References: <20201126132717.1216907-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfI2mYU/U22kBPRgdIV4rFhhBfw55xjWo5zsUQkgwONGtjwg1nWlRrYf/MrJQoHvJbLKYsi5QGNYkG+ulpk4vZ64bqHvJm7MQfqyIEhP5op/CaxfaPSEs
 KNhiDZ2GQWRALvY/1ucE59gxB3rcgcudHXJ9WYO+jp+tfOzfBX5GBC6qASCiqJdFYLNHnZKzmty7x6R9VW+xQzlEmc74ztHq6NXr6tHANX+rzhgD9OGuut+T
 jXcvYK25kfd7VwvryfEbgl0dbFQXVxeQJ3osXw4pNdw=
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Drop the 'bullets' for the HEVC stateless codec documentation.
It doesn't work, and they just show up as asterisks.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 .../userspace-api/media/v4l/pixfmt-compressed.rst         | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
index b8899262d8de..4ae737520925 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
@@ -191,10 +191,10 @@ Compressed Formats
 	through the ``V4L2_CID_MPEG_VIDEO_HEVC_DECODE_MODE``
         and ``V4L2_CID_MPEG_VIDEO_HEVC_START_CODE`` controls.
 	Metadata associated with the frame to decode is required to be passed
-	through the following controls :
-        * ``V4L2_CID_MPEG_VIDEO_HEVC_SPS``
-        * ``V4L2_CID_MPEG_VIDEO_HEVC_PPS``
-        * ``V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS``
+	through the following controls:
+        ``V4L2_CID_MPEG_VIDEO_HEVC_SPS``,
+        ``V4L2_CID_MPEG_VIDEO_HEVC_PPS``, and
+        ``V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS``.
 	See the :ref:`associated Codec Control IDs <v4l2-mpeg-hevc>`.
 	Buffers associated with this pixel format must contain the appropriate
 	number of macroblocks to decode a full corresponding frame.
-- 
2.29.2

