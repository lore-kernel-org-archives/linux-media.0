Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6290C001DE
	for <linux-media@archiver.kernel.org>; Fri, 11 Aug 2023 02:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjHKCuT (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 10 Aug 2023 22:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHKCuS (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 10 Aug 2023 22:50:18 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996BF2D5F
        for <linux-media@vger.kernel.org>; Thu, 10 Aug 2023 19:50:17 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RMSt570Nkz1L9KR;
        Fri, 11 Aug 2023 10:49:01 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 10:50:14 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <TheSven73@gmail.com>, <gregkh@linuxfoundation.org>,
        <mripard@kernel.org>, <paul.kocialkowski@bootlin.com>,
        <mchehab@kernel.org>, <wens@csie.org>, <jernej.skrabec@gmail.com>,
        <samuel@sholland.org>, <linux-staging@lists.linux.dev>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next 0/2] staging: Remove redundant of_match_ptr() macro
Date:   Fri, 11 Aug 2023 10:49:43 +0800
Message-ID: <20230811024945.2256437-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Since these staging drivers depend on CONFIG_OF, there is
no need to wrap the macro of_match_ptr() here.

Ruan Jinjie (2):
  staging: fieldbus: arcx-anybus: Remove redundant of_match_ptr()
  media: staging: media: sunxi: cedrus: Remove redundant of_match_ptr()

 drivers/staging/fieldbus/anybuss/arcx-anybus.c | 2 +-
 drivers/staging/media/sunxi/cedrus/cedrus.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1

