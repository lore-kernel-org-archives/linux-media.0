Return-Path: <SRS0=ylfx=ST=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1895AC282DA
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 14:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC785206BA
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 14:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nST7WThO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbfDQOHE (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:07:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38125 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732415AbfDQOHE (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 17 Apr 2019 10:07:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id f36so12103888plb.5
        for <linux-media@vger.kernel.org>; Wed, 17 Apr 2019 07:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NPgOQBXzW4Ol5dUsHFFFHYnkL55V442tMVIw3BHYqEs=;
        b=nST7WThOA1OEh9CHGKmTqAuA3jFvgDIBur4sIObiv4m5w18NutPB1nTaDdeLfkoeuR
         /Uya9v0h+Q1qtBqi6pTfvCVkVIwMncS/7QEsUgAkjeDr6hF1D9mo+87vx/bwEBaOeGLd
         LQxVtaCQMR0g2eyooyeZCdbCv37QYL4QX3T2LSYCR1wWmVLQDwFE5waRFfvgLcLj1s7a
         A4zGWedRakl2DWERQEtPoAkCSy48GnaA2R1+8LotctMqV/NTWx8UxjHkl0AzPStaB+OD
         ijfkjVe5dgPZZaHFNsKtJppdB80mcRXBm/KjT/vjv8KNT2QDP2Y1dYGtwkvoHdsSKQC9
         BrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NPgOQBXzW4Ol5dUsHFFFHYnkL55V442tMVIw3BHYqEs=;
        b=dahP2nHl68MJZwSCD/7M5UtoQ91CPco+l6YTU1io3098rZrkw7z6sTd3N4WVqxWhlt
         rA3IxZ75kFltMvbFFebP67R9IO1lmsNIM11HVDjMpkx/po0vfqUBvLp4RAIk6HNLywI3
         PPCSEOaCl3nnJ1s3z/4ZnMyd5BuolMfVqGO/wVy+8oVJhVM4AUHQ5K8O7oUrdJ2ZTvs1
         Sy6kDFGuHrfe/5cW07S1Z011AuECAZxMsJ9iqfa3zqB0OibBx1us37kTIygfhjgUpMPr
         zRTXthY776mBZclS97B0mbaYvea+hCijuiCs/68dd+E25u91I0OsJwGZuVmZC3RQHtG9
         j4jw==
X-Gm-Message-State: APjAAAUj8J/ZHwYZdUkxTowNX1SInjDJON0qRt1g0OGhS6JPThScz6YV
        aJiJYVPlKtG2pcZ5Za4aufO5Bw35
X-Google-Smtp-Source: APXvYqzpMHmgfMcWQKmxgU9/GiY7z6FzLo+Zmwn0xbDr6I61+P5dhzabLF0j0l+FbXlrnKiRV6xMyw==
X-Received: by 2002:a17:902:2962:: with SMTP id g89mr40231003plb.264.1555510023557;
        Wed, 17 Apr 2019 07:07:03 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:1b24:991b:df50:ea3f])
        by smtp.gmail.com with ESMTPSA id t82sm144498222pfa.153.2019.04.17.07.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Apr 2019 07:07:02 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 4/4] media: ov7740: remove redundant V4L2_CTRL_FLAG_VOLATILE set
Date:   Wed, 17 Apr 2019 23:06:41 +0900
Message-Id: <1555510001-23922-5-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555510001-23922-1-git-send-email-akinobu.mita@gmail.com>
References: <1555510001-23922-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

If the v4l2 controls are set up for autofoo/foo-type handling by calling
v4l2_ctrl_auto_cluster() with the last set_volatile argument setting true,
each non-auto control doesn't need to be flagged V4L2_CTRL_FLAG_VOLATILE.

Cc: Wenyou Yang <wenyou.yang@microchip.com>
Cc: Eugen Hristev <eugen.hristev@microchip.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/media/i2c/ov7740.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/i2c/ov7740.c b/drivers/media/i2c/ov7740.c
index 352658b..70bb870 100644
--- a/drivers/media/i2c/ov7740.c
+++ b/drivers/media/i2c/ov7740.c
@@ -1012,8 +1012,6 @@ static int ov7740_init_controls(struct ov7740 *ov7740)
 
 	ov7740->gain = v4l2_ctrl_new_std(ctrl_hdlr, &ov7740_ctrl_ops,
 				       V4L2_CID_GAIN, 0, 1023, 1, 500);
-	if (ov7740->gain)
-		ov7740->gain->flags |= V4L2_CTRL_FLAG_VOLATILE;
 
 	ov7740->auto_gain = v4l2_ctrl_new_std(ctrl_hdlr, &ov7740_ctrl_ops,
 					    V4L2_CID_AUTOGAIN, 0, 1, 1, 1);
-- 
2.7.4

