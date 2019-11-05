Return-Path: <SRS0=TICA=Y5=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0590BCA9EC7
	for <linux-media@archiver.kernel.org>; Tue,  5 Nov 2019 08:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1FEA20818
	for <linux-media@archiver.kernel.org>; Tue,  5 Nov 2019 08:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387782AbfKEIRj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 5 Nov 2019 03:17:39 -0500
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:58897 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387590AbfKEIRj (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 5 Nov 2019 03:17:39 -0500
Received: from [192.168.2.10] ([46.9.232.237])
        by smtp-cloud9.xs4all.net with ESMTPA
        id Ru1piftts9P9bRu1tiYtac; Tue, 05 Nov 2019 09:17:34 +0100
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH] v4l2-device.h: fix typo: putss -> puts
Message-ID: <b9e73b81-d097-5913-4faa-8a9eb449ac8b@xs4all.nl>
Date:   Tue, 5 Nov 2019 09:17:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOD+XUEgAp/zCy8iCRGfYyTRU5Uo3VgjQqUJanQWXoN68xlk2/AX6HK/wmfSncmdN5PrZ5+93IDkdFldV2069VNIxJJGvz4UvgTtmn/5drsg4u5Nnwro
 +VDJyd/HFagU15ld7R1ZwHm/9y0JDN8mvPhCwpUJYDgCOc8XOY3aw6UeGqnmtyog++KaFwHPJgxApA==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fix typo: putss -> puts

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
diff --git a/include/media/v4l2-device.h b/include/media/v4l2-device.h
index e0b8f2602670..5f36e0d2ede6 100644
--- a/include/media/v4l2-device.h
+++ b/include/media/v4l2-device.h
@@ -72,7 +72,7 @@ static inline void v4l2_device_get(struct v4l2_device *v4l2_dev)
 }

 /**
- * v4l2_device_put - putss a V4L2 device reference
+ * v4l2_device_put - puts a V4L2 device reference
  *
  * @v4l2_dev: pointer to struct &v4l2_device
  *

