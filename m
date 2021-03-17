Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727E7C433E0
	for <linux-media@archiver.kernel.org>; Wed, 17 Mar 2021 03:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 333F064EEC
	for <linux-media@archiver.kernel.org>; Wed, 17 Mar 2021 03:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhCQDIJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 16 Mar 2021 23:08:09 -0400
Received: from m12-14.163.com ([220.181.12.14]:46637 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhCQDIE (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 16 Mar 2021 23:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=sWaHc
        EKnEN8WAmqNPC+vLArUK//AL/TvZrfczH0nT3k=; b=b6BEB2YnFD8siF3wnYERN
        nP+r76CrjBVX43mWX9+6QcZGVSrlh86WdSjmjQwfT499UH68RxjWNiWkCV4QpFzi
        UIWgZwzyNBB9HFAp23qS6y3+Iumfy2gkke7nFq3XaphZ0QenZADMuC46d1JD1yn3
        i86hg8/YVO+12k+t8PE4Eg=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp10 (Coremail) with SMTP id DsCowACHiByJclFgYhk4pw--.32401S2;
        Wed, 17 Mar 2021 11:07:56 +0800 (CST)
From:   zuoqilin1@163.com
To:     tskd08@gmail.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] media/pci: Assign value when defining variables
Date:   Wed, 17 Mar 2021 11:08:04 +0800
Message-Id: <20210317030804.963-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowACHiByJclFgYhk4pw--.32401S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFWfKry3tF1xtrWxWrWDXFb_yoWftrc_W3
        43Zrn3u3y8Zr1rCF4xZrykArZF9ayjqrs2qa9ava9xZrZ8CFnYgryqkF47Jr1DXF15CFZx
        ZFWDWrW5GF1UKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnzT5PUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/xtbBRQ1YiVPAKjBU8QAAs1
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

When defining variables and assigning values can be done at the same time.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 drivers/media/pci/pt1/pt1.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/pci/pt1/pt1.c b/drivers/media/pci/pt1/pt1.c
index 72b191c..f2aa368 100644
--- a/drivers/media/pci/pt1/pt1.c
+++ b/drivers/media/pci/pt1/pt1.c
@@ -334,8 +334,7 @@ static int pt1_sync(struct pt1 *pt1)
 static u64 pt1_identify(struct pt1 *pt1)
 {
 	int i;
-	u64 id;
-	id = 0;
+	u64 id = 0;
 	for (i = 0; i < 57; i++) {
 		id |= (u64)(pt1_read_reg(pt1, 0) >> 30 & 1) << i;
 		pt1_write_reg(pt1, 0, 0x00000008);
@@ -1122,8 +1121,7 @@ static int pt1_i2c_end(struct pt1 *pt1, int addr)
 
 static void pt1_i2c_begin(struct pt1 *pt1, int *addrp)
 {
-	int addr;
-	addr = 0;
+	int addr = 0;
 
 	pt1_i2c_emit(pt1, addr,     0, 0, 1, 1, addr /* itself */);
 	addr = addr + 1;
-- 
1.9.1


