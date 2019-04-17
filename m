Return-Path: <SRS0=ylfx=ST=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839BDC282DD
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 11:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5157B20656
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 11:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNk+Viy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbfDQLlm (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:41:42 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39050 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731824AbfDQLlm (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 17 Apr 2019 07:41:42 -0400
Received: by mail-ed1-f65.google.com with SMTP id k45so20674715edb.6
        for <linux-media@vger.kernel.org>; Wed, 17 Apr 2019 04:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z2Mp3vpIaM6Y6yW5+wrIeNSHfaxVWCs8372mcYQb1ak=;
        b=HNk+Viy9HPS5YcMRQV7Qcw0Ro0N0IZXdLky54Te8hORA4YxznkzDrHQbsQw3g6o9DK
         OXQaIUzKv6lQSNX1SqhFvXBfZybbtRkPj1vsqA6NJxX9ckviOf/KkVoPd8hJm8/cLe4B
         c7nfaZqhDW+3Vdg9suvyo+a0IOlAK7vwVSiuBqz3qfwivl98YsrG3ZLqR7haqyYukA8M
         Ppyb6i4h1U1tiNTs29d8DjsJrxIuZ1kfix2k6DOVkGtU3PEqBoIBuoLhM0O7zq6lcNgp
         j1JK6eTQemPtpHk1d0B5E1Mv7cK1zukK1S8ePKGfLTnSqTVSWliOKD16P1EHnKQ07NOF
         2Fdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=z2Mp3vpIaM6Y6yW5+wrIeNSHfaxVWCs8372mcYQb1ak=;
        b=WMep00WF0ANQE6G7jnOD8nzbUjRjOfeuLrTD0w/k8mxB6zRgEC/tRjDHoPu4x6MKBR
         4gnaktkUP5ddtyllJ0hWhio6qpmFbWn0ZKpjs9PXTdvXYx/ak1K61iqNoQR7f763A8ea
         CO8OhVK95oXN/3axGR8MEE0L0y86qlmYFbAKbVnFThghwpDG6TKQE3R1m9MAmRHHyuH7
         pZNNOxnv4T1lRvv1kpQolQ5+WJWZPOUR3cqKE8pVGeRguy6c5oFbZl5iCyQQ1rQHMPRT
         sxBHhri3iIoh/tKj9C8f1NC6Vj5KCbv6BNjnqEKsms5foYNPKCA/kXm79ztg4OHkKFWG
         DrKQ==
X-Gm-Message-State: APjAAAWO4bIxcemXjLtR3XRq5BiH+gK3NRkHOax434C03f7XalOHXYjN
        9mIsqMya+Hy7+8rWaCilH6U=
X-Google-Smtp-Source: APXvYqxo/9HAxOSU8N/ykxVFpHQRO+TZsnIyIjEKMBMYkcrBS00P+YJlIcOk4mAbhN3n8GO7Zo8B9w==
X-Received: by 2002:a17:906:aece:: with SMTP id me14mr48585445ejb.0.1555501300059;
        Wed, 17 Apr 2019 04:41:40 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id q56sm4371622edd.80.2019.04.17.04.41.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 04:41:38 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo@ribalda.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Gregor Jasny <gjasny@googlemail.com>,
        linux-media@vger.kernel.org, daniel@qtec.com
Cc:     Ricardo Ribalda Delgado <ricardo@ribalda.com>
Subject: [PATCH v2 2/2] libv4lconvert: Add support for V4L2_PIX_FMT_NV12
Date:   Wed, 17 Apr 2019 13:41:35 +0200
Message-Id: <20190417114135.5987-2-ricardo@ribalda.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190417114135.5987-1-ricardo@ribalda.com>
References: <20190416120203.24028-1-ricardo@ribalda.com>
 <20190417114135.5987-1-ricardo@ribalda.com>
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

Changelog v2:
- None

The code has ben tested with qv4l2 and vivid.
v4lconvert_nv12_to_yuv420 has not been tested!!, any suggestions for
how to do it?

 lib/libv4lconvert/libv4lconvert-priv.h |  6 +++
 lib/libv4lconvert/libv4lconvert.c      | 19 +++++++++
 lib/libv4lconvert/rgbyuv.c             | 56 ++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/lib/libv4lconvert/libv4lconvert-priv.h b/lib/libv4lconvert/libv4lconvert-priv.h
index 5286a9b1..ce5970c9 100644
--- a/lib/libv4lconvert/libv4lconvert-priv.h
+++ b/lib/libv4lconvert/libv4lconvert-priv.h
@@ -286,6 +286,12 @@ void v4lconvert_hm12_to_yuv420(const unsigned char *src,
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
index 0607cc8b..665ee9ea 100644
--- a/lib/libv4lconvert/libv4lconvert.c
+++ b/lib/libv4lconvert/libv4lconvert.c
@@ -139,6 +139,7 @@ static const struct v4lconvert_pixfmt supported_src_pixfmts[] = {
 	{ V4L2_PIX_FMT_SN9C20X_I420,	12,	 6,	 3,	1 },
 	{ V4L2_PIX_FMT_M420,		12,	 6,	 3,	1 },
 	{ V4L2_PIX_FMT_HM12,		12,	 6,	 3,	1 },
+	{ V4L2_PIX_FMT_NV12,		12,	 6,	 3,	1 },
 	{ V4L2_PIX_FMT_CPIA1,		 0,	 6,	 3,	1 },
 	/* JPEG and variants */
 	{ V4L2_PIX_FMT_MJPEG,		 0,	 7,	 7,	0 },
@@ -932,6 +933,24 @@ static int v4lconvert_convert_pixfmt(struct v4lconvert_data *data,
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
index 02c8cb5b..79bc0bdb 100644
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

