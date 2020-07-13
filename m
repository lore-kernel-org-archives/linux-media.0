Return-Path: <SRS0=Gq82=AY=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3722DC433EB
	for <linux-media@archiver.kernel.org>; Mon, 13 Jul 2020 15:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D4B62075B
	for <linux-media@archiver.kernel.org>; Mon, 13 Jul 2020 15:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbgGMPsr (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:48:47 -0400
Received: from turbocat.net ([88.99.82.50]:54550 "EHLO mail.turbocat.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729782AbgGMPsr (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 13 Jul 2020 11:48:47 -0400
Received: from hps2020.home.selasky.org (unknown [178.17.145.105])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id A77FA260CC3
        for <linux-media@vger.kernel.org>; Mon, 13 Jul 2020 17:48:42 +0200 (CEST)
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Petter Selasky <hps@selasky.org>
Subject: [PATCH] FreeBSD already defines packed. Check for existing
 definition, before defining.
Message-ID: <6664dfef-7ef7-af9c-e558-a8e9e242b593@selasky.org>
Date:   Mon, 13 Jul 2020 17:48:20 +0200
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


Signed-off-by: Hans Petter Selasky <hps@selasky.org>
---
  utils/common/v4l2-tpg.h | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/utils/common/v4l2-tpg.h b/utils/common/v4l2-tpg.h
index c07c60aa..b2eab10d 100644
--- a/utils/common/v4l2-tpg.h
+++ b/utils/common/v4l2-tpg.h
@@ -22,7 +22,9 @@ typedef __s16 s16;
  typedef __u8 u8;
  typedef __s8 s8;

+#ifndef __packed
  #define __packed __attribute__((packed))
+#endif
  #define pr_info printf
  #define noinline

