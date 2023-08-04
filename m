Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D4DC04A6A
	for <linux-media@archiver.kernel.org>; Fri,  4 Aug 2023 03:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbjHDDQv (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 3 Aug 2023 23:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjHDDPo (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 3 Aug 2023 23:15:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D044C4EED
        for <linux-media@vger.kernel.org>; Thu,  3 Aug 2023 20:14:13 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RH9hR4ChVztRhM;
        Fri,  4 Aug 2023 11:10:47 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 11:14:10 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <j.neuschaefer@gmx.net>, <u.kleine-koenig@pengutronix.de>,
        <linux-media@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next 1/3] media: dvb-frontends: drx39xyj: Remove an unnecessary ternary operator
Date:   Fri, 4 Aug 2023 11:13:21 +0800
Message-ID: <20230804031323.2105187-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804031323.2105187-1-ruanjinjie@huawei.com>
References: <20230804031323.2105187-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

There is a ternary operator, the true or false judgement of which
is unnecessary in C language semantics.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/media/dvb-frontends/drx39xyj/drxj.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/drx39xyj/drxj.c b/drivers/media/dvb-frontends/drx39xyj/drxj.c
index 68f4e8b5a0ab..e54e61c3518a 100644
--- a/drivers/media/dvb-frontends/drx39xyj/drxj.c
+++ b/drivers/media/dvb-frontends/drx39xyj/drxj.c
@@ -4779,7 +4779,7 @@ set_frequency(struct drx_demod_instance *demod,
 	bool image_to_select;
 	s32 fm_frequency_shift = 0;
 
-	rf_mirror = (ext_attr->mirror == DRX_MIRROR_YES) ? true : false;
+	rf_mirror = ext_attr->mirror == DRX_MIRROR_YES;
 	tuner_mirror = demod->my_common_attr->mirror_freq_spect ? false : true;
 	/*
 	   Program frequency shifter
-- 
2.34.1

