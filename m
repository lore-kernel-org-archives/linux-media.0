Return-Path: <SRS0=ut6f=SS=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E294C10F14
	for <linux-media@archiver.kernel.org>; Tue, 16 Apr 2019 12:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C76C20821
	for <linux-media@archiver.kernel.org>; Tue, 16 Apr 2019 12:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THe/AvEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfDPMCM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:02:12 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43111 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfDPMCM (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 16 Apr 2019 08:02:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id j20so7435974edq.10
        for <linux-media@vger.kernel.org>; Tue, 16 Apr 2019 05:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=llzl80DiIp82SCBlcIGLvNGZnzcIImMsnESshKV4KbY=;
        b=THe/AvEE5PCCgIQSdaMkK7fNtMoTy4zdOYIjgrpbAAfMV1ZwZ4ex+Yq5kMrEx+67St
         PzPJkp8janKqoDaU2PGFaYx6W1gy4OHFoFXKLjZWX50Ztamxj8Jy2rheVpNu5s+PMYUL
         Ikl7LTK2se34tW29xFBpf8Hmyoh5Zoae+0T2sVWJPwg9xWmr037n6rpamhEYPzkx1KrO
         x6abB9IH42RrmE5nspLZSZUy4xzMXCsqLUGTRmjILyuRVeP3CJtNoS4LaoRDhkB7cJsR
         +pxtXtYBtF/rwnS0K5xd+Q1Uo40n0+jh/IyfNBGVssBaUTKdruf7ZKNjG2ljsFzuVrRB
         RHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=llzl80DiIp82SCBlcIGLvNGZnzcIImMsnESshKV4KbY=;
        b=hOKmuAvJP0ttykM7mk8F9TW3fJBGs+Lx/T9DKMJtggyzgmxPwbZOWed2pX8Bm4tkof
         ppfpekhh1Qev8JYk31kNMNPdPIsKkSH0+gDP/y1AMXd1IaScuausA4Iy1PUspvOACdJQ
         fANWqLCpxCXuy65wCtCxEkSI+vzUOVBL0wXCwQ7K0lPVM4w8gGjwJpDRFvGlkeIZ4MHF
         tP6dQ+iKbFNecXZkQO92+ZuLCah4nSg4RuAIEfMVXjpt7fklQXNMg4flsfMB+Uw2hDNz
         9dOpcickRE5mQrisc3r+b4Lh3A402Z57edoZQukknixGAXz8P67u45WKsE+/O0+HnVZD
         o/Og==
X-Gm-Message-State: APjAAAUMP6QuZ8yfJMchQynGqH5SZ4GLVBI3BukeckI3A33ZfcXZymfQ
        Ta0pz3JaBf8vNOVkIwKTKdE=
X-Google-Smtp-Source: APXvYqzlskozCrer3jEUOgNrQCo+LEcqKZ56oVdrC/oXH2J7X3XZ8OTJon+2jAg19+vWqCQvMVt2VQ==
X-Received: by 2002:aa7:c5c4:: with SMTP id h4mr50253161eds.19.1555416129838;
        Tue, 16 Apr 2019 05:02:09 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id q20sm9616450ejb.65.2019.04.16.05.02.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 05:02:05 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo@ribalda.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Gregor Jasny <gjasny@googlemail.com>,
        linux-media@vger.kernel.org, daniel@qtec.com
Cc:     Ricardo Ribalda Delgado <ricardo@ribalda.com>
Subject: [PATCH] libv4lconvert: Add support for V4L2_PIX_FMT_NV12
Date:   Tue, 16 Apr 2019 14:02:03 +0200
Message-Id: <20190416120203.24028-1-ricardo@ribalda.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

NV12 is a two-plane version YUV 4:2:0, where the U and V components
are subsampled 2x2.

Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
---
The code has ben tested with qv4l2 and vivid.
v4lconvert_nv12_to_yuv420 has not been tested!!, any suggestions for
how to do it?

Thanks!
 lib/libv4lconvert/libv4lconvert-priv.h |  6 +++
 lib/libv4lconvert/libv4lconvert.c      | 19 +++++++++
 lib/libv4lconvert/rgbyuv.c             | 56 ++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/lib/libv4lconvert/libv4lconvert-priv.h b/lib/libv4lconvert/libv4lconvert-priv.h
index a8046ce2..c45b086e 100644
--- a/lib/libv4lconvert/libv4lconvert-priv.h
+++ b/lib/libv4lconvert/libv4lconvert-priv.h
@@ -285,6 +285,12 @@ void v4lconvert_hm12_to_yuv420(const unsigned char *src,
 void v4lconvert_hsv_to_rgb24(const unsigned char *src, unsigned char *dest,
 		int width, int height, int bgr, int Xin, unsigned char hsv_enc);
 
+void v4lconvert_nv12_to_rgb24(const unsigned char *src, unsigned char *dest,
+		int width, int height, int bgr);
+
+void v4lconvert_nv12_to_yuv420(const unsigned char *src, unsigned char *dest,
+		int width, int height, int yvu);
+
 void v4lconvert_rotate90(unsigned char *src, unsigned char *dest,
 		struct v4l2_format *fmt);
 
diff --git a/lib/libv4lconvert/libv4lconvert.c b/lib/libv4lconvert/libv4lconvert.c
index 78fb3432..2111d19f 100644
--- a/lib/libv4lconvert/libv4lconvert.c
+++ b/lib/libv4lconvert/libv4lconvert.c
@@ -116,6 +116,7 @@ static const struct v4lconvert_pixfmt supported_src_pixfmts[] = {
 	{ V4L2_PIX_FMT_SN9C20X_I420,	12,	 6,	 3,	1 },
 	{ V4L2_PIX_FMT_M420,		12,	 6,	 3,	1 },
 	{ V4L2_PIX_FMT_HM12,		12,	 6,	 3,	1 },
+	{ V4L2_PIX_FMT_NV12,		12,	 6,	 3,	1 },
 	{ V4L2_PIX_FMT_CPIA1,		 0,	 6,	 3,	1 },
 	/* JPEG and variants */
 	{ V4L2_PIX_FMT_MJPEG,		 0,	 7,	 7,	0 },
@@ -902,6 +903,24 @@ static int v4lconvert_convert_pixfmt(struct v4lconvert_data *data,
 		}
 		break;
 
+		/* NV12 formats */
+	case V4L2_PIX_FMT_NV12:
+		switch (dest_pix_fmt) {
+		case V4L2_PIX_FMT_RGB24:
+			v4lconvert_nv12_to_rgb24(src, dest, width, height, 0);
+			break;
+		case V4L2_PIX_FMT_BGR24:
+			v4lconvert_nv12_to_rgb24(src, dest, width, height, 1);
+			break;
+		case V4L2_PIX_FMT_YUV420:
+			v4lconvert_nv12_to_yuv420(src, dest, width, height, 0);
+			break;
+		case V4L2_PIX_FMT_YVU420:
+			v4lconvert_nv12_to_yuv420(src, dest, width, height, 1);
+			break;
+		}
+		break;
+
 		/* compressed bayer formats */
 	case V4L2_PIX_FMT_SPCA561:
 	case V4L2_PIX_FMT_SN9C10X:
diff --git a/lib/libv4lconvert/rgbyuv.c b/lib/libv4lconvert/rgbyuv.c
index 02c8cb5b..bfe3b15f 100644
--- a/lib/libv4lconvert/rgbyuv.c
+++ b/lib/libv4lconvert/rgbyuv.c
@@ -845,3 +845,59 @@ void v4lconvert_hsv_to_rgb24(const unsigned char *src, unsigned char *dest,
 			src += bppIN;
 		}
 }
+
+void v4lconvert_nv12_to_rgb24(const unsigned char *src, unsigned char *dest,
+		int width, int height, int bgr)
+{
+	int i, j;
+	const unsigned char *ysrc = src;
+	const unsigned char *uvsrc = src + width * height;
+
+	for (i = 0; i < height; i++) {
+		for (j = 0; j < width; j ++) {
+			if (bgr) {
+				*dest++ = YUV2B(*ysrc, *uvsrc, *(uvsrc + 1));
+				*dest++ = YUV2G(*ysrc, *uvsrc, *(uvsrc + 1));
+				*dest++ = YUV2R(*ysrc, *uvsrc, *(uvsrc + 1));
+			} else {
+				*dest++ = YUV2R(*ysrc, *uvsrc, *(uvsrc + 1));
+				*dest++ = YUV2G(*ysrc, *uvsrc, *(uvsrc + 1));
+				*dest++ = YUV2B(*ysrc, *uvsrc, *(uvsrc + 1));
+			}
+			ysrc++;
+			if (j&1)
+				uvsrc += 2;
+		}
+
+		/* Rewind u and v for next line */
+		if (!(i&1))
+			uvsrc -= width;
+	}
+}
+
+void v4lconvert_nv12_to_yuv420(const unsigned char *src, unsigned char *dest,
+		int width, int height, int yvu)
+{
+	int i, j;
+	const unsigned char *ysrc = src;
+	const unsigned char *uvsrc = src + width * height;
+	unsigned char *ydst = dest;
+	unsigned char *udst, *vdst;
+
+	if (yvu) {
+		vdst = ydst + width * height;
+		udst = vdst + ((width / 2) * (height / 2));
+	} else {
+		udst = ydst + width * height;
+		vdst = udst + ((width / 2) * (height / 2));
+	}
+
+	for (i = 0; i < height; i++)
+		for (j = 0; i < width; j++) {
+			*ydst++ = *ysrc++;
+			if (((i % 2) == 0) && ((j % 2) == 0)) {
+				*udst++ = *uvsrc++;
+				*vdst++ = *uvsrc++;
+			}
+		}
+}
-- 
2.20.1

