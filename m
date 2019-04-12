Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC0FC10F0E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 15:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F044E218AF
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 15:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s+ifSMih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfDLP7c (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:59:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36545 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfDLP7b (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 11:59:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so12647226wrd.3
        for <linux-media@vger.kernel.org>; Fri, 12 Apr 2019 08:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=90rwpXEXFGoNt9j8MqywsjEPW+NzjmMm6jkw8wsUGVA=;
        b=s+ifSMihs8ddL09X415RQy/hlbE8x22tzAPwKBQ71Nc7WSkPJXiXi4aNMcdlRItpQB
         6HQYeA702yfHyVRTvUiIV0tN+XQHPRlo58QIMtt6ENDVgc63ViF9YfRj1w7+5j/P2qxe
         2howVQi3eI14kMTWwM6/iqB6wIUD9ulWOdaLIt3oJprpM65dzpwccSfTplmdXibJbHud
         Wuoy123UmX7qB6pgOolOl11GwKta3U3Y8VGFowm6UeniM8Ove+DeErJ6IIhej1O9Fqek
         gR9zL5brBEfgc41syQd3vZGZ/kKatGYFh78HfFYV/hoqsFM1EUr9TAYsSYWQVNZEzbtC
         FoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=90rwpXEXFGoNt9j8MqywsjEPW+NzjmMm6jkw8wsUGVA=;
        b=lvWDjzvJMJ53Cz97YzmPMiWjRC8XgzhAQzDb+6YCsGkAWv1PSACLV4L65hpc39fdb6
         abxnsf7dckNcBqmYdZZCm33X+4jNIjUKXCOFquVh54ryCcjb7MEoycpiuEsGQb1cY7vy
         DJpCowns7Ch7nTGSfrZMEiKgCU5zSnKdXi1eElOLJVBCyn7aU/H27E2BkmLzPRWkEFcZ
         3lAKYsHoAQ+wiyX05lKi3B+8WMyMGcZLPiJ7khS2ri1nbHTyayxxcsfe5YCBjaB1Lrxc
         RqmP+6HHA2dxZAaqGQVDzGU2L4cjp/bdCaEErm1oG+3Odmx7MMJiTqtYfn05slgaNE0L
         vqSw==
X-Gm-Message-State: APjAAAXHJEcRxXZWVz8X8K1T8AkeOk+KWMVAFfr3iafRoAHrIVE8/hSG
        SX+RRld9xry4t6BP1v172x8z8SrFif4=
X-Google-Smtp-Source: APXvYqzQNgPoaW/WaGC5ih7Q2ZmwYpBFGHEngHKVMvZ0hwor0vP+g5fOqu9HiWVIDFJsJJcarpuKow==
X-Received: by 2002:adf:db0c:: with SMTP id s12mr36574749wri.184.1555084769753;
        Fri, 12 Apr 2019 08:59:29 -0700 (PDT)
Received: from localhost.localdomain ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id b134sm15745440wmd.26.2019.04.12.08.59.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 08:59:29 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2] media/doc: Allow sizeimage to be set by v4l clients
Date:   Fri, 12 Apr 2019 18:59:15 +0300
Message-Id: <20190412155915.16849-1-stanimir.varbanov@linaro.org>
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
 Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst | 13 ++++++++++++-
 Documentation/media/uapi/v4l/pixfmt-v4l2.rst        | 11 ++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst b/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
index 5688c816e334..005428a8121e 100644
--- a/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
@@ -31,7 +31,18 @@ describing all planes of that format.
 
     * - __u32
       - ``sizeimage``
-      - Maximum size in bytes required for image data in this plane.
+      - Maximum size in bytes required for image data in this plane,
+	set by the driver. When the image consists of variable length
+	compressed data this is the number of bytes required by the
+	codec to support the worst-case compression scenario.
+
+	For uncompressed images the driver will set the value. For
+	variable length compressed data clients are allowed to set
+	the sizeimage field, but the driver may ignore it and set the
+	value itself, or it may modify the provided value based on
+	alignment requirements or minimum/maximum size requirements.
+	If the client wants to leave this to the driver, then it should
+	set sizeimage to 0.
     * - __u32
       - ``bytesperline``
       - Distance in bytes between the leftmost pixels in two adjacent
diff --git a/Documentation/media/uapi/v4l/pixfmt-v4l2.rst b/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
index 71eebfc6d853..0f7771151db9 100644
--- a/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
@@ -89,7 +89,16 @@ Single-planar format structure
       - Size in bytes of the buffer to hold a complete image, set by the
 	driver. Usually this is ``bytesperline`` times ``height``. When
 	the image consists of variable length compressed data this is the
-	maximum number of bytes required to hold an image.
+	number of bytes required by the codec to support the worst-case
+	compression scenario.
+
+	For uncompressed images the driver will set the value. For
+	variable length compressed data clients are allowed to set
+	the sizeimage field, but the driver may ignore it and set the
+	value itself, or it may modify the provided value based on
+	alignment requirements or minimum/maximum size requirements.
+	If the client wants to leave this to the driver, then it should
+	set sizeimage to 0.
     * - __u32
       - ``colorspace``
       - Image colorspace, from enum :c:type:`v4l2_colorspace`.
-- 
2.17.1

