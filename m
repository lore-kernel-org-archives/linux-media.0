Return-Path: <SRS0=Zegy=33=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D32C352A3
	for <linux-media@archiver.kernel.org>; Fri,  7 Feb 2020 09:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072612082E
	for <linux-media@archiver.kernel.org>; Fri,  7 Feb 2020 09:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgBGJAI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 7 Feb 2020 04:00:08 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50448 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgBGJAH (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 7 Feb 2020 04:00:07 -0500
Received: from localhost.localdomain (p200300CB87166A00301E621E2266094E.dip0.t-ipconnect.de [IPv6:2003:cb:8716:6a00:301e:621e:2266:94e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E8EB2295A87;
        Fri,  7 Feb 2020 09:00:05 +0000 (GMT)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     dafna.hirschfeld@collabora.com, helen.koike@collabora.com,
        ezequiel@collabora.com, hverkuil@xs4all.nl, kernel@collabora.com,
        dafna3@gmail.com, sakari.ailus@linux.intel.com,
        linux-rockchip@lists.infradead.org, mchehab@kernel.org
Subject: [PATCH 2/4] media: staging: rkisp1: isp: check for dphy bus before initializations in s_stream
Date:   Fri,  7 Feb 2020 09:59:49 +0100
Message-Id: <20200207085951.5226-3-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200207085951.5226-1-dafna.hirschfeld@collabora.com>
References: <20200207085951.5226-1-dafna.hirschfeld@collabora.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

In rkisp1_isp_s_stream it is better to return error in case the
bus type is not dphy before initializing the registers.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/staging/media/rkisp1/rkisp1-isp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/rkisp1/rkisp1-isp.c b/drivers/staging/media/rkisp1/rkisp1-isp.c
index 56bd95d01f65..c98e3c16f520 100644
--- a/drivers/staging/media/rkisp1/rkisp1-isp.c
+++ b/drivers/staging/media/rkisp1/rkisp1-isp.c
@@ -963,14 +963,14 @@ static int rkisp1_isp_s_stream(struct v4l2_subdev *sd, int enable)
 	rkisp1->active_sensor = container_of(sensor_sd->asd,
 					     struct rkisp1_sensor_async, asd);
 
+	if (rkisp1->active_sensor->mbus.type != V4L2_MBUS_CSI2_DPHY)
+		return -EINVAL;
+
 	atomic_set(&rkisp1->isp.frame_sequence, -1);
 	ret = rkisp1_config_cif(rkisp1);
 	if (ret)
 		return ret;
 
-	if (rkisp1->active_sensor->mbus.type != V4L2_MBUS_CSI2_DPHY)
-		return -EINVAL;
-
 	ret = rkisp1_mipi_csi2_start(&rkisp1->isp, rkisp1->active_sensor);
 	if (ret)
 		return ret;
-- 
2.17.1

