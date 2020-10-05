Return-Path: <SRS0=4VRt=DM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1E4C4363A
	for <linux-media@archiver.kernel.org>; Mon,  5 Oct 2020 15:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFD79207BC
	for <linux-media@archiver.kernel.org>; Mon,  5 Oct 2020 15:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601911005;
	bh=T0FiFYCJs43k19BYlB81hToSe3v+FKbC7usG6h45kKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jjaaiYbHm8poNiJ+wxc7t7RopCY3YO3+87FIGBwYI6ZugKvuxHltL70qGdOvYwLWN
	 J9t3AsLSONJcwYiMsyZ0ViL/LccQnsu6KUOpYlicGCjKQpt54elwIa7lXVuqI1RtFI
	 Mw+MyO/80yhx2BPjoypg7S1/7zLaVN5R0vCHU8Ao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgJEPQI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 5 Oct 2020 11:16:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbgJEPQI (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 5 Oct 2020 11:16:08 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DFE3208C7;
        Mon,  5 Oct 2020 15:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601910967;
        bh=T0FiFYCJs43k19BYlB81hToSe3v+FKbC7usG6h45kKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vTQFUnXe5M/uazzQJidKdDX/fW+UdoiLCjOAHYgmpd8pdb+MS4DEBKbpb0RZN25RA
         VguAA36k6K3+rRgvRUaysL1aPxL9j+KdOiZCDeqELYeynVcaVTVrCwm8ANB6yfgsv9
         MIunsolZU60Qk1Dc7NUEhn2H1mjztuMATNIgL8Os=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] media: i2c: imx258: validate rotation only if it is provided
Date:   Mon,  5 Oct 2020 17:15:59 +0200
Message-Id: <20201005151559.12003-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201005151559.12003-1-krzk@kernel.org>
References: <20201005151559.12003-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The sensor supports rotation by 180 degrees however the value of
"rotation" property should be validated only if it exists.  If
"rotation" is missing, do not fail the probe:

    imx258: probe of 3-001a failed with error -22

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/media/i2c/imx258.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index aedf8e7c6165..c52932e5b881 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -1284,7 +1284,7 @@ static int imx258_probe(struct i2c_client *client)
 	 * supports a single pixel order right now.
 	 */
 	ret = device_property_read_u32(&client->dev, "rotation", &val);
-	if (ret || val != 180)
+	if (!ret && val != 180)
 		return -EINVAL;
 
 	/* Initialize subdev */
-- 
2.17.1

