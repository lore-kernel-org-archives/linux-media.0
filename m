Return-Path: <SRS0=oGXw=CZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F8BC433E2
	for <linux-media@archiver.kernel.org>; Wed, 16 Sep 2020 19:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D7EF206DB
	for <linux-media@archiver.kernel.org>; Wed, 16 Sep 2020 19:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jqnZb9lE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgIPTCW (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 16 Sep 2020 15:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbgIPRsr (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 16 Sep 2020 13:48:47 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4034C06178A
        for <linux-media@vger.kernel.org>; Wed, 16 Sep 2020 03:47:16 -0700 (PDT)
Received: from Q.local (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 473A357F;
        Wed, 16 Sep 2020 12:46:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1600253220;
        bh=XtUINuLQHklOMV2d9DgAuMtlAOO0EARVXAk3NQJpN1w=;
        h=From:To:Cc:Subject:Date:From;
        b=jqnZb9lEbDOfU1IDXOlhnTdG2ZI3vrxzPATgISKKpC2aACULfj3Tb7+YIkZfyJlHD
         wLLt7H5SLgbSbiheGKPXSJlsCsiHmJG3EU7JhRO51pd87hAq/6FlVtKkYXsLvRbJfu
         UIjOqUP25yGlprVS3N+uS2q4czteQw7ZZo+QVQEI=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Jiri Kosina <trivial@kernel.org>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH] media: v4l2-async: Fix trivial documentation typo
Date:   Wed, 16 Sep 2020 11:46:45 +0100
Message-Id: <20200916104645.1460619-1-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fix the incorrect spelling asyncrhronous as asynchronous, which is
visible in the public documentation of enum v4l2_async_match_type.

Fixes: ab4f5a4afc2d ("[media] v4l2-async: document the remaining stuff")
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 include/media/v4l2-async.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
index 8319284c93cb..3b85efc253ec 100644
--- a/include/media/v4l2-async.h
+++ b/include/media/v4l2-async.h
@@ -27,7 +27,7 @@ struct v4l2_async_notifier;
  * @V4L2_ASYNC_MATCH_I2C: Match will check for I2C adapter ID and address
  * @V4L2_ASYNC_MATCH_FWNODE: Match will use firmware node
  *
- * This enum is used by the asyncrhronous sub-device logic to define the
+ * This enum is used by the asynchronous sub-device logic to define the
  * algorithm that will be used to match an asynchronous device.
  */
 enum v4l2_async_match_type {
-- 
2.25.1

