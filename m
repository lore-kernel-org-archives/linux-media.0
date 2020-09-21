Return-Path: <SRS0=F5P7=C6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA7DC43465
	for <linux-media@archiver.kernel.org>; Mon, 21 Sep 2020 16:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E320C23976
	for <linux-media@archiver.kernel.org>; Mon, 21 Sep 2020 16:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600705645;
	bh=e6E2P2BYXwVmCEmpSJPcXJWaHXTpyBF/68bjK1631TY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U7wEK3i/S8SRqMB4Vy46OTTals5ynAzHX6/Kk8FbPfWt8wSSkFA0t1y2oYERvccR2
	 b9EkXKRf+5fMFwrIsS8KlmDYKZQCkLikIMV3Zt+PfWUO4sXEikqukDgVuBaT1NJJUE
	 fIFF7YOKNmSyoYcy8EtFTBviQ4OgHYnmzvpHNVfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgIUQ1W (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 21 Sep 2020 12:27:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbgIUQ1T (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 21 Sep 2020 12:27:19 -0400
Received: from localhost.localdomain (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E68612223E;
        Mon, 21 Sep 2020 16:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600705638;
        bh=e6E2P2BYXwVmCEmpSJPcXJWaHXTpyBF/68bjK1631TY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gqklv8QK+pLEBZnsQ3PyfqEj3QjNrO1ivWXstm8712DqS1gkPnghbR70d2eHpOBvB
         ksJL7N1syixJxvInW/mZMrOMb1+XWTMuXE4WIh1cCyaxrruGHAuTd0fexNoaolloDh
         mzvgfbytCWNGmh+HT6C8WwuGQW6J1S+I7UmOnvHU=
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
Subject: [PATCH 25/25] media: i2c: tvp5150: simplify getting state container
Date:   Mon, 21 Sep 2020 18:23:42 +0200
Message-Id: <20200921162342.7348-25-krzk@kernel.org>
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
dereferences.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/media/i2c/tvp5150.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/tvp5150.c b/drivers/media/i2c/tvp5150.c
index 7d9401219a3a..29f65bb6103d 100644
--- a/drivers/media/i2c/tvp5150.c
+++ b/drivers/media/i2c/tvp5150.c
@@ -1413,8 +1413,7 @@ static const struct media_entity_operations tvp5150_sd_media_ops = {
  ****************************************************************************/
 static int __maybe_unused tvp5150_runtime_suspend(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct v4l2_subdev *sd = i2c_get_clientdata(client);
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct tvp5150 *decoder = to_tvp5150(sd);
 
 	if (decoder->irq)
@@ -1427,8 +1426,7 @@ static int __maybe_unused tvp5150_runtime_suspend(struct device *dev)
 
 static int __maybe_unused tvp5150_runtime_resume(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct v4l2_subdev *sd = i2c_get_clientdata(client);
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct tvp5150 *decoder = to_tvp5150(sd);
 
 	if (decoder->irq)
-- 
2.17.1

