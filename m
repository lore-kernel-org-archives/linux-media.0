Return-Path: <SRS0=ylfx=ST=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2E1C282DC
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 14:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39AA21773
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 14:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYfjv37X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbfDQOHC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:07:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44971 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQOHC (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 17 Apr 2019 10:07:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id g12so12066323pll.11
        for <linux-media@vger.kernel.org>; Wed, 17 Apr 2019 07:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2tGYYamzoV0YMO6GpLIy/3DeA+mGZ0ak/RzXNmUlqd4=;
        b=nYfjv37Xjo9Fl0Y4uN97OHZMhnejJ3yYqqyzcDMMscGfDngYm9O3PmVx4Qz6NYJBvJ
         IjR5D6Jr9rQV2oTOIhAIFLbMrPyKk14QWJKSBKjyJtqt6Kwcn/gaiwQCN11pdw4RIwCq
         HX9mxCVFrOXvexISDxuSDhmHzIaOOZfCgI0hyilTabRGdWQ3+biYJgEgwz7zZ28SV75W
         DywWS70pRIxGHUcPVNY7TNr9Od/OKFAQdSaXyXI13zDCEJgN/pWKfR4/pLF9kUQxkve/
         pCQCxZz6xV6mcKbMCGUKct5RYKLWq2ox4UwNR7hhJ9Cot8iWft1q1a4rEjbJZ8WSeJBL
         v6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2tGYYamzoV0YMO6GpLIy/3DeA+mGZ0ak/RzXNmUlqd4=;
        b=ctBKO+721DWmxPklA0nc0IigDBVp4npotRea+V1mAo5mVS4dlPd7YM7WMMyJgJ1pV2
         YQF4OhuRDOiqdadVkeIvQ3gf7aMLBVFcCbaxVNlckBQZ7NQYI/sQyt2hfi87UsVmFLcX
         8MlHTNrmXLlOAFt4LbUO4O/wcrz+8e3nJZt7cTkH3TLbbo6KLNXjYD3yLf6IPqhyK5Aw
         LhncQiVwubk88wDt0iUeXEl20665X4c81dOCFjwxCuwsmyOnx7LIgLZwwT4VxvUfGcuz
         WVU/s4lB2YgYuFTK01COI/MgthQ2y1QJfkxAKjH3k34IPjjowaweVrW0KVRUkWcaQoEg
         YQJg==
X-Gm-Message-State: APjAAAWB6nJr/XcSn9BqmH8BBQfzXCwNCECubDsgwYwNdX3m73IW22AH
        /zu5vKnD8TvS9SKw3RiFB7qg6oWx
X-Google-Smtp-Source: APXvYqzYiSXd0TO1rgqAVKPjtH3GpQMvMhCJu9+mwZNVYNStQlQVgBg0vYtjANklTRpcs/fixK2J/w==
X-Received: by 2002:a17:902:29:: with SMTP id 38mr66491433pla.178.1555510021246;
        Wed, 17 Apr 2019 07:07:01 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:1b24:991b:df50:ea3f])
        by smtp.gmail.com with ESMTPSA id t82sm144498222pfa.153.2019.04.17.07.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Apr 2019 07:07:00 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 3/4] media: ov7740: fix vertical flip control
Date:   Wed, 17 Apr 2019 23:06:40 +0900
Message-Id: <1555510001-23922-4-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555510001-23922-1-git-send-email-akinobu.mita@gmail.com>
References: <1555510001-23922-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Setting the value of the V4L2_CID_VFLIP control is currently ignored.

Because V4L2_CID_HFLIP and V4L2_CID_VFLIP are independently controlled
in s_ctrl() but these controls belong to the same cluster and the first
control is V4L2_CID_HFLIP.

Fix it by not clustering these controls.  Also correct erroneous updating
register bit for vertical flip.

Cc: Wenyou Yang <wenyou.yang@microchip.com>
Cc: Eugen Hristev <eugen.hristev@microchip.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/media/i2c/ov7740.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov7740.c b/drivers/media/i2c/ov7740.c
index 5c0dfdf..352658b 100644
--- a/drivers/media/i2c/ov7740.c
+++ b/drivers/media/i2c/ov7740.c
@@ -532,7 +532,7 @@ static int ov7740_set_ctrl(struct v4l2_ctrl *ctrl)
 	struct i2c_client *client = v4l2_get_subdevdata(&ov7740->subdev);
 	struct regmap *regmap = ov7740->regmap;
 	int ret;
-	u8 val = 0;
+	u8 val;
 
 	if (!pm_runtime_get_if_in_use(&client->dev))
 		return 0;
@@ -551,6 +551,7 @@ static int ov7740_set_ctrl(struct v4l2_ctrl *ctrl)
 		ret = ov7740_set_contrast(regmap, ctrl->val);
 		break;
 	case V4L2_CID_VFLIP:
+		val = ctrl->val ? REG0C_IMG_FLIP : 0x00;
 		ret = regmap_update_bits(regmap, REG_REG0C,
 					 REG0C_IMG_FLIP, val);
 		break;
@@ -1030,7 +1031,6 @@ static int ov7740_init_controls(struct ov7740 *ov7740)
 	v4l2_ctrl_auto_cluster(2, &ov7740->auto_gain, 0, true);
 	v4l2_ctrl_auto_cluster(2, &ov7740->auto_exposure,
 			       V4L2_EXPOSURE_MANUAL, true);
-	v4l2_ctrl_cluster(2, &ov7740->hflip);
 
 	if (ctrl_hdlr->error) {
 		ret = ctrl_hdlr->error;
-- 
2.7.4

