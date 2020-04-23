Return-Path: <SRS0=iMag=6H=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C495CC55193
	for <linux-media@archiver.kernel.org>; Thu, 23 Apr 2020 10:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99839208E4
	for <linux-media@archiver.kernel.org>; Thu, 23 Apr 2020 10:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="QDz/m7Qf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgDWKs3 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:48:29 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:37999 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727832AbgDWKsZ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 23 Apr 2020 06:48:25 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud7.xs4all.net with ESMTPA
        id RZP2jLuQ47xncRZP5jQHTz; Thu, 23 Apr 2020 12:48:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1587638904; bh=tXcERKsqHRsDnc50u8Vx+0Dijxw2cNLibuxxlZFQAt8=;
        h=From:Subject:To:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=QDz/m7Qf23IfsuOqpSWVciZ0/MyENp5djf7mnaCJRKH+dmz4Vvzy8SEepxW9tuFWU
         5aED4hHCZm2iOZq0GgiIeOYBkpxmSVmnFEk2ROdFUxk90dhDjWqTV5UZf7juM5F2QX
         1xLrH3yny/iWw3NMp6ka8t9XxeRIz9sjGHUKXh/JEvyb2WRPUpLdaZ/473i9itTSqI
         GnnhGuV+Avc+mZnHzQ/lc2ZLAmBf9uwVskPLCB9kCUX7EgLGC4IS3CCcltXF5KNNT5
         eEUSfAQ+mR0sUw9gg69bS/T9kRTJwxkJ9cBBkea3doF3afN453Uxwx1ieDGWwoGIFZ
         5doS94sZGvuSA==
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH] v4l2-compliance: zero mbus_code
To:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Helen Koike <helen.koike@collabora.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Message-ID: <5cf00351-bf5f-b347-0ab5-9ea260a7bc85@xs4all.nl>
Date:   Thu, 23 Apr 2020 12:48:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLyJwAkzqMpJcNEPA9l6sDUPy/n8xiKsCQOPdIgnsOgW0YZLiLwQ0vaJ2NFDel12rkQjs9XX10Y3lN5RvdSio0C7j6VoO3Yfw31G9jqIrH8NKfXU/0CA
 FxMkRv58Ck3DL27OGC9PpVK7F3/PwGekXIrTkxDBpUlPH7DiDYL7VZpxvlGGvpUF+m0AwUHvB85uFl2+HqDzBTRx8zyDKjqnhf+SNI5DldtUVcB4VyWT4OTC
 SkFDhs2NCtsihjCDNQmhr8l6TkTwrIHgP2G0U7PyWeZBIH2NuYzYdmvb1+zEduV6W2FFLY3LqptpvVLWPobAtzxia8FFBuoD5OZgypzcbUfF3JDMibotKceK
 rsZ+wUFnALgSAwMnYI8Uxz7kX1YMc23pCDUyCsYd8DC0T8VNROo=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The new fmtdesc.mbus_code should be zeroed by applications.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
diff --git a/utils/v4l2-compliance/v4l2-test-formats.cpp b/utils/v4l2-compliance/v4l2-test-formats.cpp
index 824769b3..269a5fd9 100644
--- a/utils/v4l2-compliance/v4l2-test-formats.cpp
+++ b/utils/v4l2-compliance/v4l2-test-formats.cpp
@@ -235,6 +235,7 @@ static int testEnumFormatsType(struct node *node, unsigned type)
 		memset(&fmtdesc, 0xff, sizeof(fmtdesc));
 		fmtdesc.type = type;
 		fmtdesc.index = f;
+		fmtdesc.mbus_code = 0;

 		ret = doioctl(node, VIDIOC_ENUM_FMT, &fmtdesc);
 		if (ret == ENOTTY)
