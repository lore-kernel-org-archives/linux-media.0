Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DCDC433F5
	for <linux-media@archiver.kernel.org>; Fri, 11 Mar 2022 14:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349568AbiCKOh7 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 11 Mar 2022 09:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349682AbiCKOhx (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 11 Mar 2022 09:37:53 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215491C8DAF;
        Fri, 11 Mar 2022 06:36:45 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 632AE24000C;
        Fri, 11 Mar 2022 14:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647009404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LXpRJF0PicFoimO3k7dmVxuvDLPPZZvvYdE5xGjlQ9w=;
        b=VGYA9Mnqf2UIs8uZLn5qZu9xImvvjKvDQ5dOrl/NvyJ+K8Le4aB5zec4iCB1zxDvDkmaGd
        mrOeaTrQTBpBxMayaxEplhHpp8LyQCQVOa0Fvfor4JRdnIi3a5t9BybKw/hwCz/iTMmEqb
        5OZxXL2A1vVSBpFSLtkqHR2/7oKWXOA8tAmrpAQIzLjmRW20YbmYTAWTjNz05LyLKsWySx
        a8GTo4DLgjtdTl1ZV0QOpcIzgGjW0M3IpOAVYGe2Fl2lEsyBDdKmqVMKrMIXiqR7VfNAtz
        ta/bxuzYhTTZ/I2/r35TMPmYLoKU2o5xIEC2FPhtes5aNsvOBP5cqZ2qjulR0A==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 37/46] media: sun6i-csi: Unset bridge source on capture streamon fail
Date:   Fri, 11 Mar 2022 15:35:23 +0100
Message-Id: <20220311143532.265091-38-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
References: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

In cases where the media pipeline start fails but our bridge
has already registered a source, the source remains set and
the bridge code is not called.

Clean it in capture streamon error handler to avoid the issue.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index 4315e197d53f..6033acaa9564 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -628,6 +628,8 @@ static int sun6i_csi_capture_start_streaming(struct vb2_queue *queue,
 error_state:
 	sun6i_csi_capture_state_cleanup(csi_dev, false);
 
+	csi_dev->bridge.source = NULL;
+
 	return ret;
 }
 
-- 
2.35.1

