Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BA3C282CE
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 09:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997112075B
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 09:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbfDJJNi (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:13:38 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:45028 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729159AbfDJJNh (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 05:13:37 -0400
Received: from marune.fritz.box ([IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f])
        by smtp-cloud8.xs4all.net with ESMTPA
        id E9IUhpDJCUjKfE9IVhgr9Z; Wed, 10 Apr 2019 11:13:35 +0200
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Ettore Chimenti <ek5.chimenti@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCHv2 4/7] stih_cec: use new cec_notifier_parse_hdmi_phandle helper
Date:   Wed, 10 Apr 2019 11:13:31 +0200
Message-Id: <20190410091334.8654-5-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410091334.8654-1-hverkuil-cisco@xs4all.nl>
References: <20190410091334.8654-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfIefm1wvOkBIt1bXOX7G3Qkbt7geMjELYYlM/3tAmvR+Vej4U7mmDzhU3CAOiDJxDERX+fKtJxhmq5rm9HXyPmIdt66EnCPHgJzIm/LRsLf0OKu49flx
 I4YPhZNoM1JHwcngK5DtkdjsFEvDAVjzoPRYqTWk9YnasaINJR9XMELMhb/2txL0xQaH0qQ4UnPsgg3hdGKAuYbcUk4rcyt1+0ayRIoU0qfl0Ghs//I16N85
 h1QGs5JeR40AXQdbU73zc65kg9QYvAfynW723IAEtbKunZIqlm9NsE1lYfPKtPWkDnDP6ROulJiup+F/e5Dd4q+VeY6sdLkz0VTk+uD/oXIJRp3WVdictMMN
 yCduj/p3AdDgDl3Yu+kgrgBAdiyPONX8MPE5EjyJxd1fyQyXv5I/82MX7NIpcxzdSLr23tPtP7zWDnCV8xRxpB0ZSnXpEl6OwW8Q9cMBYZcONRtYJD/UPF2t
 TTOeRhIUIWS9DPMaEv/6PzdPYhBN8LUnTMtBMQ==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The STI CEC driver increased the HDMI device refcount when
it shouldn't. Use the new helper function to ensure that that
doesn't happen and to simplify the driver code.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 drivers/media/platform/sti/cec/stih-cec.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/sti/cec/stih-cec.c b/drivers/media/platform/sti/cec/stih-cec.c
index d34099f75990..fc37efe1d554 100644
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
 
+	hdmi_dev = cec_notifier_parse_hdmi_phandle(dev);
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

