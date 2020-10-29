Return-Path: <SRS0=okk5=EE=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC26C2D0A3
	for <linux-media@archiver.kernel.org>; Thu, 29 Oct 2020 16:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26F2B20825
	for <linux-media@archiver.kernel.org>; Thu, 29 Oct 2020 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603989863;
	bh=OfNTGOEcq6a2/mVQk8B8PLTOw1S/yOSkRUMbqD2Ij+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ho9OTMdDzLIAzh6oM99QRaiCy1Ze/8cjH+7BtG7N2NmPrvM7oNOWd6rdsKZ0cYmFe
	 2nYi/smYFW1dgvBU0F5M8xi/IcPRLg8KmpdEtue8By9HfUBCZOwXzAEUlDbQ+CHMhJ
	 KHdqoUyHwTU45+5HVh7EjUfvm5Ly6Ybdgx3IeX4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgJ2QoV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 29 Oct 2020 12:44:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbgJ2QoU (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 29 Oct 2020 12:44:20 -0400
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34246214F1;
        Thu, 29 Oct 2020 16:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603989859;
        bh=OfNTGOEcq6a2/mVQk8B8PLTOw1S/yOSkRUMbqD2Ij+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fu/66TMz3LD2zCFiDWwXs6dubafZE+6inbeIL/cHUwz9WUOH2C1ow2cxbbis51PzL
         /+tdEAP92GIOI4dqCEYTy9UNb2xfXTdM367+F5bWrTIF8Zko7/ZryhMaxQtb4Fn16K
         hQwK8wIpflZe3NBfuuSHWi3YYQZJZI6UXI7CoMrQ=
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
Subject: [RESEND PATCH 22/25] media: i2c: ov7740: simplify getting state container
Date:   Thu, 29 Oct 2020 17:42:36 +0100
Message-Id: <20201029164239.84240-22-krzk@kernel.org>
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
 drivers/media/i2c/ov7740.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ov7740.c b/drivers/media/i2c/ov7740.c
index 5832461c032d..47a9003d29d6 100644
--- a/drivers/media/i2c/ov7740.c
+++ b/drivers/media/i2c/ov7740.c
@@ -1176,8 +1176,7 @@ static int ov7740_remove(struct i2c_client *client)
 
 static int __maybe_unused ov7740_runtime_suspend(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct v4l2_subdev *sd = i2c_get_clientdata(client);
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct ov7740 *ov7740 = container_of(sd, struct ov7740, subdev);
 
 	ov7740_set_power(ov7740, 0);
@@ -1187,8 +1186,7 @@ static int __maybe_unused ov7740_runtime_suspend(struct device *dev)
 
 static int __maybe_unused ov7740_runtime_resume(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct v4l2_subdev *sd = i2c_get_clientdata(client);
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct ov7740 *ov7740 = container_of(sd, struct ov7740, subdev);
 
 	return ov7740_set_power(ov7740, 1);
-- 
2.25.1

