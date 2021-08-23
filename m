Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73C6C4338F
	for <linux-media@archiver.kernel.org>; Mon, 23 Aug 2021 12:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A19061378
	for <linux-media@archiver.kernel.org>; Mon, 23 Aug 2021 12:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbhHWMGe (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:06:34 -0400
Received: from mx20.baidu.com ([111.202.115.85]:46234 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233755AbhHWMGd (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 23 Aug 2021 08:06:33 -0400
Received: from BC-Mail-HQEx02.internal.baidu.com (unknown [172.31.51.58])
        by Forcepoint Email with ESMTPS id C9E0917B1871147F860D;
        Mon, 23 Aug 2021 20:05:46 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-HQEx02.internal.baidu.com (172.31.51.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 23 Aug 2021 20:05:46 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 23 Aug 2021 20:05:46 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <jasmin@anw.at>, <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH] media: dvb-frontends/cxd2099: Remove repeated verbose license text
Date:   Mon, 23 Aug 2021 20:05:40 +0800
Message-ID: <20210823120540.500-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex31.internal.baidu.com (172.31.51.25) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

remove it because SPDX-License-Identifier is already used

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/media/dvb-frontends/cxd2099.c | 9 ---------
 drivers/media/dvb-frontends/cxd2099.h | 9 ---------
 2 files changed, 18 deletions(-)

diff --git a/drivers/media/dvb-frontends/cxd2099.c b/drivers/media/dvb-frontends/cxd2099.c
index f88b5355493e..1c8207ab8988 100644
--- a/drivers/media/dvb-frontends/cxd2099.c
+++ b/drivers/media/dvb-frontends/cxd2099.c
@@ -3,15 +3,6 @@
  * cxd2099.c: Driver for the Sony CXD2099AR Common Interface Controller
  *
  * Copyright (C) 2010-2013 Digital Devices GmbH
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 only, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/slab.h>
diff --git a/drivers/media/dvb-frontends/cxd2099.h b/drivers/media/dvb-frontends/cxd2099.h
index 0c101bdef01d..5d4060007c46 100644
--- a/drivers/media/dvb-frontends/cxd2099.h
+++ b/drivers/media/dvb-frontends/cxd2099.h
@@ -3,15 +3,6 @@
  * cxd2099.h: Driver for the Sony CXD2099AR Common Interface Controller
  *
  * Copyright (C) 2010-2011 Digital Devices GmbH
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 only, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef _CXD2099_H_
-- 
2.25.1

