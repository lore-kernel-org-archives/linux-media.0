Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA87C10F13
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 11:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D18F20857
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 11:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfDHLEH (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:04:07 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:60226 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726471AbfDHLEG (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 8 Apr 2019 07:04:06 -0400
Received: from marune.fritz.box ([IPv6:2001:983:e9a7:1:1170:5c87:411e:5806])
        by smtp-cloud7.xs4all.net with ESMTPA
        id DS4HhTHSRNG8zDS4KhlZOn; Mon, 08 Apr 2019 13:04:04 +0200
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Ettore Chimenti <ek5.chimenti@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 4/7] stih_cec: use new cec_notifier_find_hdmi_dev helper
Date:   Mon,  8 Apr 2019 13:03:58 +0200
Message-Id: <20190408110401.3345-5-hverkuil-cisco@xs4all.nl>
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

The STI CEC driver increased the HDMI device refcount when
it shouldn't. Use the new helper function to ensure that that
doesn't happen and to simplify the driver code.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/platform/sti/cec/stih-cec.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/sti/cec/stih-cec.c b/drivers/media/platform/sti/cec/stih-cec.c
index d34099f75990..678d7cb38637 100644
--- a/drivers/media/platform/sti/cec/stih-cec.c
+++ b/drivers/media/platform/sti/cec/stih-cec.c
@@ -301,26 +301,19 @@ static int stih_cec_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	struct stih_cec *cec;
-	struct device_node *np;
-	struct platform_device *hdmi_dev;
+	struct device *hdmi_dev;
 	int ret;
 
+	hdmi_dev = cec_notifier_find_hdmi_dev(dev);
+
+	if (IS_ERR(hdmi_dev))
+		return PTR_ERR(hdmi_dev);
+
 	cec = devm_kzalloc(dev, sizeof(*cec), GFP_KERNEL);
 	if (!cec)
 		return -ENOMEM;
 
-	np = of_parse_phandle(pdev->dev.of_node, "hdmi-phandle", 0);
-
-	if (!np) {
-		dev_err(&pdev->dev, "Failed to find hdmi node in device tree\n");
-		return -ENODEV;
-	}
-
-	hdmi_dev = of_find_device_by_node(np);
-	if (!hdmi_dev)
-		return -EPROBE_DEFER;
-
-	cec->notifier = cec_notifier_get(&hdmi_dev->dev);
+	cec->notifier = cec_notifier_get(hdmi_dev);
 	if (!cec->notifier)
 		return -ENOMEM;
 
-- 
2.20.1

