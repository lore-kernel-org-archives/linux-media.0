Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE65BC433ED
	for <linux-media@archiver.kernel.org>; Tue, 20 Apr 2021 12:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D70613C3
	for <linux-media@archiver.kernel.org>; Tue, 20 Apr 2021 12:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhDTMGC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:06:02 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:57972 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbhDTMGB (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 20 Apr 2021 08:06:01 -0400
Received: from deskari.lan (91-157-208-71.elisa-laajakaista.fi [91.157.208.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CA7B01273;
        Tue, 20 Apr 2021 14:05:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1618920327;
        bh=VUhMhlehDNQXYOY7L5Gj15fEWM3vYKBUo0nQKFyfogI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q5eOPa+GuOgzZZ1sIGuyqb8ytv34Pv+QUNsR7cHw9VY2SeZw9QoRhbMxM4EPUn5z1
         UJ9ia5A1kBXvCMtPEjxFCPGVkCSVGqA+KHWMjBIv0gvyp+IZRUbJRp0/DkviQFRDPH
         aGOiL5fK0Vp8WNoqFIUm9j89wR8sJiHvlpHgZo50=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     Benoit Parrot <bparrot@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v2 23/35] media: ti-vpe: cal: fix typo in a comment
Date:   Tue, 20 Apr 2021 15:04:21 +0300
Message-Id: <20210420120433.902394-24-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420120433.902394-1-tomi.valkeinen@ideasonboard.com>
References: <20210420120433.902394-1-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fix a typo in a comment in cal_camerarx_sd_set_fmt().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/ti-vpe/cal-camerarx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti-vpe/cal-camerarx.c b/drivers/media/platform/ti-vpe/cal-camerarx.c
index c5b5cc4d19f5..85fb887325f5 100644
--- a/drivers/media/platform/ti-vpe/cal-camerarx.c
+++ b/drivers/media/platform/ti-vpe/cal-camerarx.c
@@ -697,7 +697,7 @@ static int cal_camerarx_sd_set_fmt(struct v4l2_subdev *sd,
 		return cal_camerarx_sd_get_fmt(sd, cfg, format);
 
 	/*
-	 * Default to the first format is the requested media bus code isn't
+	 * Default to the first format if the requested media bus code isn't
 	 * supported.
 	 */
 	fmtinfo = cal_format_by_code(format->format.code);
-- 
2.25.1

