Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8659C433E0
	for <linux-media@archiver.kernel.org>; Tue, 12 Jan 2021 01:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C13F622CA2
	for <linux-media@archiver.kernel.org>; Tue, 12 Jan 2021 01:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbhALBRF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 11 Jan 2021 20:17:05 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11379 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbhALBRE (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 11 Jan 2021 20:17:04 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DFCLL32HMz7Syk;
        Tue, 12 Jan 2021 09:15:22 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Tue, 12 Jan 2021 09:16:12 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <bparrot@ti.com>, <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] media: ti-vpe: cal: Mark cal_camerarx_media_ops with static keyword
Date:   Tue, 12 Jan 2021 09:27:14 +0800
Message-ID: <1610414834-92332-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fix the following sparse warning:

drivers/media/platform/ti-vpe/cal-camerarx.c:783:32: warning: symbol 'cal_camerarx_media_ops' was not declared. Should it be static?

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/media/platform/ti-vpe/cal-camerarx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti-vpe/cal-camerarx.c b/drivers/media/platform/ti-vpe/cal-camerarx.c
index 1920f36..dd48017 100644
--- a/drivers/media/platform/ti-vpe/cal-camerarx.c
+++ b/drivers/media/platform/ti-vpe/cal-camerarx.c
@@ -780,7 +780,7 @@ static const struct v4l2_subdev_ops cal_camerarx_subdev_ops = {
 	.pad = &cal_camerarx_pad_ops,
 };
 
-struct media_entity_operations cal_camerarx_media_ops = {
+static struct media_entity_operations cal_camerarx_media_ops = {
 	.link_validate = v4l2_subdev_link_validate,
 };
 
-- 
2.6.2

