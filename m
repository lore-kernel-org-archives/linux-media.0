Return-Path: <SRS0=C6Fs=6S=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3ECC3A5A9
	for <linux-media@archiver.kernel.org>; Mon,  4 May 2020 17:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F6924962
	for <linux-media@archiver.kernel.org>; Mon,  4 May 2020 17:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqoHMRb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbgEDRKj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 4 May 2020 13:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729823AbgEDRKh (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 4 May 2020 13:10:37 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E39FC061A0E
        for <linux-media@vger.kernel.org>; Mon,  4 May 2020 10:10:37 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id w14so10456740lfk.3
        for <linux-media@vger.kernel.org>; Mon, 04 May 2020 10:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yMNQHx/HQdD8ViHdN2g+eBjwoESMqOutVksDKu9Tgbw=;
        b=jqoHMRb0vzxwRw3zttvI1iJ+EEIoUF2qoMvWQaJXXqUKwGqcqDuAeXO8L6fMN9f1mA
         COHxJyQcU5wriOeDyU4+MH1ggZ8IqG/Cew9AhyT3j8Cu0/ecJbS35wtQofU513HA96PB
         ueVEKXhjF3ILyhFnq3H13PI2BRmnysrDxtCesubJR2xCNSya4CnU0kVKGSV5CFalyWj8
         9glcd8As7TEMNVDZ3oZshsMmhQrHAgB58kyjgcHW7E9MbRmHQJLXB/0Y8jA+PVFcva5B
         ieBvTqd+CFUCo02h+vpfx98FolZU6snT+19sTmuk4v2PsmEwl0Ck5TuDD0UMd+d/Emtf
         Tkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yMNQHx/HQdD8ViHdN2g+eBjwoESMqOutVksDKu9Tgbw=;
        b=NEwKDdbIPsbjiG0ijGg4TsmWoWH0TX768uQDKXmkFQEEimhwCWzscIVMqtNE7TGjXg
         VkoMwkEUKDuupaLzfZE7A2ZdpGcYjnj/R3bocXUQ9273mbxgl+xCJwd5VLoQdrOoD2Xa
         xjwPbm6QkMPX1xmPiSGXuADwCPp+Yalz2I9dgj7UK+WQVojUwFYAzxI1nujNcYZR8FFE
         KECs8F6Q7joYIY0V2TrxTZ9txQJHiAki0NcoWkMRHfdtfA/PwbEK6EurZt2eGyRtZuWO
         UfZ6jmnqx1seQ7mR7W1jsEh3Yp04ausKpTVkOWpGHcejsbkpMxldU1Wh1Z57LqMmdsPl
         Hl9g==
X-Gm-Message-State: AGi0PuaGFg0q+J0elLq5QzXMoo86xj7y41+5+RrEcCdONTaS8vB5epei
        MsH289MoN6cJ2gi1ZT9XcdxJpdQKJ0NWJA==
X-Google-Smtp-Source: APiQypICU6HcN6l1Hiew4v7nOYy7CbA7FxXA0Mnk/p90kZrLjI9cacLvbertATqj+LzkfFXI74Gt7g==
X-Received: by 2002:ac2:47fb:: with SMTP id b27mr11199778lfp.10.1588612235827;
        Mon, 04 May 2020 10:10:35 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241122244.gdansk.vectranet.pl. [109.241.122.244])
        by smtp.gmail.com with ESMTPSA id h28sm10304378lfe.80.2020.05.04.10.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 10:10:34 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2] media: ov6650: Fix missing frame interval enumeration support
Date:   Mon,  4 May 2020 19:10:12 +0200
Message-Id: <20200504171012.32601-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200503223641.29753-1-jmkrzyszt@gmail.com>
References: <20200503223641.29753-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

According to v4l2-compliance utility, a video device which supports
V4L2_CAP_TIMEPERFRAME via .vidioc_s_parm() operation should also
support .vidioc_enum_frameintervals().  If the former is implemented
via a call to v4l2_s_parm_cap() which in turn calls a subdevice
.s_frame_interval() pad operation, the video device may want to
implement the latter by passing frame interval enumeration requests to
the subdevice .enum_frame_intervals() video operation.  If that
operation is not supported by the subdevice and failure is returned by
the video device, the compliance test issues a warning.

Implement the missing pad operation.  Enumerate frame intervals
possible to be set via pixel clock adjustment, as implemented by
.s_frame_interval(), but not exceeding a reasonable maximum of 1
second.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
v2: Fix incorrect function name in commit description - sorry.

 drivers/media/i2c/ov6650.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index 91906b94f978..b8c3aff0c73d 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -738,6 +738,33 @@ static int ov6650_enum_mbus_code(struct v4l2_subdev *sd,
 	return 0;
 }
 
+static int ov6650_enum_frame_interval(struct v4l2_subdev *sd,
+				    struct v4l2_subdev_pad_config *cfg,
+				    struct v4l2_subdev_frame_interval_enum *fie)
+{
+	int i;
+
+	/* enumerate supported frame intervals not exceeding 1 second */
+	if (fie->index > CLKRC_DIV_MASK ||
+	    GET_CLKRC_DIV(fie->index) > FRAME_RATE_MAX)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(ov6650_codes); i++)
+		if (fie->code == ov6650_codes[i])
+			break;
+	if (i == ARRAY_SIZE(ov6650_codes))
+		return -EINVAL;
+
+	if (!fie->width || fie->width > W_CIF ||
+	    !fie->height || fie->height > H_CIF)
+		return -EINVAL;
+
+	fie->interval.numerator = GET_CLKRC_DIV(fie->index);
+	fie->interval.denominator = FRAME_RATE_MAX;
+
+	return 0;
+}
+
 static int ov6650_g_frame_interval(struct v4l2_subdev *sd,
 				   struct v4l2_subdev_frame_interval *ival)
 {
@@ -973,11 +1000,12 @@ static const struct v4l2_subdev_video_ops ov6650_video_ops = {
 };
 
 static const struct v4l2_subdev_pad_ops ov6650_pad_ops = {
-	.enum_mbus_code = ov6650_enum_mbus_code,
-	.get_selection	= ov6650_get_selection,
-	.set_selection	= ov6650_set_selection,
-	.get_fmt	= ov6650_get_fmt,
-	.set_fmt	= ov6650_set_fmt,
+	.enum_mbus_code		= ov6650_enum_mbus_code,
+	.enum_frame_interval	= ov6650_enum_frame_interval,
+	.get_selection		= ov6650_get_selection,
+	.set_selection		= ov6650_set_selection,
+	.get_fmt		= ov6650_get_fmt,
+	.set_fmt		= ov6650_set_fmt,
 };
 
 static const struct v4l2_subdev_ops ov6650_subdev_ops = {
-- 
2.24.1

