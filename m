Return-Path: <SRS0=54rz=5Y=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9744C2D0F4
	for <linux-media@archiver.kernel.org>; Wed,  8 Apr 2020 17:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E40420771
	for <linux-media@archiver.kernel.org>; Wed,  8 Apr 2020 17:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbgDHR1G (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 8 Apr 2020 13:27:06 -0400
Received: from turbocat.net ([88.99.82.50]:33410 "EHLO mail.turbocat.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730538AbgDHR1F (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 8 Apr 2020 13:27:05 -0400
X-Greylist: delayed 444 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Apr 2020 13:27:05 EDT
Received: from hps2020.home.selasky.org (unknown [62.141.129.235])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id 3BC6B260306
        for <linux-media@vger.kernel.org>; Wed,  8 Apr 2020 19:19:39 +0200 (CEST)
To:     linux-media@vger.kernel.org
From:   Hans Petter Selasky <hps@selasky.org>
Subject: [PATCH] Fix broken for loop in libv4l
Message-ID: <3fc9b235-4763-546d-c9f6-5ac928a1bcff@selasky.org>
Date:   Wed, 8 Apr 2020 19:17:42 +0200
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,

This is one in a series of patches. Is this the right place to post 
patches for libv4l ?

Signed-off-by: Hans Petter Selasky <hps@selasky.org>
---
  lib/libv4lconvert/rgbyuv.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/libv4lconvert/rgbyuv.c b/lib/libv4lconvert/rgbyuv.c
index 79bc0bdb..b54b4577 100644
--- a/lib/libv4lconvert/rgbyuv.c
+++ b/lib/libv4lconvert/rgbyuv.c
@@ -893,7 +893,7 @@ void v4lconvert_nv12_to_yuv420(const unsigned char 
*src, unsigned char *dest,
  	}

  	for (i = 0; i < height; i++)
-		for (j = 0; i < width; j++) {
+		for (j = 0; j < width; j++) {
  			*ydst++ = *ysrc++;
  			if (((i % 2) == 0) && ((j % 2) == 0)) {
  				*udst++ = *uvsrc++;
-- 
2.25.0
