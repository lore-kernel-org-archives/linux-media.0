Return-Path: <SRS0=qP1p=XM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6303BC4CECE
	for <linux-media@archiver.kernel.org>; Tue, 17 Sep 2019 16:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B112189D
	for <linux-media@archiver.kernel.org>; Tue, 17 Sep 2019 16:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568738124;
	bh=N1zCtYdfz6IPFrdGpdXh9jUSgmObjnjYMcgU90vUt1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r5TZJ4lTmKZO/J229ksF6kq7dX8Z4CbA0Act0z6WK7msmuJWoKXgLwsQKBCoDBTf8
	 6q5y2Y6o2GKVSlspk7Snxrhs99uaTmZ5zQ4uwBltpXKirb7QISYebCvDJ64TzNegpb
	 Mpxalcdds/tBm2QzC9z1P6jgJoaQeeBIFBfqC7kE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbfIQQfW (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 17 Sep 2019 12:35:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35681 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730498AbfIQQfW (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 17 Sep 2019 12:35:22 -0400
Received: by mail-io1-f67.google.com with SMTP id q10so9204864iop.2
        for <linux-media@vger.kernel.org>; Tue, 17 Sep 2019 09:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VVJL//iLgewkEoRfC7CxEoEman5r0AHZTTZchJ8JH74=;
        b=OubrW9S48K1g7uFLUI7/zdWhbZmzku0sG+Nhd8AwOW7CSGHvs/Z9b6+gZyg+sqsdF6
         Q6zJZMOJSHVeqyT1TsznCMpK2XWpajqZAMVVDOy9cIXTDMv6oIlo2VUQwB6GgUkyhNxG
         fw1N9WrsgavfRe6U5Loa41EJOuzhUnE7RemXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VVJL//iLgewkEoRfC7CxEoEman5r0AHZTTZchJ8JH74=;
        b=tao/k8W9JQQWB2fkeM8nj7O5TDbv8tLOJxh+HDBEc2IOsZC/KP0TV+mH3u6N3V3nqR
         BjLX92w8tt2O1LOezWCzXlQsIh/bGFOdJ/7u5LVy/LYVQOkrd6xFuOAVhPSZczc4DvYd
         3oLOq9XdBOTe+EDhHSpUw7zZAxy98Ruy44ErkqM7psdFsAaH7mEJ6mkcZ7zRSYcq/KNE
         +CC6bK2rlZOX2X2Qiq22+DprEdbnYb5GroFNb7/0bgzU5lrJKrjEwAR+/InzuMFossKD
         AiwpM8Y4sQNmsrpFd4DePsQl/N1dERI8vYMWnQmWpuTgrOw311BmtiNPAsQkpJGh92+0
         N7WQ==
X-Gm-Message-State: APjAAAWqpjVV5MHCqiNpEwZ+WBFuKef4QBVdzUu0Sg/atoqUNShtnUFp
        i+9k6XBG5OzjxcG9TKM08tS/Vg==
X-Google-Smtp-Source: APXvYqxfbzWoJgWSpGE8if7ltPy0aR4ZcyEh3dO0n7WdjWUwwfzIKTeQ9T1Ymv3OWkH26HL19qL+wg==
X-Received: by 2002:a05:6638:3a5:: with SMTP id z5mr2781140jap.95.1568738121535;
        Tue, 17 Sep 2019 09:35:21 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v3sm2593781ioh.51.2019.09.17.09.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 09:35:21 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mchehab@kernel.org, helen.koike@collabora.com,
        skhan@linuxfoundation.org, andrealmeid@collabora.com,
        dafna.hirschfeld@collabora.com, hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/5] doc: media: vimc: Update module parameter usage information
Date:   Tue, 17 Sep 2019 10:35:11 -0600
Message-Id: <f21e40f304507dffe2de240fdaeb881305c270ca.1568689325.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1568689325.git.skhan@linuxfoundation.org>
References: <cover.1568689325.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

vimc driver is now a monolithic driver. Update the module parameter
usage information to reflect that.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Documentation/media/v4l-drivers/vimc.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/media/v4l-drivers/vimc.rst b/Documentation/media/v4l-drivers/vimc.rst
index 406417680db5..a582af0509ee 100644
--- a/Documentation/media/v4l-drivers/vimc.rst
+++ b/Documentation/media/v4l-drivers/vimc.rst
@@ -76,22 +76,22 @@ vimc-capture:
 	* 1 Pad sink
 	* 1 Pad source
 
-Module options
+
+        Module options
 ---------------
 
-Vimc has a few module parameters to configure the driver. You should pass
-those arguments to each subdevice, not to the vimc module. For example::
+Vimc has a few module parameters to configure the driver.
 
-        vimc_subdevice.param=value
+        param=value
 
-* ``vimc_scaler.sca_mult=<unsigned int>``
+* ``sca_mult=<unsigned int>``
 
         Image size multiplier factor to be used to multiply both width and
         height, so the image size will be ``sca_mult^2`` bigger than the
         original one. Currently, only supports scaling up (the default value
         is 3).
 
-* ``vimc_debayer.deb_mean_win_size=<unsigned int>``
+* ``deb_mean_win_size=<unsigned int>``
 
         Window size to calculate the mean. Note: the window size needs to be an
         odd number, as the main pixel stays in the center of the window,
-- 
2.20.1

