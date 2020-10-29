Return-Path: <SRS0=okk5=EE=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C8BC56201
	for <linux-media@archiver.kernel.org>; Thu, 29 Oct 2020 16:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F1BC20838
	for <linux-media@archiver.kernel.org>; Thu, 29 Oct 2020 16:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603989838;
	bh=+YhrTdxTZ9IwtpRsXLWk8hGCvf874D+0Yy5rA92EFsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BVwdw13UzudP4FRB53MW2t8zSjnuNFphcVUB5anNzeaUg9wgRHZ6trZVxMlDJSFVc
	 bHKX3qN8n8iKz1uVzNBn56POhIk5Ojt1TDmE/FMmCdv8Lt19eYqmSQpYZV1vRRNHjv
	 YHEg0iIRQJfE4lkJE9Wb+LtdZs7acOFPSFCQrwVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgJ2Qn4 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 29 Oct 2020 12:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbgJ2Qnz (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 29 Oct 2020 12:43:55 -0400
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93D3022228;
        Thu, 29 Oct 2020 16:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603989834;
        bh=+YhrTdxTZ9IwtpRsXLWk8hGCvf874D+0Yy5rA92EFsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xVI7U1/ns8qtAZsNJz7jZMmDHaQXB3y7rJCQ4c9M+hNICGYdRmIRVF37lEZC8H4nN
         bPVQKXfduJPxWCN3UWNNA7ELc2WVhkoKZVn3kdkzuM2OKQljk0J84Lc+Nb1YFl9IbO
         thPKRa2Xk/+2Q31fWu9jdtri/mQ9MZtxniQjbSNY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Hyungwoo Yang <hyungwoo.yang@intel.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH 16/25] media: i2c: ov2680: simplify getting state container
Date:   Thu, 29 Oct 2020 17:42:30 +0100
Message-Id: <20201029164239.84240-16-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201029164239.84240-1-krzk@kernel.org>
References: <20201029164239.84240-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The pointer to 'struct v4l2_subdev' is stored in drvdata via
v4l2_i2c_subdev_init() so there is no point of a dance like:

    struct i2c_client *client = to_i2c_client(struct device *dev)
    struct v4l2_subdev *sd = i2c_get_clientdata(client);

This allows to remove local variable 'client' and few pointer
dereferences.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/media/i2c/ov2680.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
index 59cdbc33658c..178dfe985a25 100644
--- a/drivers/media/i2c/ov2680.c
+++ b/drivers/media/i2c/ov2680.c
@@ -1111,8 +1111,7 @@ static int ov2680_remove(struct i2c_client *client)
 
 static int __maybe_unused ov2680_suspend(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct v4l2_subdev *sd = i2c_get_clientdata(client);
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct ov2680_dev *sensor = to_ov2680_dev(sd);
 
 	if (sensor->is_streaming)
@@ -1123,8 +1122,7 @@ static int __maybe_unused ov2680_suspend(struct device *dev)
 
 static int __maybe_unused ov2680_resume(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct v4l2_subdev *sd = i2c_get_clientdata(client);
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct ov2680_dev *sensor = to_ov2680_dev(sd);
 	int ret;
 
-- 
2.25.1

