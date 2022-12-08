Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A09C3A5A7
	for <linux-media@archiver.kernel.org>; Thu,  8 Dec 2022 13:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiLHN4d (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 8 Dec 2022 08:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiLHN4O (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 8 Dec 2022 08:56:14 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409E498575;
        Thu,  8 Dec 2022 05:56:01 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DB6182000D;
        Thu,  8 Dec 2022 13:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670507760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o81YP8iaZF1sop9pwY0IwP4XTu0ePsqSN3S/jSq8oYA=;
        b=NfylqO5/yCL99QdgCyudiwPSAqArXO2czHvBiFyPnDz+NRlFssMSKJfxYaOcVT1VNt+xu4
        I7/RFD0vFq42Y6fpwcEdQNpvuhYeqzX4pxhuhftpTaXeTNmgBz5MymKAsqMPFKh08Vw9rI
        yKcJkqtHNc8oEhh9XSTiOl3PqbJiMaF/JXsqaoqPHWSM8f9GX/wCWGwtUjf6PWiThQ291t
        i0KslkXUH6u7IRLVKsBAcIrYU4CYNuiYkND5QzOkPaRMbveioscDeDvgmfzCC5GbtH1khS
        33hKW1UR8N4FT1X8RxScBLNLjrpNXrgWAcVPi2Rb62484pXcZHl5jA+iVQAphg==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Conor Dooley <conor@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 11/11] media: sun6i-isp: params: Fix incorrect indentation
Date:   Thu,  8 Dec 2022 14:55:12 +0100
Message-Id: <20221208135512.421903-12-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208135512.421903-1-paul.kocialkowski@bootlin.com>
References: <20221208135512.421903-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Remove a heading whitespace that results in a smatch warning.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c
index 8039e311cb1c..7b41a13162b9 100644
--- a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c
+++ b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c
@@ -183,8 +183,8 @@ void sun6i_isp_params_configure(struct sun6i_isp_device *isp_dev)
 	if (state->configured)
 		goto complete;
 
-	 sun6i_isp_params_configure_modules(isp_dev,
-					    &sun6i_isp_params_config_default);
+	sun6i_isp_params_configure_modules(isp_dev,
+					   &sun6i_isp_params_config_default);
 
 	state->configured = true;
 
-- 
2.38.1

