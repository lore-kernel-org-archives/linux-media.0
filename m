Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CF8C282CE
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 11:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E310208E3
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 11:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbfDHLEG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:04:06 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:46103 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726456AbfDHLEG (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 8 Apr 2019 07:04:06 -0400
Received: from marune.fritz.box ([IPv6:2001:983:e9a7:1:1170:5c87:411e:5806])
        by smtp-cloud7.xs4all.net with ESMTPA
        id DS4HhTHSRNG8zDS4KhlZOP; Mon, 08 Apr 2019 13:04:04 +0200
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Ettore Chimenti <ek5.chimenti@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 2/7] meson: ao-cec: use new cec_notifier_find_hdmi_dev helper
Date:   Mon,  8 Apr 2019 13:03:56 +0200
Message-Id: <20190408110401.3345-3-hverkuil-cisco@xs4all.nl>
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

The meson CEC driver increased the HDMI device refcount when
it shouldn't. Use the new helper function to ensure that that
doesn't happen and to simplify the driver code.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/platform/meson/ao-cec.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/meson/ao-cec.c b/drivers/media/platform/meson/ao-cec.c
index cd4be38ab5ac..c8b374741a7c 100644
--- a/drivers/media/platform/meson/ao-cec.c
+++ b/drivers/media/platform/meson/ao-cec.c
@@ -601,20 +601,14 @@ static const struct cec_adap_ops meson_ao_cec_ops = {
 static int meson_ao_cec_probe(struct platform_device *pdev)
 {
 	struct meson_ao_cec_device *ao_cec;
-	struct platform_device *hdmi_dev;
-	struct device_node *np;
+	struct device *hdmi_dev;
 	struct resource *res;
 	int ret, irq;
 
-	np = of_parse_phandle(pdev->dev.of_node, "hdmi-phandle", 0);
-	if (!np) {
-		dev_err(&pdev->dev, "Failed to find hdmi node\n");
-		return -ENODEV;
-	}
+	hdmi_dev = cec_notifier_find_hdmi_dev(&pdev->dev);
 
-	hdmi_dev = of_find_device_by_node(np);
-	if (hdmi_dev == NULL)
-		return -EPROBE_DEFER;
+	if (IS_ERR(hdmi_dev))
+		return PTR_ERR(hdmi_dev);
 
 	ao_cec = devm_kzalloc(&pdev->dev, sizeof(*ao_cec), GFP_KERNEL);
 	if (!ao_cec)
@@ -622,7 +616,7 @@ static int meson_ao_cec_probe(struct platform_device *pdev)
 
 	spin_lock_init(&ao_cec->cec_reg_lock);
 
-	ao_cec->notify = cec_notifier_get(&hdmi_dev->dev);
+	ao_cec->notify = cec_notifier_get(hdmi_dev);
 	if (!ao_cec->notify)
 		return -ENOMEM;
 
-- 
2.20.1

