Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B412DC04FF3
	for <linux-media@archiver.kernel.org>; Mon, 24 May 2021 12:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 909A661370
	for <linux-media@archiver.kernel.org>; Mon, 24 May 2021 12:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbhEXMcr (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 24 May 2021 08:32:47 -0400
Received: from m12-18.163.com ([220.181.12.18]:59808 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232409AbhEXMcq (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 24 May 2021 08:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=sU5FY
        b8dbRCDV7uzf79+KDS0Ydjp7nGO86CkKtG3jkY=; b=NoCqksKag7hdsEvMEK7H3
        R76yvtwkiD3bqkWnPNIAKqHvUgIlULcVxfjqO7coRhiMp9mHz/g27CzW7ozM2T71
        uKrG5nYLhjx51Mq/dt8uDfTIo5GJ//p0adhmQ0GY+0VEqlS4Lz1sZ1eRDkUIRw0S
        c0k6y0W83+Q1gD5kDx4Lec=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp14 (Coremail) with SMTP id EsCowAC3n92DnKtg2fc2lQ--.61126S2;
        Mon, 24 May 2021 20:31:03 +0800 (CST)
From:   zuoqilin1@163.com
To:     mchehab@kernel.org, colin.king@canonical.com,
        gustavoars@kernel.org, trix@redhat.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] drivers: media: Simplify the return expression
Date:   Mon, 24 May 2021 20:31:08 +0800
Message-Id: <20210524123108.470-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowAC3n92DnKtg2fc2lQ--.61126S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF13ZF1fCw47tryktFWfuFg_yoWDZrg_KF
        93Z3W5WrW0yF48G34Utr1xJ3s5trWYqF1vqF1UtFZxXFs3GF15Jr1DKr47XryYga17ury5
        WFnxWr1xCr4UGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU09NVDUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/1tbipQeciVUMeTFAxAAAsi
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

Simplify the return expression of drxj_dap_scu_atomic_write_reg16().

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 drivers/media/dvb-frontends/drx39xyj/drxj.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/media/dvb-frontends/drx39xyj/drxj.c b/drivers/media/dvb-frontends/drx39xyj/drxj.c
index bf9e4ef..108d1f4 100644
--- a/drivers/media/dvb-frontends/drx39xyj/drxj.c
+++ b/drivers/media/dvb-frontends/drx39xyj/drxj.c
@@ -4234,14 +4234,11 @@ int drxj_dap_scu_atomic_write_reg16(struct i2c_device_addr *dev_addr,
 					  u16 data, u32 flags)
 {
 	u8 buf[2];
-	int rc;
 
 	buf[0] = (u8) (data & 0xff);
 	buf[1] = (u8) ((data >> 8) & 0xff);
 
-	rc = drxj_dap_scu_atomic_read_write_block(dev_addr, addr, 2, buf, false);
-
-	return rc;
+	return drxj_dap_scu_atomic_read_write_block(dev_addr, addr, 2, buf, false);
 }
 
 /* -------------------------------------------------------------------------- */
-- 
1.9.1


