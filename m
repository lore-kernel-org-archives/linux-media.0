Return-Path: <SRS0=CnRj=T5=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D96C28CC0
	for <linux-media@archiver.kernel.org>; Wed, 29 May 2019 12:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8514C208C3
	for <linux-media@archiver.kernel.org>; Wed, 29 May 2019 12:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfE2Mqf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 29 May 2019 08:46:35 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:40473 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbfE2Mqe (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 29 May 2019 08:46:34 -0400
Received: from [IPv6:2001:983:e9a7:1:c843:3d28:cba4:8b6e] ([IPv6:2001:983:e9a7:1:c843:3d28:cba4:8b6e])
        by smtp-cloud7.xs4all.net with ESMTPA
        id VxySh8Doy3qlsVxyThtkxM; Wed, 29 May 2019 14:46:33 +0200
To:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Michael Tretter <m.tretter@pengutronix.de>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH] allegro-dvt: fix build failure
Message-ID: <032941d2-3681-218e-4c47-3c8a9f48b904@xs4all.nl>
Date:   Wed, 29 May 2019 14:46:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfIxxKT6d3dtuXHtooPlnUPkej2aCsCbQpHhEH4xotzEqjTcAmilQ647ly1MJI4WNKanPdfF9RpOCT+qGp1sJJAnJlEkNv0HnI+uDE39ZttdaIMYC+71N
 001PfKddDMKOcYF2pvBLEbjCJlbUX/eBKuPFsI7nluxTAFuhaR7+ugAV7bztPml17ufNZWTFdVru0rzEoDIJV8Dt9XdZXNGYuquauNvdmWEso//2/hMN8Ooo
 A9CoNczlZ00IYMsC9NPSlwE1kzkVB/kOlvpqWcBlfLDYpboAiYqSvBr3x3r+9/ZRjCbl+xpC3/OBPotDaK2zag==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

nal-h264.h is a local header, not a global one. Use "" instead of <>.

Fixed this compile error:

  CC      drivers/staging/media/allegro-dvt/nal-h264.o
drivers/staging/media/allegro-dvt/nal-h264.c:24:10: fatal error: nal-h264.h: No such file or directory
 #include <nal-h264.h>
          ^~~~~~~~~~~~

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
diff --git a/drivers/staging/media/allegro-dvt/nal-h264.c b/drivers/staging/media/allegro-dvt/nal-h264.c
index fd4b96817b69..4e14b77851e1 100644
--- a/drivers/staging/media/allegro-dvt/nal-h264.c
+++ b/drivers/staging/media/allegro-dvt/nal-h264.c
@@ -21,7 +21,7 @@
 #include <linux/export.h>
 #include <linux/log2.h>

-#include <nal-h264.h>
+#include "nal-h264.h"

 /*
  * See Rec. ITU-T H.264 (04/2017) Table 7-1 – NAL unit type codes, syntax
