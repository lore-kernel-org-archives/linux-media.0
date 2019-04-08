Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A77C282DE
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 11:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF565208E3
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 11:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfDHLEG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:04:06 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:50583 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726464AbfDHLEG (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 8 Apr 2019 07:04:06 -0400
Received: from marune.fritz.box ([IPv6:2001:983:e9a7:1:1170:5c87:411e:5806])
        by smtp-cloud7.xs4all.net with ESMTPA
        id DS4HhTHSRNG8zDS4KhlZP2; Mon, 08 Apr 2019 13:04:04 +0200
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Ettore Chimenti <ek5.chimenti@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 5/7] tegra_cec: use new cec_notifier_find_hdmi_dev helper
Date:   Mon,  8 Apr 2019 13:03:59 +0200
Message-Id: <20190408110401.3345-6-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408110401.3345-1-hverkuil-cisco@xs4all.nl>
References: <20190408110401.3345-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLfSxf2AE183XfVVV6a2UI5fWTLb1QG/s1qtjC0Ua/wMBndy1sPfxlIxGHM5STR4zSj/Lt5IzFLx7G9yPKYmaE3SZASt5x53vt9DqIfMFzPU3m8fJszo
 4qxh7gPZbg/ZDTbLREIF8C+D8bFg9S5ztYjRkWUxA/SavgSI3C+rNp9LiBAulbvhqISTZDUEkPPOO8fYoRqZzbNQ5ax9pp2r1EucYz6CbIg/HSxGdlRYPLtY
 xWlbj0LB/hTrBztSuNvstStN6r2ZfRjDXV90Aj0qw9Fh9oN0Mr4yiHVNPqRRX/UG71uTIupcL2UNmaJO8UaHktnNT1DcEqCfTAkkdC4aefTkoU699APhMJo5
 48lfdn9jSMIWyRJIaum867Z7+iJT/LYABKKA7i6LZat9Ez+cOwtTnVQjyPo31styIjtDraTqBJI0Xj7eTG4zd/BhsMPzcLNu+ohABQ+9fxeLRWEO+EodVr1x
 y6EbhNTZ5RasFnnc2TzEcllOgCThtfLJtHRiNQ==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The Tegra CEC driver increased the HDMI device refcount when
it shouldn't. Use the new helper function to ensure that that
doesn't happen and to simplify the driver code.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/platform/tegra-cec/tegra_cec.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/tegra-cec/tegra_cec.c b/drivers/media/platform/tegra-cec/tegra_cec.c
index aba488cd0e64..074d647f2908 100644
--- a/drivers/media/platform/tegra-cec/tegra_cec.c
+++ b/drivers/media/platform/tegra-cec/tegra_cec.c
@@ -327,21 +327,15 @@ static const struct cec_adap_ops tegra_cec_ops = {
 
 static int tegra_cec_probe(struct platform_device *pdev)
 {
-	struct platform_device *hdmi_dev;
-	struct device_node *np;
+	struct device *hdmi_dev;
 	struct tegra_cec *cec;
 	struct resource *res;
 	int ret = 0;
 
-	np = of_parse_phandle(pdev->dev.of_node, "hdmi-phandle", 0);
+	hdmi_dev = cec_notifier_find_hdmi_dev(&pdev->dev);
 
-	if (!np) {
-		dev_err(&pdev->dev, "Failed to find hdmi node in device tree\n");
+	if (!hdmi_dev)
 		return -ENODEV;
-	}
-	hdmi_dev = of_find_device_by_node(np);
-	if (hdmi_dev == NULL)
-		return -EPROBE_DEFER;
 
 	cec = devm_kzalloc(&pdev->dev, sizeof(struct tegra_cec), GFP_KERNEL);
 
@@ -400,7 +394,7 @@ static int tegra_cec_probe(struct platform_device *pdev)
 		goto clk_error;
 	}
 
-	cec->notifier = cec_notifier_get(&hdmi_dev->dev);
+	cec->notifier = cec_notifier_get(hdmi_dev);
 	if (!cec->notifier) {
 		ret = -ENOMEM;
 		goto clk_error;
-- 
2.20.1

