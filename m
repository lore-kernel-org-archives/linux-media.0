Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18385C433E6
	for <linux-media@archiver.kernel.org>; Mon, 18 Jan 2021 11:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A2E221F8
	for <linux-media@archiver.kernel.org>; Mon, 18 Jan 2021 11:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389568AbhARLGO (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 18 Jan 2021 06:06:14 -0500
Received: from gloria.sntech.de ([185.11.138.130]:46738 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389237AbhARLFe (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 18 Jan 2021 06:05:34 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1l1SL4-0003HM-W9; Mon, 18 Jan 2021 12:04:51 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     dafna.hirschfeld@collabora.com, helen.koike@collabora.com,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        Laurent.pinchart@ideasonboard.com, hverkuil@xs4all.nl
Cc:     linux-rockchip@lists.infradead.org, ezequiel@collabora.com,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        tfiga@chromium.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH v6 2/4] media: rockchip: rkisp1: reduce number of histogram grid elements in uapi
Date:   Mon, 18 Jan 2021 12:04:46 +0100
Message-Id: <20210118110448.275389-3-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118110448.275389-1-heiko@sntech.de>
References: <20210118110448.275389-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

The uapi right now specifies an array size of 28 but the actual number
of elements is only 25 with the last 3 being unused.

Reduce the array size to the correct number of elements.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 include/uapi/linux/rkisp1-config.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/uapi/linux/rkisp1-config.h b/include/uapi/linux/rkisp1-config.h
index ba443771cc0b..ecfb8f7a6c70 100644
--- a/include/uapi/linux/rkisp1-config.h
+++ b/include/uapi/linux/rkisp1-config.h
@@ -102,8 +102,7 @@
 /*
  * Histogram calculation
  */
-/* Last 3 values unused. */
-#define RKISP1_CIF_ISP_HISTOGRAM_WEIGHT_GRIDS_SIZE 28
+#define RKISP1_CIF_ISP_HISTOGRAM_WEIGHT_GRIDS_SIZE 25
 
 /*
  * Defect Pixel Cluster Correction
-- 
2.29.2

