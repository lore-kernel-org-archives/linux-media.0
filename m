Return-Path: <SRS0=uFep=T4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DD0C04AB6
	for <linux-media@archiver.kernel.org>; Tue, 28 May 2019 17:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6F42075B
	for <linux-media@archiver.kernel.org>; Tue, 28 May 2019 17:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfE1REP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 28 May 2019 13:04:15 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46080 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfE1REP (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 28 May 2019 13:04:15 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id D05BC284AF7
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>
Cc:     kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v6 16/16] rockchip/vpu: Add support for MPEG-2 decoding on RK3328
Date:   Tue, 28 May 2019 14:02:32 -0300
Message-Id: <20190528170232.2091-17-ezequiel@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528170232.2091-1-ezequiel@collabora.com>
References: <20190528170232.2091-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Jonas Karlman <jonas@kwiboo.se>

Add necessary bits to support MPEG2 decoding on RK3328.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
--
Changes from v5:
* New patch.

 drivers/staging/media/rockchip/vpu/rk3399_vpu_hw.c   | 12 ++++++++++++
 .../staging/media/rockchip/vpu/rockchip_vpu_drv.c    |  1 +
 drivers/staging/media/rockchip/vpu/rockchip_vpu_hw.h |  1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw.c b/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw.c
index 2b3689968ef4..341f8d69c33d 100644
--- a/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw.c
+++ b/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw.c
@@ -175,3 +175,15 @@ const struct rockchip_vpu_variant rk3399_vpu_variant = {
 	.clk_names = {"aclk", "hclk"},
 	.num_clocks = 2
 };
+
+const struct rockchip_vpu_variant rk3328_vpu_variant = {
+	.dec_offset = 0x400,
+	.dec_fmts = rk3399_vpu_dec_fmts,
+	.num_dec_fmts = ARRAY_SIZE(rk3399_vpu_dec_fmts),
+	.codec = RK_VPU_MPEG2_DECODER,
+	.codec_ops = rk3399_vpu_codec_ops,
+	.vdpu_irq = rk3399_vdpu_irq,
+	.init = rk3399_vpu_hw_init,
+	.clk_names = {"aclk", "hclk"},
+	.num_clocks = 2
+};
diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
index b94ff97451db..2e22009b6583 100644
--- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
+++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
@@ -419,6 +419,7 @@ static const struct v4l2_file_operations rockchip_vpu_fops = {
 
 static const struct of_device_id of_rockchip_vpu_match[] = {
 	{ .compatible = "rockchip,rk3399-vpu", .data = &rk3399_vpu_variant, },
+	{ .compatible = "rockchip,rk3328-vpu", .data = &rk3328_vpu_variant, },
 	{ .compatible = "rockchip,rk3288-vpu", .data = &rk3288_vpu_variant, },
 	{ /* sentinel */ }
 };
diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_hw.h b/drivers/staging/media/rockchip/vpu/rockchip_vpu_hw.h
index 6cecb528f994..3d6b97af90fb 100644
--- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_hw.h
+++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_hw.h
@@ -79,6 +79,7 @@ enum rockchip_vpu_enc_fmt {
 };
 
 extern const struct rockchip_vpu_variant rk3399_vpu_variant;
+extern const struct rockchip_vpu_variant rk3328_vpu_variant;
 extern const struct rockchip_vpu_variant rk3288_vpu_variant;
 
 void rockchip_vpu_watchdog(struct work_struct *work);
-- 
2.20.1

