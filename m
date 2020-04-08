Return-Path: <SRS0=54rz=5Y=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC05AC2BA80
	for <linux-media@archiver.kernel.org>; Wed,  8 Apr 2020 11:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9017D2082F
	for <linux-media@archiver.kernel.org>; Wed,  8 Apr 2020 11:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgDHLsk (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 8 Apr 2020 07:48:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51264 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbgDHLsk (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 8 Apr 2020 07:48:40 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id 3CB212969A6
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     dafna.hirschfeld@collabora.com, helen.koike@collabora.com,
        ezequiel@collabora.com, hverkuil@xs4all.nl, kernel@collabora.com,
        dafna3@gmail.com, sakari.ailus@linux.intel.com,
        linux-rockchip@lists.infradead.org, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH v3 4/6] media: staging: rkisp1: cap: support uv swap only for semiplanar formats
Date:   Wed,  8 Apr 2020 13:48:20 +0200
Message-Id: <20200408114822.27360-5-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200408114822.27360-1-dafna.hirschfeld@collabora.com>
References: <20200408114822.27360-1-dafna.hirschfeld@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The register RKISP1_CIF_MI_XTD_FORMAT_CTRL is relevant only
for semiplanar formats, therefore the uv swap can be supported
through this register only for semiplanar formats.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/staging/media/rkisp1/rkisp1-capture.c | 31 ++++++++++++-------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/media/rkisp1/rkisp1-capture.c b/drivers/staging/media/rkisp1/rkisp1-capture.c
index 4830083c33fd..257799a7d865 100644
--- a/drivers/staging/media/rkisp1/rkisp1-capture.c
+++ b/drivers/staging/media/rkisp1/rkisp1-capture.c
@@ -383,12 +383,16 @@ static void rkisp1_mp_config(struct rkisp1_capture *cap)
 		     cap->config->mi.cr_size_init);
 
 	rkisp1_irq_frame_end_enable(cap);
-	reg = rkisp1_read(rkisp1, RKISP1_CIF_MI_XTD_FORMAT_CTRL);
-	if (cap->pix.cfg->uv_swap)
-		reg |= RKISP1_CIF_MI_XTD_FMT_CTRL_MP_CB_CR_SWAP;
-	else
-		reg &= ~RKISP1_CIF_MI_XTD_FMT_CTRL_MP_CB_CR_SWAP;
-	rkisp1_write(rkisp1, reg, RKISP1_CIF_MI_XTD_FORMAT_CTRL);
+
+	/* set uv swapping for semiplanar formats */
+	if (cap->pix.info->comp_planes == 2) {
+		reg = rkisp1_read(rkisp1, RKISP1_CIF_MI_XTD_FORMAT_CTRL);
+		if (cap->pix.cfg->uv_swap)
+			reg |= RKISP1_CIF_MI_XTD_FMT_CTRL_MP_CB_CR_SWAP;
+		else
+			reg &= ~RKISP1_CIF_MI_XTD_FMT_CTRL_MP_CB_CR_SWAP;
+		rkisp1_write(rkisp1, reg, RKISP1_CIF_MI_XTD_FORMAT_CTRL);
+	}
 
 	rkisp1_mi_config_ctrl(cap);
 
@@ -421,12 +425,15 @@ static void rkisp1_sp_config(struct rkisp1_capture *cap)
 
 	rkisp1_irq_frame_end_enable(cap);
 
-	reg = rkisp1_read(rkisp1, RKISP1_CIF_MI_XTD_FORMAT_CTRL);
-	if (cap->pix.cfg->uv_swap)
-		reg |= RKISP1_CIF_MI_XTD_FMT_CTRL_SP_CB_CR_SWAP;
-	else
-		reg &= ~RKISP1_CIF_MI_XTD_FMT_CTRL_SP_CB_CR_SWAP;
-	rkisp1_write(rkisp1, reg, RKISP1_CIF_MI_XTD_FORMAT_CTRL);
+	/* set uv swapping for semiplanar formats */
+	if (cap->pix.info->comp_planes == 2) {
+		reg = rkisp1_read(rkisp1, RKISP1_CIF_MI_XTD_FORMAT_CTRL);
+		if (cap->pix.cfg->uv_swap)
+			reg |= RKISP1_CIF_MI_XTD_FMT_CTRL_SP_CB_CR_SWAP;
+		else
+			reg &= ~RKISP1_CIF_MI_XTD_FMT_CTRL_SP_CB_CR_SWAP;
+		rkisp1_write(rkisp1, reg, RKISP1_CIF_MI_XTD_FORMAT_CTRL);
+	}
 
 	rkisp1_mi_config_ctrl(cap);
 
-- 
2.20.1

