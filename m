Return-Path: <SRS0=sYeE=AS=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C47C433E0
	for <linux-media@archiver.kernel.org>; Tue,  7 Jul 2020 17:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9F6B20738
	for <linux-media@archiver.kernel.org>; Tue,  7 Jul 2020 17:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgGGRQB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:16:01 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35136 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgGGRQB (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 7 Jul 2020 13:16:01 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id 047DF26CBF8
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com
Cc:     dafna.hirschfeld@collabora.com, helen.koike@collabora.com,
        ezequiel@collabora.com, hverkuil@xs4all.nl, kernel@collabora.com,
        dafna3@gmail.com, sakari.ailus@linux.intel.com,
        linux-rockchip@lists.infradead.org, mchehab@kernel.org,
        tfiga@chromium.org
Subject: [PATCH] media: staging: rkisp1: rename RKISP1_CIF_ISP_STAT_AFM_FIN to RKISP1_CIF_ISP_STAT_AFM
Date:   Tue,  7 Jul 2020 19:15:49 +0200
Message-Id: <20200707171549.29601-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The flag RKISP1_CIF_ISP_STAT_AFM_FIN indicates userspace
that auto-focus measurements were collected. Therefore
the suffix _FIN in the flag's name does not fit.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/staging/media/rkisp1/rkisp1-stats.c       | 2 +-
 drivers/staging/media/rkisp1/uapi/rkisp1-config.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/rkisp1/rkisp1-stats.c b/drivers/staging/media/rkisp1/rkisp1-stats.c
index 0616793ae395..b2a77ec21989 100644
--- a/drivers/staging/media/rkisp1/rkisp1-stats.c
+++ b/drivers/staging/media/rkisp1/rkisp1-stats.c
@@ -253,7 +253,7 @@ static void rkisp1_stats_get_afc_meas(struct rkisp1_stats *stats,
 	struct rkisp1_device *rkisp1 = stats->rkisp1;
 	struct rkisp1_cif_isp_af_stat *af;
 
-	pbuf->meas_type |= RKISP1_CIF_ISP_STAT_AFM_FIN;
+	pbuf->meas_type |= RKISP1_CIF_ISP_STAT_AFM;
 
 	af = &pbuf->params.af;
 	af->window[0].sum = rkisp1_read(rkisp1, RKISP1_CIF_ISP_AFM_SUM_A);
diff --git a/drivers/staging/media/rkisp1/uapi/rkisp1-config.h b/drivers/staging/media/rkisp1/uapi/rkisp1-config.h
index ec624f2579cd..57f5035d62a4 100644
--- a/drivers/staging/media/rkisp1/uapi/rkisp1-config.h
+++ b/drivers/staging/media/rkisp1/uapi/rkisp1-config.h
@@ -113,7 +113,7 @@
  */
 #define RKISP1_CIF_ISP_STAT_AWB           BIT(0)
 #define RKISP1_CIF_ISP_STAT_AUTOEXP       BIT(1)
-#define RKISP1_CIF_ISP_STAT_AFM_FIN       BIT(2)
+#define RKISP1_CIF_ISP_STAT_AFM           BIT(2)
 #define RKISP1_CIF_ISP_STAT_HIST          BIT(3)
 
 enum rkisp1_cif_isp_histogram_mode {
-- 
2.17.1

