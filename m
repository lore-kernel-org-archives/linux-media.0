Return-Path: <SRS0=F5P7=C6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C579EC43465
	for <linux-media@archiver.kernel.org>; Mon, 21 Sep 2020 16:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A6FD22B2D
	for <linux-media@archiver.kernel.org>; Mon, 21 Sep 2020 16:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600705454;
	bh=k7zLMCQ9i2/JBhUqe/oTadHZU3FhlPAS2kI1B02f/EI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kfIap1bVQ0X7l7iLjKJzQp/KOa6gEG0UD3FtU23ZLPaz3BQRf4mcTRtF5D7dzPLlx
	 Aul2UQoo/bT8S2Ah/8sbrBK9slrYkZpNT7r7IpqhZT9iYmWo+cD5+erNUcmkLo89bf
	 z3U/9rw8LX8rJWFPWegWWJD3eYxSxIf74rWSBKzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgIUQYN (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 21 Sep 2020 12:24:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbgIUQYM (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 21 Sep 2020 12:24:12 -0400
Received: from localhost.localdomain (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67DAE22574;
        Mon, 21 Sep 2020 16:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600705451;
        bh=k7zLMCQ9i2/JBhUqe/oTadHZU3FhlPAS2kI1B02f/EI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQYRXmLAQd7PJwOEEI2XROzbvWO9G5AE8Kg19nhsgMtXEzh4Ys7CCT0Cu6kF4htuY
         F1uIBgCTAjNqunx6KpXoUK2EduuN9wikzsoUsMFvdEX+2gnXiweETL9Kvb6IRUTDBW
         0ySOlXclKcYzDA++efAYcIrTUpcDQPBZZvcrDqh0=
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
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 03/25] media: i2c: imx290: simplify getting state container
Date:   Mon, 21 Sep 2020 18:23:20 +0200
Message-Id: <20200921162342.7348-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921162342.7348-1-krzk@kernel.org>
References: <20200921162342.7348-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The pointer to 'struct v4l2_subdev' is stored in drvdata via
v4l2_i2c_subdev_init() so there is no point of a dance like:

    struct i2c_client *client = to_i2c_client(struct device *dev)
    struct v4l2_subdev *sd = i2c_get_clientdata(client);

This allows to remove local variable 'client' and few pointer
dereferences.  White at it, use 'dev' directly instead of 'imx290->dev'.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/media/i2c/imx290.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index adcddf3204f7..6319a42057d2 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -842,20 +842,19 @@ static int imx290_set_data_lanes(struct imx290 *imx290)
 
 static int imx290_power_on(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct v4l2_subdev *sd = i2c_get_clientdata(client);
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct imx290 *imx290 = to_imx290(sd);
 	int ret;
 
 	ret = clk_prepare_enable(imx290->xclk);
 	if (ret) {
-		dev_err(imx290->dev, "Failed to enable clock\n");
+		dev_err(dev, "Failed to enable clock\n");
 		return ret;
 	}
 
 	ret = regulator_bulk_enable(IMX290_NUM_SUPPLIES, imx290->supplies);
 	if (ret) {
-		dev_err(imx290->dev, "Failed to enable regulators\n");
+		dev_err(dev, "Failed to enable regulators\n");
 		clk_disable_unprepare(imx290->xclk);
 		return ret;
 	}
@@ -872,8 +871,7 @@ static int imx290_power_on(struct device *dev)
 
 static int imx290_power_off(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct v4l2_subdev *sd = i2c_get_clientdata(client);
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct imx290 *imx290 = to_imx290(sd);
 
 	clk_disable_unprepare(imx290->xclk);
-- 
2.17.1

