Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2C6C433E6
	for <linux-media@archiver.kernel.org>; Mon, 15 Mar 2021 17:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B47364F07
	for <linux-media@archiver.kernel.org>; Mon, 15 Mar 2021 17:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbhCORgg (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Mar 2021 13:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbhCORgN (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Mar 2021 13:36:13 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA4DC06175F
        for <linux-media@vger.kernel.org>; Mon, 15 Mar 2021 10:36:13 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id mj10so67677991ejb.5
        for <linux-media@vger.kernel.org>; Mon, 15 Mar 2021 10:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DgS4OPGpMnlY/AXfZW8QgtbwbGQ3UnwEJWQevK1FyQM=;
        b=Al7Au5qrWKDUWWxWszyg+RCKYoNVfZF0Ls3oN/2uJW2qijirbLB8Ls9c9al9GH1PqS
         XJTiZ5qLKkjlQ57tROZSdvEMFl1PNE2LwXTN8sVWHICg/4NtoVbWGpHGto7aLGg5ebgm
         /GdQT2pCbd3tce+FV57gOZON15GPsKK6oUI/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DgS4OPGpMnlY/AXfZW8QgtbwbGQ3UnwEJWQevK1FyQM=;
        b=Llnk1nPXI3066hc08aXQu9chN6GbL1DdFv9KcR3wb5sUQJCSZ3kBssoFL/lhgjZIPW
         sb+aiaySLwph8blN2fQk0YA5/BKnjxAAf3t4PGrk2oKtaGD82zkUqXL8keiihuoUyVD2
         G89NmNjHQg9ibr52M68spK5W94aCIrjrSnL51kd/9HjeIsGK5B+WFGnQqps+cDtLjal3
         78QVwQo1t1Ju9Ukyzai/Hg7SkTIEM5Lsx60HuFdzbZDn9SaEDoHolf8gTf7BEsryihht
         +mW1SHZTMLBbsCYkLQmI0HGunMAapza0RCciS3r0MNTXCd+feW3targQIRiF9fsa11If
         lklw==
X-Gm-Message-State: AOAM5328dfRKhfgHVMrqY4SnFm2ZdLMJSa34qAVqctiCLUrZ7sOkiTz4
        R6W9KI6BGoHUCsmtg0Ur4x1G5w==
X-Google-Smtp-Source: ABdhPJybqQLxb6wI/x4Uz9yaDR+qzO+umUF/dAlWVl6VlDbW2ZvoVdKUqmc7bpycPL9FfzOuKkQCJQ==
X-Received: by 2002:a17:906:5acd:: with SMTP id x13mr24713291ejs.211.1615829772215;
        Mon, 15 Mar 2021 10:36:12 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id a3sm8109239ejv.40.2021.03.15.10.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 10:36:12 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
Subject: [PATCH v4 01/11] media: v4l2-ioctl: Fix check_ext_ctrls
Date:   Mon, 15 Mar 2021 18:35:59 +0100
Message-Id: <20210315173609.1547857-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210315173609.1547857-1-ribalda@chromium.org>
References: <20210315173609.1547857-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Drivers that do not use the ctrl-framework use this function instead.

- Return error when handling of REQUEST_VAL.
- Do not check for multiple classes when getting the DEF_VAL.

Fixes v4l2-compliance:
Control ioctls (Input 0):
		fail: v4l2-test-controls.cpp(813): doioctl(node, VIDIOC_G_EXT_CTRLS, &ctrls)
	test VIDIOC_G/S/TRY_EXT_CTRLS: FAIL

Cc: stable@vger.kernel.org
Fixes: 6fa6f831f095 ("media: v4l2-ctrls: add core request support")
Suggested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 31d1342e61e8..9406e90ff805 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -917,15 +917,24 @@ static int check_ext_ctrls(struct v4l2_ext_controls *c, int allow_priv)
 	for (i = 0; i < c->count; i++)
 		c->controls[i].reserved2[0] = 0;
 
-	/* V4L2_CID_PRIVATE_BASE cannot be used as control class
-	   when using extended controls.
-	   Only when passed in through VIDIOC_G_CTRL and VIDIOC_S_CTRL
-	   is it allowed for backwards compatibility.
-	 */
-	if (!allow_priv && c->which == V4L2_CID_PRIVATE_BASE)
-		return 0;
-	if (!c->which)
+	switch (c->which) {
+	case V4L2_CID_PRIVATE_BASE:
+		/*
+		 * V4L2_CID_PRIVATE_BASE cannot be used as control class
+		 * when using extended controls.
+		 * Only when passed in through VIDIOC_G_CTRL and VIDIOC_S_CTRL
+		 * is it allowed for backwards compatibility.
+		*/
+		if (!allow_priv)
+			return 0;
+		break;
+	case V4L2_CTRL_WHICH_DEF_VAL:
+	case V4L2_CTRL_WHICH_CUR_VAL:
 		return 1;
+	case V4L2_CTRL_WHICH_REQUEST_VAL:
+		return 0;
+	}
+
 	/* Check that all controls are from the same control class. */
 	for (i = 0; i < c->count; i++) {
 		if (V4L2_CTRL_ID2WHICH(c->controls[i].id) != c->which) {
-- 
2.31.0.rc2.261.g7f71774620-goog

