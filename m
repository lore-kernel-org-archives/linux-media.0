Return-Path: <SRS0=ylfx=ST=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C90AC282DC
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 14:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A17D206BA
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 14:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWbm+yFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732300AbfDQOG6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:06:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45931 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQOG5 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 17 Apr 2019 10:06:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id e24so12150220pfi.12
        for <linux-media@vger.kernel.org>; Wed, 17 Apr 2019 07:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eIqEivdb8SjPK/zHYSaRKQktoBq5eXpt3dgLLDl5C9U=;
        b=ZWbm+yFEQfyG7GLqujm3VDrmRL6DPbiq5Un1vzXz5NMc2pNrcjBoy3D+kHWbVyMUX4
         mNLdeXY/AAizVsDnw7LALDbVsQBheg0onte7Pq4jeFm1xZPa/3osDJehfebRMe2dkW6V
         f8rKcASArXmSruYrvBXjbXqJ2nuCCVBHS28e0hH9SgP3OfC13NX4qPMEf9qMbNWMP1ZU
         aUSXsR/uo6I1LRqY+fujuWuMiB7hJAeRuiV7LXk8BfdCmyn6Fq0H9T3wW5NNDnDTuu+S
         j0L0IWbVAPlM8d0RX6TGDscCNUebE4NdZMepyInklPnMGyqgH295BW+fNz4M8VfGxRq9
         cE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eIqEivdb8SjPK/zHYSaRKQktoBq5eXpt3dgLLDl5C9U=;
        b=Nfuw8SSDM175Req9xhnPyKeK8io43gWzSK9t9SyGtT76NMeCTOxJ6JABbtAJ7IOlzf
         0OR97r6ZCqmT6GvH3aCkB+HFTsA7pLUt2BYq73Ydawe8QJZETgs3jBQpOnBxf6LlFuRb
         uLzR2zNfT2+HP4vKBnMRJOJ2nn+N1S3fKayQE85l9zyQQoo2dOagLUmSowfOMVPvrC36
         lk22K3qd6Zz/ZXTCzEr6hdHnb/kkZosUEWwjIHf25aSSZpwZjkaPaPV0CsIvEvhH9zcU
         4jfsJdBWpRIDXwxnt9bIr74d5ySm2sZGnaxfY9j9nXMMl3Sh8GTX0QKc6MPvmKyheMGf
         Ci1Q==
X-Gm-Message-State: APjAAAXTsJEIn2Lqv+yXiPmNZnHXS9cXfzY6gWHuzGrCW5qhZAAEBIPY
        XZNperAcrOtQzwQGeYbzIGsM5kC4
X-Google-Smtp-Source: APXvYqx7j3xeu1asI+87y0aVSCG5OHi7UdvVENpoOgoBpBXbJGbVv8mtav2MVnI0zMa/tSNmTbywrg==
X-Received: by 2002:a62:ab14:: with SMTP id p20mr89330028pff.23.1555510016811;
        Wed, 17 Apr 2019 07:06:56 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:1b24:991b:df50:ea3f])
        by smtp.gmail.com with ESMTPSA id t82sm144498222pfa.153.2019.04.17.07.06.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Apr 2019 07:06:56 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 1/4] media: ov7740: fix unbalanced pm_runtime_get/put
Date:   Wed, 17 Apr 2019 23:06:38 +0900
Message-Id: <1555510001-23922-2-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555510001-23922-1-git-send-email-akinobu.mita@gmail.com>
References: <1555510001-23922-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Avoid returning without decrement the usage count in s_ctrl().

Cc: Wenyou Yang <wenyou.yang@microchip.com>
Cc: Eugen Hristev <eugen.hristev@microchip.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/media/i2c/ov7740.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/ov7740.c b/drivers/media/i2c/ov7740.c
index 54e80a6..d122e35 100644
--- a/drivers/media/i2c/ov7740.c
+++ b/drivers/media/i2c/ov7740.c
@@ -561,16 +561,16 @@ static int ov7740_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	case V4L2_CID_AUTOGAIN:
 		if (!ctrl->val)
-			return ov7740_set_gain(regmap, ov7740->gain->val);
-
-		ret = ov7740_set_autogain(regmap, ctrl->val);
+			ret = ov7740_set_gain(regmap, ov7740->gain->val);
+		else
+			ret = ov7740_set_autogain(regmap, ctrl->val);
 		break;
 
 	case V4L2_CID_EXPOSURE_AUTO:
 		if (ctrl->val == V4L2_EXPOSURE_MANUAL)
-			return ov7740_set_exp(regmap, ov7740->exposure->val);
-
-		ret = ov7740_set_autoexp(regmap, ctrl->val);
+			ret = ov7740_set_exp(regmap, ov7740->exposure->val);
+		else
+			ret = ov7740_set_autoexp(regmap, ctrl->val);
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.7.4

