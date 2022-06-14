Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C18FC43334
	for <linux-media@archiver.kernel.org>; Tue, 14 Jun 2022 19:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350914AbiFNTNh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 14 Jun 2022 15:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357599AbiFNTNb (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 14 Jun 2022 15:13:31 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00F2764E
        for <linux-media@vger.kernel.org>; Tue, 14 Jun 2022 12:13:30 -0700 (PDT)
Received: from pyrite.rasen.tech (softbank036240126034.bbtec.net [36.240.126.34])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 75B89D96;
        Tue, 14 Jun 2022 21:13:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1655234009;
        bh=35br+PBGDYimxknyVI8XqRWDD0b9S/DSRrn5qKiWY6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t4myaVjzWPrvYpED+Ffsu43wnK6LlYemIw80A22B2XQ+G0SrlCNWPnJKCukoCcEXt
         +SGDSUOiHpDwXxySn+gsOsVjWFDEZQtgM6yWWXAe55oCehF9DoH4A2SHeuMm5RA0K1
         1aUbgZjO07mrRPXBuxeAZ8Kxhwf+A56bpf4kViXQ=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dafna@fastmail.com, heiko@sntech.de,
        jeanmichel.hautbois@ideasonboard.com, jacopo@jmondi.org,
        djrscally@gmail.com, helen.koike@collabora.com,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 25/55] media: rkisp1: isp: Don't initialize ret to 0 in rkisp1_isp_s_stream()
Date:   Wed, 15 Jun 2022 04:10:57 +0900
Message-Id: <20220614191127.3420492-26-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614191127.3420492-1-paul.elder@ideasonboard.com>
References: <20220614191127.3420492-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The ret variable doesn't need to be initialized in
rkisp1_isp_s_stream().

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
index 3ea0deb6b792..a234cf29ec67 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
@@ -751,7 +751,7 @@ static int rkisp1_isp_s_stream(struct v4l2_subdev *sd, int enable)
 		container_of(sd->v4l2_dev, struct rkisp1_device, v4l2_dev);
 	struct rkisp1_isp *isp = &rkisp1->isp;
 	struct v4l2_subdev *sensor_sd;
-	int ret = 0;
+	int ret;
 
 	if (!enable) {
 		v4l2_subdev_call(rkisp1->active_sensor->sd, video, s_stream,
-- 
2.30.2

