Return-Path: <SRS0=ylfx=ST=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13B4C282DD
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 11:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A150620656
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 11:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQbSMTri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbfDQLll (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:41:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35916 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfDQLlk (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 17 Apr 2019 07:41:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id u57so20054811edm.3
        for <linux-media@vger.kernel.org>; Wed, 17 Apr 2019 04:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1quVYlEoDtNWy2499n+DF3o+pu+n5t21qNaf1+jmtvc=;
        b=YQbSMTriRs80GWGVOCq6l0n0P9cCmh6JVU22KiNeMy23JGfqx86ddKmOKiZP1Q0XUC
         awZuNZzYd2VVU0swy8N+/ve7ZPNfvWVFq8YYD6uXBBoE4Hx2zKC58XhzUuquJ3QyZLz8
         qf3be0XxCqbriwevWT3YtfYQoC9Sq71bZz/K8ro4t6opZ5HFsVaeIi108wmGl++tMr3Q
         8NSBTC0x3pP2PZzQqlhJ3u9uZWfBaAknVKuVf6yC5gS0oyyeNqzKHqaKgEcPKZ+egiz/
         8Bx3yyb1Auv7pisGgXM6h8qsAr4COlgLkAoS/nrdG5mNH6PhpP9S796z/ZHxt0e2mqeX
         jDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1quVYlEoDtNWy2499n+DF3o+pu+n5t21qNaf1+jmtvc=;
        b=JMaBcx3qn27JA7ixsoJubNlvnYc0zGjFqjn0ucxMD2R6pOiRLO2uP38fwrmWCVFGya
         yBquWgY1NMf9MSFeXC6sgJ2lU7WAGj0ibxFFbG5NBl48SmpBO97TDOthYgP473mb9RXV
         Qpdhi33c6ven0QQ/tdf4mBYXIz6g6HmJSt7eR76vhByKWQk094vxtkQDTLjgOltx9Ucr
         0WYfgl/2655RpGcvQAaWYaYnH489yBAhHUGkMl/TDsgwFTzLFKV8vFs0IsszxACasIXe
         T5SgAKcToPHe3hyV+gBvnUEtlddLFEOZncDxJsBSiaBIoNTM2KX86OrB3NyfRp0bRGfj
         mK8g==
X-Gm-Message-State: APjAAAUQTxkeHyAnQInmQQmCrr8nN2p1jhhXB1ZBj6CwFctNQFDwAXYF
        alOMuxNW8iaP7O+d2e0id3s=
X-Google-Smtp-Source: APXvYqzeiW8mht9fpLpTKuI+efMoFEmUc3FuljfTJ95tAgAbtu+qGB31abDTe+/2SouI6GjEWIg8EQ==
X-Received: by 2002:a50:ba8e:: with SMTP id x14mr55318616ede.211.1555501298242;
        Wed, 17 Apr 2019 04:41:38 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id q56sm4371622edd.80.2019.04.17.04.41.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 04:41:37 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo@ribalda.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Gregor Jasny <gjasny@googlemail.com>,
        linux-media@vger.kernel.org, daniel@qtec.com
Cc:     Ricardo Ribalda Delgado <ricardo@ribalda.com>
Subject: [PATCH v2 1/2] libv4lconvert: Port supported_src_formats to bit-ops
Date:   Wed, 17 Apr 2019 13:41:34 +0200
Message-Id: <20190417114135.5987-1-ricardo@ribalda.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416120203.24028-1-ricardo@ribalda.com>
References: <20190416120203.24028-1-ricardo@ribalda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

We have passed the barrier of 64 supported formats, therefore a int64_t
is not enough for holding the bitfield.

Instead use bit-ops ala kernel.

Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
Suggested-by: Hans de Goede <hdegoede@redhat.com>
---
 lib/libv4lconvert/libv4lconvert-priv.h |  3 +-
 lib/libv4lconvert/libv4lconvert.c      | 40 ++++++++++++++++++++++----
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/lib/libv4lconvert/libv4lconvert-priv.h b/lib/libv4lconvert/libv4lconvert-priv.h
index a8046ce2..5286a9b1 100644
--- a/lib/libv4lconvert/libv4lconvert-priv.h
+++ b/lib/libv4lconvert/libv4lconvert-priv.h
@@ -38,6 +38,7 @@
 #include "tinyjpeg.h"
 
 #define ARRAY_SIZE(x) ((int)sizeof(x)/(int)sizeof((x)[0]))
+#define BITS_PER_LONG (8 * sizeof(long))
 
 #define V4LCONVERT_ERROR_MSG_SIZE 256
 #define V4LCONVERT_MAX_FRAMESIZES 256
@@ -55,7 +56,7 @@ struct v4lconvert_data {
 	int flags; /* bitfield */
 	int control_flags; /* bitfield */
 	unsigned int no_formats;
-	int64_t supported_src_formats; /* bitfield */
+	unsigned long supported_src_formats[128 / BITS_PER_LONG];
 	char error_msg[V4LCONVERT_ERROR_MSG_SIZE];
 	struct jdec_private *tinyjpeg;
 #ifdef HAVE_JPEG
diff --git a/lib/libv4lconvert/libv4lconvert.c b/lib/libv4lconvert/libv4lconvert.c
index 78fb3432..0607cc8b 100644
--- a/lib/libv4lconvert/libv4lconvert.c
+++ b/lib/libv4lconvert/libv4lconvert.c
@@ -32,6 +32,29 @@
 #include "libv4lsyscall-priv.h"
 
 #define MIN(a, b) (((a) < (b)) ? (a) : (b))
+#define BIT_MASK(nr) (1UL << ((nr) % BITS_PER_LONG))
+#define BIT_WORD(nr) ((nr) / BITS_PER_LONG)
+
+static inline void __set_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+
+	*p  |= mask;
+}
+
+static inline void __clear_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+
+	*p &= ~mask;
+}
+
+static inline int __test_bit(int nr, const volatile unsigned long *addr)
+{
+	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
+}
 
 static void *dev_init(int fd)
 {
@@ -231,7 +254,7 @@ struct v4lconvert_data *v4lconvert_create_with_dev_ops(int fd, void *dev_ops_pri
 				break;
 
 		if (j < ARRAY_SIZE(supported_src_pixfmts)) {
-			data->supported_src_formats |= 1ULL << j;
+			__set_bit(j, data->supported_src_formats);
 			v4lconvert_get_framesizes(data, fmt.pixelformat, j);
 			if (!supported_src_pixfmts[j].needs_conversion)
 				always_needs_conversion = 0;
@@ -316,8 +339,15 @@ int v4lconvert_supported_dst_format(unsigned int pixelformat)
 
 int v4lconvert_supported_dst_fmt_only(struct v4lconvert_data *data)
 {
-	return v4lcontrol_needs_conversion(data->control) &&
-		data->supported_src_formats;
+	int i;
+
+	for (i = 0 ; i < ARRAY_SIZE(data->supported_src_formats); i++)
+		if (data->supported_src_formats[i])
+			break;
+	if (i == ARRAY_SIZE(data->supported_src_formats))
+		return 0;
+
+	return v4lcontrol_needs_conversion(data->control);
 }
 
 /* See libv4lconvert.h for description of in / out parameters */
@@ -334,7 +364,7 @@ int v4lconvert_enum_fmt(struct v4lconvert_data *data, struct v4l2_fmtdesc *fmt)
 
 	for (i = 0; i < ARRAY_SIZE(supported_dst_pixfmts); i++)
 		if (v4lconvert_supported_dst_fmt_only(data) ||
-				!(data->supported_src_formats & (1ULL << i))) {
+		    !__test_bit(i, data->supported_src_formats)) {
 			faked_fmts[no_faked_fmts] = supported_dst_pixfmts[i].fmt;
 			no_faked_fmts++;
 		}
@@ -490,7 +520,7 @@ static int v4lconvert_do_try_format(struct v4lconvert_data *data,
 
 	for (i = 0; i < ARRAY_SIZE(supported_src_pixfmts); i++) {
 		/* is this format supported? */
-		if (!(data->supported_src_formats & (1ULL << i)))
+		if (!__test_bit(i, data->supported_src_formats))
 			continue;
 
 		try_fmt = *dest_fmt;
-- 
2.20.1

