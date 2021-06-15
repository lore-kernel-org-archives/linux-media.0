Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9D5C49EA3
	for <linux-media@archiver.kernel.org>; Tue, 15 Jun 2021 00:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D741611CA
	for <linux-media@archiver.kernel.org>; Tue, 15 Jun 2021 00:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhFOAkF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 14 Jun 2021 20:40:05 -0400
Received: from gloria.sntech.de ([185.11.138.130]:42354 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230222AbhFOAkE (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 14 Jun 2021 20:40:04 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lsx5Y-0004ks-LY; Tue, 15 Jun 2021 02:37:56 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     ezequiel@collabora.com, dafna.hirschfeld@collabora.com,
        helen.koike@collabora.com, Laurent.pinchart@ideasonboard.com,
        linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
        heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH v2 7/7] media: rockchip: rkisp1: add support for px30 isp version
Date:   Tue, 15 Jun 2021 02:37:41 +0200
Message-Id: <20210615003741.3758316-8-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210615003741.3758316-1-heiko@sntech.de>
References: <20210615003741.3758316-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

The px30 uses a V12 isp block so add compatible and matchdata
for it.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 .../media/platform/rockchip/rkisp1/rkisp1-dev.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index ddc05189c62a..6e4c0710f3a3 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -398,6 +398,19 @@ static irqreturn_t rkisp1_isr(int irq, void *ctx)
 	return IRQ_HANDLED;
 }
 
+static const char * const px30_isp_clks[] = {
+	"isp",
+	"aclk",
+	"hclk",
+	"pclk",
+};
+
+static const struct rkisp1_match_data px30_isp_match_data = {
+	.clks = px30_isp_clks,
+	.size = ARRAY_SIZE(px30_isp_clks),
+	.isp_ver = RKISP1_V12,
+};
+
 static const char * const rk3399_isp_clks[] = {
 	"isp",
 	"aclk",
@@ -411,6 +424,10 @@ static const struct rkisp1_match_data rk3399_isp_match_data = {
 };
 
 static const struct of_device_id rkisp1_of_match[] = {
+	{
+		.compatible = "rockchip,px30-cif-isp",
+		.data = &px30_isp_match_data,
+	},
 	{
 		.compatible = "rockchip,rk3399-cif-isp",
 		.data = &rk3399_isp_match_data,
-- 
2.29.2

