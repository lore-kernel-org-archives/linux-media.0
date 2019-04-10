Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5900DC10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 15:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A0120854
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 15:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xmGYe7kp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfDJPVw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:21:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34673 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbfDJPVw (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 11:21:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so3487146wrq.1
        for <linux-media@vger.kernel.org>; Wed, 10 Apr 2019 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AqX3A4MUaXSULlKElxwofe4FLxfbNpQxFe7Pr95S+64=;
        b=xmGYe7kpRXsDcJnxwx2CdmqmrXMoN51RH4t9VLu3foGGAE4yT1IKvwpW88f6f5NTLO
         JbptK5SBXzd40pG/UTrfrca3BWiMnK0lueR9PM25K4pTs+VOb6PlGxtybq77HOngSZdb
         XFp4vBhDWdfbKaGVERRB/sFi1CpH34UZXAPxIUne909bURp0Yp6X+3XrdunSkcm9r1U7
         SdyT4JEWDT2s6EcBVcGtLR5c3n4aSkiFTXd5xMXCl3Z0kIMztC0D21C47Rc0yWxcfK3r
         H5wBXz0sC/dDcZz8lxZhUud6hPiyLMSzDYW67o4N9SEQBW/RhzrNdtE5ESzwgq0t4ut4
         FOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AqX3A4MUaXSULlKElxwofe4FLxfbNpQxFe7Pr95S+64=;
        b=j+c34/joSRu/VB9If1eia0jaJjMppMHX4MVWTyn+HtlvxSxOSsVSs1W8wSo0nrgCJD
         z58IMCfuZ1aBIvoL3ZnW00pOAKbty0267ovy9lOHkJxwHUyqSmc1/vPyO8mDR+hYIpyj
         eYCA3Jk4WvkvRRuFKuK/A/U0pjsC+Dj4wtHUcY+OZLUSkjmAo7fWv/fTaVUBuzYsW/1m
         NN8Z3M6EDuH4pxB+M3Y7ZwM02H9qI7dkeybOiWqKeecRHkCkPu58JNA50iLXl+2JqYYE
         oy7Dt/DRPiP+NLst3fpRqqFEEuRqZ9Hy1FB6kpjfIa1xsPpUdTSVPwiBWjtozZpZG10k
         qZGw==
X-Gm-Message-State: APjAAAXj7zXvPT6E4SR2tS0FnPG5q2sozkQOiezAsieenxCXCMMl9e7q
        TB0/09wc47gSaibuR0oYXLvMGkL9m9s=
X-Google-Smtp-Source: APXvYqwoq7aym4F3FLIxJoPCp+XqYntyhMymgqLaoK0ACljf63ZNnmqSN6SrgwmJ8McXxVa/gwzDgQ==
X-Received: by 2002:a5d:69c1:: with SMTP id s1mr27671947wrw.245.1554909710195;
        Wed, 10 Apr 2019 08:21:50 -0700 (PDT)
Received: from localhost.localdomain ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id s1sm27045644wrt.43.2019.04.10.08.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 08:21:49 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH] media/doc: Allow sizeimage to be set by v4l clients
Date:   Wed, 10 Apr 2019 18:21:28 +0300
Message-Id: <20190410152128.9811-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This changes v4l2_pix_format and v4l2_plane_pix_format sizeimage
field description to allow v4l clients to set bigger image size
in case of variable length compressed data.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst | 6 +++++-
 Documentation/media/uapi/v4l/pixfmt-v4l2.rst        | 4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst b/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
index 5688c816e334..a5cdc4537012 100644
--- a/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
@@ -31,7 +31,11 @@ describing all planes of that format.
 
     * - __u32
       - ``sizeimage``
-      - Maximum size in bytes required for image data in this plane.
+      - Maximum size in bytes required for image data in this plane,
+	set by the driver. When the image consists of variable length
+	compressed data this is the number of bytes required by the
+	codec to support the worst-case compression scenario. Clients
+	are allowed to set the sizeimage field, but drivers may modify it.
     * - __u32
       - ``bytesperline``
       - Distance in bytes between the leftmost pixels in two adjacent
diff --git a/Documentation/media/uapi/v4l/pixfmt-v4l2.rst b/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
index 71eebfc6d853..70e08c58febc 100644
--- a/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
@@ -89,7 +89,9 @@ Single-planar format structure
       - Size in bytes of the buffer to hold a complete image, set by the
 	driver. Usually this is ``bytesperline`` times ``height``. When
 	the image consists of variable length compressed data this is the
-	maximum number of bytes required to hold an image.
+	number of bytes required by the codec to support the worst-case
+	compression scenario. Clients are allowed to set the sizeimage
+	field, but drivers may modify it.
     * - __u32
       - ``colorspace``
       - Image colorspace, from enum :c:type:`v4l2_colorspace`.
-- 
2.17.1

