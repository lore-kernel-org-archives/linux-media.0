Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2BBC433E0
	for <linux-media@archiver.kernel.org>; Wed, 20 Jan 2021 16:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E57233EB
	for <linux-media@archiver.kernel.org>; Wed, 20 Jan 2021 16:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391679AbhATQv7 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:51:59 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50576 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391570AbhATQpm (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 20 Jan 2021 11:45:42 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id 3E1631F44FA7
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org, heiko.stuebner@theobroma-systems.com,
        heiko@sntech.de
Cc:     laurent.pinchart@ideasonboard.com, dafna.hirschfeld@collabora.com,
        helen.koike@collabora.com, ezequiel@collabora.com,
        hverkuil@xs4all.nl, kernel@collabora.com, dafna3@gmail.com,
        sakari.ailus@linux.intel.com, linux-rockchip@lists.infradead.org,
        mchehab@kernel.org, tfiga@chromium.org
Subject: [PATCH v7 1/5] media: rkisp1: uapi: change hist_bins array type from __u16 to __u32
Date:   Wed, 20 Jan 2021 17:44:42 +0100
Message-Id: <20210120164446.1220-2-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210120164446.1220-1-dafna.hirschfeld@collabora.com>
References: <20210120164446.1220-1-dafna.hirschfeld@collabora.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Each entry in the array is a 20 bits value composed of 16
bits unsigned integer and 4 bits fractional part. So the
type should change to __u32.
In addition add a documentation of how the measurements
are done.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 include/uapi/linux/rkisp1-config.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/rkisp1-config.h b/include/uapi/linux/rkisp1-config.h
index 6e449e784260..f75f8d698fb4 100644
--- a/include/uapi/linux/rkisp1-config.h
+++ b/include/uapi/linux/rkisp1-config.h
@@ -844,13 +844,17 @@ struct rkisp1_cif_isp_af_stat {
 /**
  * struct rkisp1_cif_isp_hist_stat - statistics histogram data
  *
- * @hist_bins: measured bin counters
+ * @hist_bins: measured bin counters. Each bin is a 20 bits unsigned fixed point type.
+ *	       Bits 0-4 are the fractional part and bits 5-19 are the integer part.
  *
- * Measurement window divided into 25 sub-windows, set
- * with ISP_HIST_XXX
+ * The window of the measurements area is divided to 5x5 sub-windows. The histogram
+ * is then computed for each sub-window independently and the final result is a weighted
+ * average of the histogram measurements on all sub-windows.
+ * The window of the measurements area and the weight of each sub-window are configurable
+ * using struct @rkisp1_cif_isp_hst_config.
  */
 struct rkisp1_cif_isp_hist_stat {
-	__u16 hist_bins[RKISP1_CIF_ISP_HIST_BIN_N_MAX];
+	__u32 hist_bins[RKISP1_CIF_ISP_HIST_BIN_N_MAX];
 };
 
 /**
-- 
2.17.1

