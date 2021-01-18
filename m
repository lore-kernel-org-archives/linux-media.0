Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C7AC4332D
	for <linux-media@archiver.kernel.org>; Mon, 18 Jan 2021 21:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEBE322E01
	for <linux-media@archiver.kernel.org>; Mon, 18 Jan 2021 21:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389022AbhARVoS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 18 Jan 2021 16:44:18 -0500
Received: from gloria.sntech.de ([185.11.138.130]:46160 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388624AbhARJ6c (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 18 Jan 2021 04:58:32 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1l1RI2-0002qw-ME; Mon, 18 Jan 2021 10:57:38 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     dafna.hirschfeld@collabora.com, helen.koike@collabora.com,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        Laurent.pinchart@ideasonboard.com, hverkuil@xs4all.nl
Cc:     linux-rockchip@lists.infradead.org, ezequiel@collabora.com,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        tfiga@chromium.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH v5 1/3] media: rockchip: rkisp1: fix comment about number of histogram sub-windows
Date:   Mon, 18 Jan 2021 10:57:34 +0100
Message-Id: <20210118095736.272473-2-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118095736.272473-1-heiko@sntech.de>
References: <20210118095736.272473-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

The histogram data is divided into 16 sub-windows, not 25.
See RKISP1_CIF_ISP_HIST_BIN_N_MAX being defined as 16 for reference
and this also matches the datasheet.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 include/uapi/linux/rkisp1-config.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/rkisp1-config.h b/include/uapi/linux/rkisp1-config.h
index 6e449e784260..ba443771cc0b 100644
--- a/include/uapi/linux/rkisp1-config.h
+++ b/include/uapi/linux/rkisp1-config.h
@@ -846,7 +846,7 @@ struct rkisp1_cif_isp_af_stat {
  *
  * @hist_bins: measured bin counters
  *
- * Measurement window divided into 25 sub-windows, set
+ * Measurement window divided into 16 sub-windows, set
  * with ISP_HIST_XXX
  */
 struct rkisp1_cif_isp_hist_stat {
-- 
2.29.2

