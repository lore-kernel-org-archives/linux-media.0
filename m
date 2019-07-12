Return-Path: <SRS0=oO/i=VJ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121D6C742C2
	for <linux-media@archiver.kernel.org>; Fri, 12 Jul 2019 14:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA56B21019
	for <linux-media@archiver.kernel.org>; Fri, 12 Jul 2019 14:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfGLOTW (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Jul 2019 10:19:22 -0400
Received: from ns.iliad.fr ([212.27.33.1]:60796 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbfGLOTW (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Jul 2019 10:19:22 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id BBC5F20907;
        Fri, 12 Jul 2019 16:19:20 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id A1AEF2022D;
        Fri, 12 Jul 2019 16:19:20 +0200 (CEST)
To:     Sean Young <sean@mess.org>, Brad Love <brad@nextdimension.cc>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media <linux-media@vger.kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH v1] media: dvb: Add devm_dvb_register_adapter
Message-ID: <a69ec163-8515-2e86-e2e7-0da61beda6e1@free.fr>
Date:   Fri, 12 Jul 2019 16:19:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Fri Jul 12 16:19:20 2019 +0200 (CEST)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add devm* variant for automagic resource release.
---
 drivers/media/dvb-core/dvbdev.c | 21 +++++++++++++++++++++
 include/media/dvbdev.h          |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index a3393cd4e584..c7a5302e8840 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -885,6 +885,27 @@ int dvb_register_adapter(struct dvb_adapter *adap, const char *name,
 }
 EXPORT_SYMBOL(dvb_register_adapter);
 
+static void unregister_adapter(void *adap)
+{
+	dvb_unregister_adapter(adap);
+}
+
+int devm_dvb_register_adapter(struct device *dev, struct dvb_adapter *adap,
+		const char *name, struct module *module, short *adapter_nums)
+{
+	int v1, v2;
+
+	v1 = dvb_register_adapter(adap, name, module, dev, adapter_nums);
+	if (v1 < 0)
+		return v1;
+
+	v2 = devm_add_action_or_reset(dev, unregister_adapter, adap);
+	if (v2 < 0)
+		return v2;
+
+	return v1;
+}
+EXPORT_SYMBOL(devm_dvb_register_adapter);
 
 int dvb_unregister_adapter(struct dvb_adapter *adap)
 {
diff --git a/include/media/dvbdev.h b/include/media/dvbdev.h
index 551325858de3..32f8d1626319 100644
--- a/include/media/dvbdev.h
+++ b/include/media/dvbdev.h
@@ -202,6 +202,9 @@ int dvb_register_adapter(struct dvb_adapter *adap, const char *name,
 			 struct module *module, struct device *device,
 			 short *adapter_nums);
 
+int devm_dvb_register_adapter(struct device *dev, struct dvb_adapter *adap,
+		const char *name, struct module *module, short *adapter_nums);
+
 /**
  * dvb_unregister_adapter - Unregisters a DVB adapter
  *
-- 
2.17.1
