Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C577C48BCF
	for <linux-media@archiver.kernel.org>; Thu, 10 Jun 2021 03:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F6861418
	for <linux-media@archiver.kernel.org>; Thu, 10 Jun 2021 03:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhFJD1Q (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 9 Jun 2021 23:27:16 -0400
Received: from m12-11.163.com ([220.181.12.11]:60675 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhFJD1P (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 9 Jun 2021 23:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qlDdq
        u2OZeBY5YQAhNVQrYpOCpyh1jjGKwNL9do3Hrg=; b=LehbY7G1wKonYfR0Ck9bZ
        0xPpceD6McDwqLp/PC9ro3CqVZ1gzC8a7avPIhHnGGN8tfAfJwbWPEDHyu5aO1/C
        e9akGtvERQR+7IyhqioC0+JAQHeDgCSS6QqUkx2RYG4M13+KfBNYbK2jQxAlZlgD
        K1g9v8zGjRdgRQHFVdMzE4=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp7 (Coremail) with SMTP id C8CowABnopoVhsFgcHjDhA--.17690S2;
        Thu, 10 Jun 2021 11:25:11 +0800 (CST)
From:   lijian_8010a29@163.com
To:     sean@mess.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
Subject: [PATCH] media: rc: redrat3: Fix a typo
Date:   Thu, 10 Jun 2021 11:24:13 +0800
Message-Id: <20210610032413.35868-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowABnopoVhsFgcHjDhA--.17690S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw1UKry8CFW5Cr13Ary8uFg_yoW3Cwc_Ww
        1fXFn7Z34DtrW7uw1FywsIvr9rta95uFnaqFs5t3yayFyUZa9rGF1q9ryxJr1UWr4IvF9x
        WFyDXFWxCr43GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnCoGDUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbiqxetUFUMZxOpxAAAsB
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: lijian <lijian@yulong.com>

Change 'an' to 'on'.

Signed-off-by: lijian <lijian@yulong.com>
---
 drivers/media/rc/redrat3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/redrat3.c b/drivers/media/rc/redrat3.c
index 2cf3377ec63a..ac85464864b9 100644
--- a/drivers/media/rc/redrat3.c
+++ b/drivers/media/rc/redrat3.c
@@ -6,7 +6,7 @@
  *  based heavily on the work of Stephen Cox, with additional
  *  help from RedRat Ltd.
  *
- * This driver began life based an an old version of the first-generation
+ * This driver began life based on an old version of the first-generation
  * lirc_mceusb driver from the lirc 0.7.2 distribution. It was then
  * significantly rewritten by Stephen Cox with the aid of RedRat Ltd's
  * Chris Dodge.
-- 
2.25.1

