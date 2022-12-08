Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA33C3A5A7
	for <linux-media@archiver.kernel.org>; Thu,  8 Dec 2022 11:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiLHLs0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 8 Dec 2022 06:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiLHLsP (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 8 Dec 2022 06:48:15 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CF184DDC;
        Thu,  8 Dec 2022 03:48:08 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4523B24000F;
        Thu,  8 Dec 2022 11:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670500087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G6S8oJ3aFtNCcZoU3kaxCoOFZa8bIBnBoUJ/ngEwAfA=;
        b=dUWD1ZGv9IFpByixdjm7gJRgcw5SjjHfkd6ABN3i8v5wYathBEODJDb0Tms3YqwJUPLlRF
        tGP8LlqVTbFp4iykF4Cx9VkPdKLr3eSzR9Jy/plnGlEN1ZF0W883+/HEdPPWa+PmNMlujP
        D1i/wBPeZpKni3KK+1mPH1vKaX3Y9BfBtWLx+Xy7rfRqdTqwSaj9Mg3KM+OdC8F3LSnxYZ
        XzAiJGPOsVdL3GvomGO2wmIHvu9FoQqXwraQrx84Ez12QB1bythbGFxMQJwTdWfAj0TrSV
        N9NEpX40Ilc0J55PCC1PoOxkkWurcxbc+GCCqLdKTRGpa+iv4naZdnbnOFOYcQ==
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
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH 3/9] media: sun6i-csi: bridge: Error out on invalid port to fix warning
Date:   Thu,  8 Dec 2022 12:47:36 +0100
Message-Id: <20221208114742.399461-4-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208114742.399461-1-paul.kocialkowski@bootlin.com>
References: <20221208114742.399461-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The enabled variable is only set for a valid port and used later,
which triggers an uninitialized use smatch warning. Explicitly error
out in that case to fix the warning.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
index 88df3a73ebfa..4517c0346eef 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
@@ -663,7 +663,7 @@ sun6i_csi_bridge_notifier_bound(struct v4l2_async_notifier *notifier,
 		enabled = !bridge->source_parallel.expected;
 		break;
 	default:
-		break;
+		return -EINVAL;
 	}
 
 	source->subdev = remote_subdev;
-- 
2.38.1

