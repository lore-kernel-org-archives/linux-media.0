Return-Path: <SRS0=gF/f=XR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BCFC3A5A2
	for <linux-media@archiver.kernel.org>; Sun, 22 Sep 2019 19:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A2C20882
	for <linux-media@archiver.kernel.org>; Sun, 22 Sep 2019 19:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179206;
	bh=Tcx/Yp0C4YgpHbn3nCmZwEpP1zIaf3+0RQo1r8RcIR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H8yhK1GBZAn21telOtu3FQI9jtj+H0jeJ8Gaz4gQD2Qg89rTXtlZI3zXU1AmxO/dg
	 JsNupKwE7BKvyhLyFbt4FwPv8yeepDMdoEZW5nhwg621UJQjBqiIRSwVHtXo0hCk3o
	 q/M2uGT/DNwG/LIkisDt3itW8GOXaYLwS6/8zcA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395177AbfIVTA0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395165AbfIVTAY (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sun, 22 Sep 2019 15:00:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A5A0208C2;
        Sun, 22 Sep 2019 19:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178824;
        bh=Tcx/Yp0C4YgpHbn3nCmZwEpP1zIaf3+0RQo1r8RcIR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SG2ttpJ6qtpfiC+QiGMJaPuZV2x+CZy1Yhk6saSerMg4whyJO0f+LTRNpe2fhh/ng
         ru6dkbGk5QHXcg5QWfv7iwlibYXkMxlkSOw4HhUS0E46f3pMKZcX1dqRQqCNBdhKKe
         i+eo6QaUvY++OZxSHapzKGI5unr5PyIb0VTLiVmA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 35/60] media: saa7134: fix terminology around saa7134_i2c_eeprom_md7134_gate()
Date:   Sun, 22 Sep 2019 14:59:08 -0400
Message-Id: <20190922185934.4305-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185934.4305-1-sashal@kernel.org>
References: <20190922185934.4305-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>

[ Upstream commit 9d802222a3405599d6e1984d9324cddf592ea1f4 ]

saa7134_i2c_eeprom_md7134_gate() function and the associated comment uses
an inverted i2c gate open / closed terminology.
Let's fix this.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
[hverkuil-cisco@xs4all.nl: fix alignment checkpatch warning]
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/saa7134/saa7134-i2c.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/pci/saa7134/saa7134-i2c.c b/drivers/media/pci/saa7134/saa7134-i2c.c
index dca0592c5f471..6f93568f56204 100644
--- a/drivers/media/pci/saa7134/saa7134-i2c.c
+++ b/drivers/media/pci/saa7134/saa7134-i2c.c
@@ -355,7 +355,11 @@ static struct i2c_client saa7134_client_template = {
 
 /* ----------------------------------------------------------- */
 
-/* On Medion 7134 reading EEPROM needs DVB-T demod i2c gate open */
+/*
+ * On Medion 7134 reading the SAA7134 chip config EEPROM needs DVB-T
+ * demod i2c gate closed due to an address clash between this EEPROM
+ * and the demod one.
+ */
 static void saa7134_i2c_eeprom_md7134_gate(struct saa7134_dev *dev)
 {
 	u8 subaddr = 0x7, dmdregval;
@@ -372,14 +376,14 @@ static void saa7134_i2c_eeprom_md7134_gate(struct saa7134_dev *dev)
 
 	ret = i2c_transfer(&dev->i2c_adap, i2cgatemsg_r, 2);
 	if ((ret == 2) && (dmdregval & 0x2)) {
-		pr_debug("%s: DVB-T demod i2c gate was left closed\n",
+		pr_debug("%s: DVB-T demod i2c gate was left open\n",
 			 dev->name);
 
 		data[0] = subaddr;
 		data[1] = (dmdregval & ~0x2);
 		if (i2c_transfer(&dev->i2c_adap, i2cgatemsg_w, 1) != 1)
-			pr_err("%s: EEPROM i2c gate open failure\n",
-			  dev->name);
+			pr_err("%s: EEPROM i2c gate close failure\n",
+			       dev->name);
 	}
 }
 
-- 
2.20.1

