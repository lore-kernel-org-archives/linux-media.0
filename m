Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A961C433ED
	for <linux-media@archiver.kernel.org>; Sat,  1 May 2021 08:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1C2461409
	for <linux-media@archiver.kernel.org>; Sat,  1 May 2021 08:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhEAIU6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 1 May 2021 04:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhEAIU5 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sat, 1 May 2021 04:20:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B7FC06138B
        for <linux-media@vger.kernel.org>; Sat,  1 May 2021 01:20:07 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t2-20020a17090a0242b0290155433387beso7769162pje.1
        for <linux-media@vger.kernel.org>; Sat, 01 May 2021 01:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T0QhAMVRyhNZYOJkS7fUdHkK76N85VkHR9KJl9UPz1Y=;
        b=BwppWs5HW/jbJNB2RxDjaX8ydUGFrmXSsSghqsA4s4C5yVNYRb2qgd/bFA/7Njine0
         1oXLMT7wJa1F2+bROSEwmXOrFKLgpX3KgehxvehGzt1lmoCvpXvNrG2qs4bQ9YwIunsD
         dcFYc9Fccj66Zg30m9OfByEkxPH+0zFVa1+xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T0QhAMVRyhNZYOJkS7fUdHkK76N85VkHR9KJl9UPz1Y=;
        b=pkoAlPKXZpvcIlwU0d6I34GyhkHwlOdrC47aZoVpFqGdGLEb1veGIzNG1o/h7YdhZq
         oCTcas83ShZB3+IQ8NrF0mhuLl35siRC1PkIye0z4bHn2LWK5mlqwGjKNZ4ZutP5DJXp
         21Y/E3TypbBcaSGM5G/TFI+yT7MKltUPej/b2fRUEEwvZDd2YWtulMwC5p2X1/x1nPew
         3+OUL1kb1mgFg0VaOHH/x1zl3w0YYlkxIttJKhnc5ZeDDUMJbf6jhWpO6O6Uryf6XuoY
         ll3zURpTlkEpJoO6wkQOnzQ9qiPjlGcr9hLuwq14ClCUKl2bufPbOGJXBmRFcXlwzYI0
         T4Nw==
X-Gm-Message-State: AOAM5320qWr0aRZWLAZzyK6tbXkUxd7hKSb5UCsfxTwK+w+OfY03guVS
        MfhI6mQEP/EmLoGw4yzC4kbV7A==
X-Google-Smtp-Source: ABdhPJwqf9Ub0IV90a1ZxmPebz2HBQYvKnice/9THmJFRh83gL37jdOs/v/FMtOTSdQL8rPMPBEhlg==
X-Received: by 2002:a17:90a:1d4b:: with SMTP id u11mr19137166pju.74.1619857207370;
        Sat, 01 May 2021 01:20:07 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:8be7:e987:d00a:1442])
        by smtp.gmail.com with ESMTPSA id b7sm3763003pjq.36.2021.05.01.01.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 01:20:06 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ricardo Ribalda <ribalda@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 0/5] media: uvcvideo: implement UVC 1.5 ROI
Date:   Sat,  1 May 2021 17:19:56 +0900
Message-Id: <20210501082001.100533-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello,

	This patch set implements UVC 1.5 ROI using v4l2_selection API.

v5:
-- fixed UAPI typo: STABILIXATION
-- moved V4L2_CID_REGION_OF_INTEREST_AUTO to V4L2_CID_CAMERA_CLASS_BASE+36
-- added more comments (Ricardo)
-- added V4L2_CID_REGION_OF_INTEREST_AUTO to v4l2_ctrl_get_name() (Ricardo)

Sergey Senozhatsky (5):
  media: v4l UAPI: add ROI selection targets
  media: v4l UAPI: document ROI selection targets
  media: uvcvideo: add ROI auto controls
  media: v4l UAPI: document ROI auto_controls
  media: uvcvideo: add UVC 1.5 ROI control

 .../media/v4l/ext-ctrls-camera.rst            |  23 +++
 .../media/v4l/selection-api-configuration.rst |  22 ++
 .../media/v4l/selection-api-examples.rst      |  27 +++
 .../media/v4l/v4l2-selection-targets.rst      |  24 +++
 drivers/media/usb/uvc/uvc_ctrl.c              |  19 ++
 drivers/media/usb/uvc/uvc_v4l2.c              | 189 +++++++++++++++++-
 drivers/media/v4l2-core/v4l2-ctrls.c          |   1 +
 include/uapi/linux/usb/video.h                |   1 +
 include/uapi/linux/v4l2-common.h              |   8 +
 include/uapi/linux/v4l2-controls.h            |  10 +
 10 files changed, 321 insertions(+), 3 deletions(-)

-- 
2.31.1.527.g47e6f16901-goog

