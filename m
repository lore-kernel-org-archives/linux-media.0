Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F87C7113C
	for <linux-media@archiver.kernel.org>; Fri, 18 Aug 2023 12:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376801AbjHRMNB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 18 Aug 2023 08:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376800AbjHRMMx (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 18 Aug 2023 08:12:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACA61FC3
        for <linux-media@vger.kernel.org>; Fri, 18 Aug 2023 05:12:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E85562352
        for <linux-media@vger.kernel.org>; Fri, 18 Aug 2023 12:12:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32781C433C8
        for <linux-media@vger.kernel.org>; Fri, 18 Aug 2023 12:12:50 +0000 (UTC)
Message-ID: <17cd1a67-3966-237c-2e0d-2d3ae618f915@xs4all.nl>
Date:   Fri, 18 Aug 2023 14:12:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US, nl
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH] media: cec: cec.h: 2.1 ms -> 2100 ms
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The transfer timeout is 2100 ms, not 2.1 ms. Fix this in the
kerneldoc comment.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
diff --git a/include/media/cec.h b/include/media/cec.h
index 9c007f83569a..06db2483e225 100644
--- a/include/media/cec.h
+++ b/include/media/cec.h
@@ -173,7 +173,7 @@ struct cec_adap_ops {
  *			case the transmit will finish, but will not retransmit
  *			and be marked as ABORTED.
  * @xfer_timeout_ms:	the transfer timeout in ms.
- *			If 0, then timeout after 2.1 ms.
+ *			If 0, then timeout after 2100 ms.
  * @kthread_config:	kthread used to configure a CEC adapter
  * @config_completion:	used to signal completion of the config kthread
  * @kthread:		main CEC processing thread
