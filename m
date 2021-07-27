Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5432FC4338F
	for <linux-media@archiver.kernel.org>; Tue, 27 Jul 2021 05:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EFFE610E6
	for <linux-media@archiver.kernel.org>; Tue, 27 Jul 2021 05:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbhG0FjR (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 27 Jul 2021 01:39:17 -0400
Received: from mx20.baidu.com ([111.202.115.85]:48866 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235182AbhG0FjM (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 27 Jul 2021 01:39:12 -0400
Received: from BC-Mail-Ex30.internal.baidu.com (unknown [172.31.51.24])
        by Forcepoint Email with ESMTPS id 2C089BB21FA82E598B1E;
        Tue, 27 Jul 2021 13:39:11 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex30.internal.baidu.com (172.31.51.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Tue, 27 Jul 2021 13:39:11 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 27 Jul 2021 13:39:10 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <patrice.chotard@foss.st.com>, <mchehab@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH] [media] c8sectpfe: c8sectpfe-dvb: Remove unused including <linux/version.h>
Date:   Tue, 27 Jul 2021 13:39:03 +0800
Message-ID: <20210727053903.711-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex31.internal.baidu.com (172.31.51.25) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Remove including <linux/version.h> that don't need it.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c | 1 -
 drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
index 338b205ae3a7..02dc78bd7fab 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
@@ -28,7 +28,6 @@
 #include <linux/usb.h>
 #include <linux/slab.h>
 #include <linux/time.h>
-#include <linux/version.h>
 #include <linux/wait.h>
 #include <linux/pinctrl/pinctrl.h>
 
diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c
index 0560a9cb004b..feb48cb546d7 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c
@@ -11,7 +11,6 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
-#include <linux/version.h>
 
 #include <dt-bindings/media/c8sectpfe.h>
 
-- 
2.25.1

