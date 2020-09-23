Return-Path: <SRS0=mA+5=DA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B52FC4363D
	for <linux-media@archiver.kernel.org>; Wed, 23 Sep 2020 15:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A4332223E
	for <linux-media@archiver.kernel.org>; Wed, 23 Sep 2020 15:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600874518;
	bh=+tyuJ8q5tjs0jpFIPnpAR8bb5kiLEh5MWM0XHwgZgz0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kExO3A/1js670NWWghLhbfJ9Wqezmp2Kuzstyu5YrU5yyZTbpdEk7KVcFgHasVmY3
	 phqDDBFlaj8Fyu/Bdnj1wzLg+t7rcDzCfFhYD3RrL37zCBuHAGSIQNyGcU7xdMemRr
	 pW5tXcDuJcihlI0zUvo019HQeLEp9C/MmcQLEGb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgIWPV5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 23 Sep 2020 11:21:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgIWPV4 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 23 Sep 2020 11:21:56 -0400
Received: from localhost.localdomain (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2C31221E7;
        Wed, 23 Sep 2020 15:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600874516;
        bh=+tyuJ8q5tjs0jpFIPnpAR8bb5kiLEh5MWM0XHwgZgz0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sUCUIUoUUR9CrF6o2sXj2S9Tqz0z+l8tXQnNuiXIROgOWFhTBxOz7rsEcDBSJOevC
         00WjyLhmw9x7dboS2T/3gaI8ExtLKsCxCKCnqSJV0FzhJSi2n3QzScek8DXfgIzuhu
         7qQ72iMlLyMWV6ZafCcBdrq+USeQLLqHzE2N+V9o=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] media: i2c: imx258: simplify getting state container
Date:   Wed, 23 Sep 2020 17:21:28 +0200
Message-Id: <20200923152129.21736-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923152129.21736-1-krzk@kernel.org>
References: <20200923152129.21736-1-krzk@kernel.org>
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

Changes since v3:
1. None

Changes since v2:
1. New patch
---
 drivers/media/i2c/imx258.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index ed79bfb4c991..ae183b0dbba9 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -1018,8 +1018,7 @@ static int imx258_set_stream(struct v4l2_subdev *sd, int enable)
 
 static int __maybe_unused imx258_suspend(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct v4l2_subdev *sd = i2c_get_clientdata(client);
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct imx258 *imx258 = to_imx258(sd);
 
 	if (imx258->streaming)
@@ -1030,8 +1029,7 @@ static int __maybe_unused imx258_suspend(struct device *dev)
 
 static int __maybe_unused imx258_resume(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct v4l2_subdev *sd = i2c_get_clientdata(client);
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct imx258 *imx258 = to_imx258(sd);
 	int ret;
 
-- 
2.17.1

