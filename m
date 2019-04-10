Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895D5C282DA
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 09:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584BC20850
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 09:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfDJJNi (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:13:38 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:36656 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727020AbfDJJNh (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 05:13:37 -0400
Received: from marune.fritz.box ([IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f])
        by smtp-cloud8.xs4all.net with ESMTPA
        id E9IUhpDJCUjKfE9IVhgr9o; Wed, 10 Apr 2019 11:13:36 +0200
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Ettore Chimenti <ek5.chimenti@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCHv2 5/7] tegra_cec: use new cec_notifier_parse_hdmi_phandle helper
Date:   Wed, 10 Apr 2019 11:13:32 +0200
Message-Id: <20190410091334.8654-6-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410091334.8654-1-hverkuil-cisco@xs4all.nl>
References: <20190410091334.8654-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOI7DS1Nto+WVDbT9kY2Sy2fxK3GKg2CTzMo+Xa6eAvzgQvnVNFTuUSZy6zWbkyyV2EbCMnr7VN3GWx2LMMPBJTpeT6xhl1UmxQlTqPua3NjMaU2JNlL
 gBwU0RYJPyLzCaTcaEBZcXVtbGLkjODXbljv6/1sSgcH5OnyzW8NuGjirC/PWvWkgOcqKKkCxIs/QrRfU6vMKTwSQZ3/92XhopbPR+L/+GPYjOV6KK645+z8
 VK6HRQ/Dnq3/ZR6wvUOf1J0q47ug7gBbd9eOZ5fVGBbPs7xV5tttvaEekIEJfTxpU88i1ErkXGc44U0hJMX9OLQ9G6DbV1WnktuoaOE6zbro/yfhtglt04kM
 dFKqS70V3gQcbUC53xIeApeDp6jV0pw26VEI/jtVrPbOjRCyDtZM/+G80OXrvJvkruj1DerpUP+2xGTUCxKd+TFONQ5C5oX023k6ft/t1f4Qte6MI2WdjpLZ
 L6cOusAMz6F7NcW2xNcv5znePfzvDU6LgdZSwg==
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
index aba488cd0e64..7fb3a4fa07c1 100644
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
+	hdmi_dev = cec_notifier_parse_hdmi_phandle(&pdev->dev);
 
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

