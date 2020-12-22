Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C23FC4332D
	for <linux-media@archiver.kernel.org>; Tue, 22 Dec 2020 13:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41DF0229C6
	for <linux-media@archiver.kernel.org>; Tue, 22 Dec 2020 13:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgLVNca (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 22 Dec 2020 08:32:30 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10061 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgLVNca (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 22 Dec 2020 08:32:30 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D0cfj1sKKzM7ZK;
        Tue, 22 Dec 2020 21:30:53 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 22 Dec 2020 21:31:39 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] media: dvb-frontends: use DIV_ROUND_UP to calculate timeout
Date:   Tue, 22 Dec 2020 21:32:14 +0800
Message-ID: <20201222133214.19632-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Don't open-code DIV_ROUND_UP() kernel macro.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/media/dvb-frontends/cxd2841er.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/cxd2841er.c b/drivers/media/dvb-frontends/cxd2841er.c
index 758c95bc3b11..ed21d51e16e4 100644
--- a/drivers/media/dvb-frontends/cxd2841er.c
+++ b/drivers/media/dvb-frontends/cxd2841er.c
@@ -3338,7 +3338,7 @@ static int cxd2841er_set_frontend_s(struct dvb_frontend *fe)
 		cxd2841er_tuner_set(fe);
 
 	cxd2841er_tune_done(priv);
-	timeout = ((3000000 + (symbol_rate - 1)) / symbol_rate) + 150;
+	timeout = DIV_ROUND_UP(3000000, symbol_rate) + 150;;
 
 	i = 0;
 	do {
-- 
2.22.0

