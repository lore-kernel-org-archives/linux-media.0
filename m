Return-Path: <SRS0=z7aI=SZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E36EC10F14
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 14:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AD320645
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 14:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfDWOFQ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:05:16 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:38539 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727500AbfDWOFQ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 23 Apr 2019 10:05:16 -0400
Received: from [IPv6:2001:420:44c1:2579:c4cd:9df1:43f2:db66] ([IPv6:2001:420:44c1:2579:c4cd:9df1:43f2:db66])
        by smtp-cloud7.xs4all.net with ESMTPA
        id Iw2nhDKwvZVjxIw2qhWXw5; Tue, 23 Apr 2019 16:05:14 +0200
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     "Rodin, Michael (Ferchau; ADITG/ESM1)" <mrodin@de.adit-jv.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH] field-order.rst: clarify FIELD_ANY and FIELD_NONE
Message-ID: <300aac49-db2e-0583-565a-8273d4b22185@xs4all.nl>
Date:   Tue, 23 Apr 2019 16:05:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAB6lVmS4GqZmAEZpncKu+ki4SfKDNveGJyQdQcDf/6lMkTpaCp7P5lyvDsHumyP/EP9iZCYxvwK6SPUfr+aiNl8srV3CEA2kAHTU/eA5si1mfZbD4kJ
 BA5iXicexhz3GCr4SoJJpy4YYuS0z9Qrb0SKPKRUZVuvSOm0/HNGENph9brSHP9Mb2JrL1dubU6YKW8nmsRPpfdHCIQKn/05I1n4q7XiGnTQ3DX23ZMx/mqz
 99EybSk54bzb1OcbX8SNQohL0wnKXJl1mmyVT/ea4WY4CyP0NO6BaADRJlY/BmyksunOYjVmD2MNxt7uhkykmg==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Rephrased the FIELD_ANY description: rather than explicitly list
field values, just say 'when any field format is acceptable'. The
list of FIELD values was outdated, so it was a bit confusing.

The FIELD_NONE description said that 'The driver may also indicate
this order when it cannot distinguish between V4L2_FIELD_TOP and
V4L2_FIELD_BOTTOM'. This is false, NONE really means a full frame
and userspace depends on that. So drop this line completely. There
are no drivers that do this anyway.

FIELD_TOP/BOTTOM/ALTERNATE indicate that the number of lines in the
buffer are that of a field, not frame, so returning NONE here would
cause huge problems.

Finally attempt to clarify 'progressive' and 'interlaced' a little
bit.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
diff --git a/Documentation/media/uapi/v4l/field-order.rst b/Documentation/media/uapi/v4l/field-order.rst
index 3fb473e3b8e2..d640e922a974 100644
--- a/Documentation/media/uapi/v4l/field-order.rst
+++ b/Documentation/media/uapi/v4l/field-order.rst
@@ -75,12 +75,11 @@ enum v4l2_field

     * - ``V4L2_FIELD_ANY``
       - 0
-      - Applications request this field order when any one of the
-	``V4L2_FIELD_NONE``, ``V4L2_FIELD_TOP``, ``V4L2_FIELD_BOTTOM``, or
-	``V4L2_FIELD_INTERLACED`` formats is acceptable. Drivers choose
-	depending on hardware capabilities or e. g. the requested image
-	size, and return the actual field order. Drivers must never return
-	``V4L2_FIELD_ANY``. If multiple field orders are possible the
+      - Applications request this field order when any field format
+	is acceptable. Drivers choose depending on hardware capabilities or
+	e.g. the requested image size, and return the actual field order.
+	Drivers must never return ``V4L2_FIELD_ANY``.
+	If multiple field orders are possible the
 	driver must choose one of the possible field orders during
 	:ref:`VIDIOC_S_FMT <VIDIOC_G_FMT>` or
 	:ref:`VIDIOC_TRY_FMT <VIDIOC_G_FMT>`. struct
@@ -88,9 +87,8 @@ enum v4l2_field
 	``V4L2_FIELD_ANY``.
     * - ``V4L2_FIELD_NONE``
       - 1
-      - Images are in progressive format, not interlaced. The driver may
-	also indicate this order when it cannot distinguish between
-	``V4L2_FIELD_TOP`` and ``V4L2_FIELD_BOTTOM``.
+      - Images are in progressive (frame-based) format, not interlaced
+        (field-based).
     * - ``V4L2_FIELD_TOP``
       - 2
       - Images consist of the top (aka odd) field only.

