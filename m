Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BF9C433E9
	for <linux-media@archiver.kernel.org>; Mon, 15 Mar 2021 17:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D04B64F04
	for <linux-media@archiver.kernel.org>; Mon, 15 Mar 2021 17:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhCORgf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Mar 2021 13:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbhCORgO (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Mar 2021 13:36:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256C6C06175F
        for <linux-media@vger.kernel.org>; Mon, 15 Mar 2021 10:36:14 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bm21so67663345ejb.4
        for <linux-media@vger.kernel.org>; Mon, 15 Mar 2021 10:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kGLUxRHfm3EIlGd4N+uEn8OSkXWMynAv8QMKM8OCTEg=;
        b=XoBqXGw00b+nV7WXr92n0EdsVDmyBBbbt6UZfiZc91iF+dhWYj40r0p1dBj69bv2wm
         m5O65up56g+rtsLwAaCZFnW+jbtEerOILhXss9ALl6UexQFweLZymGoq/cUisipf6rO9
         k+q2jl7oz4EBEtGm8UsFQaHebvcWS6+Vzy3+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kGLUxRHfm3EIlGd4N+uEn8OSkXWMynAv8QMKM8OCTEg=;
        b=IAwqNZZ0HQdhBchf8TLmrrdVW4J0lz6PTI2XlAxEU9P5zPlVnsgrM+XLSHuuUZyX9h
         Q4uBPayRFxE52Zff6OPs8KWwvrDYXnWeJT3loFvQVdt6CzbMX7diyab0CdEfGg/OCdOH
         8f15gTRQlltwIlvHGkmbUc0vgl++i+Ig6pz1reWtwNaG+Vm20DfnVa0VgSgSTES+NMuo
         RilPlJsIPB+d+i6JVFsC4g/yck9cTIc3SWjIKwsd/GYfsS9qcsQpBCZ0xzFeoSHxCsMx
         iTfxc5jrtzYDG6yl09W7VOcjehmpghdG7DgEoDqym61xwB/OOJHI/MCWfL6+hcZ3rFhw
         5wmw==
X-Gm-Message-State: AOAM533TyH1YxIcsz6bA95yatjMwQdioErwmTrq4bep14c8ViA53gtiv
        MpanS5vkgPx/0seICun9X+SlvA==
X-Google-Smtp-Source: ABdhPJxhr0bL1B8rtOBmIEPWSJulYD8sUtEQc75FYbnJbNufb4DVLqF+V6zZEnppOctDz1QkwiR31A==
X-Received: by 2002:a17:906:2dda:: with SMTP id h26mr24655719eji.163.1615829772839;
        Mon, 15 Mar 2021 10:36:12 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id a3sm8109239ejv.40.2021.03.15.10.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 10:36:12 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 02/11] media: uvcvideo: Set capability in s_param
Date:   Mon, 15 Mar 2021 18:36:00 +0100
Message-Id: <20210315173609.1547857-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210315173609.1547857-1-ribalda@chromium.org>
References: <20210315173609.1547857-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fixes v4l2-compliance:

Format ioctls (Input 0):
                warn: v4l2-test-formats.cpp(1339): S_PARM is supported but doesn't report V4L2_CAP_TIMEPERFRAME
                fail: v4l2-test-formats.cpp(1241): node->has_frmintervals && !cap->capability

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 252136cc885c..157310c0ca87 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -472,10 +472,13 @@ static int uvc_v4l2_set_streamparm(struct uvc_streaming *stream,
 	uvc_simplify_fraction(&timeperframe.numerator,
 		&timeperframe.denominator, 8, 333);
 
-	if (parm->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
+	if (parm->type == V4L2_BUF_TYPE_VIDEO_CAPTURE) {
 		parm->parm.capture.timeperframe = timeperframe;
-	else
+		parm->parm.capture.capability = V4L2_CAP_TIMEPERFRAME;
+	} else {
 		parm->parm.output.timeperframe = timeperframe;
+		parm->parm.output.capability = V4L2_CAP_TIMEPERFRAME;
+	}
 
 	return 0;
 }
-- 
2.31.0.rc2.261.g7f71774620-goog

