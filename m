Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCD1C63705
	for <linux-media@archiver.kernel.org>; Thu,  8 Dec 2022 08:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiLHIB5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 8 Dec 2022 03:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiLHIBx (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 8 Dec 2022 03:01:53 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09545447F
        for <linux-media@vger.kernel.org>; Thu,  8 Dec 2022 00:01:51 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NSRRZ1QXWzmWX6;
        Thu,  8 Dec 2022 16:00:58 +0800 (CST)
Received: from huawei.com (10.175.100.227) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 8 Dec
 2022 16:01:48 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <tian.shu.qiu@intel.com>, <shawnx.tu@intel.com>,
        <bingbu.cao@intel.com>, <mchehab@kernel.org>,
        <sakari.ailus@linux.intel.com>, <linux-media@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH 0/2] media: i2c: Fix some memleaks
Date:   Thu, 8 Dec 2022 15:59:36 +0800
Message-ID: <20221208075938.13764-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Some memleaks are found due to the missing v4l2_ctrl_handler_free() and
fixed by this patch.

Shang XiaoJing (2):
  media: ov2740: Fix memleak in ov2740_init_controls()
  media: ov5675: Fix memleak in ov5675_init_controls()

 drivers/media/i2c/ov2740.c | 4 +++-
 drivers/media/i2c/ov5675.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.17.1

