Return-Path: <SRS0=JUE0=SR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A15C10F12
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 15:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E412075B
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 15:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uPREm/Ix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfDOP1p (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:27:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44208 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfDOP1l (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Apr 2019 11:27:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id y7so22484825wrn.11
        for <linux-media@vger.kernel.org>; Mon, 15 Apr 2019 08:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rdjAJXPyrM7EYkVn/ceLH5U36WNFw9E4wp8blYV0QHo=;
        b=uPREm/IxJb+c7rMXJxDJMh982pm80bSgcoyt+4c2rUBFlpqabZFtJjD6BD9+UA1KYt
         5vx/eEY4H6WNCnZ7syHqiO/HD1lxfL6T2qPgACJJ2+3ukcVipDTNlRFdLF9A0MfT9RQd
         VK+vFaIWWjn4UZGgsm57pPhnBY+jOvuOMWXK6rBQdeBoRQFgChIkdPiHdAC7R7zSxSJO
         DuluM82P013xbllH6mjENEdWMT2jvkxI7+CLSpT3M5DXIqKhB/auctdGdjsjYdYhmHb7
         9E2WNMOiOEFCZ+wvuK6sdApFgDEX5ZbhMpzKK63x7K7MuNNVMlL0E+mFwA2exa7/T8Yb
         YWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rdjAJXPyrM7EYkVn/ceLH5U36WNFw9E4wp8blYV0QHo=;
        b=f+HIVxXvz8tm0qAS6EmuSSZLL/LSUKa7wOC1cSbv57MmV/WCmnB9lhn7ZuQpmEOazV
         MjiwKh97+iJ59uUci6eYeO120llXSPbMehcm2uy43RCfUhgE4xL1C8gc6WU9Z9fupEUC
         YHR97Uqs3eWgfllKjsYqGkjgnVunFFi6cfmyYoqIfZEcP9Hgr3ZIvrP40w+/M3s1BVzk
         4zR0Gfkk8cpWDjOgjHH1JHVrEg/WHLleGc4Eg+CH4p94uk52zkfUB/UZ9ECkZQyKi6M9
         7bSxoc7lr0iA0uSguwnF14qnxgiUxDNZtla2DYqJnApsSOiK6IBIVO2P2+J+XdCdL4fV
         jDwQ==
X-Gm-Message-State: APjAAAX4t+qef7UYwnLKx8m6WnsbRWBveP8P2YvJl3SWFKZUSDKnFbVI
        glK6IP89IDAj58fQDqxDZ1ixMnroWV0=
X-Google-Smtp-Source: APXvYqzq2oXCRYl5tmmkNntvSrG3Vz2aLWwIA5L9wCn7RJswjP0FpZAI5Q66CmQ6uDdMWUxgqgx0oQ==
X-Received: by 2002:adf:ea0b:: with SMTP id q11mr29187233wrm.233.1555342058968;
        Mon, 15 Apr 2019 08:27:38 -0700 (PDT)
Received: from localhost.localdomain ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id t74sm288818wmt.3.2019.04.15.08.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 08:27:38 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH] v4l: Add source event change for bit-depth
Date:   Mon, 15 Apr 2019 18:27:23 +0300
Message-Id: <20190415152723.2481-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This event indicate that the source bit-depth is changed during
run-time. The client must get the new format and re-allocate buffers
for it. This can usually happens with video decoder (encoders) when
the bit-stream depth is changed from 8 to 10bits or vice versa.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 Documentation/media/uapi/v4l/vidioc-dqevent.rst | 7 +++++++
 Documentation/media/videodev2.h.rst.exceptions  | 1 +
 include/uapi/linux/videodev2.h                  | 1 +
 3 files changed, 9 insertions(+)

diff --git a/Documentation/media/uapi/v4l/vidioc-dqevent.rst b/Documentation/media/uapi/v4l/vidioc-dqevent.rst
index dea9c0cc00ab..92573d7c3e05 100644
--- a/Documentation/media/uapi/v4l/vidioc-dqevent.rst
+++ b/Documentation/media/uapi/v4l/vidioc-dqevent.rst
@@ -397,6 +397,13 @@ call.
 	that many devices are not able to recover from a temporary loss of
 	signal and so restarting streaming I/O is required in order for the
 	hardware to synchronize to the video signal.
+    * - ``V4L2_EVENT_SRC_CH_BITDEPTH``
+      - 0x0002
+      - This event gets triggered when bit-depth change is detected from a
+	video decoder. Applications will have to query the new pixel format
+	and re-negotiate the queue. In most cases the streaming must be stopped
+	and restarted (:ref:`VIDIOC_STREAMOFF <VIDIOC_STREAMON>` followed by
+	:ref:`VIDIOC_STREAMON <VIDIOC_STREAMON>`).
 
 
 Return Value
diff --git a/Documentation/media/videodev2.h.rst.exceptions b/Documentation/media/videodev2.h.rst.exceptions
index 64d348e67df9..b4c35b347983 100644
--- a/Documentation/media/videodev2.h.rst.exceptions
+++ b/Documentation/media/videodev2.h.rst.exceptions
@@ -478,6 +478,7 @@ replace define V4L2_EVENT_CTRL_CH_FLAGS ctrl-changes-flags
 replace define V4L2_EVENT_CTRL_CH_RANGE ctrl-changes-flags
 
 replace define V4L2_EVENT_SRC_CH_RESOLUTION src-changes-flags
+replace define V4L2_EVENT_SRC_CH_BITDEPTH src-changes-flags
 
 replace define V4L2_EVENT_MD_FL_HAVE_FRAME_SEQ :c:type:`v4l2_event_motion_det`
 
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 496e6453450c..7398f42eac7d 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -2271,6 +2271,7 @@ struct v4l2_event_frame_sync {
 };
 
 #define V4L2_EVENT_SRC_CH_RESOLUTION		(1 << 0)
+#define V4L2_EVENT_SRC_CH_BITDEPTH		(1 << 1)
 
 struct v4l2_event_src_change {
 	__u32 changes;
-- 
2.17.1

