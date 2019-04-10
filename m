Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9218C10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 09:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FEC52075B
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 09:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfDJJNi (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:13:38 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:44643 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728726AbfDJJNh (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 05:13:37 -0400
Received: from marune.fritz.box ([IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f])
        by smtp-cloud8.xs4all.net with ESMTPA
        id E9IUhpDJCUjKfE9IVhgr8x; Wed, 10 Apr 2019 11:13:35 +0200
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Ettore Chimenti <ek5.chimenti@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCHv2 1/7] cec-notifier: add cec_notifier_parse_hdmi_phandle helper
Date:   Wed, 10 Apr 2019 11:13:28 +0200
Message-Id: <20190410091334.8654-2-hverkuil-cisco@xs4all.nl>
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

Add helper function to parse the DT for the hdmi-phandle property
and return the corresponding struct device pointer.

It takes care to avoid increasing the device refcount since all
we need is the device pointer. This pointer is used in the
notifier list as a key, but it is never accessed by the CEC driver.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reported-by: Wen Yang <wen.yang99@zte.com.cn>
---
 drivers/media/cec/cec-notifier.c | 30 ++++++++++++++++++++++++++++++
 include/media/cec-notifier.h     | 19 ++++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/media/cec/cec-notifier.c b/drivers/media/cec/cec-notifier.c
index dd2078b27a41..9598c7778871 100644
--- a/drivers/media/cec/cec-notifier.c
+++ b/drivers/media/cec/cec-notifier.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/list.h>
 #include <linux/kref.h>
+#include <linux/of_platform.h>
 
 #include <media/cec.h>
 #include <media/cec-notifier.h>
@@ -127,3 +128,32 @@ void cec_notifier_unregister(struct cec_notifier *n)
 	cec_notifier_put(n);
 }
 EXPORT_SYMBOL_GPL(cec_notifier_unregister);
+
+struct device *cec_notifier_parse_hdmi_phandle(struct device *dev)
+{
+	struct platform_device *hdmi_pdev;
+	struct device *hdmi_dev = NULL;
+	struct device_node *np;
+
+	np = of_parse_phandle(dev->of_node, "hdmi-phandle", 0);
+
+	if (!np) {
+		dev_err(dev, "Failed to find HDMI node in device tree\n");
+		return ERR_PTR(-ENODEV);
+	}
+	hdmi_pdev = of_find_device_by_node(np);
+	of_node_put(np);
+	if (hdmi_pdev) {
+		hdmi_dev = &hdmi_pdev->dev;
+		/*
+		 * Note that the device struct is only used as a key into the
+		 * cec_notifiers list, it is never actually accessed.
+		 * So we decrement the reference here so we don't leak
+		 * memory.
+		 */
+		put_device(hdmi_dev);
+		return hdmi_dev;
+	}
+	return ERR_PTR(-EPROBE_DEFER);
+}
+EXPORT_SYMBOL_GPL(cec_notifier_parse_hdmi_phandle);
diff --git a/include/media/cec-notifier.h b/include/media/cec-notifier.h
index 814eeef35a5c..57b3a9f6ea1d 100644
--- a/include/media/cec-notifier.h
+++ b/include/media/cec-notifier.h
@@ -9,7 +9,7 @@
 #ifndef LINUX_CEC_NOTIFIER_H
 #define LINUX_CEC_NOTIFIER_H
 
-#include <linux/types.h>
+#include <linux/err.h>
 #include <media/cec.h>
 
 struct device;
@@ -87,6 +87,17 @@ void cec_notifier_unregister(struct cec_notifier *n);
 void cec_register_cec_notifier(struct cec_adapter *adap,
 			       struct cec_notifier *notifier);
 
+/**
+ * cec_notifier_parse_hdmi_phandle - find the hdmi device from "hdmi-phandle"
+ * @dev: the device with the "hdmi-phandle" device tree property
+ *
+ * Returns the device pointer referenced by the "hdmi-phandle" property.
+ * Note that the refcount of the returned device is not incremented.
+ * This device pointer is only used as a key value in the notifier
+ * list, but it is never accessed by the CEC driver.
+ */
+struct device *cec_notifier_parse_hdmi_phandle(struct device *dev);
+
 #else
 static inline struct cec_notifier *cec_notifier_get_conn(struct device *dev,
 							 const char *conn)
@@ -122,6 +133,12 @@ static inline void cec_register_cec_notifier(struct cec_adapter *adap,
 					     struct cec_notifier *notifier)
 {
 }
+
+static inline struct device *cec_notifier_parse_hdmi_phandle(struct device *dev)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 #endif
 
 /**
-- 
2.20.1

