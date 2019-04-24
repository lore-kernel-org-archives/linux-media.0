Return-Path: <SRS0=rHfj=S2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BC7C10F11
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 10:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E6D20811
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 10:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfDXKJ7 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:09:59 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:37911 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbfDXKJ7 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 24 Apr 2019 06:09:59 -0400
Received: from [IPv6:2001:420:44c1:2579:8575:c0e0:a08:6676] ([IPv6:2001:420:44c1:2579:8575:c0e0:a08:6676])
        by smtp-cloud7.xs4all.net with ESMTPA
        id JEqghJS0eZVjxJEqjhZvRZ; Wed, 24 Apr 2019 12:09:57 +0200
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Thierry Reding <thierry.reding@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH] tegra-cec: fix cec_notifier_parse_hdmi_phandle return check
Message-ID: <8f933fa3-8f01-39b4-7898-c08aac1c6e1f@xs4all.nl>
Date:   Wed, 24 Apr 2019 12:09:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDP7druZNAeClw1QB1rRBkzEDBRYAR0vQCKS+ZoCSPGlmu0B/brHVHTmjkOfZEKDLRPUP9UTSZuAeN6D+LICSSNaJa455Xr+TlBh8f39jblQFaUh7gaQ
 psrCpxsB+JBL/Wbrs2FfYJSYtPhUelpv7L/4Y0KzJDgUnnzZdoMpqlCOc8I/ugo407bdVUW5FG4gcbcpPzswWcHHdn1Gjjy4ACIRbPtvwazR8KMGfQYzfJMO
 eDUtagggr5h3jhp4p5/bEBjscwzUMAXLE1Ah/XoJ0I5kQppEGSZS7noPpLs8eeIlmkvbYEpEC8AcT5k/mkxZ1Vf7T2E8/DHWqneMxN8uG2UiMigpfbppbfUI
 XZDh/D+6
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

cec_notifier_parse_hdmi_phandle returns an error pointer, not a NULL
pointer on error.

Fixes: 4d34c9267db7: ("media: tegra_cec: use new cec_notifier_parse_hdmi_phandle helper")
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
diff --git a/drivers/media/platform/tegra-cec/tegra_cec.c b/drivers/media/platform/tegra-cec/tegra_cec.c
index 7fb3a4fa07c1..447bdfbe5afe 100644
--- a/drivers/media/platform/tegra-cec/tegra_cec.c
+++ b/drivers/media/platform/tegra-cec/tegra_cec.c
@@ -334,8 +334,8 @@ static int tegra_cec_probe(struct platform_device *pdev)

 	hdmi_dev = cec_notifier_parse_hdmi_phandle(&pdev->dev);

-	if (!hdmi_dev)
-		return -ENODEV;
+	if (IS_ERR(hdmi_dev))
+		return PTR_ERR(hdmi_dev);

 	cec = devm_kzalloc(&pdev->dev, sizeof(struct tegra_cec), GFP_KERNEL);

